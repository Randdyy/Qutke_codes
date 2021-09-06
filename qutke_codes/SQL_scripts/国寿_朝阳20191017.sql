select 
coalesce(c.category1,"OTHER") as 一级分类,
coalesce(b.px_code,"OTHER") as 分类代码,
sum(ref_return*(weight1+weight2)/2) as 资产收益贡
from fund_return_detail a where a.f_code='000264.OF' and start_date>19980724 and end_date<20190101 
left join clpc_asset_category b
on a.ref_code = b.ref_code
left join fund_asset_category c
on b.px_code = c.px_code
