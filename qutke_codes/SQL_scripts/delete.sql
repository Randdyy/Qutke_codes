delete from maa_ftuser.FUND_ANALYSIS_INFO where length(f_code)!=24 and biz_date>='20190601';
commit; 
delete from maa_ftuser.FUND_ASSET_STRUCTUR where length(f_code)!=24 and biz_date>='20190601';
commit; 
delete from maa_ftuser.FUND_BOND_CONCEPT where length(f_code)!=24 and biz_date>='20190601';
commit; 
delete from maa_ftuser.FUND_BOND_POSITION where length(f_code)!=24 and biz_date>='20190601';
commit; 
delete from maa_ftuser.fund_eq_concept where length(f_code)!=24 and biz_date>='20190601';
commit; 
delete from maa_ftuser.FUND_EQ_INDUSTRY where length(f_code)!=24 and biz_date>='20190601';
commit; 
delete from maa_ftuser.FUND_EQ_POSITION where length(f_code)!=24 and biz_date>='20190601';
commit; 
delete from maa_ftuser.FUND_EQ_STYLE where length(f_code)!=24 and biz_date>='20190601';
commit; 
delete from maa_ftuser.FUND_FUND_POSITION where length(f_code)!=24 and biz_date>='20190601';
commit; 
delete from maa_ftuser.FUND_FUT_POSITION where length(f_code)!=24 and biz_date>='20190601';
commit; 
delete from maa_ftuser.FUND_FUT_TYPE where length(f_code)!=24 and biz_date>='20190601';
commit; 
delete from maa_ftuser.FUND_QUANT_ANALYSIS where length(f_code)!=24 and biz_date>='20190601';
commit; 
delete from maa_ftuser.FUND_VAR where length(f_code)!=24 and biz_date>='20190601';
commit; 
delete from maa_ftuser.ORIG_FUND_SUMMARY where length(f_code)!=24 and biz_date>='20190601';
commit; 
delete from maa_ftuser.ORIG_POSITION where length(f_code)!=24 and biz_date>='20190601';
commit; 


delete from maa_ftuser.FUND_RETURN_DETAIL where length(f_code)!=24 and end_date>='20190601';
commit; 
delete from maa_ftuser.FUND_EQ_BRINSON_DETAIL where length(f_code)!=24 and end_date>='20190601';
commit; 
delete from maa_ftuser.FUND_EQ_BRINSON_SUM where length(f_code)!=24 and end_date>='20190601';
commit;
