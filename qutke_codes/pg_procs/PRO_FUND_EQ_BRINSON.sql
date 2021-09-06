create or replace function PRO_FUND_EQ_BRINSON(
    i_f_code      in     varchar,
    i_startdate   in     varchar,      -- 开始日期
    i_enddate     in     varchar       -- 结束日期
)
returns void as $func$
declare

/*

计算股票投资业绩归因


20161129   创建


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
    
    select min(t.FT01) into v_endjyr
    from refdatauser.FT_TABLE1 t
    where t.FT01>=i_enddate
    ;

    select max(t.FT01) into v_startjyr_hk
    from refdatauser.FT_TABLE19 t
    where t.FT01<=i_startdate
          and t.FT11='HKEX'
    ;

    select min(t.FT01) into v_endjyr_hk
    from refdatauser.FT_TABLE19 t
    where t.FT01>=i_enddate
          and t.FT11='HKEX'
    ;
  

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




    delete from FUND_EQ_BRINSON_DETAIL a
    where a.f_code=i_f_code
          and a.start_date=i_startdate
          and a.end_date=i_enddate
    ;
    
    
/* 以 沪深300 为基准进行业绩归因 */
    
    insert into FUND_EQ_BRINSON_DETAIL
                (
                  F_CODE     ,
                  F_NAME     ,
                  START_DATE ,
                  END_DATE   ,
                  INDEX_TYPE ,
                  INDUSTRY   ,
                  WEIGHT_B   ,
                  RETURN_B   ,
                  WEIGHT_P   ,
                  RETURN_P   ,
                  WEIGHT_EX  ,
                  RETURN_EX  ,
                  AR1        ,
                  SR1        ,
                  AR2        ,
                  SR2        ,
                  IR2        ,
                  ADJ_FACTOR         
                )
                
    with fund_industry as
    (
        select f_code
               ,industry
               ,sum(weight1) as weight_p
               ,sum(return*weight2) as return_p
        from
        (
               
            select coalesce(t1.f_code,t2.f_code) as f_code
                   ,coalesce(t1.industry,t2.industry) as industry
                   ,coalesce(t1.stock_code,t2.stock_code) as stock_code
                   ,(coalesce(t1.weight,0)+coalesce(t2.weight,0))/2 as weight1   -- 在基金净资产中的权重
                   ,(coalesce(t1.weight,0)+coalesce(t2.weight,0))/(sum(coalesce(t1.weight,0)+coalesce(t2.weight,0)) over (partition by coalesce(t1.f_code,t2.f_code),coalesce(t1.industry,t2.industry))) as weight2   --在行业中的权重
                   ,coalesce(t4.FT12/t3.FT12-1,0) as return
            from
            (
                select a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,c.FT02
                       ,sum(a.balance/b.net_asset) as weight
                from fund_eq_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                left join refdatauser.FT_TABLE2 c
                on a.exchange_type=c.FT05
                   and a.stock_code=c.FT03
                where a.f_code=i_f_code
                      and a.biz_date=i_startdate
                      and a.exchange_type in ('SSE','SZSE')
                      and a.balance != 0
                group by a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,c.FT02
            ) t1
            full join 
            (
                select a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,c.FT02
                       ,sum(a.balance/b.net_asset) as weight
                from fund_eq_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                left join refdatauser.FT_TABLE2 c
                on a.exchange_type=c.FT05
                   and a.stock_code=c.FT03
                where a.f_code=i_f_code
                      and a.biz_date=i_enddate
                      and a.exchange_type in ('SSE','SZSE')
                      and a.balance != 0
                group by a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,c.FT02
            ) t2
            on t1.f_code=t2.f_code
               and t1.FT02=t2.FT02
            left join refdatauser.FT_TABLE17 t3
            on coalesce(t1.FT02,t2.FT02)=t3.FT02
               and t3.FT01=v_startjyr
            left join refdatauser.FT_TABLE17 t4
            on coalesce(t1.FT02,t2.FT02)=t4.FT02
               and t4.FT01=v_endjyr
               
        ) tt1
        where industry is not null
        group by f_code
               ,industry
    ) 
    ,
     market_industry as
    (

        select a.industry
               ,avg(coalesce(a.weight,0)) as weight_b
               ,sum(a.weight*(case when a.biz_date=v_startjyr then 0 else a.pct end)*a.adj_factor/(case when c.FT11<>b.FT11 then ln(c.FT11/b.FT11)/(c.FT11/b.FT11-1) else 1 end))/avg(coalesce(a.weight,0)) as return_b
        from refdatauser.industry_weight a
        left join refdatauser.FT_TABLE18 b
        on b.FT01=v_startjyr
        left join refdatauser.FT_TABLE18 c
        on c.FT01=v_endjyr
        where a.index_type='沪深300'
              and a.biz_date>=v_startjyr
              and a.biz_date<=v_endjyr
        group by a.industry
        
    )

    select i_f_code
           ,i_f_code
           ,i_startdate
           ,i_enddate
           ,'沪深300' as INDEX_TYPE
           ,t1.industry
           ,coalesce(t2.weight_b,1-coalesce(t4.weight_market,0)) as weight_b
           ,coalesce(t2.return_b,0) as return_b
           ,coalesce(t3.weight_p,0) as weight_p
           ,coalesce(t3.return_p,0) as return_p
           ,coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0) as weight_ex
           ,coalesce(t3.return_p,0)-coalesce(t2.return_b,0) as return_ex
           ,(coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0))*(coalesce(t2.return_b,0)-coalesce(t4.return_market,0)) as ar1
           ,(coalesce(t3.return_p,0)-coalesce(t2.return_b,0))*coalesce(t3.weight_p,0) as sr1
           ,(coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0))*(coalesce(t2.return_b,0)-coalesce(t4.return_market,0)) as ar2
           ,(coalesce(t3.return_p,0)-coalesce(t2.return_b,0))*coalesce(t2.weight_b,0) as sr2
           ,(coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0))*(coalesce(t3.return_p,0)-coalesce(t2.return_b,0)+coalesce(t4.return_market,0)) as ir2
           ,coalesce(case when t5.return_fund-t4.return_market=0 then 1
                          else (ln(1+t5.return_fund)-ln(1+t4.return_market))/(t5.return_fund-t4.return_market) end,1) as adj_factor
      
    from
    (
        select t.FT12 as industry
        from refdatauser.FT_TABLE4 t
        where substr(t.FT11,1,2)='61'
              and t.FT13=2
              and t.FT14=1
        union all
        select 'OTHER' as industry
        from dual
    ) t1
    left join 
    (
        select t.industry
               ,t.weight_b/b.weight_market as weight_b
               ,case when b.return_market=0 then t.return_b else t.return_b/b.return_market*a.total_return end as return_b
        from market_industry t
        ,
        (
            select (b.s_dq_close-a.s_dq_close)/a.s_dq_close as total_return
            from wind.AIndexEODPrices a
            left join wind.AIndexEODPrices b
            on b.s_info_windcode='399300.SZ'
               and b.trade_dt=v_endjyr
            where a.s_info_windcode='399300.SZ'
                  and a.trade_dt=v_startjyr
        ) a
        ,
        (
            select sum(weight_b) as weight_market
                   ,sum(weight_b*return_b) as return_market
            from market_industry 
        ) b
    ) t2
    on t1.industry=t2.industry
    left join
    (
        select
            t.f_code
            ,t.industry
            ,t.weight_p
            ,case when b.weight_stock = 1 then t.return_p*a.total_return/b.return_stock else t.return_p end as return_p
        from fund_industry t
        left join 
        (
            select a.f_code
                   ,coalesce(b.fq_nav/a.fq_nav-1,(coalesce(b.acc_nav,b.nav)-coalesce(a.acc_nav,a.nav))/coalesce(a.nav,a.acc_nav)) as total_return
            from orig_fund_summary a
            left join orig_fund_summary b
            on a.f_code=b.f_code
               and b.biz_date=i_enddate
            where a.f_code=i_f_code
                  and a.biz_date=i_startdate
        ) a
        on 1=1
        left join
        (
            select f_code
                   ,case when abs(coalesce(sum(weight_p), 0) - 1) < 1e-10 then 1 else coalesce(sum(weight_p), 0) end as weight_stock
                   ,coalesce(sum(weight_p*return_p), 0) as return_stock
            from dual left join fund_industry on 1=1
            group by f_code
        ) b
        on 1=1
        union all
        select a.f_code
               ,'OTHER' as industry
               ,1-b.weight_stock as weight_p
               ,case when (1-b.weight_stock) = 0 then 0 else (a.total_return-b.return_stock)/(1-b.weight_stock) end as return_p
        from
        (
            select a.f_code
                   ,coalesce(b.fq_nav/a.fq_nav-1,(coalesce(b.acc_nav,b.nav)-coalesce(a.acc_nav,a.nav))/coalesce(a.nav,a.acc_nav)) as total_return
            from orig_fund_summary a
            left join orig_fund_summary b
            on a.f_code=b.f_code
               and b.biz_date=i_enddate
            where a.f_code=i_f_code
                  and a.biz_date=i_startdate
        ) a
        left join 
        (
            select f_code
                   ,case when abs(coalesce(sum(weight_p), 0) - 1) < 1e-10 then 1 else coalesce(sum(weight_p), 0) end as weight_stock
                   ,coalesce(sum(weight_p*return_p), 0) as return_stock
            from dual left join fund_industry on 1=1
            group by f_code
        ) b
        on 1=1
    ) t3
    on t1.industry=t3.industry
    ,
    (
       select sum(weight_b) as weight_market
              ,sum(weight_b*return_b) as return_market
       from market_industry
    ) t4
    ,
    (
        select coalesce(b.fq_nav/a.fq_nav-1,(coalesce(b.acc_nav,b.nav)-coalesce(a.acc_nav,a.nav))/coalesce(a.nav,a.acc_nav)) as return_fund
        from orig_fund_summary a
        left join orig_fund_summary b
        on a.f_code=b.f_code
           and b.biz_date=i_enddate
        where a.f_code=i_f_code
              and a.biz_date=i_startdate
    ) t5
    ;
    
    

