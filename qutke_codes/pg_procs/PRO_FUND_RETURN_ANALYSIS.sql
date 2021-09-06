create or replace function PRO_FUND_RETURN_ANALYSIS(
    i_f_code      in     varchar,
    i_startdate   in     varchar,      -- 开始日期
    i_enddate     in     varchar       -- 结束日期
)
returns void as $func$
declare

/*

收益分解


20170823   创建


*/

    v_startjyr varchar(8);
    v_endjyr  varchar(8);
    
    v_startjyr_hk varchar(8);
    v_endjyr_hk  varchar(8);
    
    net_asset_flag1 numeric;
    net_asset_flag2 numeric;
  
BEGIN
  

    IF(i_f_code is null or i_startdate is null or i_enddate is null) THEN
    
            
        RETURN;
        
    END IF;


    select max(t.FT01) into v_startjyr
    from refdatauser.FT_TABLE1 t
    where t.FT01<=i_startdate
    ;
    
    select max(t.FT01) into v_endjyr
    from refdatauser.FT_TABLE1 t
    where t.FT01<=i_enddate
    ;

    select max(t.FT01) into v_startjyr_hk
    from refdatauser.FT_TABLE19 t
    where t.FT01<=i_startdate
          and t.FT11='HKEX'
    ;

    select max(t.FT01) into v_endjyr_hk
    from refdatauser.FT_TABLE19 t
    where t.FT01<=i_enddate
          and t.FT11='HKEX'
    ;


