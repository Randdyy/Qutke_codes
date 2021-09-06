create or replace function PRO_FUND_POSITION_ANALYSIS_V2(
    i_f_code      in     varchar,      -- 基金内部编码
    i_biz_date    in     varchar,       -- 计算日期
    i_analyze_structure    in     varchar   -- 是否计算资产类型结构
) 
returns void as $func$
declare

/*

基金持仓解析


*/


   v_f_code       varchar(4000);
   v_jyr          varchar(8);
   v_hkjyr        varchar(8);
   v_lastday      varchar(8);
   v_nextday      varchar(8);
   
  
BEGIN
  
--    v_f_code := ';'||REPLACE(REPLACE(REPLACE(i_f_code, ',', ';'), '，', ';'), '；', ';')||';';
    v_f_code := ';'||i_f_code||';';

    IF(i_biz_date is null) THEN
    
       
            
        RETURN;
        
    END IF;
    
    
    IF(i_f_code is null) THEN
    
      
            
        RETURN;
        
    END IF;
    
    
    
    select max(t.FT01) into v_jyr
    from FT_TABLE1 t
    where t.FT01<=i_biz_date
    ;
    
    select max(t.FT01) into v_hkjyr
    from FT_TABLE19 t
    where t.FT01<=i_biz_date
          and t.FT11='HKEX'
    ;
    
    if(i_analyze_structure = 'Y') then
      /* 插入 基金资产结构表 FUND_ASSET_STRUCTUR */
         
      delete from FUND_ASSET_STRUCTUR a
      where a.biz_date=i_biz_date
            and a.f_code=i_f_code
      ;
      
      insert into FUND_ASSET_STRUCTUR
                  (
                    F_CODE,
                    F_NAME,
                    BIZ_DATE,
                    ASSET_TYPE,
                    BALANCE_LONG,
                    BALANCE_SHORT
                  )
      select a.f_code
             ,a.f_code as F_NAME
             ,a.biz_date
             ,a.asset_type
             ,sum(case when a.side='L' then a.balance else 0 end) as BALANCE_LONG
             ,sum(case when a.side='S' then a.balance else 0 end) as BALANCE_SHORT
      from orig_position a
      where a.f_code=i_f_code
            and a.biz_date=i_biz_date
      group by a.f_code
             ,a.biz_date
             ,a.asset_type
      order by 1,2,3,4
      ;
    end if;
    

    
    
    /* 插入 基金股票持仓表  FUND_EQ_POSITION */
       
    delete from FUND_EQ_POSITION a
    where a.biz_date=i_biz_date
          and a.f_code=i_f_code
    ;

    insert into FUND_EQ_POSITION
                (
                  F_CODE,
                  F_NAME,
                  BIZ_DATE,
                  RANK,
                  EXCHANGE_TYPE,
                  STOCK_CODE,
                  STOCK_NAME,
                  INDUSTRY,
                  AMOUNT,
                  BALANCE,
                  BALANCE_RATIO,
                  PE_TTM,
                  PB_MRQ,
                  ROE,
                  VAlUE_SCORE,
                  GROWTH_SCORE,
                  SIZE_SCORE,
                  CONCEPT,
                  REF_CODE
                )
    
    select  F_CODE,
            F_NAME,
            BIZ_DATE,
            row_number() over (partition by t.f_code,t.biz_date order by t.balance desc) as RANK,
            EXCHANGE_TYPE,
            STOCK_CODE,
            STOCK_NAME,
            INDUSTRY,
            AMOUNT,
            BALANCE,
            BALANCE_RATIO,
            PE_TTM,
            PB_MRQ,
            ROE,
            VAlUE_SCORE,
            GROWTH_SCORE,
            SIZE_SCORE,
            CONCEPT,
            REF_CODE
    from
    (            
                    
        select a.f_code
               ,a.f_code as F_NAME
               ,a.biz_date
               ,/*row_number() over (partition by a.f_code,a.biz_date order by a.balance desc) */ null as rank
               ,a.exchange_type
               ,a.stock_code 
               ,coalesce(AShare.FT04,a.stock_name) as stock_name
               ,AIndCode.FT12 as INDUSTRY
               ,a.amount 
               ,a.balance 
               ,a.balance/t2.TOTAL_BALANCE as BALANCE_RATIO
               ,round(coalesce(AEODInd.FT11*10000/AEODInd.FT16,FT15),2) as PE_TTM
               ,round(AEODInd.FT14,2) as PB_MRQ
               ,round(coalesce(100*AEODInd.FT14/(AEODInd.FT11*10000/AEODInd.FT16),100*AEODInd.FT14/FT15),2) as ROE
               ,round(100*h.value_score/power(AEODInd.FT14,0.2),2) as VAlUE_SCORE
               ,round(100*h.growth_score,2) as GROWTH_SCORE
               ,round(100*i.规模投资指数,2) as SIZE_SCORE
               ,T3.Concept_Name as CONCEPT
               ,AShare.FT02 as REF_CODE
        from  orig_position a
        left join ft_table2 AShare
        on a.stock_code=AShare.FT03
        left join ft_table3 SWClass
        on AShare.FT02=SWClass.FT02
           and SWClass.FT14='1'
        left join ft_table4 AIndCode
        on substr(SWClass.FT11,1,4)=substr(AIndCode.FT11,1,4)
           and AIndCode.FT13=2
        left join ft_table5 AEODInd
        on AShare.FT02=AEODInd.FT02
           and AEODInd.FT01=v_jyr
        left join 
        (
            select b.stock_code as 证券代码
                   ,max(b.report_period) as 最近报告日期
                   ,max(b.ann_dt) as 最近公告日期
            from STOCK_BASIC_SCORE b
            where b.ann_dt<=i_biz_date
            group by b.stock_code
            
        ) hh
        on a.stock_code=hh.证券代码
        left join STOCK_BASIC_SCORE h
        on a.stock_code=h.stock_code
           and h.ann_dt=hh.最近公告日期
           and h.report_period=hh.最近报告日期
        left join 
        (
            select a.FT01
                   ,a.FT02
                   ,(1-(dense_rank() over (partition by a.FT01 order by a.FT12 desc))/b.cnt) as 规模投资指数
            from ft_table5 a
            , (select sum(1) as cnt from ft_table5 where FT01=v_jyr) b
            where a.FT01=v_jyr
        ) i
        on AShare.FT02=i.FT02
       --    and a.biz_date=i.trade_Dt
        left join 
        (
            select f_code
                   ,biz_date
                   ,round(sum(BALANCE),2) as TOTAL_BALANCE
            from  orig_position 
            where f_code=i_f_code
                  and biz_date=i_biz_date
                  and asset_type='2'
            group by f_code,biz_date
        ) t2
        on a.f_code=t2.f_code
    --       and a.biz_date=t2.biz_date  
          
        left join stock_concept t3
        on a.stock_code=t3.stock_code
           and t3.biz_date=v_jyr
        
        where a.biz_date=i_biz_date
              and a.f_code=i_f_code
              and a.asset_type='2'
              and t2.TOTAL_BALANCE<>0
              and a.exchange_type in ('SSE','SZSE')


        union all
        

        select a.f_code
               ,a.f_code as F_NAME
               ,a.biz_date
               ,/*row_number() over (partition by a.f_code,a.biz_date order by a.balance desc)*/ null as rank
               ,a.exchange_type
               ,a.stock_code 
               ,coalesce(HShare.FT11,a.stock_name) as stock_name
               ,HIndCode.FT13 as INDUSTRY
               ,a.amount 
               ,a.balance 
               ,a.balance/t2.TOTAL_BALANCE as BALANCE_RATIO
               ,round(HEODInd.FT11/HEODInd.FT15,2) as PE_TTM
               ,round(HEODInd.FT13,2) as PB_MRQ
               ,round(100*HEODInd.FT13/(HEODInd.FT11/HEODInd.FT15),2) as ROE
               ,round(100*h.value_score/power(HEODInd.FT13,0.2),2) as VAlUE_SCORE
               ,round(100*h.growth_score,2) as GROWTH_SCORE
               ,round(100*i.规模投资指数,2) as SIZE_SCORE
               ,null as CONCEPT
               ,HShare.FT02 as REF_CODE
        from  orig_position a
        left join ft_table6 HShare
        on (lpad(a.stock_code,6,'0')=lpad(HShare.FT03,6,'0') --or
           --a.stock_name = REGEXP_REPLACE(HShare.FT11, '(&|\s)', '') --or
           --or a.stock_name = HShare.FT11
        )
           and substr(HShare.FT02,length(HShare.FT02)-2,3)<>'HKS'
        left join 
        (
             
             select FT02,max(FT11) as HS_IND_CODE
             from ft_table7 k
             where (k.FT12 is null or k.FT12<=i_biz_date)
               and (k.FT13 is null or k.FT13>=i_biz_date)
             group by FT02
             
        ) e
        on HShare.FT02=e.FT02
        left join ft_table8 HIndCode
        on substr(e.HS_IND_CODE,1,7)=substr(HIndCode.FT12,1,7)
           and HIndCode.FT14=2
           and HIndCode.FT11='恒生行业分类'
        left join ft_table9 HEODInd
        on HShare.FT02=HEODInd.FT02
           and HEODInd.FT01=v_hkjyr
        left join 
        (

            select b.stock_code as 证券代码
                   ,max(b.ann_dt) as 最近公告日期
            from STOCK_BASIC_SCORE b
            where b.ann_dt<=i_biz_date
            group by b.stock_code
            
        ) hh
        on a.stock_code=hh.证券代码

        left join STOCK_BASIC_SCORE h
        on a.stock_code=h.stock_code
           and h.ann_dt=hh.最近公告日期
        left join 
        (
            select a.FT01
                   ,a.FT02
                   ,power((1-(dense_rank() over (partition by a.FT01 order by a.FT12 desc))/b.cnt),2) as 规模投资指数
            from ft_table9 a
            ,(select sum(1) as cnt from ft_table9 where FT01=v_hkjyr) b
            where a.FT01=v_hkjyr
                  and a.FT12 is not null
        ) i
        on HShare.FT02=i.FT02

        left join 
        (
            select f_code
                   ,biz_date
                   ,round(sum(BALANCE),2) as TOTAL_BALANCE
            from  orig_position 
            where f_code=i_f_code
                  and biz_date=i_biz_date
                  and asset_type='2'
            group by f_code,biz_date
        ) t2
        on a.f_code=t2.f_code
        
        where a.biz_date=i_biz_date
              and a.f_code=i_f_code
              and a.asset_type='2'
              and t2.TOTAL_BALANCE<>0
              AND a.exchange_type ='HKEX'
    ) t
    order by t.balance desc
    
    
    ;
    