/* 以 中证500 为基准进行业绩归因 */


    
    insert into FUND_EQ_BRINSON_DETAIL
                (
                  F_CODE     ,
                  F_NAME     ,
                  START_DATE ,
                  END_DATE   ,
                  INDEX_TYPE ,
                  INDUSTRY   ,
                  WEIGHT_B   ,
                  RETURN_B   ,
                  WEIGHT_P   ,
                  RETURN_P   ,
                  WEIGHT_EX  ,
                  RETURN_EX  ,
                  AR1        ,
                  SR1        ,
                  AR2        ,
                  SR2        ,
                  IR2        ,
                  ADJ_FACTOR         
                )
                
    with fund_industry as
    (
        select f_code
               ,industry
               ,sum(weight1) as weight_p
               ,sum(return*weight2) as return_p
        from
        (
               
            select coalesce(t1.f_code,t2.f_code) as f_code
                   ,coalesce(t1.industry,t2.industry) as industry
                   ,coalesce(t1.stock_code,t2.stock_code) as stock_code
                   ,(coalesce(t1.weight,0)+coalesce(t2.weight,0))/2 as weight1   -- 在基金净资产中的权重
                   ,(coalesce(t1.weight,0)+coalesce(t2.weight,0))/(sum(coalesce(t1.weight,0)+coalesce(t2.weight,0)) over (partition by coalesce(t1.f_code,t2.f_code),coalesce(t1.industry,t2.industry))) as weight2   --在行业中的权重
                   ,coalesce(t4.FT12/t3.FT12-1,0) as return
            from
            (
                select a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,c.FT02
                       ,sum(a.balance/b.net_asset) as weight
                from fund_eq_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                left join refdatauser.FT_TABLE2 c
                on a.exchange_type=c.FT05
                   and a.stock_code=c.FT03
                where a.f_code=i_f_code
                      and a.biz_date=i_startdate
                      and a.exchange_type in ('SSE','SZSE')
                      and a.balance != 0
                group by a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,c.FT02
            ) t1
            full join 
            (
                select a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,c.FT02
                       ,sum(a.balance/b.net_asset) as weight
                from fund_eq_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                left join refdatauser.FT_TABLE2 c
                on a.exchange_type=c.FT05
                   and a.stock_code=c.FT03
                where a.f_code=i_f_code
                      and a.biz_date=i_enddate
                      and a.exchange_type in ('SSE','SZSE')
                      and a.balance != 0
                group by a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,c.FT02
            ) t2
            on t1.f_code=t2.f_code
               and t1.FT02=t2.FT02
            left join refdatauser.FT_TABLE17 t3
            on coalesce(t1.FT02,t2.FT02)=t3.FT02
               and t3.FT01=v_startjyr
            left join refdatauser.FT_TABLE17 t4
            on coalesce(t1.FT02,t2.FT02)=t4.FT02
               and t4.FT01=v_endjyr
               
        ) tt2
        where industry is not null
        group by f_code
               ,industry
    ) 
    ,
     market_industry as
    (

        select a.industry
               ,avg(coalesce(a.weight,0)) as weight_b
               ,sum(a.weight*(case when a.biz_date=v_startjyr then 0 else a.pct end)*a.adj_factor/(case when c.FT11<>b.FT11 then ln(c.FT11/b.FT11)/(c.FT11/b.FT11-1) else 1 end))/avg(coalesce(a.weight,0)) as return_b
        from refdatauser.industry_weight a
        left join 
        (
          select t.trade_dt as FT01
                 ,t.s_dq_close as FT11
          from wind.AIndexEODPrices t
          where t.s_info_windcode='399905.SZ'
        ) b
        on b.FT01=v_startjyr
        left join 
        (
          select t.trade_dt as FT01
                 ,t.s_dq_close as FT11
          from wind.AIndexEODPrices t
          where t.s_info_windcode='399905.SZ'
        ) c
        on c.FT01=v_endjyr
        where a.index_type='中证500'
              and a.biz_date>=v_startjyr
              and a.biz_date<=v_endjyr
        group by a.industry
        
    )

    select i_f_code
           ,i_f_code
           ,i_startdate
           ,i_enddate
           ,'中证500' as INDEX_TYPE
           ,t1.industry
           ,coalesce(t2.weight_b,1-coalesce(t4.weight_market,0)) as weight_b
           ,coalesce(t2.return_b,0) as return_b
           ,coalesce(t3.weight_p,0) as weight_p
           ,coalesce(t3.return_p,0) as return_p
           ,coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0) as weight_ex
           ,coalesce(t3.return_p,0)-coalesce(t2.return_b,0) as return_ex
           ,(coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0))*(coalesce(t2.return_b,0)-coalesce(t4.return_market,0)) as ar1
           ,(coalesce(t3.return_p,0)-coalesce(t2.return_b,0))*coalesce(t3.weight_p,0) as sr1
           ,(coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0))*(coalesce(t2.return_b,0)-coalesce(t4.return_market,0)) as ar2
           ,(coalesce(t3.return_p,0)-coalesce(t2.return_b,0))*coalesce(t2.weight_b,0) as sr2
           ,(coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0))*(coalesce(t3.return_p,0)-coalesce(t2.return_b,0)+coalesce(t4.return_market,0)) as ir2
           ,coalesce(case when t5.return_fund-t4.return_market=0 then 1
                          else (ln(1+t5.return_fund)-ln(1+t4.return_market))/(t5.return_fund-t4.return_market) end,1) as adj_factor
      
    from
    (
        select t.FT12 as industry
        from refdatauser.FT_TABLE4 t
        where substr(t.FT11,1,2)='61'
              and t.FT13=2
              and t.FT14=1
        union all
        select 'OTHER' as industry
        from dual
    ) t1
    left join 
    (
        select t.industry
               ,t.weight_b/b.weight_market as weight_b
               ,case when b.return_market=0 then t.return_b else t.return_b/b.return_market*a.total_return end as return_b
        from market_industry t
        ,
        (
            select (b.s_dq_close-a.s_dq_close)/a.s_dq_close as total_return
            from wind.AIndexEODPrices a
            left join wind.AIndexEODPrices b
            on b.s_info_windcode='000905.SH'
               and b.trade_dt=v_endjyr
            where a.s_info_windcode='000905.SH'
                  and a.trade_dt=v_startjyr
        ) a
        ,
        (
            select sum(weight_b) as weight_market
                   ,sum(weight_b*return_b) as return_market
            from market_industry 
        ) b
    ) t2
    on t1.industry=t2.industry
    left join
    (
        select
            t.f_code
            ,t.industry
            ,t.weight_p
            ,case when b.weight_stock = 1 then t.return_p*a.total_return/b.return_stock else t.return_p end as return_p
        from fund_industry t
        left join 
        (
            select a.f_code
                   ,coalesce(b.fq_nav/a.fq_nav-1,(coalesce(b.acc_nav,b.nav)-coalesce(a.acc_nav,a.nav))/coalesce(a.nav,a.acc_nav)) as total_return
            from orig_fund_summary a
            left join orig_fund_summary b
            on a.f_code=b.f_code
               and b.biz_date=i_enddate
            where a.f_code=i_f_code
                  and a.biz_date=i_startdate
        ) a
        on 1=1
        left join
        (
            select f_code
                   ,case when abs(coalesce(sum(weight_p), 0) - 1) < 1e-10 then 1 else coalesce(sum(weight_p), 0) end as weight_stock
                   ,coalesce(sum(weight_p*return_p), 0) as return_stock
            from dual left join fund_industry on 1=1
            group by f_code
        ) b
        on 1=1
        union all
        select a.f_code
               ,'OTHER' as industry
               ,1-b.weight_stock as weight_p
               ,case when (1-b.weight_stock) = 0 then 0 else (a.total_return-b.return_stock)/(1-b.weight_stock) end as return_p
        from
        (
            select a.f_code
                   ,coalesce(b.fq_nav/a.fq_nav-1,(coalesce(b.acc_nav,b.nav)-coalesce(a.acc_nav,a.nav))/coalesce(a.nav,a.acc_nav)) as total_return
            from orig_fund_summary a
            left join orig_fund_summary b
            on a.f_code=b.f_code
               and b.biz_date=i_enddate
            where a.f_code=i_f_code
                  and a.biz_date=i_startdate
        ) a
        left join 
        (
            select f_code
                   ,case when abs(coalesce(sum(weight_p), 0) - 1) < 1e-10 then 1 else coalesce(sum(weight_p), 0) end as weight_stock
                   ,coalesce(sum(weight_p*return_p), 0) as return_stock
            from dual left join fund_industry on 1=1
            group by f_code
        ) b
        on 1=1
    ) t3
    on t1.industry=t3.industry
    ,
    (
       select sum(weight_b) as weight_market
              ,sum(weight_b*return_b) as return_market
       from market_industry
    ) t4
    ,
    (
        select coalesce(b.fq_nav/a.fq_nav-1,(coalesce(b.acc_nav,b.nav)-coalesce(a.acc_nav,a.nav))/coalesce(a.nav,a.acc_nav)) as return_fund
        from orig_fund_summary a
        left join orig_fund_summary b
        on a.f_code=b.f_code
           and b.biz_date=i_enddate
        where a.f_code=i_f_code
              and a.biz_date=i_startdate
    ) t5
    ;
    
  
  