BEGIN
  

    select min(coalesce(t.net_asset,0)) into net_asset_flag1
    from orig_fund_summary t
    where t.f_code=i_f_code
          and t.biz_date=i_startdate
    ;

    select min(coalesce(t.net_asset,0)) into net_asset_flag2
    from orig_fund_summary t
    where t.f_code=i_f_code
          and t.biz_date=i_enddate
    ;


    IF(net_asset_flag1=0 or net_asset_flag2=0) THEN
        

        rollback;
        return;
            
    END IF;




    delete from FUND_RETURN_DETAIL a
    where a.f_code=i_f_code
          and a.start_date=i_startdate
          and a.end_date=i_enddate
    ;
    
    
    insert into FUND_RETURN_DETAIL
                (
                  F_CODE     ,
                  START_DATE ,
                  END_DATE   ,
                  ASSET_TYPE ,
                  REF_CODE   ,
                  EXCHANGE_TYPE,
                  STOCK_CODE ,
                  STOCK_NAME ,
                  INDUSTRY   ,
                  BALANCE1   ,
                  BALANCE2   ,
                  WEIGHT1    ,
                  WEIGHT2    ,
                  REF_RETURN ,
                  VOLUME     ,
                  PROFIT     ,
                  RETURN     ,
                  ADJ_FACTOR ,
                  REF_IE     ,
                  REF_TE     ,
                  REF_SE      
                )
      select  k1.F_CODE     ,
              i_startdate as START_DATE ,
              i_enddate as END_DATE   ,
              k1.ASSET_TYPE ,
              k1.REF_CODE   ,
              k1.EXCHANGE_TYPE,
              k1.STOCK_CODE ,
              k1.STOCK_NAME ,
              k1.INDUSTRY   ,
              k1.BALANCE1   ,
              k1.BALANCE2   ,
              k1.WEIGHT1    ,
              k1.WEIGHT2    ,
              k1.REF_RETURN ,
              abs(k1.BALANCE1+k1.PROFIT-k1.BALANCE2)  as VOLUME     ,
              k1.PROFIT     ,
              k1.RETURN     ,
              case when k2.return_fund=0 then 1 else ln(1+return_fund)/return_fund end as ADJ_FACTOR ,
              k1.ref_ie,
              k1.ref_te,
              k1.ref_se
      from
      (
            select coalesce(t1.f_code,t2.f_code) as f_code
                   ,t1.biz_date as START_DATE
                   ,t2.biz_date as END_DATE
                   ,'2' as ASSET_TYPE
                   ,coalesce(t1.ref_code,t2.ref_code) as ref_code
                   ,coalesce(t1.EXCHANGE_TYPE,t2.EXCHANGE_TYPE) as EXCHANGE_TYPE
                   ,coalesce(t1.stock_code,t2.stock_code) as stock_code
                   ,coalesce(t1.stock_name,t2.stock_name) as stock_name
                   ,coalesce(t1.industry,t2.industry) as industry
                   ,coalesce(t1.balance,0) as balance1
                   ,coalesce(t2.balance,0) as balance2
                   ,coalesce(t1.weight,0) as weight1
                   ,coalesce(t2.weight,0) as weight2
                   ,coalesce(t4.S_DQ_ADJCLOSE/t3.S_DQ_ADJCLOSE-1,0) as ref_return
                   ,round((coalesce(t1.balance,0)*coalesce(t4.S_DQ_ADJCLOSE/t3.S_DQ_ADJCLOSE-1,0)+coalesce(t2.balance,0)*coalesce(1-t3.S_DQ_ADJCLOSE/t4.S_DQ_ADJCLOSE,0))/2,2) as profit
                   ,coalesce(t1.weight,t2.weight,0)*coalesce(t4.S_DQ_ADJCLOSE/t3.S_DQ_ADJCLOSE-1,0) as return
                   ,null as ref_ie
                   ,null as ref_te
                   ,null as ref_se
            from
            (
                select a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,sum(a.balance) as balance
                       ,sum(a.balance/b.net_asset) as weight
                from fund_eq_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                where a.f_code=i_f_code
                      and a.biz_date=i_startdate
                      and a.exchange_type in ('SSE','SZSE')
                group by a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
            ) t1
            full join 
            (
                select a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,sum(a.balance) as balance
                       ,sum(a.balance/b.net_asset) as weight
                from fund_eq_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                where a.f_code=i_f_code
                      and a.biz_date=i_enddate
                      and a.exchange_type in ('SSE','SZSE')
                group by a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
            ) t2
            on t1.f_code=t2.f_code
               and t1.ref_code=t2.ref_code
            left join wind.AShareEODPrices t3
            on coalesce(t1.ref_code,t2.ref_code)=t3.S_INFO_WINDCODE
               and t3.TRADE_DT=v_startjyr
            left join wind.AShareEODPrices t4
            on coalesce(t1.ref_code,t2.ref_code)=t4.S_INFO_WINDCODE
               and t4.TRADE_DT=v_endjyr
               
            union all
            
            select coalesce(t1.f_code,t2.f_code) as f_code
                   ,t1.biz_date as START_DATE
                   ,t2.biz_date as END_DATE
                   ,'2' as ASSET_TYPE
                   ,coalesce(t1.ref_code,t2.ref_code) as ref_code
                   ,coalesce(t1.EXCHANGE_TYPE,t2.EXCHANGE_TYPE) as EXCHANGE_TYPE
                   ,coalesce(t1.stock_code,t2.stock_code) as stock_code
                   ,coalesce(t1.stock_name,t2.stock_name) as stock_name
                   ,coalesce(t1.industry,t2.industry) as industry
                   ,coalesce(t1.balance,0) as balance1
                   ,coalesce(t2.balance,0) as balance2
                   ,coalesce(t1.weight,0) as weight1
                   ,coalesce(t2.weight,0) as weight2
                   ,coalesce(t4.s_dq_adjclose/t3.s_dq_adjclose-1,0) as ref_return
                   ,round((coalesce(t1.balance,0)*coalesce(t4.s_dq_adjclose/t3.s_dq_adjclose-1,0)+coalesce(t2.balance,0)*coalesce(1-t3.s_dq_adjclose/t4.s_dq_adjclose,0))/2,2) as profit
                   ,coalesce(t1.weight,t2.weight,0)*coalesce(t4.s_dq_adjclose/t3.s_dq_adjclose-1,0) as return
                   ,null as ref_ie
                   ,null as ref_te
                   ,null as ref_se
            from
            (
                select a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,sum(a.balance) as balance
                       ,sum(a.balance/b.net_asset) as weight
                from fund_eq_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                where a.f_code=i_f_code
                      and a.biz_date=i_startdate
                      and a.exchange_type in ('HKEX')
                group by a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
            ) t1
            full join 
            (
                select a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,sum(a.balance) as balance
                       ,sum(a.balance/b.net_asset) as weight
                from fund_eq_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                where a.f_code=i_f_code
                      and a.biz_date=i_enddate
                      and a.exchange_type in ('HKEX')
                group by a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
            ) t2
            on t1.f_code=t2.f_code
               and t1.ref_code=t2.ref_code
            left join wind.HKshareEODPrices t3
            on coalesce(t1.ref_code,t2.ref_code)=t3.s_info_windcode
               and t3.trade_dt=v_startjyr_hk
            left join wind.HKshareEODPrices t4
            on coalesce(t1.ref_code,t2.ref_code)=t4.s_info_windcode
               and t4.trade_dt=v_endjyr_hk
            
            union all
               
            select coalesce(t1.f_code,t2.f_code) as f_code
                   ,t1.biz_date as START_DATE
                   ,t2.biz_date as END_DATE
                   ,'4' as ASSET_TYPE
                   ,coalesce(t1.ref_code,t2.ref_code) as ref_code
                   ,coalesce(t1.EXCHANGE_TYPE,t2.EXCHANGE_TYPE) as EXCHANGE_TYPE
                   ,coalesce(t1.stock_code,t2.stock_code) as stock_code
                   ,coalesce(t1.stock_name,t2.stock_name) as stock_name
                   ,null as industry
                   ,coalesce(t1.balance,0) as balance1
                   ,coalesce(t2.balance,0) as balance2
                   ,coalesce(t1.weight,0) as weight1
                   ,coalesce(t2.weight,0) as weight2
                   ,coalesce((coalesce(t8.b_anal_dirty_cnbd, t4.b_dq_originclose) + coalesce(t9.payment, 0) - coalesce(t7.b_anal_dirty_cnbd, t3.b_dq_originclose)) / coalesce(t7.b_anal_dirty_cnbd, t3.b_dq_originclose), 0) as ref_return
                   ,round((coalesce(t1.balance,0)*coalesce((coalesce(t8.b_anal_dirty_cnbd, t4.b_dq_originclose) + coalesce(t9.payment, 0) - coalesce(t7.b_anal_dirty_cnbd, t3.b_dq_originclose)) / coalesce(t7.b_anal_dirty_cnbd, t3.b_dq_originclose), 0)+coalesce(t2.balance,0)*coalesce(((coalesce(t8.b_anal_dirty_cnbd, t4.b_dq_originclose) + coalesce(t9.payment, 0) - coalesce(t7.b_anal_dirty_cnbd, t3.b_dq_originclose))) / (coalesce(t8.b_anal_dirty_cnbd, t4.b_dq_originclose) + t9.payment),0))/2,2) as profit
                   ,coalesce(t1.weight,t2.weight,0)*coalesce((coalesce(t8.b_anal_dirty_cnbd, t4.b_dq_originclose) + coalesce(t9.payment, 0) - coalesce(t7.b_anal_dirty_cnbd, t3.b_dq_originclose)) / coalesce(t7.b_anal_dirty_cnbd, t3.b_dq_originclose), 0) as return                   
                   ,coalesce(t1.ytm,t2.ytm,0)*(to_date(i_enddate,'yyyymmdd')-to_date(i_startdate,'yyyymmdd'))/360/100 as ref_ie -- 收入效应（Income Effect）
                   ,-coalesce(round(t1.MODIFIED_DURATION,1),round(t2.MODIFIED_DURATION,1),0)*(coalesce(t6.b_anal_yield,t5.b_anal_yield,0)-coalesce(t5.b_anal_yield,t6.b_anal_yield,0))/100 as ref_te --国债效应（Treasury Effect）
                   , coalesce((coalesce(t8.b_anal_dirty_cnbd, t4.b_dq_originclose) + coalesce(t9.payment, 0) - coalesce(t7.b_anal_dirty_cnbd, t3.b_dq_originclose)) / coalesce(t7.b_anal_dirty_cnbd, t3.b_dq_originclose), 0)
                    -coalesce(t1.ytm,t2.ytm,0)*(to_date(i_enddate,'yyyymmdd')-to_date(i_startdate,'yyyymmdd'))/360/100
                    -(-coalesce(round(t1.MODIFIED_DURATION,1),round(t2.MODIFIED_DURATION,1),0)*(coalesce(t6.b_anal_yield,t5.b_anal_yield,0)-coalesce(t5.b_anal_yield,t6.b_anal_yield,0))/100) as ref_se -- 利差效应（Spread Effect）

            from
            (
                select a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,a.YTM
                       ,a.MODIFIED_DURATION
                       ,sum(a.balance) as balance
                       ,sum(a.balance/b.net_asset) as weight
                from fund_bond_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                where a.f_code=i_f_code
                      and a.biz_date=i_startdate
                group by a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,a.YTM
                       ,a.MODIFIED_DURATION
            ) t1
            full join 
            (
                select a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,a.YTM
                       ,a.MODIFIED_DURATION
                       ,sum(a.balance) as balance
                       ,sum(a.balance/b.net_asset) as weight
                from fund_bond_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                where a.f_code=i_f_code
                      and a.biz_date=i_enddate
                group by a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,a.YTM
                       ,a.MODIFIED_DURATION
            ) t2
            on t1.f_code=t2.f_code
               and t1.ref_code=t2.ref_code
            left join wind.CBondPrices t3
            on coalesce(t1.ref_code,t2.ref_code)=t3.S_INFO_WINDCODE
               and t3.TRADE_DT=v_startjyr
            left join wind.CBondPrices t4
            on coalesce(t1.ref_code,t2.ref_code)=t4.S_INFO_WINDCODE
               and t4.TRADE_DT=v_endjyr
            left join wind.CBondCurveCNBD t5
            on coalesce(round(t1.MODIFIED_DURATION,1),round(t2.MODIFIED_DURATION,1))=t5.b_anal_curveterm
            --   and t5.b_anal_curvename='中债国债收益率曲线'
               and t5.b_anal_curvenumeric='1231'
               and t5.b_anal_curvetype='1'
               and t5.trade_dt=v_startjyr
            left join wind.CBondCurveCNBD t6
            on coalesce(round(t1.MODIFIED_DURATION,1),round(t2.MODIFIED_DURATION,1))=t6.b_anal_curveterm
           --    and t6.b_anal_curvename='中债国债收益率曲线'
               and t6.b_anal_curvenumeric='1231'
               and t6.b_anal_curvetype='1'
               and t6.trade_dt=v_endjyr
            left join
               refdatauser.v_cbondanalysiscnbd t7
            on
                coalesce(t1.ref_code, t2.ref_code) = t7.s_info_windcode and t7.trade_dt = v_startjyr
            left join
               refdatauser.v_cbondanalysiscnbd t8
            on
                coalesce(t1.ref_code, t2.ref_code) = t8.s_info_windcode and t8.trade_dt = v_endjyr
            left join
            (
               select
                  a.s_info_windcode,
                  sum(a.b_info_paymentsum) as payment
               from
                  wind.cbondcf a
               where
                  a.b_info_paymentdate > v_startjyr and a.b_info_paymentdate <= v_endjyr
               group by a.s_info_windcode
            ) t9
            on
               coalesce(t1.ref_code, t2.ref_code) = t9.s_info_windcode
            union all
               
            select coalesce(t1.f_code,t2.f_code) as f_code
                   ,t1.biz_date as START_DATE
                   ,t2.biz_date as END_DATE
                   ,'3' as ASSET_TYPE
                   ,coalesce(t1.ref_code,t2.ref_code) as ref_code
                   ,coalesce(t1.EXCHANGE_TYPE,t2.EXCHANGE_TYPE) as EXCHANGE_TYPE
                   ,coalesce(t1.stock_code,t2.stock_code) as stock_code
                   ,coalesce(t1.stock_name,t2.stock_name) as stock_name
                   ,null as industry
                   ,coalesce(t1.balance,0) as balance1
                   ,coalesce(t2.balance,0) as balance2
                   ,coalesce(t1.weight,0) as weight1
                   ,coalesce(t2.weight,0) as weight2
                   ,(coalesce(t52.S_DQ_SETTLE,t62.S_DQ_SETTLE,t72.S_DQ_SETTLE)-coalesce(t51.S_DQ_SETTLE,t61.S_DQ_SETTLE,t71.S_DQ_SETTLE))/coalesce(t51.S_DQ_SETTLE,t61.S_DQ_SETTLE,t71.S_DQ_SETTLE) as ref_return 
                   ,round((coalesce(t1.balance,0)*coalesce(coalesce(t52.S_DQ_SETTLE,t62.S_DQ_SETTLE,t72.S_DQ_SETTLE)/coalesce(t51.S_DQ_SETTLE,t61.S_DQ_SETTLE,t71.S_DQ_SETTLE)-1,0)+coalesce(t2.balance,0)*coalesce(1-coalesce(t51.S_DQ_SETTLE,t61.S_DQ_SETTLE,t71.S_DQ_SETTLE)/coalesce(t52.S_DQ_SETTLE,t62.S_DQ_SETTLE,t72.S_DQ_SETTLE),0))/2,2) as profit
                   ,coalesce(t1.weight,t2.weight,0)*coalesce(coalesce(t52.S_DQ_SETTLE,t62.S_DQ_SETTLE,t72.S_DQ_SETTLE)/coalesce(t51.S_DQ_SETTLE,t61.S_DQ_SETTLE,t71.S_DQ_SETTLE)-1,0) as return
                   ,null as ref_ie
                   ,null as ref_te
                   ,null as ref_se
            from
            (
                select a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,sum(a.balance_net) as balance
                       ,sum(a.balance_net/b.net_asset) as weight
                from ftuser.fund_fut_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                where a.f_code=i_f_code
                      and a.biz_date=i_startdate
                group by a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
            ) t1
            full join 
            (
                select a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,sum(a.balance_net) as balance
                       ,sum(a.balance_net/b.net_asset) as weight
                from ftuser.fund_fut_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                where a.f_code=i_f_code
                      and a.biz_date=i_enddate
                group by a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
            ) t2
            on t1.f_code=t2.f_code
               and t1.ref_code=t2.ref_code
            left join 
            (
                  select a.*
                  from wind.CfuturesContractMapping a
                  where a.s_info_windcode in (select S_INFO_WINDCODE from wind.CFuturesDescription where substr(FS_INFO_CCTYPE,1,6) in ('706001','706002','706003','706004','706005'))
            ) t31
            on t1.ref_code=t31.FS_MAPPING_WINDCODE
               and t31.startdate<=v_startjyr
               and t31.enddate>=v_startjyr
            left join 
            (
                  select a.*
                  from wind.CfuturesContractMapping a
                  where a.s_info_windcode in (select S_INFO_WINDCODE from wind.CFuturesDescription where substr(FS_INFO_CCTYPE,1,6) in ('706001','706002','706003','706004','706005'))
            ) t32
            on t2.ref_code=t32.FS_MAPPING_WINDCODE
               and t32.startdate<=v_endjyr
               and t32.enddate>=v_endjyr    
                       
            left join wind.CIndexFuturesEODPrices t51
            on coalesce(t31.S_INFO_WINDCODE,t32.S_INFO_WINDCODE)=t51.S_INFO_WINDCODE
               and t51.TRADE_DT=v_startjyr
            left join wind.CIndexFuturesEODPrices t52
            on coalesce(t32.S_INFO_WINDCODE,t31.S_INFO_WINDCODE)=t52.S_INFO_WINDCODE
               and t52.TRADE_DT=v_endjyr 
            left join wind.CBondFuturesEODPrices t61
            on coalesce(t31.S_INFO_WINDCODE,t32.S_INFO_WINDCODE)=t61.S_INFO_WINDCODE
               and t61.TRADE_DT=v_startjyr 
            left join wind.CBondFuturesEODPrices t62
            on coalesce(t32.S_INFO_WINDCODE,t31.S_INFO_WINDCODE)=t62.S_INFO_WINDCODE
               and t62.TRADE_DT=v_endjyr     
            left join wind.CCommodityFuturesEODPrices t71
            on coalesce(t31.S_INFO_WINDCODE,t32.S_INFO_WINDCODE)=t71.S_INFO_WINDCODE
               and t71.TRADE_DT=v_startjyr
            left join wind.CCommodityFuturesEODPrices t72
            on coalesce(t32.S_INFO_WINDCODE,t31.S_INFO_WINDCODE)=t72.S_INFO_WINDCODE
               and t72.TRADE_DT=v_endjyr
               
            union all

            select coalesce(t1.f_code,t2.f_code) as f_code
                   ,t1.biz_date as START_DATE
                   ,t2.biz_date as END_DATE
                   ,'5' as ASSET_TYPE
                   ,coalesce(t1.ref_code,t2.ref_code) as ref_code
                   ,coalesce(t1.EXCHANGE_TYPE,t2.EXCHANGE_TYPE) as EXCHANGE_TYPE
                   ,coalesce(t1.stock_code,t2.stock_code) as stock_code
                   ,coalesce(t1.stock_name,t2.stock_name) as stock_name
                   ,null as industry
                   ,coalesce(t1.balance,0) as balance1
                   ,coalesce(t2.balance,0) as balance2
                   ,coalesce(t1.weight,0) as weight1
                   ,coalesce(t2.weight,0) as weight2
                   ,coalesce(t4.F_NAV_ADJUSTED/t3.F_NAV_ADJUSTED-1,0) as ref_return
                   ,round((coalesce(t1.balance,0)*coalesce(t4.F_NAV_ADJUSTED/t3.F_NAV_ADJUSTED-1,0)+coalesce(t2.balance,0)*coalesce(1-t3.F_NAV_ADJUSTED/t4.F_NAV_ADJUSTED,0))/2,2) as profit
                   ,coalesce(t1.weight,t2.weight,0)*coalesce(t4.F_NAV_ADJUSTED/t3.F_NAV_ADJUSTED-1,0) as return
                   ,null as ref_ie
                   ,null as ref_te
                   ,null as ref_se
            from
            (
                select a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,sum(a.balance) as balance
                       ,sum(a.balance/b.net_asset) as weight
                from fund_fund_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                where a.f_code=i_f_code
                      and a.biz_date=i_startdate
                group by a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
            ) t1
            full join 
            (
                select a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,sum(a.balance) as balance
                       ,sum(a.balance/b.net_asset) as weight
                from fund_fund_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                where a.f_code=i_f_code
                      and a.biz_date=i_enddate
                group by a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
            ) t2
            on t1.f_code=t2.f_code
               and t1.ref_code=t2.ref_code
            left join wind.ChinaMutualFundNAV t3
            on coalesce(t1.ref_code,t2.ref_code)=t3.F_INFO_WINDCODE
               and t3.PRICE_DATE=v_startjyr
            left join wind.ChinaMutualFundNAV t4
            on coalesce(t1.ref_code,t2.ref_code)=t4.F_INFO_WINDCODE
               and t4.PRICE_DATE=v_endjyr
            

            union all

            select coalesce(t1.f_code,t2.f_code) as f_code
                   ,t1.biz_date as START_DATE
                   ,t2.biz_date as END_DATE
                   ,'11' as ASSET_TYPE
                   ,coalesce(t1.ref_code,t2.ref_code) as ref_code
                   ,coalesce(t1.EXCHANGE_TYPE,t2.EXCHANGE_TYPE) as EXCHANGE_TYPE
                   ,coalesce(t1.stock_code,t2.stock_code) as stock_code
                   ,coalesce(t1.stock_name,t2.stock_name) as stock_name
                   ,null as industry
                   ,coalesce(t1.balance,0) as balance1
                   ,coalesce(t2.balance,0) as balance2
                   ,coalesce(t1.weight,0) as weight1
                   ,coalesce(t2.weight,0) as weight2
                   ,coalesce(t4.ft04/t3.ft04-1,0) as ref_return
                   ,round((coalesce(t1.balance,0)*coalesce(t4.ft04/t3.ft04-1,0)+coalesce(t2.balance,0)*coalesce(1-t3.ft04/t4.ft04,0))/2,2) as profit
                   ,coalesce(t1.weight,t2.weight,0)*coalesce(t4.ft04/t3.ft04-1,0) as return
                   ,null as ref_ie
                   ,null as ref_te
                   ,null as ref_se
            from
            (
                select a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,sum(a.balance) as balance
                       ,sum(a.balance/b.net_asset) as weight
                from fund_pension_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                where a.f_code=i_f_code
                      and a.biz_date=i_startdate
                group by a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
            ) t1
            full join 
            (
                select a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,sum(a.balance) as balance
                       ,sum(a.balance/b.net_asset) as weight
                from fund_pension_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                where a.f_code=i_f_code
                      and a.biz_date=i_enddate
                group by a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
            ) t2
            on t1.f_code=t2.f_code
               and t1.ref_code=t2.ref_code
            left join refdatauser.ft_table29 t3
            on coalesce(t1.ref_code,t2.ref_code)=t3.ft02
               and t3.ft03=v_startjyr
            left join refdatauser.ft_table29 t4
            on coalesce(t1.ref_code,t2.ref_code)=t4.ft02
               and t4.ft03=v_endjyr
               
            union all

            select coalesce(t1.f_code,t2.f_code) as f_code
                   ,t1.biz_date as START_DATE
                   ,t2.biz_date as END_DATE
                   ,'18' as ASSET_TYPE
                   ,coalesce(t1.ref_code,t2.ref_code) as ref_code
                   ,coalesce(t1.EXCHANGE_TYPE,t2.EXCHANGE_TYPE) as EXCHANGE_TYPE
                   ,coalesce(t1.stock_code,t2.stock_code) as stock_code
                   ,coalesce(t1.stock_name,t2.stock_name) as stock_name
                   ,null as industry
                   ,coalesce(t1.balance,0) as balance1
                   ,coalesce(t2.balance,0) as balance2
                   ,coalesce(t1.weight,0) as weight1
                   ,coalesce(t2.weight,0) as weight2
                   ,coalesce(t4.ft04/t3.ft04-1,0) as ref_return
                   ,round((coalesce(t1.balance,0)*coalesce(t4.ft04/t3.ft04-1,0)+coalesce(t2.balance,0)*coalesce(1-t3.ft04/t4.ft04,0))/2,2) as profit
                   ,coalesce(t1.weight,t2.weight,0)*coalesce(t4.ft04/t3.ft04-1,0) as return
                   ,null as ref_ie
                   ,null as ref_te
                   ,null as ref_se
            from
            (
                select a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,sum(a.balance) as balance
                       ,sum(a.balance/b.net_asset) as weight
                from fund_hedge_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                where a.f_code=i_f_code
                      and a.biz_date=i_startdate
                group by a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
            ) t1
            full join 
            (
                select a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
                       ,sum(a.balance) as balance
                       ,sum(a.balance/b.net_asset) as weight
                from fund_hedge_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                where a.f_code=i_f_code
                      and a.biz_date=i_enddate
                group by a.biz_date
                       ,a.f_code
                       ,a.ref_code
                       ,a.exchange_type
                       ,a.stock_code
                       ,a.stock_name
            ) t2
            on t1.f_code=t2.f_code
               and t1.ref_code=t2.ref_code
            left join refdatauser.ft_table30 t3
            on coalesce(t1.ref_code,t2.ref_code)=t3.ft02
               and t3.ft03=v_startjyr
            left join refdatauser.ft_table30 t4
            on coalesce(t1.ref_code,t2.ref_code)=t4.ft02
               and t4.ft03=v_endjyr
       ) k1
       left join 
       (
            select a.f_code
                   ,coalesce(b.fq_nav/a.fq_nav-1,(coalesce(b.acc_nav,b.nav)-coalesce(a.acc_nav,a.nav))/coalesce(a.nav,a.acc_nav)) as return_fund
            from orig_fund_summary a
            left join orig_fund_summary b
            on a.f_code=b.f_code
               and b.biz_date=i_enddate
            where a.f_code=i_f_code
                  and a.biz_date=i_startdate
       ) k2
       on k1.f_code=k2.f_code
       ; 
     
       
    
    insert into FUND_RETURN_DETAIL
                (
                  F_CODE     ,
                  START_DATE ,
                  END_DATE   ,
                  ASSET_TYPE ,
                  REF_CODE   ,
                  EXCHANGE_TYPE,
                  STOCK_CODE ,
                  STOCK_NAME ,
                  INDUSTRY   ,
                  BALANCE1   ,
                  BALANCE2   ,
                  WEIGHT1    ,
                  WEIGHT2    ,
                  REF_RETURN ,
                  VOLUME     ,
                  PROFIT     ,
                  RETURN     ,
                  ADJ_FACTOR        
                )
    select  t2.F_CODE     ,
            i_startdate as START_DATE ,
            i_enddate as END_DATE   ,
            'OTHER' as ASSET_TYPE ,
            null as REF_CODE   ,
            null as EXCHANGE_TYPE,
            null as STOCK_CODE ,
            null as STOCK_NAME ,
            null as industry   ,
            null as BALANCE1   ,
            null as BALANCE2   ,
            null as WEIGHT1    ,
            null as WEIGHT2    ,
            null as REF_RETURN ,
            null as VOLUME     ,
            null as PROFIT     ,
            t2.return_fund-coalesce(t1.sum_return,0) as RETURN     ,
            case when t2.return_fund=0 then 1 else ln(1+return_fund)/return_fund end as ADJ_FACTOR 
    from 
    (
         select t.f_code
                ,sum(t.balance1) as balance1
                ,sum(t.balance2) as balance2
                ,sum(t.weight1) as weight1
                ,sum(t.weight2) as weight2
                ,sum(t.return) as sum_return
         from fund_return_detail t
         where f_code=i_f_code
            and start_date=i_startdate
            and end_date=i_enddate
         group by t.f_code
    ) t1
    right join 
    (
        select a.f_code
               ,coalesce(b.fq_nav/a.fq_nav-1,(coalesce(b.acc_nav,b.nav)-coalesce(a.acc_nav,a.nav))/coalesce(a.nav,a.acc_nav))  as return_fund
        from orig_fund_summary a
        left join orig_fund_summary b
        on a.f_code=b.f_code
           and b.biz_date=i_enddate
        where a.f_code=i_f_code
              and a.biz_date=i_startdate
    ) t2
    on t1.f_code=t2.f_code
    order by 4,8 desc
    ;
       
       
       
       
       
       commit;
    


END;
end;

$func$ language plpgsql;