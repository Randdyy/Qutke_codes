delete from ftuser.fund_eq_brinson_detail a where a.f_code in ('');
delete from ftuser.fund_eq_brinson_sum a where a.f_code in ('');
delete from ftuser.fund_return_detail a where a.f_code in ('');

declare
 o_code number;
 o_note VARCHAR2(4000);

begin
 for x in (
  select * from (
   select t1.*, rownum as rowno from (
    select a.f_code, a.start_date, a.end_date 
    from (select a.f_code, a.biz_date as end_date, lead(a.biz_date, 1, null) over (partition by a.f_code order by a.biz_date desc) as start_date 
    from ftuser.orig_fund_summary a where a.f_code in
    (
    '5e5c66a9496acd58aa1c37b6'
    )
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








