/* 以 恒生指数 为基准进行业绩归因 */


    insert into FUND_EQ_BRINSON_DETAIL
                (
                  F_CODE     ,
                  F_NAME     ,
                  START_DATE ,
                  END_DATE   ,
                  INDEX_TYPE ,
                  INDUSTRY   ,
                  WEIGHT_B   ,
                  RETURN_B   ,
                  WEIGHT_P   ,
                  RETURN_P   ,
                  WEIGHT_EX  ,
                  RETURN_EX  ,
                  AR1        ,
                  SR1        ,
                  AR2        ,
                  SR2        ,
                  IR2        ,
                  ADJ_FACTOR         
                )
                
    with fund_industry as
    (
        select f_code
               ,industry
               ,sum(weight1) as weight_p
               ,sum(return*weight2) as return_p
        from
        (
               
            select coalesce(t1.f_code,t2.f_code) as f_code
                   ,coalesce(t1.industry,t2.industry) as industry
                   ,coalesce(t1.stock_code,t2.stock_code) as stock_code
                   ,(coalesce(t1.weight,0)+coalesce(t2.weight,0))/2 as weight1   -- 在基金净资产中的权重
                   ,(coalesce(t1.weight,0)+coalesce(t2.weight,0))/(sum(coalesce(t1.weight,0)+coalesce(t2.weight,0)) over (partition by coalesce(t1.f_code,t2.f_code),coalesce(t1.industry,t2.industry))) as weight2   --在行业中的权重
                   ,case when t3.s_dq_adjclose = 0 then 0 else coalesce(t4.s_dq_adjclose/t3.s_dq_adjclose-1,0) end as return
            from
            (
                select a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,c.FT02
                       ,sum(a.balance/b.net_asset) as weight
                from fund_eq_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                left join refdatauser.FT_TABLE6 c
                on lpad(a.stock_code,5,'0')=lpad(c.FT03,5,'0')
                where a.f_code=i_f_code
                      and a.biz_date=i_startdate
                      and a.exchange_type in ('HKEX')
                      and a.balance != 0
                group by a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,c.FT02
            ) t1
            full join 
            (
                select a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,c.FT02
                       ,sum(a.balance/b.net_asset) as weight
                from fund_eq_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                left join refdatauser.FT_TABLE6 c
                on lpad(a.stock_code,5,'0')=lpad(c.FT03,5,'0')
                where a.f_code=i_f_code
                      and a.biz_date=i_enddate
                      and a.exchange_type in ('HKEX')
                      and a.balance != 0
                group by a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,c.FT02
            ) t2
            on t1.f_code=t2.f_code
               and t1.FT02=t2.FT02
            left join wind.HKshareEODPrices t3
            on coalesce(t1.FT02,t2.FT02)=t3.s_info_windcode
               and t3.trade_dt=v_startjyr_hk
            left join wind.HKshareEODPrices t4
            on coalesce(t1.FT02,t2.FT02)=t4.s_info_windcode
               and t4.trade_dt=v_endjyr_hk
               
        ) tt
        where industry is not null
        group by f_code
               ,industry
    ) 
    ,
     market_industry as
    (

        select a.industry
               ,avg(coalesce(a.weight,0)) as weight_b
               ,sum(a.weight*(case when a.biz_date=v_startjyr_hk then 0 else a.pct end)*a.adj_factor/(case when c.FT11<>b.FT11 then ln(c.FT11/b.FT11)/(c.FT11/b.FT11-1) else 1 end))/avg(coalesce(a.weight,0)) as return_b
        from refdatauser.industry_weight a
        left join 
        (
          select t.trade_dt as FT01
                 ,t.s_dq_close as FT11
          from wind.HKIndexEODPrices t
          where t.s_info_windcode='HSI.HI'
        ) b
        on b.FT01=v_startjyr_hk
        left join 
        (
          select t.trade_dt as FT01
                 ,t.s_dq_close as FT11
          from wind.HKIndexEODPrices t
          where t.s_info_windcode='HSI.HI'
        ) c
        on c.FT01=v_endjyr_hk
        where a.index_type='恒生指数'
              and a.biz_date>=v_startjyr_hk
              and a.biz_date<=v_endjyr_hk
        group by a.industry
        
    )

    select i_f_code
           ,i_f_code
           ,i_startdate
           ,i_enddate
           ,'恒生指数' as INDEX_TYPE
           ,t1.industry
           ,coalesce(t2.weight_b,0) as weight_b
           ,coalesce(t2.return_b,0) as return_b
           ,coalesce(t3.weight_p,0) as weight_p
           ,coalesce(t3.return_p,0) as return_p
           ,coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0) as weight_ex
           ,coalesce(t3.return_p,0)-coalesce(t2.return_b,0) as return_ex
           ,(coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0))*(coalesce(t2.return_b,0)-coalesce(t4.return_market,0)) as ar1
           ,(coalesce(t3.return_p,0)-coalesce(t2.return_b,0))*coalesce(t3.weight_p,0) as sr1
           ,(coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0))*(coalesce(t2.return_b,0)-coalesce(t4.return_market,0)) as ar2
           ,(coalesce(t3.return_p,0)-coalesce(t2.return_b,0))*coalesce(t2.weight_b,0) as sr2
           ,(coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0))*(coalesce(t3.return_p,0)-coalesce(t2.return_b,0)+coalesce(t4.return_market,0)) as ir2
           ,coalesce(case when t5.return_fund-t4.return_market=0 then 1
                          else (ln(1+t5.return_fund)-ln(1+t4.return_market))/(t5.return_fund-t4.return_market) end,1) as adj_factor
      
    from
    (
        select a.industriesname as industry
        from wind.HKStockIndustriesCode a
        where levelnum=2
              and industriesclass='恒生行业分类'
        union all
        select 'OTHER' as industry
        from dual
    ) t1
    left join 
    (
        select t.industry
               ,t.weight_b/b.weight_market as weight_b
               ,case when b.return_market=0 then t.return_b else t.return_b/b.return_market*a.total_return end as return_b
        from market_industry t
        ,
        (
            select (b.s_dq_close-a.s_dq_close)/a.s_dq_close as total_return
            from wind.HKIndexEODPrices a
            left join wind.HKIndexEODPrices b
            on b.s_info_windcode='HSI.HI'
               and b.trade_dt=v_endjyr_hk
            where a.s_info_windcode='HSI.HI'
                  and a.trade_dt=v_startjyr_hk
        ) a
        ,
        (
            select sum(weight_b) as weight_market
                   ,sum(weight_b*return_b) as return_market
            from market_industry 
        ) b
    ) t2
    on t1.industry=t2.industry
    left join
    (
        select
            t.f_code
            ,t.industry
            ,t.weight_p
            ,case when b.weight_stock = 1 then t.return_p*a.total_return/b.return_stock else t.return_p end as return_p
        from fund_industry t
        left join 
        (
            select a.f_code
                   ,coalesce(b.fq_nav/a.fq_nav-1,(coalesce(b.acc_nav,b.nav)-coalesce(a.acc_nav,a.nav))/coalesce(a.nav,a.acc_nav)) as total_return
            from orig_fund_summary a
            left join orig_fund_summary b
            on a.f_code=b.f_code
               and b.biz_date=i_enddate
            where a.f_code=i_f_code
                  and a.biz_date=i_startdate
        ) a
        on 1=1
        left join
        (
            select f_code
                   ,case when abs(coalesce(sum(weight_p), 0) - 1) < 1e-10 then 1 else coalesce(sum(weight_p), 0) end as weight_stock
                   ,coalesce(sum(weight_p*return_p), 0) as return_stock
            from dual left join fund_industry on 1=1
            group by f_code
        ) b
        on 1=1
        union all
        select a.f_code
               ,'OTHER' as industry
               ,1-b.weight_stock as weight_p
               ,case when (1-b.weight_stock) = 0 then 0 else (a.total_return-b.return_stock)/(1-b.weight_stock) end as return_p
        from
        (
            select a.f_code
                   ,coalesce(b.fq_nav/a.fq_nav-1,(coalesce(b.acc_nav,b.nav)-coalesce(a.acc_nav,a.nav))/coalesce(a.nav,a.acc_nav)) as total_return
            from orig_fund_summary a
            left join orig_fund_summary b
            on a.f_code=b.f_code
               and b.biz_date=i_enddate
            where a.f_code=i_f_code
                  and a.biz_date=i_startdate
        ) a
        left join 
        (
            select f_code
                   ,case when abs(coalesce(sum(weight_p), 0) - 1) < 1e-10 then 1 else coalesce(sum(weight_p), 0) end as weight_stock
                   ,coalesce(sum(weight_p*return_p), 0) as return_stock
            from dual left join fund_industry on 1=1
            group by f_code
        ) b
        on 1=1
    ) t3
    on t1.industry=t3.industry
    ,
    (
/*       select sum(weight_b) as weight_market
              ,sum(weight_b*return_b) as return_market
       from market_industry*/
       
        select 1 as weight_market
               ,(b.s_dq_close-a.s_dq_close)/a.s_dq_close as return_market
        from wind.HKIndexEODPrices a
        left join wind.HKIndexEODPrices b
        on b.s_info_windcode='HSI.HI'
           and b.trade_dt=v_endjyr_hk
        where a.s_info_windcode='HSI.HI'
              and a.trade_dt=v_startjyr_hk
       
    ) t4
    ,
    (
        select coalesce(b.fq_nav/a.fq_nav-1,(coalesce(b.acc_nav,b.nav)-coalesce(a.acc_nav,a.nav))/coalesce(a.nav,a.acc_nav)) as return_fund
        from orig_fund_summary a
        left join orig_fund_summary b
        on a.f_code=b.f_code
           and b.biz_date=i_enddate
        where a.f_code=i_f_code
              and a.biz_date=i_startdate
    ) t5
    ;
    

    
    


