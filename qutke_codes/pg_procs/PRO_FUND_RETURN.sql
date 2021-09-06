create or replace function PRO_FUND_RETURN(
    i_f_code      in     varchar,      -- 基金内部编码
    i_biz_date    in     varchar       -- 计算日期
)
returns void as $func$
declare

/*

收益分解


*/

   v_lastday      VARCHAR(8);
   v_nextday      VARCHAR(8);
   
  
BEGIN
  


    IF(i_biz_date is null) THEN
    
            
        RETURN;
        
    END IF;
    
    
    IF(i_f_code is null) THEN
    

            
        RETURN;
        
    END IF;
    
    
    
    
    /* 收益分解  */
    

    
        select max(a.biz_date) into v_lastday
        from FUND_ANALYSIS_INFO a
        where a.f_code=i_f_code
              and a.biz_date<i_biz_date
        ;
        
        select min(a.biz_date) into v_nextday
        from FUND_ANALYSIS_INFO a
        where a.f_code=i_f_code
              and a.biz_date>i_biz_date
        ;
        
        delete from FUND_RETURN_DETAIL a
        where a.f_code=i_f_code
              and (a.start_date=v_lastday or a.end_date=v_nextday)
        ;
    

    
    
        IF(v_lastday is not null) THEN
        
            select PRO_FUND_RETURN_ANALYSIS(o_code, o_note, i_f_code, v_lastday, i_biz_date);
            
            if o_code<>1  then
              rollback;
              return;
            end if;
            
        END IF;
        
        IF(v_nextday is not null) THEN
        
            select PRO_FUND_RETURN_ANALYSIS(o_code, o_note, i_f_code, i_biz_date, v_nextday);
            
            if o_code<>1 then
              rollback;
              return;
            end if;
            
        END IF;
    
    
    commit;
    
    
end;
$func$ language plpgsql;