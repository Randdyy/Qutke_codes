create or replace procedure PRO_FUND_QUANT_ANALYSIS
(

    o_code        out    number,
    o_note        out    varchar2,
    i_f_code      in     varchar2,      -- 基金内部编码
    i_biz_date    in     varchar2       -- 计算日期
  
) 
IS

/*

量化基金分析


*/


   v_f_code       VARCHAR2(4000);
   v_jyr          VARCHAR2(8);  
   net_asset_flag number;
  
  
BEGIN
  
--    v_f_code := ';'||REPLACE(REPLACE(REPLACE(i_f_code, ',', ';'), '，', ';'), '；', ';')||';';
    v_f_code := ';'||i_f_code||';';

    IF(i_biz_date is null) THEN
    
        o_code := -1;
        o_note := '日期参数为空';
            
        RETURN;
        
    END IF;
    
    
    IF(i_f_code is null) THEN
    
        o_code := -1;
        o_note := '基金参数为空';
            
        RETURN;
        
    END IF;
    
    
    select max(t.FT01) into v_jyr
    from refdatauser.FT_TABLE1 t
    where t.FT01<=i_biz_date
    ;  
    
    
    select min(coalesce(t.net_asset,0)) into net_asset_flag
    from orig_fund_summary t
    where t.f_code=i_f_code
          and t.biz_date=i_biz_date
    ;
    
    

    IF(net_asset_flag=0 ) THEN
        
        o_code := -1;
        o_note := '净资产未正确解析，量化分析无法运行';
        return;
            
    END IF;
    
    
    
    
    /* 量化基金分析  */
    


    delete FUND_QUANT_ANALYSIS a
    where a.biz_date=i_biz_date
          and (instr(v_f_code, ';'||a.f_code||';') > 0 or i_f_code is null)
    ;
   
    insert into FUND_QUANT_ANALYSIS
    (
      BIZ_DATE       ,
      F_CODE         ,
      INDEX_TYPE     ,
      INDUSTRY_NUM_P ,
      INDUSTRY_NUM_B ,
      INDUSTRY_COVER ,
      INDUSTRY_DEVIA ,
      STOCK_NUM_P    ,
      STOCK_NUM_B    ,
      STOCK_COVER    ,
      STOCK_DEVIA    ,
      PE_P           ,
      PE_B           ,
      PB_P           ,
      PB_B           ,
      DQ_MV_P        ,
      DQ_MV_B        ,
      VAL_MV_P       ,
      VAL_MV_B       ,
      BETA_90D       ,
      BETA_180D      ,
      BETA_1Y        ,
      BETA_2Y        ,
      BETA_HEDGE     
    )
    select k1.日期 as BIZ_DATE
           ,k1.基金编码 as F_CODE
           ,'中证500' as INDEX_TYPE
           ,k1.持有行业数量 as INDUSTRY_NUM_P
           ,k1.基准行业数量 as INDUSTRY_NUM_B
           ,k1.行业覆盖度 as INDUSTRY_COVER
           ,k1.行业偏离度 as INDUSTRY_DEVIA
           ,k2.持有股票数量 as STOCK_NUM_P
           ,k2.基准股票数量 as STOCK_NUM_B
           ,k2.股票覆盖度 as STOCK_COVER
           ,k2.股票偏离度 as STOCK_DEVIA
           ,k2.组合PE as PE_P
           ,k2.基准PE as PE_B
           ,k2.组合PB as PB_P
           ,k2.基准PB as PB_B
           ,k2.组合平均流通市值 as DQ_MV_P
           ,k2.基准平均流通市值 as DQ_MV_B
           ,k2.组合平均总市值 as VAL_MV_P
           ,k2.基准平均总市值 as VAL_MV_B
           ,k2.组合BETA_90天*k2.股票市值/k3.净资产 as BETA_90D
           ,k2.组合BETA_180天*k2.股票市值/k3.净资产 as BETA_180D
           ,k2.组合BETA_1年*k2.股票市值/k3.净资产 as BETA_1Y
           ,k2.组合BETA_2年*k2.股票市值/k3.净资产 as BETA_2Y
           ,k3.BETA_HEDGE as BETA_HEDGE
    from 
    (
        select k.日期
               ,k.f_code as 基金编码
               ,sum(case when 行业组合权重>0 then 1 else 0 end) as 持有行业数量
               ,sum(case when 行业基准权重>0 then 1 else 0 end) as 基准行业数量
               ,sum(case when 行业组合权重>0 and 行业基准权重>0 then 1 else 0 end)/sum(case when 行业基准权重>0 then 1 else 0 end) as 行业覆盖度
               ,sum(abs(k.行业权重偏差))/2 as 行业偏离度
        from
        (
            select t0.biz_date as 日期
                   ,t0.f_code 
                   ,t1.industry as 行业
                   ,coalesce(t3.balance_ratio,0) as 行业组合权重
                   ,coalesce(t2.weight,0) as 行业基准权重
                   ,coalesce(t3.balance_ratio,0)-coalesce(t2.weight,0) as 行业权重偏差
            from ftuser.orig_fund_summary t0
            left join 
            (
                select t.FT12 as industry
                from refdatauser.FT_TABLE4 t
                where substr(t.FT11,1,2)='61'
                      and t.FT13=2
                      and t.FT14=1
            ) t1
            on 1=1
            left join refdatauser.industry_weight t2
            on t1.industry=t2.industry
               and t2.biz_date=v_jyr
               and t2.index_type='中证500'
            left join ftuser.fund_eq_industry t3
            on t0.biz_date=t3.biz_date
               and t0.f_code=t3.f_code
               and t1.industry=t3.industry
            where t0.f_code=i_f_code
                  and t0.biz_date=i_biz_date
            order by 4 desc
        ) k
        group by k.日期,k.f_code
        order by 1 desc
    ) k1
    left join 
    (
        select k.日期
               ,k.f_code as 基金编码
               ,sum(case when 组合权重>0 then 1 else 0 end) as 持有股票数量
               ,sum(case when 基准权重>0 then 1 else 0 end) as 基准股票数量
               ,sum(case when 基准权重>0 and 组合权重>0 then 1 else 0 end)/sum(case when 基准权重>0 then 1 else 0 end) as 股票覆盖度
               ,sum(abs(k.股票权重偏差))/2 as 股票偏离度
               ,case when sum(case when 组合权重>0 then 组合权重/PE else 0 end)=0 then null else round(1/sum(case when 组合权重>0 then 组合权重/PE else 0 end),4) end as 组合PE
               ,round(1/sum(case when 基准权重>0 then 基准权重/PE else 0 end),4) as 基准PE
               ,case when sum(case when 组合权重>0 then 组合权重/PE else 0 end)=0 then null else round(1/sum(case when 组合权重>0 then 组合权重/PB else 0 end),4) end as 组合PB
               ,round(1/sum(case when 基准权重>0 then 基准权重/PB else 0 end),4) as 基准PB
               ,round(sum(case when 组合权重>0 then 组合权重*流通市值 else 0 end),4) as 组合平均流通市值
               ,round(sum(case when 基准权重>0 then 基准权重*流通市值 else 0 end),4) as 基准平均流通市值
               ,round(sum(case when 组合权重>0 then 组合权重*总市值 else 0 end),4) as 组合平均总市值
               ,round(sum(case when 基准权重>0 then 基准权重*总市值 else 0 end),4) as 基准平均总市值
               ,round(sum(case when 组合权重>0 then 组合权重*beta500_90d else 0 end),4) as 组合BETA_90天
               ,round(sum(case when 组合权重>0 then 组合权重*beta500_180d else 0 end),4) as 组合BETA_180天
               ,round(sum(case when 组合权重>0 then 组合权重*beta500_1y else 0 end),4) as 组合BETA_1年
               ,round(sum(case when 组合权重>0 then 组合权重*beta500_2y else 0 end),4) as 组合BETA_2年
               ,sum(市值) as 股票市值
        from
        (
            select t1.biz_date as 日期
                   ,t1.f_code
                   ,t2.s_info_code as 股票代码
                   ,t2.s_info_name as 股票名称
                   ,t3.balance as 市值
                   ,coalesce(t3.balance_ratio,0) as 组合权重
                   ,coalesce(t4.weight/100,0) as 基准权重
                   ,coalesce(t3.balance_ratio,0)-coalesce(t4.weight/100,0) as 股票权重偏差
                   ,coalesce(t5.S_VAL_MV*10000/t5.NET_PROFIT_PARENT_COMP_TTM,t5.S_VAL_PE) as PE
                   ,t5.S_VAL_PB_NEW as PB
                   ,t5.S_DQ_MV/10000 as 流通市值
                   ,t5.S_VAL_MV/10000 as 总市值
                   ,t6.beta500_90d
                   ,t6.beta500_180d
                   ,t6.beta500_1y
                   ,t6.beta500_2y
            from ftuser.orig_fund_summary t1
            inner join wind.AShareDescription t2
            on 1=1
            left join ftuser.fund_eq_position t3
            on t2.s_info_code=t3.stock_code
               and t1.f_code=t3.f_code
               and t1.biz_date=t3.biz_date
            left join wind.AIndexCSI500Weight t4
            on t2.s_info_windcode=t4.s_con_windcode
               and t4.trade_dt=v_jyr
               and t4.s_info_windcode='000905.SH'
            left join wind.AShareEODDerivativeIndicator t5
            on t2.s_info_windcode=t5.s_info_windcode
               and t5.trade_dt=v_jyr
            left join REFDATAUSER.STOCK_BETA t6
            on t2.s_info_windcode=t6.ref_code
               and t6.biz_date=v_jyr
            where t1.f_code=i_f_code
                  and t1.biz_date=i_biz_date
                  and coalesce(t3.balance_ratio,t4.weight,0)>0
            order by 5 desc
        ) k
        group by k.日期,k.f_code
        order by 1 
    ) k2
    on k1.日期=k2.日期
       and k1.基金编码=k2.基金编码
    left join 
    (
         select t1.biz_date as 日期
                ,t1.f_code as 基金编码
                ,t1.net_asset as 净资产
                ,coalesce(sum(t2.balance_net)/t1.net_asset,0) as BETA_HEDGE
         from ftuser.orig_fund_summary t1
         left join ftuser.fund_fut_position t2
         on t1.f_code=t2.f_code
            and t1.biz_date=t2.biz_date
            and t2.std_code IN ('IF','IC','IH')
         where t1.f_code=i_f_code
              and t1.biz_date=i_biz_date
         group by t1.biz_date
                ,t1.f_code
                ,t1.net_asset 
    ) k3
    on k1.日期=k3.日期
       and k1.基金编码=k3.基金编码

    union all
    
    select k1.日期 as BIZ_DATE
           ,k1.基金编码 as F_CODE
           ,'沪深300' as INDEX_TYPE
           ,k1.持有行业数量 as INDUSTRY_NUM_P
           ,k1.基准行业数量 as INDUSTRY_NUM_B
           ,k1.行业覆盖度 as INDUSTRY_COVER
           ,k1.行业偏离度 as INDUSTRY_DEVIA
           ,k2.持有股票数量 as STOCK_NUM_P
           ,k2.基准股票数量 as STOCK_NUM_B
           ,k2.股票覆盖度 as STOCK_COVER
           ,k2.股票偏离度 as STOCK_DEVIA
           ,k2.组合PE as PE_P
           ,k2.基准PE as PE_B
           ,k2.组合PB as PB_P
           ,k2.基准PB as PB_B
           ,k2.组合平均流通市值 as DQ_MV_P
           ,k2.基准平均流通市值 as DQ_MV_B
           ,k2.组合平均总市值 as VAL_MV_P
           ,k2.基准平均总市值 as VAL_MV_B
           ,k2.组合BETA_90天*k2.股票市值/k3.净资产 as BETA_90D
           ,k2.组合BETA_180天*k2.股票市值/k3.净资产 as BETA_180D
           ,k2.组合BETA_1年*k2.股票市值/k3.净资产 as BETA_1Y
           ,k2.组合BETA_2年*k2.股票市值/k3.净资产 as BETA_2Y
           ,k3.BETA_HEDGE as BETA_HEDGE
    from 
    (
        select k.日期
               ,k.f_code as 基金编码
               ,sum(case when 行业组合权重>0 then 1 else 0 end) as 持有行业数量
               ,sum(case when 行业基准权重>0 then 1 else 0 end) as 基准行业数量
               ,sum(case when 行业组合权重>0 and 行业基准权重>0 then 1 else 0 end)/sum(case when 行业基准权重>0 then 1 else 0 end) as 行业覆盖度
               ,sum(abs(k.行业权重偏差))/2 as 行业偏离度
        from
        (
            select t0.biz_date as 日期
                   ,t0.f_code 
                   ,t1.industry as 行业
                   ,coalesce(t3.balance_ratio,0) as 行业组合权重
                   ,coalesce(t2.weight,0) as 行业基准权重
                   ,coalesce(t3.balance_ratio,0)-coalesce(t2.weight,0) as 行业权重偏差
            from ftuser.orig_fund_summary t0
            left join 
            (
                select t.FT12 as industry
                from refdatauser.FT_TABLE4 t
                where substr(t.FT11,1,2)='61'
                      and t.FT13=2
                      and t.FT14=1
            ) t1
            on 1=1
            left join refdatauser.industry_weight t2
            on t1.industry=t2.industry
               and t2.biz_date=v_jyr
               and t2.index_type='沪深300'
            left join ftuser.fund_eq_industry t3
            on t0.biz_date=t3.biz_date
               and t0.f_code=t3.f_code
               and t1.industry=t3.industry
            where t0.f_code=i_f_code
                  and t0.biz_date=i_biz_date
            order by 4 desc
        ) k
        group by k.日期,k.f_code
        order by 1 desc
    ) k1
    left join 
    (
        select k.日期
               ,k.f_code as 基金编码
               ,sum(case when 组合权重>0 then 1 else 0 end) as 持有股票数量
               ,sum(case when 基准权重>0 then 1 else 0 end) as 基准股票数量
               ,sum(case when 基准权重>0 and 组合权重>0 then 1 else 0 end)/sum(case when 基准权重>0 then 1 else 0 end) as 股票覆盖度
               ,sum(abs(k.股票权重偏差))/2 as 股票偏离度
               ,case when sum(case when 组合权重>0 then 组合权重/PE else 0 end)=0 then null else round(1/sum(case when 组合权重>0 then 组合权重/PE else 0 end),4) end as 组合PE
               ,round(1/sum(case when 基准权重>0 then 基准权重/PE else 0 end),4) as 基准PE
               ,case when sum(case when 组合权重>0 then 组合权重/PE else 0 end)=0 then null else round(1/sum(case when 组合权重>0 then 组合权重/PB else 0 end),4) end as 组合PB
               ,round(1/sum(case when 基准权重>0 then 基准权重/PB else 0 end),4) as 基准PB
               ,round(sum(case when 组合权重>0 then 组合权重*流通市值 else 0 end),4) as 组合平均流通市值
               ,round(sum(case when 基准权重>0 then 基准权重*流通市值 else 0 end),4) as 基准平均流通市值
               ,round(sum(case when 组合权重>0 then 组合权重*总市值 else 0 end),4) as 组合平均总市值
               ,round(sum(case when 基准权重>0 then 基准权重*总市值 else 0 end),4) as 基准平均总市值
               ,round(sum(case when 组合权重>0 then 组合权重*beta300_90d else 0 end),4) as 组合BETA_90天
               ,round(sum(case when 组合权重>0 then 组合权重*beta300_180d else 0 end),4) as 组合BETA_180天
               ,round(sum(case when 组合权重>0 then 组合权重*beta300_1y else 0 end),4) as 组合BETA_1年
               ,round(sum(case when 组合权重>0 then 组合权重*beta300_2y else 0 end),4) as 组合BETA_2年
               ,sum(市值) as 股票市值
        from
        (
            select t1.biz_date as 日期
                   ,t1.f_code
                   ,t2.s_info_code as 股票代码
                   ,t2.s_info_name as 股票名称
                   ,t3.balance as 市值
                   ,coalesce(t3.balance_ratio,0) as 组合权重
                   ,coalesce(t4.i_weight/100,0) as 基准权重
                   ,coalesce(t3.balance_ratio,0)-coalesce(t4.i_weight/100,0) as 股票权重偏差
                   ,coalesce(t5.S_VAL_MV*10000/t5.NET_PROFIT_PARENT_COMP_TTM,t5.S_VAL_PE) as PE
                   ,t5.S_VAL_PB_NEW as PB
                   ,t5.S_DQ_MV/10000 as 流通市值
                   ,t5.S_VAL_MV/10000 as 总市值
                   ,t6.beta300_90d
                   ,t6.beta300_180d
                   ,t6.beta300_1y
                   ,t6.beta300_2y
            from ftuser.orig_fund_summary t1
            inner join wind.AShareDescription t2
            on 1=1
            left join ftuser.fund_eq_position t3
            on t2.s_info_code=t3.stock_code
               and t1.f_code=t3.f_code
               and t1.biz_date=t3.biz_date
            left join wind.AIndexHS300Weight t4
            on t2.s_info_windcode=t4.s_con_windcode
               and t4.trade_dt=v_jyr
               and t4.s_info_windcode='000300.SH'
            left join wind.AShareEODDerivativeIndicator t5
            on t2.s_info_windcode=t5.s_info_windcode
               and t5.trade_dt=v_jyr
            left join REFDATAUSER.STOCK_BETA t6
            on t2.s_info_windcode=t6.ref_code
               and t6.biz_date=v_jyr
            where t1.f_code=i_f_code
                  and t1.biz_date=i_biz_date
                  and coalesce(t3.balance_ratio,t4.i_weight,0)>0
            order by 5 desc
        ) k
        group by k.日期,k.f_code
        order by 1 
    ) k2
    on k1.日期=k2.日期
       and k1.基金编码=k2.基金编码
    left join 
    (
         select t1.biz_date as 日期
                ,t1.f_code as 基金编码
                ,t1.net_asset as 净资产
                ,coalesce(sum(t2.balance_net)/t1.net_asset,0) as BETA_HEDGE
         from ftuser.orig_fund_summary t1
         left join ftuser.fund_fut_position t2
         on t1.f_code=t2.f_code
            and t1.biz_date=t2.biz_date
            and t2.std_code IN ('IF','IC','IH')
         where t1.f_code=i_f_code
              and t1.biz_date=i_biz_date
         group by t1.biz_date
                ,t1.f_code
                ,t1.net_asset 
    ) k3
    on k1.日期=k3.日期
       and k1.基金编码=k3.基金编码
    ;



    
    commit;
    
    
                
    o_code := 1;
    o_note := '成功';
  
    EXCEPTION
        WHEN OTHERS THEN
            rollback;
            o_code := -1;
            o_note := SQLERRM;

            
end PRO_FUND_QUANT_ANALYSIS;

 