/* 以 50%沪深300+50%恒生指数 为基准进行业绩归因 */
    
  IF(length(i_f_code)>20) THEN
  
    insert into FUND_EQ_BRINSON_DETAIL
                (
                  F_CODE     ,
                  F_NAME     ,
                  START_DATE ,
                  END_DATE   ,
                  INDEX_TYPE ,
                  INDUSTRY   ,
                  WEIGHT_B   ,
                  RETURN_B   ,
                  WEIGHT_P   ,
                  RETURN_P   ,
                  WEIGHT_EX  ,
                  RETURN_EX  ,
                  AR1        ,
                  SR1        ,
                  AR2        ,
                  SR2        ,
                  IR2        ,
                  ADJ_FACTOR         
                )
                
    with fund_industry as
    (
        select f_code
               ,industry
               ,sum(weight1) as weight_p
               ,sum(return*weight2) as return_p
        from
        (
               
            select coalesce(t1.f_code,t2.f_code) as f_code
                   ,coalesce(t1.industry,t2.industry) as industry
                   ,coalesce(t1.stock_code,t2.stock_code) as stock_code
                   ,(coalesce(t1.weight,0)+coalesce(t2.weight,0))/2 as weight1   -- 在基金净资产中的权重
                   ,(coalesce(t1.weight,0)+coalesce(t2.weight,0))/(sum(coalesce(t1.weight,0)+coalesce(t2.weight,0)) over (partition by coalesce(t1.f_code,t2.f_code),coalesce(t1.industry,t2.industry))) as weight2   --在行业中的权重
                   
                   ,coalesce(
                   t41.FT12/t31.FT12-1,
                   case when t32.s_dq_adjclose = 0 then 0 else coalesce(t42.s_dq_adjclose/t32.s_dq_adjclose-1,0) end,
                   0
                   ) as return
            from
            (
                select a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,coalesce(c1.FT02,c2.FT02) as FT02
                       ,sum(a.balance/b.net_asset) as weight
                from fund_eq_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                left join refdatauser.FT_TABLE2 c1
                on a.exchange_type=c1.FT05
                   and a.stock_code=c1.FT03
                left join refdatauser.FT_TABLE6 c2
                on lpad(a.stock_code,5,'0')=lpad(c2.FT03,5,'0')
                   and a.exchange_type='HKEX'
                where a.f_code=i_f_code
                      and a.biz_date=i_startdate
                      and a.exchange_type in ('SSE','SZSE','HKEX')
                      and a.balance != 0
                group by a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,coalesce(c1.FT02,c2.FT02)
            ) t1
            full join 
            (
                select a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,coalesce(c1.FT02,c2.FT02) as FT02
                       ,sum(a.balance/b.net_asset) as weight
                from fund_eq_position a
                left join orig_fund_summary b
                on a.f_code=b.f_code
                   and a.biz_date=b.biz_date
                left join refdatauser.FT_TABLE2 c1
                on a.exchange_type=c1.FT05
                   and a.stock_code=c1.FT03
                left join refdatauser.FT_TABLE6 c2
                on lpad(a.stock_code,5,'0')=lpad(c2.FT03,5,'0')
                   and a.exchange_type='HKEX'
                where a.f_code=i_f_code
                      and a.biz_date=i_enddate
                      and a.exchange_type in ('HKEX')
                      and a.balance != 0
                group by a.biz_date
                       ,a.f_code
                       ,a.industry
                       ,a.stock_code
                       ,coalesce(c1.FT02,c2.FT02)
            ) t2
            on t1.f_code=t2.f_code
               and t1.FT02=t2.FT02
               
            left join refdatauser.FT_TABLE17 t31
            on coalesce(t1.FT02,t2.FT02)=t31.FT02
               and t31.FT01=v_startjyr
            left join refdatauser.FT_TABLE17 t41
            on coalesce(t1.FT02,t2.FT02)=t41.FT02
               and t41.FT01=v_endjyr
               
            left join wind.HKshareEODPrices t32
            on coalesce(t1.FT02,t2.FT02)=t32.s_info_windcode
               and t32.trade_dt=v_startjyr_hk
            left join wind.HKshareEODPrices t42
            on coalesce(t1.FT02,t2.FT02)=t42.s_info_windcode
               and t42.trade_dt=v_endjyr_hk
               
        ) tt
        where industry is not null
        group by f_code
               ,industry
    ) 
    ,
     market_industry as
    (

        select a.industry
               ,avg(coalesce(a.weight,0)) as weight_b
               ,sum(a.weight*(case when a.biz_date=i_startdate then 0 else a.pct end)*a.adj_factor/(case when (c1.FT11/b1.FT11-1)+(c2.FT11/b2.FT11-1)<>0 then ln(0.5*c1.FT11/b1.FT11+0.5*c2.FT11/b2.FT11)/(0.5*c1.FT11/b1.FT11+0.5*c2.FT11/b2.FT11-1) else 1 end))/avg(coalesce(a.weight,0)) as return_b
        from refdatauser.industry_weight a
        
        left join refdatauser.FT_TABLE18 b1
        on b1.FT01=v_startjyr
        left join refdatauser.FT_TABLE18 c1
        on c1.FT01=v_endjyr
        
        left join 
        (
          select t.trade_dt as FT01
                 ,t.s_dq_close as FT11
          from wind.HKIndexEODPrices t
          where t.s_info_windcode='HSI.HI'
        ) b2
        on b2.FT01=v_startjyr_hk
        left join 
        (
          select t.trade_dt as FT01
                 ,t.s_dq_close as FT11
          from wind.HKIndexEODPrices t
          where t.s_info_windcode='HSI.HI'
        ) c2
        on c2.FT01=v_endjyr_hk
        where a.index_type='50%沪深300+50%恒生指数'
              and a.biz_date>=i_startdate
              and a.biz_date<=i_enddate
        group by a.industry
        
    )

    select i_f_code
           ,i_f_code
           ,i_startdate
           ,i_enddate
           ,'50%沪深300+50%恒生指数' as INDEX_TYPE
           ,t1.industry
           ,coalesce(t2.weight_b,0) as weight_b
           ,coalesce(t2.return_b,0) as return_b
           ,coalesce(t3.weight_p,0) as weight_p
           ,coalesce(t3.return_p,0) as return_p
           ,coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0) as weight_ex
           ,coalesce(t3.return_p,0)-coalesce(t2.return_b,0) as return_ex
           ,(coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0))*(coalesce(t2.return_b,0)-coalesce(t4.return_market,0)) as ar1
           ,(coalesce(t3.return_p,0)-coalesce(t2.return_b,0))*coalesce(t3.weight_p,0) as sr1
           ,(coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0))*(coalesce(t2.return_b,0)-coalesce(t4.return_market,0)) as ar2
           ,(coalesce(t3.return_p,0)-coalesce(t2.return_b,0))*coalesce(t2.weight_b,0) as sr2
           ,(coalesce(t3.weight_p,0)-coalesce(t2.weight_b,0))*(coalesce(t3.return_p,0)-coalesce(t2.return_b,0)+coalesce(t4.return_market,0)) as ir2
           ,coalesce(case when t5.return_fund-t4.return_market=0 then 1
                          else (ln(1+t5.return_fund)-ln(1+t4.return_market))/(t5.return_fund-t4.return_market) end,1) as adj_factor
      
    from
    (
    
        select t.FT12 as industry
        from refdatauser.FT_TABLE4 t
        where substr(t.FT11,1,2)='61'
              and t.FT13=2
              and t.FT14=1
        union all
        select a.industriesname as industry
        from wind.HKStockIndustriesCode a
        where levelnum=2
              and industriesclass='恒生行业分类'
        union all
        select 'OTHER' as industry
        from dual
    ) t1
    left join 
    (
        select t.industry
               ,t.weight_b/b.weight_market as weight_b
               ,case when b.return_market=0 then t.return_b else t.return_b/b.return_market*(0.5*a1.total_return+0.5*a2.total_return) end as return_b
        from market_industry t
        ,
        (
            select b.FT11/a.FT11-1 as total_return
            from refdatauser.FT_TABLE18 a
            left join refdatauser.FT_TABLE18 b
            on b.FT01=v_endjyr
            where a.FT01=v_startjyr
        ) a1
        ,
        (
            select (b.s_dq_close-a.s_dq_close)/a.s_dq_close as total_return
            from wind.HKIndexEODPrices a
            left join wind.HKIndexEODPrices b
            on b.s_info_windcode='HSI.HI'
               and b.trade_dt=v_endjyr_hk
            where a.s_info_windcode='HSI.HI'
                  and a.trade_dt=v_startjyr_hk
        ) a2
        ,
        (
            select sum(weight_b) as weight_market
                   ,sum(weight_b*return_b) as return_market
            from market_industry 
        ) b
    ) t2
    on t1.industry=t2.industry
    left join
    (
        select
            t.f_code
            ,t.industry
            ,t.weight_p
            ,case when b.weight_stock = 1 then t.return_p*a.total_return/b.return_stock else t.return_p end as return_p
        from fund_industry t
        left join 
        (
            select a.f_code
                   ,coalesce(b.fq_nav/a.fq_nav-1,(coalesce(b.acc_nav,b.nav)-coalesce(a.acc_nav,a.nav))/coalesce(a.nav,a.acc_nav)) as total_return
            from orig_fund_summary a
            left join orig_fund_summary b
            on a.f_code=b.f_code
               and b.biz_date=i_enddate
            where a.f_code=i_f_code
                  and a.biz_date=i_startdate
        ) a
        on 1=1
        left join
        (
            select f_code
                   ,case when abs(coalesce(sum(weight_p), 0) - 1) < 1e-10 then 1 else coalesce(sum(weight_p), 0) end as weight_stock
                   ,coalesce(sum(weight_p*return_p), 0) as return_stock
            from dual left join fund_industry on 1=1
            group by f_code
        ) b
        on 1=1
        union all
        select a.f_code
               ,'OTHER' as industry
               ,1-b.weight_stock as weight_p
               ,case when (1-b.weight_stock) = 0 then 0 else (a.total_return-b.return_stock)/(1-b.weight_stock) end as return_p
        from
        (
            select a.f_code
                   ,coalesce(b.fq_nav/a.fq_nav-1,(coalesce(b.acc_nav,b.nav)-coalesce(a.acc_nav,a.nav))/coalesce(a.nav,a.acc_nav)) as total_return
            from orig_fund_summary a
            left join orig_fund_summary b
            on a.f_code=b.f_code
               and b.biz_date=i_enddate
            where a.f_code=i_f_code
                  and a.biz_date=i_startdate
        ) a
        left join 
        (
            select f_code
                   ,case when abs(coalesce(sum(weight_p), 0) - 1) < 1e-10 then 1 else coalesce(sum(weight_p), 0) end as weight_stock
                   ,coalesce(sum(weight_p*return_p), 0) as return_stock
            from dual left join fund_industry on 1=1
            group by f_code
        ) b
        on 1=1
    ) t3
    on t1.industry=t3.industry
    ,
    (
       
      select 1 as weight_market
             ,avg(return_market) as return_market
      from
      (
            select b.FT11/a.FT11-1 as return_market
            from refdatauser.FT_TABLE18 a
            left join refdatauser.FT_TABLE18 b
            on b.FT01=v_endjyr
            where a.FT01=v_startjyr
           
            union all
            
            select (b.s_dq_close-a.s_dq_close)/a.s_dq_close as return_market
            from wind.HKIndexEODPrices a
            left join wind.HKIndexEODPrices b
            on b.s_info_windcode='HSI.HI'
               and b.trade_dt=v_endjyr_hk
            where a.s_info_windcode='HSI.HI'
                  and a.trade_dt=v_startjyr_hk
       ) tt
      
    ) t4
    ,
    (
        select coalesce(b.fq_nav/a.fq_nav-1,(coalesce(b.acc_nav,b.nav)-coalesce(a.acc_nav,a.nav))/coalesce(a.nav,a.acc_nav)) as return_fund
        from orig_fund_summary a
        left join orig_fund_summary b
        on a.f_code=b.f_code
           and b.biz_date=i_enddate
        where a.f_code=i_f_code
              and a.biz_date=i_startdate
    ) t5
    ;
    
  END IF;
    
    
    
    
    
    
    
    delete from FUND_EQ_BRINSON_SUM a
    where a.f_code=i_f_code
          and a.start_date=i_startdate
          and a.end_date=i_enddate
    ;
    


