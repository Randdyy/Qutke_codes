select 'FUND_ANALYSIS_INFO' as table_name,count(*) from ftuser.FUND_ANALYSIS_INFO where length(f_code) != 24
union all
select 'FUND_ASSET_STRUCTUR' as table_name,count(*) from ftuser.FUND_ASSET_STRUCTUR where length(f_code) != 24
union all
select 'FUND_BOND_CONCEPT' as table_name,count(*) from ftuser.FUND_BOND_CONCEPT where length(f_code) != 24
union all
select 'FUND_BOND_POSITION' as table_name,count(*) from ftuser.FUND_BOND_POSITION where length(f_code) != 24
union all
select 'FUND_EQ_BRINSON_DETAIL' as table_name,count(*) from ftuser.FUND_EQ_BRINSON_DETAIL where length(f_code) != 24
union all
select 'FUND_EQ_BRINSON_SUM' as table_name,count(*) from ftuser.FUND_EQ_BRINSON_SUM where length(f_code) != 24
union all
select 'FUND_EQ_INDUSTRY' as table_name,count(*) from ftuser.FUND_EQ_INDUSTRY where length(f_code) != 24
union all
select 'FUND_EQ_POSITION' as table_name,count(*) from ftuser.FUND_EQ_POSITION where length(f_code) != 24
union all
select 'FUND_EQ_STYLE' as table_name,count(*) from ftuser.FUND_EQ_STYLE where length(f_code) != 24
union all
select 'FUND_FUND_POSITION' as table_name,count(*) from ftuser.FUND_FUND_POSITION where length(f_code) != 24
union all
select 'FUND_FUT_POSITION' as table_name,count(*) from ftuser.FUND_FUT_POSITION where length(f_code) != 24
union all
select 'FUND_FUT_TYPE' as table_name,count(*) from ftuser.FUND_FUT_TYPE where length(f_code) != 24
union all
select 'FUND_QUANT_ANALYSIS' as table_name,count(*) from ftuser.FUND_QUANT_ANALYSIS where length(f_code) != 24
union all
select 'FUND_RETURN_DETAIL' as table_name,count(*) from ftuser.FUND_RETURN_DETAIL where length(f_code) != 24
union all
select 'FUND_VAR' as table_name,count(*) from ftuser.FUND_VAR where length(f_code) != 24
union all
select 'ORIG_FUND_SUMMARY' as table_name,count(*) from ftuser.ORIG_FUND_SUMMARY where length(f_code) != 24
union all
select 'ORIG_POSITION' as table_name,count(*) from ftuser.ORIG_POSITION where length(f_code) != 24