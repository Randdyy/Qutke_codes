declare
   o_code number;
   o_note VARCHAR2(4000);
     
BEGIN

    FOR x IN (
        select * from (
        select t1.*, rownum as rowno from (
            select distinct f_code, start_date, end_date from fund_return_detail 
            -- where f_code in ('')
            order by f_code, start_date desc
        ) t1
        where rownum <= 16000) t2
        where t2.rowno > 15000
    ) LOOP
      
    pro_fund_return_analysis(o_code, o_note, x.f_code, x.start_date, x.end_date);
    
    commit;
    
    END LOOP;
END;