/* 以 沪深300 为基准进行业绩归因 */


    insert into FUND_EQ_BRINSON_SUM
                (
                  F_CODE     ,
                  F_NAME     ,
                  START_DATE ,
                  END_DATE   ,
                  INDEX_TYPE ,
                  WEIGHT_B   ,
                  RETURN_B   ,
                  WEIGHT_P   ,
                  RETURN_P   ,
                  WEIGHT_EX  ,
                  RETURN_EX  ,
                  AR1        ,
                  SR1        ,
                  AR2        ,
                  SR2        ,
                  IR2        ,
                  ADJ_FACTOR         
                )
    select a.f_code
           ,a.f_code
           ,a.start_date
           ,a.end_date
           ,a.index_type
           ,sum(a.weight_b) as weight_b
           ,sum(a.weight_b*a.return_b) as return_b
           ,sum(a.weight_p) as weight_p
           ,sum(a.weight_p*a.return_p) as return_p
           ,sum(a.weight_ex) as weight_ex
           ,sum(a.weight_p*a.return_p)-sum(a.weight_b*a.return_b) as return_ex
           ,sum(a.ar1) as ar1
           ,sum(a.sr1) as sr1
           ,sum(a.ar2) as ar2
           ,sum(a.sr2) as sr2
           ,sum(a.ir2) as ir2
           ,max(a.adj_factor) as adj_factor
    from fund_eq_brinson_detail a
    where a.f_code=i_f_code
          and a.start_date=i_startdate
          and a.end_date=i_enddate
          and a.index_type='沪深300'
    group by a.f_code
           ,a.start_date
           ,a.end_date
           ,a.index_type
       ; 
    
    
    
    
    
    

    
