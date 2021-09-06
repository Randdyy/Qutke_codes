create or replace function PRO_STOCK_CONCEPT(
    i_startdate   in     varchar,     -- 开始日期
    i_enddate     in     varchar       -- 结束日期
)
returns void as $func$
declare

/*
计算股票概念分类


20161024   创建


*/

    v_startDate varchar(8);
    v_endDate   varchar(8);
  
BEGIN
  

    SELECT coalesce(i_startdate,to_char(sysdate-15,'yyyymmdd')) INTO v_startDate
    FROM dual;
       
    SELECT coalesce(i_enddate,to_char(sysdate,'yyyymmdd')) INTO v_endDate
    FROM dual;
       
    delete from STOCK_CONCEPT a
    where a.biz_date>=v_startDate
          and a.biz_date<=v_endDate
    ;



BEGIN
  

    insert into STOCK_CONCEPT
                (
                  BIZ_DATE      ,
                  EXCHANGE_TYPE ,
                  STOCK_CODE    ,
                  CONCEPT_NUM   ,
                  CONCEPT_NAME       
                )
    select  a.trade_days as biz_Date
           ,d.s_info_exchmarket as EXCHANGE_TYPE
           ,d.s_info_code as stock_code
           ,sum(1) as CONCEPT_NUM
        --   ,to_char(wm_concat(e.wind_sec_name)) as CONCEPT_NAME
           ,to_char(listagg(e.wind_sec_name,',') within group(order by e.wind_sec_name)) as CONCEPT_NAME
    from AShareCalendar a
    left join AShareDescription d
    on 1=1
    inner join AShareConseption e
    on d.S_INFO_WINDCODE=e.S_INFO_WINDCODE
       and e.entry_dt<=a.trade_days
       and (e.remove_dt>=a.trade_days or e.remove_dt is null)
    where a.trade_days>=v_startDate
          and a.trade_days<=v_endDate
          and a.s_info_exchmarket='SSE'
    group by a.trade_days,d.s_info_exchmarket,d.s_info_code
    order by 1,2,3
    
    ;
    
    commit;

END;   


            
end;
$func$ language plpgsql;