create or replace function PRO_STOCK_BETA
(

    i_startdate   in     varchar,     -- 开始日期
    i_enddate     in     varchar       -- 结束日期
  
) 
returns void as $func$
declare


/*
计算股票BETA


20170329   创建


*/

    v_startDate varchar(8);
    v_endDate   varchar(8);
  
BEGIN
  

    SELECT coalesce(i_startdate,to_char(sysdate-30,'yyyymmdd')) INTO v_startDate
    FROM dual;
       
    SELECT coalesce(i_enddate,to_char(sysdate,'yyyymmdd')) INTO v_endDate
    FROM dual;
       
    delete from STOCK_BETA a
    where a.biz_date>=v_startDate
          and a.biz_date<=v_endDate
    ;


BEGIN
  

    insert into STOCK_BETA
                (
                  BIZ_DATE      ,
                  REF_CODE      ,
                  EXCHANGE_TYPE ,
                  STOCK_CODE    ,
                  BETA300_90D   ,
                  BETA300_180D  ,
                  BETA300_1Y    ,
                  BETA300_2Y    ,
                  BETA500_90D   ,
                  BETA500_180D  ,
                  BETA500_1Y    ,
                  BETA500_2Y
                )
    select *
    from
    (
        select a.trade_dt as BIZ_DATE
               ,a.s_info_windcode as REF_CODE
               ,b.S_INFO_EXCHMARKET as EXCHANGE_TYPE
               ,b.S_INFO_CODE as STOCK_CODE
               ,regr_slope(a.stk_pct,a.ind300_pct) over (partition by a.s_info_windcode order BY to_number(a.trade_dt) desc range between 0 following and a.trade_dt-to_number(to_char(to_date(a.trade_dt, 'yyyymmdd')-90, 'yyyymmdd'))-1  following) as beta300_90d
               ,regr_slope(a.stk_pct,a.ind300_pct) over (partition by a.s_info_windcode order BY to_number(a.trade_dt) desc range between 0 following and a.trade_dt-to_number(to_char(to_date(a.trade_dt, 'yyyymmdd')-180, 'yyyymmdd'))-1  following) as beta300_180d
               ,regr_slope(a.stk_pct,a.ind300_pct) over (partition by a.s_info_windcode order BY to_number(a.trade_dt) desc range between 0 following and 10000-1  following) as beta300_1y
               ,regr_slope(a.stk_pct,a.ind300_pct) over (partition by a.s_info_windcode order BY to_number(a.trade_dt) desc range between 0 following and 20000-1  following) as beta300_2y
               ,regr_slope(a.stk_pct,a.ind500_pct) over (partition by a.s_info_windcode order BY to_number(a.trade_dt) desc range between 0 following and a.trade_dt-to_number(to_char(to_date(a.trade_dt, 'yyyymmdd')-90, 'yyyymmdd'))-1  following) as beta500_90d
               ,regr_slope(a.stk_pct,a.ind500_pct) over (partition by a.s_info_windcode order BY to_number(a.trade_dt) desc range between 0 following and a.trade_dt-to_number(to_char(to_date(a.trade_dt, 'yyyymmdd')-180, 'yyyymmdd'))-1  following) as beta500_180d
               ,regr_slope(a.stk_pct,a.ind500_pct) over (partition by a.s_info_windcode order BY to_number(a.trade_dt) desc range between 0 following and 10000-1  following) as beta500_1y
               ,regr_slope(a.stk_pct,a.ind500_pct) over (partition by a.s_info_windcode order BY to_number(a.trade_dt) desc range between 0 following and 20000-1  following) as beta500_2y
        from 
        (
            SELECT t1.trade_dt
                   ,t1.s_info_windcode
                   ,t1.S_DQ_PCTCHANGE as stk_pct 
                   ,t3.S_DQ_PCTCHANGE as ind300_pct
                   ,t4.S_DQ_PCTCHANGE as ind500_pct
            from AShareEODPrices t1
            left join AIndexEODPrices t3
            on t1.trade_dt=t3.trade_dt
               and t3.s_info_windcode='399300.SZ'
            left join AIndexEODPrices t4
            on t1.trade_dt=t4.trade_dt
               and t4.s_info_windcode='399905.SZ'
            where (t1.trade_dt, t1.s_info_windcode) NOT IN (SELECT S_DQ_SUSPENDDATE, s_info_windcode 
                                                            FROM AShareTradingSuspension 
                                                            WHERE S_DQ_SUSPENDDATE <= v_endDate 
                                                                  AND S_DQ_SUSPENDDATE >= to_char(to_number(v_startDate)-20000)
                                                            ) 
                  and t1.trade_dt<=v_endDate
                  and t1.trade_dt>=to_char(to_number(v_startDate)-20000)
            order by 1 desc,2
        ) a
        left join AShareDescription b
        on a.s_info_windcode=b.s_info_windcode
    ) t
    where t.BIZ_DATE>=v_startDate
          and t.BIZ_DATE<=v_endDate
    order by 1 desc,2
    ;
    
    commit;


END;   
END;

$func$ language plpgsql;