/* 以 中证500 为基准进行业绩归因 */

    insert into FUND_EQ_BRINSON_SUM
                (
                  F_CODE     ,
                  F_NAME     ,
                  START_DATE ,
                  END_DATE   ,
                  INDEX_TYPE ,
                  WEIGHT_B   ,
                  RETURN_B   ,
                  WEIGHT_P   ,
                  RETURN_P   ,
                  WEIGHT_EX  ,
                  RETURN_EX  ,
                  AR1        ,
                  SR1        ,
                  AR2        ,
                  SR2        ,
                  IR2        ,
                  ADJ_FACTOR         
                )
    select a.f_code
           ,a.f_code
           ,a.start_date
           ,a.end_date
           ,a.index_type
           ,sum(a.weight_b) as weight_b
           ,sum(a.weight_b*a.return_b) as return_b
           ,sum(a.weight_p) as weight_p
           ,sum(a.weight_p*a.return_p) as return_p
           ,sum(a.weight_ex) as weight_ex
           ,sum(a.weight_p*a.return_p)-sum(a.weight_b*a.return_b) as return_ex
           ,sum(a.ar1) as ar1
           ,sum(a.sr1) as sr1
           ,sum(a.ar2) as ar2
           ,sum(a.sr2) as sr2
           ,sum(a.ir2) as ir2
           ,max(a.adj_factor) as adj_factor
    from fund_eq_brinson_detail a
    where a.f_code=i_f_code
          and a.start_date=i_startdate
          and a.end_date=i_enddate
          and a.index_type='中证500'
    group by a.f_code
           ,a.start_date
           ,a.end_date
           ,a.index_type
       ; 
       
       
