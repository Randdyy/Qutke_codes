create or replace function PRO_FUND_BRINSON(
    i_f_code      in     varchar,      -- 基金内部编码
    i_biz_date    in     varchar       -- 计算日期
)
returns void as $func$
declare

/*

基金业绩归因


*/


   v_f_code       varchar(4000);
   v_lastday      varchar(8);
   v_nextday      varchar(8);
   
  
BEGIN
  
--    v_f_code := ';'||REPLACE(REPLACE(REPLACE(i_f_code, ',', ';'), '，', ';'), '；', ';')||';';
    v_f_code := ';'||i_f_code||';';

    IF(i_biz_date is null) THEN
            
        RETURN;
        
    END IF;
    
    
    IF(i_f_code is null) THEN
    
            
        RETURN;
        
    END IF;
    
    
    
    
    /* 基金股票投资业绩行业归因  */

    
        select max(a.biz_date) into v_lastday
        from FUND_ANALYSIS_INFO a
        where a.f_code=x.F_CODE
              and a.biz_date<i_biz_date
        ;
        
        select min(a.biz_date) into v_nextday
        from FUND_ANALYSIS_INFO a
        where a.f_code=x.F_CODE
              and a.biz_date>i_biz_date
        ;
        
        delete from FUND_EQ_BRINSON_DETAIL a
        where a.f_code=x.F_CODE
              and (a.start_date=v_lastday or a.end_date=v_nextday)
        ;
    
        delete from FUND_EQ_BRINSON_SUM a
        where a.f_code=x.F_CODE
              and (a.start_date=v_lastday or a.end_date=v_nextday)
        ;
    
    
        IF(v_lastday is not null) THEN
        
            select PRO_FUND_EQ_BRINSON(o_code, o_note, x.F_CODE, v_lastday, i_biz_date);
            
            if o_code<>1  then
              rollback;
              return;
            end if;
            
        END IF;
        
        IF(v_nextday is not null) THEN
        
            select PRO_FUND_EQ_BRINSON(o_code, o_note, x.F_CODE, i_biz_date, v_nextday);
            
            if o_code<>1 then
              rollback;
              return;
            end if;
            
        END IF;
    
    commit;
end;
$func$ language plpgsql;