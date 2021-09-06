create or replace function PRO_INDUSTRY_WEIGHT(
    i_startdate   in     varchar,     -- 开始日期
    i_enddate     in     varchar       -- 结束日期
)
returns void as $func$
declare


/*
计算行业市值权重


20161024   创建


*/

    v_startDate varchar(8);
    v_endDate   varchar(8);
  
BEGIN
  

    SELECT coalesce(i_startdate,to_char(sysdate-15,'yyyymmdd')) INTO v_startDate
    FROM dual;
       
    SELECT coalesce(i_enddate,to_char(sysdate,'yyyymmdd')) INTO v_endDate
    FROM dual;
       
    delete from INDUSTRY_WEIGHT a
    where a.biz_date>=v_startDate
          and a.biz_date<=v_endDate
    ;


  

    insert into INDUSTRY_WEIGHT
                (
                  biz_date      ,
                  index_type    ,
                  industry      ,
                  weight        ,
                  pct           ,
                  ADJ_FACTOR
                )
                
    with t1 as 
    (
        select a.trade_dt as biz_date
               ,'沪深300' as index_type
               ,f.industriesname as industry
               ,sum(a.i_weight)/100 as weight
               ,sum(a.i_weight*b.s_dq_pctchange)/sum(a.i_weight)/100 as pct
        from  AIndexHS300Weight a
        left join AShareEODPrices b
        on a.s_con_windcode=b.s_info_windcode
           and a.trade_dt=b.trade_dt
        left join AShareSWIndustriesClass e
        on a.s_con_windcode=e.s_info_windcode
           and e.CUR_SIGN='1'
        left join AShareIndustriesCode f
        on substr(e.SW_IND_CODE,1,4)=substr(f.industriescode,1,4)
           and f.levelnum=2
        where a.trade_dt>=v_startDate
              and a.trade_dt<=v_endDate
              and a.s_info_windcode='000300.SH'
        group by a.trade_dt,f.industriesname
        
        union all
        
        select a.trade_dt as biz_date
               ,'中证500' as index_type
               ,f.industriesname as industry
               ,sum(a.weight)/100 as weight
               ,sum(a.weight*b.s_dq_pctchange)/sum(a.weight)/100 as pct
        from  AIndexCSI500Weight a
        left join AShareEODPrices b
        on a.s_con_windcode=b.s_info_windcode
           and a.trade_dt=b.trade_dt
        left join AShareSWIndustriesClass e
        on a.s_con_windcode=e.s_info_windcode
           and e.CUR_SIGN='1'
        left join AShareIndustriesCode f
        on substr(e.SW_IND_CODE,1,4)=substr(f.industriescode,1,4)
           and f.levelnum=2
        where a.trade_dt>=v_startDate
              and a.trade_dt<=v_endDate
              and a.s_info_windcode='000905.SH'
        group by a.trade_dt,f.industriesname
        
        union all
        
        select t.financial_trade_dt as biz_date
               ,'恒生行业分类' as index_type
               ,t.industriesname as industry
               ,t.mv/sum(mv) over (partition by financial_trade_dt) as weight
               ,t.pct as pct
        from
        (
            select a.financial_trade_dt
                   ,c.industriesname
                   ,sum(a.s_val_mv) as mv
                   ,sum(a.s_val_mv*(d.S_DQ_CLOSE/(case when d.S_DQ_PRECLOSE=0 then d.S_DQ_CLOSE else d.S_DQ_PRECLOSE end)-1))/sum(a.s_val_mv) as pct
            from HKShareEODDerivativeIndex a
            inner join HKStockHSIndustriesMembers b
            on a.s_info_windcode=b.s_info_windcode
               and (b.entry_dt is null or b.entry_dt<=a.financial_trade_dt)
               and (b.remove_dt is null or b.remove_dt>=a.financial_trade_dt)
            inner join HKStockIndustriesCode c
            on substr(b.HS_IND_CODE,1,7)=substr(c.industriescode,1,7)
               and c.levelnum=2
               and c.industriesclass='恒生行业分类'
            left join HKshareEODPrices d
            on a.s_info_windcode=d.s_info_windcode
               and a.financial_trade_dt=d.trade_dt
            where a.financial_trade_dt>=v_startDate
                  and a.financial_trade_dt<=v_endDate
                  and a.s_val_mv is not null
            group by a.financial_trade_dt
                   ,c.industriesname
         ) t
         
        union all
         
        select a.trade_dt as biz_date
               ,'恒生指数' as index_type
               ,c.industriesname as industry
               ,sum(a.S_WEIGHT)/100 as weight 
               -- ,sum(a.S_WEIGHT*(d.s_dq_adjclose/(case when d.s_dq_adjpreclose=0 then d.s_dq_adjclose else d.s_dq_adjpreclose end)-1))/sum(a.S_WEIGHT) as pct
               ,sum(a.S_WEIGHT*d.s_dq_pctchange)/sum(a.S_WEIGHT)/100 as pct
        from HKStockHSIndexWeight a
        left join HKStockHSIndustriesMembers b
        on a.COMPON_STOCK_WINDCODE=b.s_info_windcode
           and (b.entry_dt is null or b.entry_dt<=a.trade_dt)
           and (b.remove_dt is null or b.remove_dt>=a.trade_dt)
        left join HKStockIndustriesCode c
        on substr(b.HS_IND_CODE,1,7)=substr(c.industriescode,1,7)
           and c.levelnum=2
           and c.industriesclass='恒生行业分类'
      --   left join HKshareEODPrices d
      --   on a.COMPON_STOCK_WINDCODE=d.s_info_windcode
      --      and a.trade_dt=d.trade_dt
        left join HKIndexEODPrices d
        on a.trade_dt = d.trade_dt
           and d.s_info_windcode='HSI.HI'
        where a.ixdex_windcode='HSI.HI'
              and a.trade_dt>=v_startDate
              and a.trade_dt<=v_endDate
        group by a.trade_dt
               ,c.industriesname
               
        union all
               
        select a.trade_dt as biz_date
               ,'50%沪深300+50%恒生指数' as index_type
               ,f.industriesname as industry
               ,sum(a.i_weight)/100/2 as weight
               ,sum(a.i_weight*b.s_dq_pctchange)/sum(a.i_weight)/100 as pct
        from  AIndexHS300Weight a
        left join AShareEODPrices b
        on a.s_con_windcode=b.s_info_windcode
           and a.trade_dt=b.trade_dt
        left join AShareSWIndustriesClass e
        on a.s_con_windcode=e.s_info_windcode
           and e.CUR_SIGN='1'
        left join AShareIndustriesCode f
        on substr(e.SW_IND_CODE,1,4)=substr(f.industriescode,1,4)
           and f.levelnum=2
        where a.trade_dt>=v_startDate
              and a.trade_dt<=v_endDate
              and a.s_info_windcode='000300.SH'
        group by a.trade_dt,f.industriesname
        union all
        select a.trade_dt as biz_date
               ,'50%沪深300+50%恒生指数' as index_type
               ,c.industriesname as industry
               ,sum(a.S_WEIGHT)/100/2 as weight 
               ,sum(a.S_WEIGHT*(d.s_dq_adjclose/(case when d.s_dq_adjpreclose=0 then d.s_dq_adjclose else d.s_dq_adjpreclose end)-1))/sum(a.S_WEIGHT) as pct
        from HKStockHSIndexWeight a
        inner join HKStockHSIndustriesMembers b
        on a.COMPON_STOCK_WINDCODE=b.s_info_windcode
           and (b.entry_dt is null or b.entry_dt<=a.trade_dt)
           and (b.remove_dt is null or b.remove_dt>=a.trade_dt)
        inner join HKStockIndustriesCode c
        on substr(b.HS_IND_CODE,1,7)=substr(c.industriescode,1,7)
           and c.levelnum=2
           and c.industriesclass='恒生行业分类'
        left join HKshareEODPrices d
        on a.COMPON_STOCK_WINDCODE=d.s_info_windcode
           and a.trade_dt=d.trade_dt
        where a.ixdex_windcode='HSI.HI'
              and a.trade_dt>=v_startDate
              and a.trade_dt<=v_endDate
        group by a.trade_dt
               ,c.industriesname
               
               
         
    )
    select t1.biz_date
           ,t1.index_type
           ,t1.industry
           ,t1.weight
           ,t1.pct
           ,case when return_b=0 then 1 else ln(1+return_b)/return_b end as adj_factor
    from t1
    left join 
    (
         select biz_date
                ,index_type
                ,sum(weight*pct) as return_b
         from t1
         group by biz_date,index_type
    ) t2
    on t1.biz_date=t2.biz_date
       and t1.index_type=t2.index_type

    order by 1,2,3
    
    ;
    
end;

$func$ language plpgsql;