/*
    IF(length(i_f_code)<20) THEN
               
        MERGE INTO fund_eq_position t1
        USING 
        (
            select a.f_code
                   ,a.biz_date
                   ,a.ref_code
                   ,case when coalesce(b.F_PRT_STOCKVALUE,0)=0 then a.balance_ratio else a.balance/coalesce(b.F_PRT_STOCKVALUE,0) end as balance_ratio
            from fund_eq_position a
            left join ChinaMutualFundAssetPortfolio b
            on a.f_code=b.s_info_windcode
               and a.biz_date=b.F_PRT_ENDDATE
            where a.f_code=i_f_code
                  and a.biz_date=i_biz_date
                  and coalesce(b.F_PRT_STOCKVALUE,0)<>0
        ) t2
        ON (t1.f_code=t2.f_code and t1.biz_date=t2.biz_Date and t1.ref_code=t2.ref_code)
        WHEN MATCHED THEN UPDATE
             SET T1.balance_ratio=T2.balance_ratio
                 ;
                 
    END IF;           
    
*/
    /* 插入 基金股票行业集中度  FUND_EQ_INDUSTRY */

    delete from FUND_EQ_INDUSTRY a
    where a.biz_date=i_biz_date
          and a.f_code=i_f_code
    ;

    insert into FUND_EQ_INDUSTRY
                (
                  F_CODE,
                  F_NAME,
                  BIZ_DATE,
                  RANK,
                  INDUSTRY,
                  BALANCE,
                  BALANCE_RATIO,
                  BASE_RATIO
                )
    select t1.f_code
           ,t1.f_name
           ,t1.biz_date
           ,row_number() over (partition by t1.f_code,t1.biz_date order by t1.balance desc) as rank
           ,t1.INDUSTRY
           ,t1.BALANCE
         --  ,t1.BALANCE_RATIO as BALANCE_RATIO
           ,t1.BALANCE/TOTAL_BALANCE as BALANCE_RATIO
           ,coalesce(t3.WEIGHT,0) as BASE_RATIO
    from
    (
        select a.f_code
               ,a.f_code as f_name
               ,a.biz_date
               ,a.industry as INDUSTRY
               ,round(sum(a.BALANCE),2) as BALANCE
               ,sum(a.balance_ratio) as BALANCE_RATIO
        from  FUND_EQ_POSITION a
        where a.f_code=i_f_code
              and a.biz_date=i_biz_date
        group by a.f_code
               ,a.biz_date
               ,a.industry
               
    ) t1
    left join 
    (
        select a.f_code
               ,a.biz_date
               ,round(sum(a.BALANCE),2) as TOTAL_BALANCE
        from  FUND_EQ_POSITION a
        where a.f_code=i_f_code
              and a.biz_date=i_biz_date
        group by a.f_code,a.biz_date
        
    ) t2
    on t1.f_code=t2.f_code
       and t1.biz_date=t2.biz_date   
    
    left join INDUSTRY_WEIGHT t3
    on t1.INDUSTRY=t3.INDUSTRY
       and t3.biz_date=v_jyr
       and t3.index_type in ('沪深300','香港GICS')

    where t2.TOTAL_BALANCE<>0
    ;           
                
                
                
    /* 插入 基金股票投资风格表  FUND_EQ_STYLE*/

    delete from FUND_EQ_STYLE a
    where a.biz_date=i_biz_date
          and a.f_code=i_f_code
    ;

    insert into FUND_EQ_STYLE
                (
                  F_CODE,
                  F_NAME,
                  BIZ_DATE,
                  SCORE_TYPE,
                  SCORE,
                  RANGE,
                  UNIFIED_SCORE
                )         
    select t1.f_code
           ,t1.f_name
           ,t1.biz_date
           ,t1.SCORE_TYPE
           ,t1.SCORE
           ,case when t1.SCORE>=t3.tier_01 then '01'
                 when t1.SCORE>=t3.tier_02 then '02'
                 when t1.SCORE>=t3.tier_03 then '03'
                 when t1.SCORE>=t3.tier_04 then '04'
                 when t1.SCORE>=t3.tier_05 then '05'
                 when t1.SCORE>=t3.tier_06 then '06'
                 when t1.SCORE>=t3.tier_07 then '07'
                 when t1.SCORE>=t3.tier_08 then '08'
                 when t1.SCORE>=t3.tier_09 then '09'
                 when t1.SCORE>=t3.tier_10 then '10'
             else '' end as RANGE
           ,case when t1.SCORE>=t3.tier_01 then 90+10*(t1.SCORE-t3.tier_01)/(100-t3.tier_01)
                 when t1.SCORE>=t3.tier_02 then 80+10*(t1.SCORE-t3.tier_02)/(t3.tier_01-t3.tier_02)
                 when t1.SCORE>=t3.tier_03 then 70+10*(t1.SCORE-t3.tier_03)/(t3.tier_02-t3.tier_03)
                 when t1.SCORE>=t3.tier_04 then 60+10*(t1.SCORE-t3.tier_04)/(t3.tier_03-t3.tier_04)
                 when t1.SCORE>=t3.tier_05 then 50+10*(t1.SCORE-t3.tier_05)/(t3.tier_04-t3.tier_05)
                 when t1.SCORE>=t3.tier_06 then 40+10*(t1.SCORE-t3.tier_06)/(t3.tier_05-t3.tier_06)
                 when t1.SCORE>=t3.tier_07 then 30+10*(t1.SCORE-t3.tier_07)/(t3.tier_06-t3.tier_07)
                 when t1.SCORE>=t3.tier_08 then 20+10*(t1.SCORE-t3.tier_08)/(t3.tier_07-t3.tier_08)
                 when t1.SCORE>=t3.tier_09 then 10+10*(t1.SCORE-t3.tier_09)/(t3.tier_08-t3.tier_09)
                 when t1.SCORE>=t3.tier_10 then  0+10*(t1.SCORE-t3.tier_10)/(t3.tier_09-t3.tier_10)
             else 0 end as UNIFIED_SCORE
    from 
    (
        select a.f_code
               ,a.f_name
               ,a.biz_date
               ,'VALUE' as SCORE_TYPE
               ,sum(a.balance*coalesce(a.value_score,0))/sum(a.balance) as SCORE
        from FUND_EQ_POSITION a
        where a.biz_date=i_biz_date
              and a.f_code=i_f_code
        group by a.f_code
               ,a.f_name
               ,a.biz_date
        having sum(a.balance)<>0
      ) t1
      left join 
      (
            select biz_date
            from
            (     select a.biz_date
                        ,row_number() over (order by abs(a.biz_date-i_biz_date)) as rk
                 from VALUE_SCORE_RANGE a
                 where a.score_type='VALUE'
            ) tt
            where rk=1
      ) t2
      on 1=1
      left join VALUE_SCORE_RANGE t3
      on t3.score_type='VALUE'
         and t3.biz_date=t2.biz_date
      
      union all
      
      select t1.f_code
             ,t1.f_name
             ,t1.biz_date
             ,t1.SCORE_TYPE
             ,t1.SCORE
             ,case when t1.SCORE>=t3.tier_01 then '01'
                   when t1.SCORE>=t3.tier_02 then '02'
                   when t1.SCORE>=t3.tier_03 then '03'
                   when t1.SCORE>=t3.tier_04 then '04'
                   when t1.SCORE>=t3.tier_05 then '05'
                   when t1.SCORE>=t3.tier_06 then '06'
                   when t1.SCORE>=t3.tier_07 then '07'
                   when t1.SCORE>=t3.tier_08 then '08'
                   when t1.SCORE>=t3.tier_09 then '09'
                   when t1.SCORE>=t3.tier_10 then '10'
               else '' end as RANGE
           ,case when t1.SCORE>=t3.tier_01 then 90+10*(t1.SCORE-t3.tier_01)/(100-t3.tier_01)
                 when t1.SCORE>=t3.tier_02 then 80+10*(t1.SCORE-t3.tier_02)/(t3.tier_01-t3.tier_02)
                 when t1.SCORE>=t3.tier_03 then 70+10*(t1.SCORE-t3.tier_03)/(t3.tier_02-t3.tier_03)
                 when t1.SCORE>=t3.tier_04 then 60+10*(t1.SCORE-t3.tier_04)/(t3.tier_03-t3.tier_04)
                 when t1.SCORE>=t3.tier_05 then 50+10*(t1.SCORE-t3.tier_05)/(t3.tier_04-t3.tier_05)
                 when t1.SCORE>=t3.tier_06 then 40+10*(t1.SCORE-t3.tier_06)/(t3.tier_05-t3.tier_06)
                 when t1.SCORE>=t3.tier_07 then 30+10*(t1.SCORE-t3.tier_07)/(t3.tier_06-t3.tier_07)
                 when t1.SCORE>=t3.tier_08 then 20+10*(t1.SCORE-t3.tier_08)/(t3.tier_07-t3.tier_08)
                 when t1.SCORE>=t3.tier_09 then 10+10*(t1.SCORE-t3.tier_09)/(t3.tier_08-t3.tier_09)
                 when t1.SCORE>=t3.tier_10 then  0+10*(t1.SCORE-t3.tier_10)/(t3.tier_09-t3.tier_10)
             else 0 end as UNIFIED_SCORE
      from 
      (
          select a.f_code
                 ,a.f_name
                 ,a.biz_date
                 ,'GROWTH' as SCORE_TYPE
                 ,sum(a.balance*coalesce(a.Growth_Score,0))/sum(a.balance) as SCORE
          from FUND_EQ_POSITION a
          where a.biz_date=i_biz_date
                and a.f_code=i_f_code
          group by a.f_code
                 ,a.f_name
                 ,a.biz_date
          having sum(a.balance)<>0
        ) t1
        left join 
        (
            select biz_date
            from
            (     select a.biz_date
                        ,row_number() over (order by abs(a.biz_date-i_biz_date)) as rk
                 from VALUE_SCORE_RANGE a
                 where a.score_type='GROWTH'
            ) tt 
            where rk=1
        ) t2
        on 1=1
        left join VALUE_SCORE_RANGE t3
        on t3.score_type='GROWTH'
           and t3.biz_date=t2.biz_date
             
        union all
        
        select t1.f_code
               ,t1.f_name
               ,t1.biz_date
               ,t1.SCORE_TYPE
               ,t1.SCORE
               ,case when t1.SCORE>=t3.tier_01 then '01'
                     when t1.SCORE>=t3.tier_02 then '02'
                     when t1.SCORE>=t3.tier_03 then '03'
                     when t1.SCORE>=t3.tier_04 then '04'
                     when t1.SCORE>=t3.tier_05 then '05'
                     when t1.SCORE>=t3.tier_06 then '06'
                     when t1.SCORE>=t3.tier_07 then '07'
                     when t1.SCORE>=t3.tier_08 then '08'
                     when t1.SCORE>=t3.tier_09 then '09'
                     when t1.SCORE>=t3.tier_10 then '10'
                 else '' end as RANGE
           ,case when t1.SCORE>=t3.tier_01 then 90+10*(t1.SCORE-t3.tier_01)/(100-t3.tier_01)
                 when t1.SCORE>=t3.tier_02 then 80+10*(t1.SCORE-t3.tier_02)/(t3.tier_01-t3.tier_02)
                 when t1.SCORE>=t3.tier_03 then 70+10*(t1.SCORE-t3.tier_03)/(t3.tier_02-t3.tier_03)
                 when t1.SCORE>=t3.tier_04 then 60+10*(t1.SCORE-t3.tier_04)/(t3.tier_03-t3.tier_04)
                 when t1.SCORE>=t3.tier_05 then 50+10*(t1.SCORE-t3.tier_05)/(t3.tier_04-t3.tier_05)
                 when t1.SCORE>=t3.tier_06 then 40+10*(t1.SCORE-t3.tier_06)/(t3.tier_05-t3.tier_06)
                 when t1.SCORE>=t3.tier_07 then 30+10*(t1.SCORE-t3.tier_07)/(t3.tier_06-t3.tier_07)
                 when t1.SCORE>=t3.tier_08 then 20+10*(t1.SCORE-t3.tier_08)/(t3.tier_07-t3.tier_08)
                 when t1.SCORE>=t3.tier_09 then 10+10*(t1.SCORE-t3.tier_09)/(t3.tier_08-t3.tier_09)
                 when t1.SCORE>=t3.tier_10 then  0+10*(t1.SCORE-t3.tier_10)/(t3.tier_09-t3.tier_10)
             else 0 end as UNIFIED_SCORE
        from 
        (
            select a.f_code
                   ,a.f_name
                   ,a.biz_date
                   ,'SIZE' as SCORE_TYPE
                   ,sum(a.balance*coalesce(a.Size_Score,0))/sum(a.balance) as SCORE
            from FUND_EQ_POSITION a
            where a.biz_date=i_biz_date
                  and a.f_code=i_f_code
            group by a.f_code
                   ,a.f_name
                   ,a.biz_date
            having sum(a.balance)<>0
          ) t1
          left join 
          (
            select biz_date
            from
            (     select a.biz_date
                        ,row_number() over (order by abs(a.biz_date-i_biz_date)) as rk
                 from VALUE_SCORE_RANGE a
                 where a.score_type='SIZE'
            ) tt
            where rk=1
          ) t2
          on 1=1
          left join VALUE_SCORE_RANGE t3
          on t3.score_type='SIZE'
             and t3.biz_date=t2.biz_date           
      ;
                
                
                
    /* 插入 基金股票投资概念表  FUND_EQ_CONCEPT  */

    delete from FUND_EQ_CONCEPT a
    where a.biz_date=i_biz_date
          and a.f_code=i_f_code
    ;

    insert into FUND_EQ_CONCEPT
                (
                  F_CODE,
                  F_NAME,
                  BIZ_DATE,
                  RANK,
                  CONCEPT_NAME,
                  RATIO,
                  RANGE,
                  IS_NOTABLE,
                  CONCEPT_CNT,
                  CONCEPT_BALANCE,
                  CONCEPT_STOCK_CODE,
                  CONCEPT_STOCK_NAME
                )        
        select t1.F_CODE
               ,t1.F_CODE as F_NAME
               ,t1.biz_date
               ,row_number() over (partition by t1.F_CODE,t1.biz_date order by t2.概念股市值 desc) as rank
               ,coalesce(t2.概念名称,'NONE') as CONCEPT_NAME
               ,t2.概念股市值/t1.总市值 as RATIO
               ,case when 100*t2.概念股市值/t1.总市值>=t4.tier_01 then '01'
                     when 100*t2.概念股市值/t1.总市值>=t4.tier_02 then '02'
                     when 100*t2.概念股市值/t1.总市值>=t4.tier_03 then '03'
                     when 100*t2.概念股市值/t1.总市值>=t4.tier_04 then '04'
                     when 100*t2.概念股市值/t1.总市值>=t4.tier_05 then '05'
                     when 100*t2.概念股市值/t1.总市值>=t4.tier_06 then '06'
                     when 100*t2.概念股市值/t1.总市值>=t4.tier_07 then '07'
                     when 100*t2.概念股市值/t1.总市值>=t4.tier_08 then '08'
                     when 100*t2.概念股市值/t1.总市值>=t4.tier_09 then '09'
                     when 100*t2.概念股市值/t1.总市值>=t4.tier_10 then '10'
                 else '' end as RANGE
               ,case when 100*t2.概念股市值/t1.总市值>t4.avg_ratio or t2.概念股市值/t1.总市值>0.3 then 'Y' else 'N' end as IS_NOTABLE
               ,t2.概念股数量 as CONCEPT_CNT
               ,t2.概念股市值 as CONCEPT_BALANCE
               ,t2.概念股代码 as CONCEPT_STOCK_CODE
               ,t2.概念股名称 as CONCEPT_STOCK_NAME
        from
        (
            select  a.biz_date
                   ,a.f_code
                   ,sum(a.balance) as 总市值
            from FUND_EQ_POSITION a
            where a.biz_date=i_biz_date
                  and a.f_code=i_f_code
            group by a.biz_date
                   ,a.f_code
                   
        ) t1
        left join
        (  
            select  a.biz_date
                   ,a.f_code
                   ,AConsep.FT12 as 概念名称
                   ,sum(1) as 概念股数量
            --       ,to_char(listagg(a.stock_code,',') within group(order by a.stock_code)) as 概念股代码
            --       ,to_char(listagg(AShare.FT04,',') within group(order by a.stock_code)) as 概念股名称
            --       ,to_char(substr(xmlagg(xmlparse(content a.stock_code||',' wellformed) order by a.stock_code).getclobval(),1,2000)) as 概念股代码
            --       ,to_char(substr(xmlagg(xmlparse(content AShare.FT04||',' wellformed) order by a.stock_code).getclobval(),1,2000)) as 概念股名称
                   ,sum(a.balance) as 概念股市值
            from FUND_EQ_POSITION a
            inner join FT_TABLE2 AShare
            on a.stock_code=AShare.FT03
            inner join ft_table10 AConsep
            on AShare.FT02=AConsep.FT02
               and AConsep.FT13<=i_biz_date
               and (AConsep.FT14>=i_biz_date or AConsep.FT14 is null)
            where a.biz_date=i_biz_date
                  and a.f_code=i_f_code
                  and a.exchange_type in ('SSE','SZSE')
            group by a.biz_date
                   ,a.f_code
                   ,AConsep.FT12
                   
        ) t2
        on t1.f_code=t2.f_code
           and t1.biz_date=t2.biz_date
        left join 
        (
           select max(a.biz_date) as biz_date
           from CONCEPT_RATIO_RANGE a
           where a.biz_date<=i_biz_date
        ) t3
        on 1=1
        left join CONCEPT_RATIO_RANGE t4
        on t2.概念名称=t4.concept
           and t4.biz_date=t3.biz_date
        where t1.总市值<>0
        order by t1.f_code,t2.概念股市值 desc
        ;
        
        
        
        
                
    /* 插入 基金期货持仓明细表  FUND_FUT_POSITION  */

    delete from FUND_FUT_POSITION a
    where a.biz_date=i_biz_date
          and a.f_code=i_f_code
    ;

    insert into FUND_FUT_POSITION
                (  
                F_CODE        ,
                F_NAME        ,
                BIZ_DATE      ,
                EXCHANGE_TYPE ,
                STOCK_CODE    ,
                STOCK_NAME    ,
                STD_CODE      ,
                STD_NAME      ,
                SUB_TYPECODE  ,
                SUB_TYPENAME  ,
                LISTDATE      ,
                DELISTDATE    ,
                DAYS          ,
                MULTIPLIER    ,
                PRICE         ,
                AMOUNT_L      ,
                AMOUNT_S      ,
                AMOUNT_NET    ,
                BALANCE_L     ,
                BALANCE_S     ,
                BALANCE_NET   ,
                MARGIN_RATIO  ,
                MARGIN_REQ    ,
                REF_CODE      ,
                BASIS         ,
                ANNUAL_BASIS
                )
        select a.f_code
               ,a.f_code as F_NAME
               ,a.biz_date
               ,a.exchange_type
               ,a.stock_code
               ,CFuture.FT11 as STOCK_NAME
               ,CFCont.FT11 as STD_CODE
               ,CFCont.FT12 as STD_NAME
               ,CFCont.FT17 as SUB_TYPECODE
               ,case when CFCont.FT17='703001001' then '贵金属'
                     when CFCont.FT17='703001002' then '有色'
                     when CFCont.FT17='703001003' then '煤焦钢矿'
                     when CFCont.FT17='703001004' then '非金属建材'
                     when CFCont.FT17='703001005' then '能源'
                     when CFCont.FT17='703001006' then '化工'
                     when CFCont.FT17='703001007' then '谷物'
                     when CFCont.FT17='703001008' then '油脂油料'
                     when CFCont.FT17='703001009' then '软商品'
                     when CFCont.FT17='703001010' then '农副产品'
                     when CFCont.FT11 in ('IC','IF','IH') THEN '股指期货'
                     when CFCont.FT11 in ('T','TF') THEN '国债期货'
                end as SUB_TYPENAME
                        
               ,CFuture.FT15 as LISTDATE
               ,CFuture.FT16 as DELISTDATE
               ,to_date(CFuture.FT16,'yyyymmdd')-to_Date(a.biz_date,'yyyymmdd') as days
               ,coalesce(CFCont.FT16,1)*CFCont.FT14 as MULTIPLIER  
               ,a.price 
               ,a.AMOUNT_L
               ,a.AMOUNT_S
               ,a.AMOUNT_NET
               ,a.BALANCE_L
               ,a.BALANCE_S
               ,a.BALANCE_NET
               ,d.MARGIN_RATIO
               ,(a.BALANCE_L-a.BALANCE_S)*d.MARGIN_RATIO as MARGIN_REQ
               ,CFuture.FT02 as REF_CODE
               ,case when CFCont.FT11 in ('IC','IF','IH') then (e.s_dq_settle-f.s_dq_close)/f.s_dq_close else null end as BASIS
               ,case when CFCont.FT11 in ('IC','IF','IH') and to_date(i_biz_date,'yyyymmdd')<to_date(CFuture.FT16,'yyyymmdd') then (e.s_dq_settle-f.s_dq_close)/f.s_dq_close/(to_date(CFuture.FT16,'yyyymmdd')-to_date(i_biz_date,'yyyymmdd'))*360 else null end as ANNUAL_BASIS
               
        from 
        (
            select a.f_code
                   ,a.f_code as F_NAME
                   ,a.biz_date
                   ,a.exchange_type
                   ,a.stock_code
                   ,a.price 
                   ,sum(case when a.side='L' then a.amount else 0 end) as AMOUNT_L
                   ,sum(case when a.side='S' then a.amount else 0 end) as AMOUNT_S
                   ,sum(case when a.side='L' then a.amount else -a.amount end) as AMOUNT_NET
                   ,sum(case when a.side='L' then a.balance else 0 end) as BALANCE_L
                   ,sum(case when a.side='S' then a.balance else 0 end) as BALANCE_S
                   ,sum(case when a.side='L' then a.balance else a.balance end) as BALANCE_NET
            from orig_position a
            where a.f_code=i_f_code
                  and a.biz_date=i_biz_date
                  and a.asset_type='3'
             group by a.f_code
                   ,a.biz_date
                   ,a.exchange_type
                   ,a.stock_code
                   ,a.price 
        ) a
        left join ft_table11 CFuture
        on a.stock_code=CFuture.FT03
        left join ft_table12 CFCont
        on CFuture.FT02=CFCont.FT02
        left join 
        (
            select t1.FT02
                   ,t1.FT11/100 as MARGIN_RATIO 
                   ,t1.FT12 as start_date   
                   ,to_char(to_date(lag(t1.FT12, 1, '99991231') over (partition by t1.FT02 order by t1.FT12 desc),'yyyymmdd')-1,'yyyymmdd') as end_date
            from ft_table13 t1
        ) d
        on CFuture.FT02=d.FT02
           and d.start_date<=a.biz_date
           and d.end_date>=a.biz_date
        left join CIndexFuturesEODPrices e
        on CFuture.FT02=e.s_info_windcode
           and e.trade_dt=v_jyr
        left join AIndexEODPrices f
        on f.s_info_windcode in ('000016.SH','000300.SH','000905.SH')
           and f.trade_dt=v_jyr
           and case when f.s_info_windcode='000016.SH' then 'IH'
                    when f.s_info_windcode='000300.SH' then 'IF'
                    when f.s_info_windcode='000905.SH' then 'IC'  
               else null end = CFCont.FT11
        ORDER BY a.f_code,abs(a.BALANCE_NET) desc
           ;  


    /* 插入 基金期货持仓品种表  FUND_FUT_TYPE  */

    delete from FUND_FUT_TYPE a
    where a.biz_date=i_biz_date
          and a.f_code=i_f_code
    ;

    insert into FUND_FUT_TYPE
                (  
                  F_CODE      ,
                  F_NAME      ,
                  BIZ_DATE    ,
                  STD_CODE    ,
                  STD_NAME    ,
                  SUB_TYPECODE  ,
                  SUB_TYPENAME  ,
                  BALANCE_L   ,
                  BALANCE_S   ,
                  BALANCE_NET ,
                  MARGIN_REQ
                )
          select a.f_code
                 ,a.f_name
                 ,a.biz_date
                 ,a.std_code
                 ,a.std_name
                 ,a.sub_typecode
                 ,a.sub_typename
                 ,sum(a.BALANCE_L) as BALANCE_L
                 ,sum(a.BALANCE_S) as BALANCE_S
                 ,sum(a.BALANCE_NET) as BALANCE_NET
                 ,sum(a.MARGIN_REQ) as MARGIN_REQ
          from fund_fut_position a
          where a.f_code=i_f_code
               and a.biz_date=i_biz_date
          group by a.f_code
                 ,a.f_name
                 ,a.biz_date
                 ,a.std_code
                 ,a.std_name
                 ,a.sub_typecode
                 ,a.sub_typename
          order by f_code,abs(sum(a.BALANCE_NET)) desc
                 ;
             
          
          
    /* 插入 基金债券持仓表  FUND_BOND_POSITION  */

    delete from FUND_BOND_POSITION a
    where a.biz_date=i_biz_date
          and a.f_code=i_f_code
    ;
   
    insert into FUND_BOND_POSITION
                (  
                  F_CODE              ,
                  F_NAME              ,
                  BIZ_DATE            ,
                  RANK                ,
                  EXCHANGE_TYPE       ,
                  REF_CODE            ,
                  STOCK_CODE          ,
                  STOCK_NAME          ,
                  AMOUNT              ,
                  PRICE               ,
                  BALANCE             ,
                  BALANCE_RATIO       ,
                  CLASS1              ,
                  CLASS2              ,
                  ISSUER              ,
                  ISSUER_TYPE         ,
                  PROVINCE            ,
                  CITY                ,
                  ISSUER_CLASS1       ,
                  ISSUER_CLASS2       ,
                  ISSUER_CLASS3       ,
                  ISSUER_CLASS4       ,
                  COUPONRATE          ,
                  LISTDATE            ,
                  MATURITYDATE        ,
                  CREDIT_DATE         ,
                  CREDITRATING        ,
                  PRE_CREDITRATING    ,
                  CREDITRATING_CHANGE ,
                  CREDITRATING_AGENCY ,
                  DURATION            ,
                  CONVEXITY           ,
                  ACCRUED_DAYS        ,
                  ACCRUED_INTEREST    ,
                  YTC                 ,
                  YTP                 ,
                  YTM                 ,
                  PTM_YEAR            ,
                  WEIGHTED_YEAR       ,
                  CREDIT_DATE_ZT         ,
                  CREDITRATING_ZT        ,
                  PRE_CREDITRATING_ZT    ,
                  CREDITRATING_CHANGE_ZT ,
                  CREDITRATING_AGENCY_ZT ,
                  SIM_NAME               ,
                  FULL_NAME              ,
                  CARRYDATE              ,
                  AMOUNTACT              ,
                  COUPONDATETXT          ,
                  GUARTYPE               ,
                  MODIFIED_DURATION      ,
                  IS_OPTION              ,
                  OPTION_TYPE            ,
                  OPTION_DATE            ,
                  TERM_YEAR              ,
                  NEXT_OPTION_DATE       ,
                  TERM_IF_EXE            ,
                  YTM_IF_EXE             ,
                  DURATION_IF_EXE          ,
                  MODIFIED_DURATION_IF_EXE ,
                  CONVEXITY_IF_EXE         ,
                  BASE_VALUE_IF_EXE 
                )  
    select a.f_code
           ,a.f_code as F_NAME
           ,a.biz_date
           ,row_number() over (partition by a.f_code,a.biz_date order by a.balance desc) as rank
           ,coalesce(case when CBond.FT16='NIB' then 'OTCIB' else CBond.FT16 end,a.exchange_type) as EXCHANGE_TYPE
           ,CBond.FT02 as REF_CODE
           ,coalesce(substr(CBond.FT02, 1, length(CBond.FT02)-3), a.stock_code) as STOCK_CODE
           ,coalesce(CBond.FT15,trim(a.stock_name)) as STOCK_NAME
           ,a.amount as AMOUNT
           ,a.price as PRICE
           ,a.balance as BALANCE
           ,a.balance/t2.总市值 as BALANCE_RATIO
           ,CBondInd.FT11 as CLASS1
           ,coalesce(CBondInd.FT12,CBondInd.FT11) as CLASS2
           ,CBond.FT12 as ISSUER
           ,CBond.FT20 as ISSUER_TYPE 
           ,Comp.FT12 as PROVINCE 
           ,Comp.FT13 as CITY
           ,CBondIssuer.FT11 as ISSUER_CLASS1
           ,CBondIssuer.FT12 as ISSUER_CLASS2 
           ,CBondIssuer.FT13 as ISSUER_CLASS3 
           ,CBondIssuer.FT14 as ISSUER_CLASS4
           ,CBond.FT13 as COUPONRATE
           ,CBond.FT17 as LISTDATE 
           ,CBond.FT14 as MATURITYDATE
           ,e.评级日期 as CREDIT_DATE
           ,e.信用评级 as CREDITRATING
           ,e.前次信用评级 as PRE_CREDITRATING
           ,e.评级变动方向 as CREDITRATING_CHANGE
           ,f.code_name as CREDITRATING_AGENCY
           ,coalesce(CBondVal.FT11, CBondValFT11) as DURATION 
           ,coalesce(CBondVal.FT15, CBondValFT15) as CONVEXITY
           ,CBondValFT16 as ACCRUED_DAYS
           ,coalesce(CBondVal.FT17, CBondValFT17) as ACCRUED_INTEREST
           ,CBondValFT18 as YTC
           ,CBondValFT19 as YTP
           ,coalesce(CBondVal.FT21, CBondValFT21) as YTM
           ,coalesce(CBondVal.FT20, CBondValFT20) as PTM_YEAR
           ,CBondValFT22 as WEIGHTED_YEAR
           ,g.评级日期 as CREDIT_DATE_ZT
           ,g.信用评级 as CREDITRATING_ZT
           ,g.前次信用评级 as PRE_CREDITRATING_ZT
           ,g.评级变动方向 as CREDITRATING_CHANGE_ZT
           ,h.code_name as CREDITRATING_AGENCY_ZT
           
           
           ,cbond.FT15 as SIM_NAME
           ,cbond.FT11 as FULL_NAME
           ,cbond.FT31 as CARRYDATE
           ,cbond.FT30 as AMOUNTACT
           ,cbond.FT28 as COUPONDATETXT 
           ,j.code_name as GUARTYPE
           ,coalesce(CBondVal.FT12, CBondValFT12) AS MODIFIED_DURATION  --修正久期
           ,cbond.FT25 as IS_OPTION
           ,i.含权特殊条款 AS OPTION_TYPE
           ,i.含权行权日期 AS OPTION_DATE
           ,rtrim(to_char(cbond.FT21,'fm999999999990.9999'),'.')||case when i.含权期限说明 is not null then '('||i.含权期限说明||')' else null end as TERM_YEAR
           ,k.b_anal_nxoptiondate as NEXT_OPTION_DATE  --最近行权日
           ,k.b_anal_termifexercise as TERM_IF_EXE -- 行权剩余期限
           ,k.b_anal_YTM_IfExe as YTM_IF_EXE  --行权收益率
           ,k.b_anal_durationifexercise as DURATION_IF_EXE  --行权久期
           ,k.b_anal_ModiDuration_IfExe as MODIFIED_DURATION_IF_EXE -- 行权修正久期
           ,k.b_anal_Convexity_IfExe as CONVEXITY_IF_EXE --行权凸性
           ,k.b_anal_BaseValue_IfExe as BASE_VALUE_IF_EXE --行权基点价值
           
    from ORIG_POSITION a
    left join FT_TABLE20 CBond
    on ((a.stock_code=CBond.FT03 /*or trim(a.stock_name)=CBond.FT15*/) and a.exchange_type = cbond.ft16)
       or ((a.stock_code=CBond.FT03 or trim(a.stock_name)=CBond.FT15) and (a.exchange_type='OTCIB' or a.exchange_type is null) and CBond.FT16='NIB')
    left join FT_TABLE21 CBondInd
    on CBond.FT02=CBondInd.FT02
    left join FT_TABLE22 CBondVal
    on CBond.FT02=CBondVal.FT02
       and CBondVal.FT01=v_jyr
    left join FT_TABLE22_01 CBondValWind
    on CBond.FT02=CBondValFT02
       and CBondValFT01=v_jyr
    left join
    (
        select t1.FT02
               ,t1.FT01 as 评级日期
               ,t1.FT12 as 信用评级
               ,t1.FT13 as 评级机构代码 
               ,row_number() over (partition by t1.FT02 order by t1.FT01 desc) as rk
               ,t1.FT15 as 前次信用评级 
               ,t1.FT16 as 评级变动方向 
        from FT_TABLE23 t1
        where t1.FT01<=i_biz_date
        order by 1,2
    ) e
    on CBond.FT02=e.FT02
       and e.rk=1
    LEFT JOIN dict_map f
    on e.评级机构代码=f.code_value
       and f.dic_type='CREDITRATINGAGENCY'
    left join FT_TABLE24 CBondIssuer 
    on CBond.FT02=CBondIssuer.FT02
       and CBondIssuer.ft15='1'
    left join FT_TABLE25 Comp
    on CBond.FT19=Comp.FT11
    left join 
    (
        select t1.S_INFO_COMPCODE
               ,t1.ANN_DT as 评级日期
               ,t1.B_INFO_CREDITRATING as 信用评级
               ,t1.B_INFO_CREDITRATINGAGENCY as 评级机构代码 
               ,row_number() over (partition by t1.S_INFO_COMPCODE order by t1.ANN_DT desc) as rk
               ,t1.B_INFO_PRECREDITRATING as 前次信用评级 
               ,t1.B_CREDITRATING_CHANGE as 评级变动方向 
        from CBondIssuerRating t1
        where t1.ANN_DT<=i_biz_date
        order by 1,2 desc
    ) g
    on CBond.FT19=g.S_INFO_COMPCODE
       and g.rk=1
    LEFT JOIN dict_map h
    on g.评级机构代码=h.code_value
       and h.dic_type='CREDITRATINGAGENCY'
       
    left join 
    (
        select t.s_info_windcode
               ,to_char(listagg(replace(t.b_info_provisiontype,'条款',''),',') within group(order by t.b_info_provisiontype)) as 含权特殊条款
               ,to_char(listagg(B_INFO_CALLBKORPUTBKDATE,',') within group(order by t.b_info_provisiontype)) as 含权行权日期
               ,max(t.B_INFO_MATURITYEMBEDDED) as 含权期限说明
        from CBondSpecialConditions t
        group by t.s_info_windcode
    ) i
    on CBond.FT02=i.s_info_windcode
    left join dict_map j
    on CBond.FT29=j.code_value
       and j.dic_type='B_INFO_GUARTYPE'
    left join COptionEmbeddedBondValuation k
    on CBond.FT02=k.s_info_windcode
       and k.trade_dt=v_jyr
       and k.price_type='wind计算收盘价'
       
    left join 
    (
        select  f_code
                ,sum(balance) as 总市值
        from ORIG_POSITION a
        where a.f_code=i_f_code
              and biz_date=i_biz_date
              and asset_type='4'
        group by f_code
    ) t2
    on a.f_code=t2.f_code
    where a.f_code=i_f_code
          and a.biz_date=i_biz_date
          and a.asset_type='4'
          ;
      
    
    /* 插入 基金债券投资概念表  FUND_BOND_CONCEPT  */

    delete from FUND_BOND_CONCEPT a
    where a.biz_date=i_biz_date
          and a.f_code=i_f_code
    ;
   
    insert into FUND_BOND_CONCEPT
                (  
                  F_CODE            ,
                  F_NAME            ,
                  BIZ_DATE          ,
                  RANK              ,
                  CONCEPT_NAME      ,
                  RATIO             ,
                  CONCEPT_CNT       ,
                  CONCEPT_BALANCE   ,
                  CONCEPT_BOND_CODE ,
                  CONCEPT_BOND_NAME 
                )
    select t1.F_CODE
           ,t1.F_CODE as F_NAME
           ,t1.biz_date
           ,row_number() over (partition by t1.F_CODE,t1.biz_date order by t2.概念债券市值 desc) as rank
           ,coalesce(t2.概念名称,'NONE') as CONCEPT_NAME
           ,t2.概念债券市值/t1.总市值 as RATIO
           ,t2.概念债券数量 as CONCEPT_CNT
           ,t2.概念债券市值 as CONCEPT_BALANCE
           ,t2.概念债券代码 as CONCEPT_BOND_CODE
           ,t2.概念债券名称 as CONCEPT_BOND_NAME
    from
    (
        select  a.biz_date
               ,a.f_code
               ,sum(a.balance) as 总市值
        from fund_bond_position a
        where a.f_code=i_f_code
              and a.biz_date=i_biz_date
        group by a.biz_date
               ,a.f_code
                   
    ) t1
    left join
    (  
        select  a.biz_date
               ,a.f_code
               ,c.FT11 as 概念名称
               ,sum(1) as 概念债券数量
         --      ,substr(to_char(listagg(a.stock_code,',') within group(order by a.stock_code)),1,1000) as 概念债券代码
         --      ,substr(to_char(listagg(a.stock_name,',') within group(order by a.stock_code)),1,1000) as 概念债券名称
         --      ,to_char(substr(xmlagg(xmlparse(content a.stock_code||',' wellformed) order by a.stock_code).getclobval(),1,2000)) as 概念债券代码
         --      ,to_char(substr(xmlagg(xmlparse(content a.stock_name||',' wellformed) order by a.stock_code).getclobval(),1,2000)) as 概念债券名称
               ,sum(a.balance) as 概念债券市值
        from fund_bond_position a
        inner join FT_TABLE26 c
        on a.ref_code=c.FT02
        where a.f_code=i_f_code
              and a.biz_date=i_biz_date
        group by a.biz_date
               ,a.f_code
               ,c.FT11
    ) t2
    on t1.f_code=t2.f_code
       and t1.biz_date=t2.biz_date
    where t1.总市值<>0
    order by t1.f_code,t2.概念债券市值 desc
    ;
    
    
    
    /* 插入 基金基金持仓表  FUND_FUND_POSITION   */

    delete from FUND_FUND_POSITION a
    where a.biz_date=i_biz_date
          and a.f_code=i_f_code
    ;
   
    insert into FUND_FUND_POSITION
                (  
                  F_CODE        ,
                  BIZ_DATE      ,
                  RANK          ,
                  EXCHANGE_TYPE ,
                  STOCK_CODE    ,
                  STOCK_NAME    ,
                  MANAGER       ,
                  FUND_TYPE1    ,
                  FUND_TYPE2    ,
                  AMOUNT        ,
                  BALANCE       ,
                  BALANCE_RATIO ,
                  REF_CODE
                  )
    select a.f_code
           ,a.biz_date
           ,row_number() over (partition by a.f_code,a.biz_date order by a.balance desc) as rank
           ,coalesce(b.f_info_exchmarket,a.exchange_type) as EXCHANGE_TYPE --市场
           ,a.stock_code -- 证券代码
           ,coalesce(b.f_info_name,a.stock_name) as stock_name -- 证券名称
           ,b.F_INFO_CORP_FUNDMANAGEMENTCOMP as MANAGER --管理人
           ,b.F_INFO_FIRSTINVESTTYPE as FUND_TYPE1
           ,b.F_INFO_TYPE AS FUND_TYPE2
           ,a.amount -- 数量
           ,a.balance -- 市值
           ,a.balance/t2.总市值 as BALANCE_RATIO
           ,b.f_info_windcode as ref_code
    from orig_position a
    left join ChinaMutualFundDescription b
    on /*a.exchange_type in ('SSE','SZSE') and b.f_info_exchmarket in ('SSE','SZSE') and*/ length(b.f_info_windcode)=9 and a.stock_code=substr(b.f_info_windcode,1,6)
    left join 
    (
        select  f_code
                ,sum(balance) as 总市值
        from ORIG_POSITION a
        where a.f_code=i_f_code
              and a.biz_date=i_biz_date
              and asset_type='5'
        group by f_code
    ) t2
    on a.f_code=t2.f_code
    where a.asset_type='5'
          and a.f_code=i_f_code
          and a.biz_date=i_biz_date
    order by a.balance desc
      ;
    
    /* 插入 基金养老金持仓表  FUND_PENSION_POSITION   */

    delete from FUND_PENSION_POSITION a
    where a.biz_date=i_biz_date
          and a.f_code=i_f_code
    ;
   
    insert into FUND_PENSION_POSITION
                (  
                  F_CODE        ,
                  BIZ_DATE      ,
                  RANK          ,
                  EXCHANGE_TYPE ,
                  STOCK_CODE    ,
                  STOCK_NAME    ,
                  MANAGER       ,
                  FUND_TYPE1    ,
                  FUND_TYPE2    ,
                  AMOUNT        ,
                  BALANCE       ,
                  BALANCE_RATIO ,
                  REF_CODE
                  )
    select a.f_code
           ,a.biz_date
           ,row_number() over (partition by a.f_code,a.biz_date order by a.balance desc) as rank
           ,a.exchange_type as EXCHANGE_TYPE --市场
           ,a.stock_code -- 证券代码
           ,coalesce(b.ft04,a.stock_name) as stock_name -- 证券名称
           ,b.ft06 as MANAGER --管理人
           ,b.ft05 as FUND_TYPE1
           ,null AS FUND_TYPE2
           ,a.amount -- 数量
           ,a.balance -- 市值
           ,a.balance/t2.总市值 as BALANCE_RATIO
           ,b.ft02 as ref_code
    from orig_position a
    left join ft_table28 b
    on a.stock_code=b.ft03
    left join 
    (
        select  f_code
                ,sum(balance) as 总市值
        from ORIG_POSITION a
        where a.f_code=i_f_code
              and a.biz_date=i_biz_date
              and asset_type='养老金产品'
        group by f_code
    ) t2
    on a.f_code=t2.f_code
    where a.asset_type='养老金产品'
          and a.f_code=i_f_code
          and a.biz_date=i_biz_date
    order by a.balance desc
      ;
    
    
    /* 插入 私募基金持仓表  FUND_HEDGE_POSITION   */

    delete from FUND_HEDGE_POSITION a
    where a.biz_date=i_biz_date
          and a.f_code=i_f_code
    ;
   
    insert into FUND_HEDGE_POSITION
                (  
                  F_CODE        ,
                  BIZ_DATE      ,
                  RANK          ,
                  EXCHANGE_TYPE ,
                  STOCK_CODE    ,
                  STOCK_NAME    ,
                  MANAGER       ,
                  FUND_TYPE1    ,
                  FUND_TYPE2    ,
                  AMOUNT        ,
                  BALANCE       ,
                  BALANCE_RATIO ,
                  REF_CODE
                  )
    select a.f_code
           ,a.biz_date
           ,row_number() over (partition by a.f_code,a.biz_date order by a.balance desc) as rank
           ,a.exchange_type as EXCHANGE_TYPE --市场
           ,a.stock_code -- 证券代码
           ,a.stock_name as stock_name -- 证券名称
           ,null as MANAGER --管理人
           ,null as FUND_TYPE1
           ,null AS FUND_TYPE2
           ,a.amount -- 数量
           ,a.balance -- 市值
           ,a.balance/t2.总市值 as BALANCE_RATIO
           ,a.stock_code as ref_code
    from orig_position a
    left join 
    (
        select  f_code
                ,sum(balance) as 总市值
        from ORIG_POSITION a
        where a.f_code=i_f_code
              and a.biz_date=i_biz_date
              and asset_type='18'
        group by f_code
    ) t2
    on a.f_code=t2.f_code
    where a.asset_type='18'
          and a.f_code=i_f_code
          and a.biz_date=i_biz_date
    order by a.balance desc
      ;
    
    /* 插入  基金期权持仓表   FUND_OPTION_POSITION   */

    delete from FUND_OPTION_POSITION a
    where a.biz_date=i_biz_date
          and a.f_code=i_f_code
    ;
   
    insert into FUND_OPTION_POSITION
                (  
                    F_CODE               ,
                    BIZ_DATE             ,
                    EXCHANGE_TYPE        ,
                    STOCK_CODE           ,
                    STOCK_NAME           ,
                    REF_CODE             ,
                    RO                   ,
                    CALLPUT              ,
                    AMOUNT               ,
                    BALANCE              ,
                    DELTA_BALANCE        ,
                    STRIKE_PRICE         ,
                    D_MONTH              ,
                    MATURITY_DATE        ,
                    START_DATE           ,
                    END_DATE             ,
                    LAST_EXE_DATE        ,
                    LAST_D_DATE          ,
                    LIST_PRICE           ,
                    UNIT                 ,
                    UNDERLYINGIMPLIEDVOL ,
                    DELTA                ,
                    THETA                ,
                    GAMMA                ,
                    VEGA                 ,
                    RHO                  
                  )
    select a.f_code
           ,a.biz_date
           ,a.exchange_type -- 市场类型
           ,a.stock_code -- 证券代码
           ,a.stock_name -- 证券名称
           ,b.s_info_windcode as ref_code
           ,case when a.side='L' then '权利方' when a.side='S' then '义务方' end as RO --权利义务
           ,case when b.S_INFO_CALLPUT='708001000' then '认购' when b.S_INFO_CALLPUT='708002000' then '认沽' end as CALLPUT--合约类别
           ,a.amount -- 数量
           ,a.balance -- 期权市值
           ,a.amount*b.S_INFO_COUNIT*c.W_ANAL_DELTA*(case when a.side='L' then 1 when a.side='S' then -1 end) as DELTA_BALANCE --Delta市值
           ,b.S_INFO_STRIKEPRICE as STRIKE_PRICE --行权价格
           ,b.S_INFO_MONTH as D_MONTH --交割月份
           ,b.S_INFO_MATURITYDATE as MATURITY_DATE --到期日
           ,b.S_INFO_FTDATE as START_DATE --开始交易日
           ,b.S_INFO_LASTTRADINGDATE as END_DATE --最后交易日
           ,b.S_INFO_EXERCISINGEND as LAST_EXE_DATE --最后行权日
           ,b.S_INFO_LDDATE as LAST_D_DATE --最后交割日
           ,b.S_INFO_LPRICE as LIST_PRICE --挂牌基准价
           ,b.S_INFO_COUNIT as UNIT --合约单位
           ,c.W_ANAL_UNDERLYINGIMPLIEDVOL as UNDERLYINGIMPLIEDVOL--隐含波动率
           ,c.W_ANAL_DELTA as Delta
           ,c.W_ANAL_THETA as Theta
           ,c.W_ANAL_GAMMA as Gamma
           ,c.W_ANAL_VEGA as Vega
           ,c.W_ANAL_RHO as Rho
    from orig_position a
    left join ChinaOptionDescription b
    on a.stock_code=b.s_info_code
       and case when a.exchange_type='SSE' then 'SH' when a.exchange_type='SZSE' then 'SZ' when a.exchange_type='CZCE' then 'CZC' when a.exchange_type='DCE' then 'DCE' else a.exchange_type end = substr(b.s_info_windcode,instr(b.s_info_windcode,'.')+1,length(b.s_info_windcode)-instr(b.s_info_windcode,'.'))
    left join ChinaOptionValuation c
    on b.s_info_windcode=c.s_info_windcode
       and a.biz_date=c.trade_dt
    where a.asset_type='10'
          and a.f_code=i_f_code
          and a.biz_date=i_biz_date
          ;
    
    
    commit;
    
    
    /* 插入 量化基金分析   FUND_QUANT_ANALYSIS  */

    
        select PRO_FUND_QUANT_ANALYSIS(o_code, o_note, i_f_code, i_biz_date);
        commit;

    
    /* 插入 VAR分析  FUND_VAR  */

    IF(length(i_f_code)>20) THEN
    
        select PRO_FUND_VAR(o_code, o_note, i_f_code, i_biz_date);
        commit;
    
    END IF;
    
    
    /* 基金业绩归因  */
    
  --  PRO_FUND_BRINSON(o_code, o_note, i_f_code, i_biz_date);
    
    
    
    /* 插入 基金解析情况表  FUND_ANALYSIS_INFO  */

    delete from FUND_ANALYSIS_INFO a
    where a.biz_date=i_biz_date
          and a.f_code=i_f_code
    ;

    insert into FUND_ANALYSIS_INFO
                (  
                  F_CODE       ,
                  BIZ_DATE     ,
                  SUB_CNT      ,
                  SUB_CODE     ,
                  IS_COMPLETED ,
                  NOTE
                )
    SELECT regexp_substr(i_f_code, '[^;]+', 1, LEVEL) F_CODE
           ,i_biz_date as BIZ_DATE
           ,NULL AS SUB_CNT
           ,null as SUB_CODE
           ,null as IS_COMPLETED
           ,NULL as NOTE
    FROM dual 
    --CONNECT BY LEVEL <= LENGTH(i_f_code) - LENGTH(REPLACE(i_f_code, ';')) + 1
    ;


    /* 插入 基金解析日志表  FUND_ANALYSIS_LOG  */


    insert into FUND_ANALYSIS_LOG
                (  
                  F_CODE       ,
                  BIZ_DATE     ,
                  SUB_CNT      ,
                  SUB_CODE     ,
                  IS_COMPLETED ,
                  NOTE
                )
    SELECT regexp_substr(i_f_code, '[^;]+', 1, LEVEL) F_CODE
           ,i_biz_date as BIZ_DATE
           ,NULL AS SUB_CNT
           ,null as SUB_CODE
           ,null as IS_COMPLETED
           ,NULL as NOTE
    FROM dual 
    CONNECT BY LEVEL <= LENGTH(i_f_code) - LENGTH(REPLACE(i_f_code, ';')) + 1
    ;


       
    commit;
    
                
$func$ language plpgsql;  

 