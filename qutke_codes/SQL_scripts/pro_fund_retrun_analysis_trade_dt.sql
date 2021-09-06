declare
 o_code number;
 o_note VARCHAR2(4000);

begin
 for x in (
  select * from (
   select t1.*, rownum as rowno from (
    select a.f_code, a.start_date, a.end_date 
    from (select a.f_code, a.biz_date as end_date, lead(a.biz_date, 1, null) over (partition by a.f_code order by a.biz_date desc) as start_date 
    from (
      select a.f_code, a.biz_date from ftuser.orig_fund_summary a
      left join wind.asharecalendar b
      on a.biz_date = b.trade_days and b.s_info_exchmarket = 'SSE'
      where
     f_code in (
       '5f1fed4786662314bac8ff9c',
       '5d0095092199a77b21a245d6',
       '5d0094d62199a77b21a245d5',
       '5a66d16b51a5b54829dd73c1',
       '5a66d13a51a5b54829dd73c0',
       '5a66d11251a5b54829dd73bf',
       '5a66d0f351a5b54829dd7349'
     )--中再的
      and b.trade_days is not null and a.biz_date >= 20200930-- and a.biz_date <= 20200429
    ) a
    ) a
    where a.start_date is not null
   ) t1
   where rownum >= 0
  ) t2
  where t2.rowno > 0
 ) loop
 pro_fund_eq_brinson(o_code, o_note, x.f_code, x.start_date, x.end_date);
 pro_fund_return_analysis(o_code, o_note, x.f_code, x.start_date, x.end_date);
 commit;
 end loop;
end;