/* 以 恒生指数 为基准进行业绩归因 */
    

  
    insert into FUND_EQ_BRINSON_SUM
                (
                  F_CODE     ,
                  F_NAME     ,
                  START_DATE ,
                  END_DATE   ,
                  INDEX_TYPE ,
                  WEIGHT_B   ,
                  RETURN_B   ,
                  WEIGHT_P   ,
                  RETURN_P   ,
                  WEIGHT_EX  ,
                  RETURN_EX  ,
                  AR1        ,
                  SR1        ,
                  AR2        ,
                  SR2        ,
                  IR2        ,
                  ADJ_FACTOR         
                )
    select a.f_code
           ,a.f_code
           ,a.start_date
           ,a.end_date
           ,a.index_type
           ,sum(a.weight_b) as weight_b
           ,sum(a.weight_b*a.return_b) as return_b
           ,sum(a.weight_p) as weight_p
           ,sum(a.weight_p*a.return_p) as return_p
           ,sum(a.weight_ex) as weight_ex
           ,sum(a.weight_p*a.return_p)-sum(a.weight_b*a.return_b) as return_ex
           ,sum(a.ar1) as ar1
           ,sum(a.sr1) as sr1
           ,sum(a.ar2) as ar2
           ,sum(a.sr2) as sr2
           ,sum(a.ir2) as ir2
           ,max(a.adj_factor) as adj_factor
    from fund_eq_brinson_detail a
    where a.f_code=i_f_code
          and a.start_date=i_startdate
          and a.end_date=i_enddate
          and a.index_type='恒生指数'
    group by a.f_code
           ,a.start_date
           ,a.end_date
           ,a.index_type
       ; 
   
       
  IF(length(i_f_code)>20) THEN
  
  
