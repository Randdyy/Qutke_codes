--查询其他类型的
select distinct stock_code,stock_name from orig_position  where  asset_type='0' and stock_code not like 'CL%'；
commit;

-- 养老金
update ftuser.orig_position a set a.asset_type ='11' where a.stock_code in (select exchange from tq_pf_basicinfo);
commit;

-- 手动更新养老金
1、update orig_position set  stock_code=UPPER(stock_code) where asset_type='0'    --（小写转大写）
commit;
2、update ftuser.orig_position a set a.stock_code ='正确的 code' where a.asset_type='0' and a.stock_code='错误的 code';   --（名字为养老金的）
commit;

-- 回购资产
update ftuser.orig_position a set a.asset_type ='13' where a.stock_code in ('') and asset_type='0';
commit;

-- 非标资产
update ftuser.orig_position a set a.asset_type ='12' where a.stock_code in (select productcode from none_standard_product);
commit;


-- 持仓分析
declare
   o_code number;
   o_note VARCHAR2(4000);
     
BEGIN

    FOR x IN (
        select * from (
        select t1.*, rownum as rowno from (
            select distinct f_code, biz_date from orig_fund_summary 
            --where f_code in ('5ceca31dd6f50e4858bca359')
            order by f_code, biz_date desc
        ) t1
        where rownum <= 1150) t2
        where t2.rowno > 1000
    ) LOOP
      
    pro_fund_position_analysis(o_code, o_note, x.f_code, x.biz_date);
    
    commit;
    
    END LOOP;
END;


-- 收益率
declare
   o_code number;
   o_note VARCHAR2(4000);
     
BEGIN

    FOR x IN (
        select * from (
        select t1.*, rownum as rowno from (
            select distinct f_code, start_date, end_date from fund_return_detail 
            --where f_code in ('5ceca31dd6f50e4858bca359')
            order by f_code, start_date desc
        ) t1
        where rownum <= 1127) t2
        where t2.rowno > 0
    ) LOOP
      
    pro_fund_return_analysis(o_code, o_note, x.f_code, x.start_date, x.end_date);
    
    commit;
    
    END LOOP;
END;