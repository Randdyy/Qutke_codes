create or replace function PRO_FUND_VAR(
    i_f_code      in     varchar,      -- 基金内部编码
    i_biz_date    in     varchar       -- 计算日期
)
returns void as $func$
declare


/*

VAR分析


*/


   v_f_code       VARCHAR(4000);
   v_jyr          VARCHAR(8);  
   v_last_date    VARCHAR(8);  
   v_last_date2   VARCHAR(8);  
   net_asset_flag numeric;
  
BEGIN
  
--    v_f_code := ';'||REPLACE(REPLACE(REPLACE(i_f_code, ',', ';'), '，', ';'), '；', ';')||';';
    v_f_code := ';'||i_f_code||';';

    IF(i_biz_date is null) THEN
    
            
        RETURN;
        
    END IF;
    
    
    IF(i_f_code is null) THEN
    

            
        RETURN;
        
    END IF;
    
    
    select max(t.FT01) into v_jyr
    from refdatauser.FT_TABLE1 t
    where t.FT01<=i_biz_date
    ;  
    
    
    select i_biz_date-'10000' into v_last_date
    from dual
    ;  
    
    
    select i_biz_date-'10000'-'10' into v_last_date2
    from dual
    ;  
    
    select min(coalesce(t.net_asset,0)) into net_asset_flag
    from orig_fund_summary t
    where t.f_code=i_f_code
          and t.biz_date=i_biz_date
    ;
    
    

    IF(net_asset_flag=0 ) THEN
        

        return;
            
    END IF;
    
    
    
    /* 量化基金分析  */
    


    delete from FUND_VAR a
    where a.biz_date=i_biz_date
          and a.f_code=i_f_code
    ;
   
    insert into FUND_VAR
    (
      BIZ_DATE       ,
      F_CODE         ,
      NET_ASSET   ,
      VAR_95      ,
      VAR_99      
    )
    with k3 as 
    (
          select a.持仓日期
                 ,a.基金编码
                 ,a.历史日期
                 ,sum(a.权重*a.涨跌幅) as A股涨跌幅
          from
          (
                select t1.biz_date as 持仓日期
                       ,t1.f_code as 基金编码
                       ,t2.stock_code as 股票代码
                       ,t2.stock_name as 股票名称
                       ,t2.balance as 市值
                       ,t2.balance/t1.net_asset as 权重
                       ,t4.trade_dt as 历史日期
                       ,t4.S_DQ_PCTCHANGE/100 as 涨跌幅
                from ftuser.orig_fund_summary t1
                inner join ftuser.fund_eq_position t2
                on t1.f_code=t2.f_code
                   and t1.biz_date=t2.biz_date
                inner join wind.AShareDescription t3
                on t2.stock_code=t3.s_info_code
                inner join wind.AShareEODPrices t4
                on t3.S_INFO_WINDCODE=t4.S_INFO_WINDCODE
                   and t4.TRADE_DT>v_last_date --i_biz_date-'10000'
                   and t4.TRADE_DT<=i_biz_date
                where t1.f_code=i_f_code
                      and t1.biz_date=i_biz_date
                      and t2.exchange_type in ('SSE','SZSE')
                order by 7,3
           ) a
           group by a.持仓日期
                 ,a.基金编码
                 ,a.历史日期
           order by 3
    )
    ,
    k4 as
    (
          select a.持仓日期
                 ,a.基金编码
                 ,a.历史日期
                 ,sum(a.权重*a.涨跌幅) as 期货涨跌幅
          from
          (
                select t1.biz_date as 持仓日期
                       ,t1.f_code as 基金编码
                       ,t2.stock_code as 期货代码
                       ,t2.stock_name as 期货名称
                       ,t2.balance_net as 市值
                       ,t2.balance_net/t1.net_asset as 权重
                       ,coalesce(t5.trade_dt,t6.trade_dt,t7.trade_dt) as 历史日期
                       ,(coalesce(t5.S_DQ_SETTLE,t6.S_DQ_SETTLE,t7.S_DQ_SETTLE)-coalesce(t5.S_DQ_PRESETTLE,t6.S_DQ_PRESETTLE,t7.S_DQ_PRESETTLE))/coalesce(t5.S_DQ_SETTLE,t6.S_DQ_SETTLE,t7.S_DQ_SETTLE) as 涨跌幅
                from ftuser.orig_fund_summary t1
                inner join ftuser.fund_fut_position t2
                on t1.f_code=t2.f_code
                   and t1.biz_date=t2.biz_date
                inner join wind.CFuturesDescription t3
                on t2.stock_code=t3.s_info_code
                inner join 
                (
                      select a.*
                      from wind.CfuturesContractMapping a
                      where a.s_info_windcode in (select S_INFO_WINDCODE from wind.CFuturesDescription where substr(FS_INFO_CCTYPE,1,6) in ('706001','706002','706003','706004','706005'))
                ) t4
                on t3.s_info_windcode=t4.FS_MAPPING_WINDCODE
                   and t4.startdate<=t1.biz_date
                   and t4.enddate>=t1.biz_date
                left join wind.CIndexFuturesEODPrices t5
                on t4.S_INFO_WINDCODE=t5.S_INFO_WINDCODE
                   and t5.TRADE_DT>v_last_date    --i_biz_date-'10000'
                   and t5.TRADE_DT<=i_biz_date
                left join wind.CBondFuturesEODPrices t6
                on t4.S_INFO_WINDCODE=t6.S_INFO_WINDCODE
                   and t6.TRADE_DT>v_last_date  --i_biz_date-'10000'
                   and t6.TRADE_DT<=i_biz_date
                left join wind.CCommodityFuturesEODPrices t7
                on t4.S_INFO_WINDCODE=t7.S_INFO_WINDCODE
                   and t7.TRADE_DT>v_last_date  --i_biz_date-'10000'
                   and t7.TRADE_DT<=i_biz_date
                where t1.f_code=i_f_code
                      and t1.biz_date=i_biz_date
                order by 7,3
           ) a
           group by a.持仓日期
                 ,a.基金编码
                 ,a.历史日期
           order by 3
    )
    ,
    k5 as
    (
          select a.持仓日期
                 ,a.基金编码
                 ,a.历史日期
                 ,sum(a.权重*a.涨跌幅) as 债券涨跌幅
          from
          (
                select t1.biz_date as 持仓日期
                       ,t1.f_code as 基金编码
                       ,t2.stock_code as 债券代码
                       ,t2.stock_name as 债券名称
                       ,t2.balance as 市值
                       ,t2.balance/t1.net_asset as 权重
                       ,t4.trade_dt as 历史日期
                       ,t4.pct as 涨跌幅
                from ftuser.orig_fund_summary t1
                inner join ftuser.fund_bond_position t2
                on t1.f_code=t2.f_code
                   and t1.biz_date=t2.biz_date
                inner join 
                (
                    select t.s_info_windcode
                           ,t.trade_dt
                           ,t.b_dq_originclose
                           ,t.b_dq_originclose/coalesce(first_value(t.b_dq_originclose) over (partition by s_info_windcode order by trade_dt desc rows between 1 following and 2 following),t.b_dq_originclose)-1 as pct
                    from wind.CBondPrices t
                    where t.TRADE_DT>v_last_date2  --i_biz_date-'10000'-'10'
                          and t.TRADE_DT<=i_biz_date
                          and t.s_info_windcode in (select ref_code from ftuser.fund_bond_position where f_code=i_f_code and biz_date=i_biz_date)
                    order by 2
                ) t4
                on t2.ref_code=t4.S_INFO_WINDCODE
                   and t4.TRADE_DT>v_last_date  --i_biz_date-'10000'
                   and t4.TRADE_DT<=i_biz_date
                where t1.f_code=i_f_code
                      and t1.biz_date=i_biz_date
                order by 7,3
           ) a
           group by a.持仓日期
                 ,a.基金编码
                 ,a.历史日期
           order by 3
    )
    ,
    k6 as 
    (
          select a.持仓日期
                 ,a.基金编码
                 ,a.历史日期
                 ,sum(a.权重*a.涨跌幅) as H股涨跌幅
          from
          (
                select t1.biz_date as 持仓日期
                       ,t1.f_code as 基金编码
                       ,t2.stock_code as 股票代码
                       ,t2.stock_name as 股票名称
                       ,t2.balance as 市值
                       ,t2.balance/t1.net_asset as 权重
                       ,t4.trade_dt as 历史日期
                       ,t4.s_dq_adjclose/t4.s_dq_adjpreclose-1 as 涨跌幅
                from ftuser.orig_fund_summary t1
                inner join ftuser.fund_eq_position t2
                on t1.f_code=t2.f_code
                   and t1.biz_date=t2.biz_date
                inner join wind.HKShareDescription t3
                on lpad(t2.stock_code,5,'0')=lpad(t3.s_info_code,5,'0')
                left join wind.HKshareEODPrices t4
                on t3.S_INFO_WINDCODE=t4.S_INFO_WINDCODE
                   and t4.TRADE_DT>v_last_date  --i_biz_date-'10000'
                   and t4.TRADE_DT<=i_biz_date
                where t1.f_code=i_f_code
                      and t1.biz_date=i_biz_date
                      and t2.exchange_type in ('HKEX')
                order by 7,3
           ) a
           group by a.持仓日期
                 ,a.基金编码
                 ,a.历史日期
           order by 3
    )

    select 持仓日期
           ,基金编码
           ,净资产
           ,sum(case when 涨幅排名=floor(历史天数*0.95) then 模拟涨跌幅 else 0 end) as VAR_95
           ,sum(case when 涨幅排名=floor(历史天数*0.99) then 模拟涨跌幅 else 0 end) as VAR_99
    from
    (

        select k1.biz_date as 持仓日期
               ,k1.f_code as 基金编码
               ,k1.net_asset as 净资产
               ,k2.trade_days as 历史日期
               ,coalesce(k3.A股涨跌幅,0)+coalesce(k6.H股涨跌幅,0)+coalesce(k4.期货涨跌幅,0)+coalesce(k5.债券涨跌幅,0) as 模拟涨跌幅
               ,row_number() over (partition by k1.biz_date,k1.f_code order by coalesce(k3.A股涨跌幅,0)+coalesce(k6.H股涨跌幅,0)+coalesce(k4.期货涨跌幅,0)+coalesce(k5.债券涨跌幅,0) desc) as 涨幅排名
               ,sum(1) over (partition by k1.biz_date,k1.f_code) as 历史天数
               ,coalesce(k3.A股涨跌幅,0) as A股涨跌幅
               ,coalesce(k6.H股涨跌幅,0) as H股涨跌幅
               ,coalesce(k4.期货涨跌幅,0) as 期货涨跌幅
               ,coalesce(k5.债券涨跌幅,0) as 债券涨跌幅
               
        from ftuser.orig_fund_summary k1
        inner join wind.AShareCalendar k2
        on k2.TRADE_DAYS>v_last_date  --i_biz_date-'10000'
           and k2.TRADE_DAYS<=i_biz_date
           and k2.S_INFO_EXCHMARKET='SSE'
        left join k3
        on k1.f_code=k3.基金编码
           and k1.biz_date=k3.持仓日期
           and k2.TRADE_DAYS=k3.历史日期
        left join k4
        on k1.f_code=k4.基金编码
           and k1.biz_date=k4.持仓日期
           and k2.TRADE_DAYS=k4.历史日期
        left join k5
        on k1.f_code=k5.基金编码
           and k1.biz_date=k5.持仓日期
           and k2.TRADE_DAYS=k5.历史日期  
        left join k6
        on k1.f_code=k6.基金编码
           and k1.biz_date=k6.持仓日期
           and k2.TRADE_DAYS=k6.历史日期 
        where k1.f_code=i_f_code
              and k1.biz_date=i_biz_date
        order by 3    
          
    ) tt
    group by 持仓日期
           ,基金编码
           ,净资产
          ;
    
    commit;
    
    
                
 end;
$func$ language plpgsql;