/* 以 50%沪深300+50%恒生指数 为基准进行业绩归因 */
    
    insert into FUND_EQ_BRINSON_SUM
                (
                  F_CODE     ,
                  F_NAME     ,
                  START_DATE ,
                  END_DATE   ,
                  INDEX_TYPE ,
                  WEIGHT_B   ,
                  RETURN_B   ,
                  WEIGHT_P   ,
                  RETURN_P   ,
                  WEIGHT_EX  ,
                  RETURN_EX  ,
                  AR1        ,
                  SR1        ,
                  AR2        ,
                  SR2        ,
                  IR2        ,
                  ADJ_FACTOR         
                )
    select a.f_code
           ,a.f_code
           ,a.start_date
           ,a.end_date
           ,a.index_type
           ,sum(a.weight_b) as weight_b
           ,sum(a.weight_b*a.return_b) as return_b
           ,sum(a.weight_p) as weight_p
           ,sum(a.weight_p*a.return_p) as return_p
           ,sum(a.weight_ex) as weight_ex
           ,sum(a.weight_p*a.return_p)-sum(a.weight_b*a.return_b) as return_ex
           ,sum(a.ar1) as ar1
           ,sum(a.sr1) as sr1
           ,sum(a.ar2) as ar2
           ,sum(a.sr2) as sr2
           ,sum(a.ir2) as ir2
           ,max(a.adj_factor) as adj_factor
    from fund_eq_brinson_detail a
    where a.f_code=i_f_code
          and a.start_date=i_startdate
          and a.end_date=i_enddate
          and a.index_type='50%沪深300+50%恒生指数'
    group by a.f_code
           ,a.start_date
           ,a.end_date
           ,a.index_type
       ; 
      
  END IF;
    
  
  

END;


$func$ language plpgsql;
