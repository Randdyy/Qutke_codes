DECLARE
    o_code  NUMBER;
    o_note  VARCHAR2 (4000);
  BEGIN
    for x in (
        
        select t1.*, rownum as rownu from (
               select distinct f_code, biz_date from orig_fund_summary a
               where f_code  in (
  'xxxxx'
               )  
               and a.biz_date >= 20200101 and a.biz_date <20200901
               order by biz_date desc
        ) t1
    
    ) loop 
  
    PRO_FUND_POSITION_ANALYSIS(o_code, o_note, x.f_code, x.biz_date);
    commit;
    end loop;
  END;