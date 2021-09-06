create or replace function PRO_MUTUALFUND_ANALYSIS(
    i_f_code      in     varchar,      -- 基金内部编码
    i_startdate   in     varchar,     -- 开始日期
    i_enddate     in     varchar       -- 结束日期
)
returns void as $func$
declare


/*
公募基金持仓分析 


20170516   创建


*/

    v_startDate varchar(8);
    v_endDate   varchar(8);
    v_f_code       varchar(4000);
    x record;
  
BEGIN
  

    SELECT coalesce(i_startdate,to_char(sysdate-130,'yyyymmdd')) INTO v_startDate
    FROM dual;
       
    SELECT coalesce(i_enddate,to_char(sysdate,'yyyymmdd')) INTO v_endDate
    FROM dual;
       
    v_f_code := ';'||i_f_code||';';



BEGIN



FOR x IN (
  /*
          select a.s_info_windcode as f_code
                 ,a.F_PRT_ENDDATE as biz_Date
          from ChinaMutualFundAssetPortfolio a
          where      (i_f_code is not null and i_f_code=a.s_info_windcode)
                and F_PRT_ENDDATE>=v_startDate
                and F_PRT_ENDDATE<=v_endDate
          
          union all 
          
          select a.s_info_windcode as f_code
                 ,a.F_PRT_ENDDATE as biz_Date
          from ChinaMutualFundAssetPortfolio a
          where     (i_f_code is null and (a.s_info_windcode,a.f_prt_enddate) not in (select f_code,biz_date from FUND_ASSET_STRUCTUR))
                and F_PRT_ENDDATE>=v_startDate
                and F_PRT_ENDDATE<=v_endDate
          
          union all
          
          select a.f_code,a.biz_date
          from fund_asset_structur a
          where a.asset_type in ('2','4')
                  and i_f_code is null
                  and a.biz_date>=v_startDate
                  and a.biz_date<=v_endDate
                  and (a.f_code,a.biz_date) not in (select f_code,biz_date from orig_position where asset_type in ('2','4'))
          order by 1,2*/
          
  
          select distinct f_code
                          ,biz_Date
          from 
          (     
/*              select a.s_info_windcode as f_code
                     ,a.F_PRT_ENDDATE as biz_Date
              from ChinaMutualFundAssetPortfolio a
              where F_PRT_ENDDATE>=v_startDate
                    and F_PRT_ENDDATE<=v_endDate
                    and (    a.s_info_windcode=i_f_code
                          or (i_f_code is null and (a.s_info_windcode,a.f_prt_enddate) not in (select f_code,biz_date from FUND_ASSET_STRUCTUR))
                        )*/
              
              select a.s_info_windcode as f_code
                     ,a.F_PRT_ENDDATE as biz_Date
              from ChinaMutualFundAssetPortfolio a
              where F_PRT_ENDDATE>=v_startDate
                    and F_PRT_ENDDATE<=v_endDate
                    and (    a.s_info_windcode=i_f_code
                 --         or (i_f_code is null and (a.s_info_windcode,a.f_prt_enddate) not in (select f_code,biz_date from FUND_ASSET_STRUCTUR))
                        )
                        
              union all
              
              select a.s_info_windcode as f_code
                     ,a.F_PRT_ENDDATE as biz_Date
              from ChinaMutualFundAssetPortfolio a
              where F_PRT_ENDDATE>=v_startDate
                    and F_PRT_ENDDATE<=v_endDate
                    and (   /* a.s_info_windcode=i_f_code
                          or */(i_f_code is null and (a.s_info_windcode,a.f_prt_enddate) not in (select f_code,biz_date from FUND_ASSET_STRUCTUR))
                        )        
                         
              union all
              
              select a.f_code,a.biz_date
              from fund_asset_structur a
              where a.asset_type in ('2','4')
                      and a.biz_date>=v_startDate
                      and a.biz_date<=v_endDate
                      and i_f_code is null
                      and (a.f_code,a.biz_date) not in (select f_code,biz_date from orig_position where asset_type in ('2','4'))
                      
              union all
              
              select t1.f_code
                     ,t1.biz_date
              from 
              (
                  select a.s_info_windcode as F_CODE
                         ,a.f_prt_enddate as BIZ_DATE
                         ,count(*) as cnt
                  from ChinaMutualFundStockPortfolio a
                  where a.f_prt_enddate>=v_startDate
                        and a.f_prt_enddate<=v_endDate
                        and i_f_code is null
                  group by a.s_info_windcode 
                         ,a.f_prt_enddate 
               ) t1
               left join 
               (
                    select a.f_code
                           ,a.biz_date
                           ,count(*) as cnt
                    from fund_eq_position a
                    where a.biz_date>=v_startDate
                          and a.biz_date<=v_endDate
                    group by a.f_code
                           ,a.biz_date
               ) t2
               on t1.f_code=t2.f_code
                  and t1.biz_date=t2.biz_date
               where t1.cnt<>coalesce(t2.cnt,0)
          
          ) tt       
          order by 1,2
           
              
         ) LOOP
             
        delete from orig_fund_summary a
        where a.f_code=x.f_code
              and a.biz_date=x.biz_date
        ;    
        
        insert into orig_fund_summary
                    (
                      F_CODE     ,
                      BIZ_DATE   ,
                      NAV        ,
                      ACC_NAV    ,
                      ASSET      ,
                      DEBIT      ,
                      NET_ASSET  ,
                      CAPITAL    ,
                      FQ_NAV
                    ) 
        select a.s_info_windcode as f_code
               ,a.F_PRT_ENDDATE as biz_Date
               ,b.F_NAV_UNIT as NAV
               ,b.F_NAV_ACCUMULATED as ACC_NAV
               ,a.F_PRT_TOTALASSET as ASSET
               ,a.F_PRT_TOTALASSET-a.F_PRT_NETASSET as DEBIT
               ,a.F_PRT_NETASSET as NET_ASSET
               ,null as CAPITAL
               ,b.F_NAV_ADJUSTED as FQ_NAV
        from ChinaMutualFundAssetPortfolio a
        left join 
        (
             select t.F_NAV_UNIT
                    ,t.F_NAV_ACCUMULATED
                    ,t.F_NAV_ADJUSTED
             from ChinaMutualFundNAV t
             where t.f_info_windcode=x.f_code
                   and t.price_date=(select max(price_date) from ChinaMutualFundNAV where f_info_windcode=x.f_code and price_date<=x.biz_date)
        ) b
        on 1=1
        where a.s_info_windcode=x.f_code
              and a.F_PRT_ENDDATE=x.biz_date
              ;
        
        
              
          
        delete from orig_position a
        where a.f_code=x.f_code
              and a.biz_date=x.biz_date
        ;    
        
        insert into orig_position
                    (
                      F_CODE          ,
                      BIZ_DATE        ,
                      ASSET_TYPE      ,
                      EXCHANGE_TYPE   ,
                      SIDE            ,
                      STOCK_CODE      ,
                      STOCK_NAME      ,
                      AMOUNT          ,
                      UNIT_COST       ,
                      COST            ,
                      COST_RATIO      ,
                      PRICE           ,
                      BALANCE         ,
                      BALANCE_RATIO   ,
                      PROFIT          ,
                      SUSPENSION_INFO    
                    ) 
        select a.s_info_windcode as F_CODE
               ,a.f_prt_enddate as BIZ_DATE
               ,'2' as ASSET_TYPE
               ,coalesce(b.s_info_exchmarket,c.s_info_exchange_eng) as EXCHANGE_TYPE
               ,'L' as SIDE
               ,coalesce(b.s_info_code,lpad(c.s_info_code,5,'0')) as STOCK_CODE
               ,coalesce(b.s_info_name,c.s_info_name) as STOCK_NAME
               ,a.F_PRT_STKQUANTITY as AMOUNT
               ,null as UNIT_COST
               ,null as COST
               ,null as COST_RATIO
               ,case when a.F_PRT_STKQUANTITY=0 then null else a.F_PRT_STKVALUE/a.F_PRT_STKQUANTITY end as PRICE
               ,a.F_PRT_STKVALUE as BALANCE
               ,null as BALANCE_RATIO
               ,null as PROFIT
               ,null as SUSPENSION_INFO
        from ChinaMutualFundStockPortfolio a
        left join asharedescription b
        on a.S_INFO_STOCKWINDCODE=b.s_info_windcode
        left join hksharedescription c
        on a.s_info_stockwindcode=c.s_info_windcode
        where a.s_info_windcode=x.f_code
              and a.f_prt_enddate=x.biz_date
        
        union all
                
        select a.s_info_windcode as F_CODE
               ,a.f_prt_enddate as BIZ_DATE
               ,'4' as ASSET_TYPE
               ,case when b.s_info_exchmarket='NIB' then 'OTCIB' else b.s_info_exchmarket end  as EXCHANGE_TYPE
               ,'L' as SIDE
               ,REGEXP_SUBSTR(b.S_INFO_WINDCODE, '[^.]+') as STOCK_CODE
               ,b.s_info_name as STOCK_NAME
               ,a.F_PRT_BDQUANTITY as AMOUNT
               ,null as UNIT_COST
               ,null as COST
               ,null as COST_RATIO
               ,case when a.F_PRT_BDQUANTITY=0 then null else a.F_PRT_BDVALUE/a.F_PRT_BDQUANTITY end as PRICE
               ,a.F_PRT_BDVALUE as BALANCE
               ,null as BALANCE_RATIO
               ,null as PROFIT
               ,null as SUSPENSION_INFO
        from ChinaMutualFundBondPortfolio a
        left join CBondDescription b
        on a.s_info_bondwindcode=b.s_info_windcode
        where a.s_info_windcode=x.f_code
              and a.f_prt_enddate=x.biz_date
        
        union all

        select a.s_info_windcode as F_CODE
               ,a.END_DT as BIZ_DATE
               ,'3' as ASSET_TYPE
               ,b.s_info_exchmarket as EXCHANGE_TYPE
               ,case when a.quantity>=0 then 'L' else 'S' end as SIDE
               ,b.S_INFO_CODE as STOCK_CODE
               ,b.s_info_name as STOCK_NAME
               ,abs(a.quantity) as AMOUNT
               ,null as UNIT_COST
               ,null as COST
               ,null as COST_RATIO
               ,null as PRICE
               ,a.value as BALANCE
               ,null as BALANCE_RATIO
               ,null as PROFIT
               ,null as SUSPENSION_INFO
        from CMFOtherPortfolio a
        inner join CFuturesDescription b
        on a.s_info_holdwindcode=b.s_info_windcode
        where a.s_info_windcode=x.f_code
              and a.END_DT=x.biz_date
              
        union all
        
        select a.s_info_windcode as F_CODE
               ,a.END_DT as BIZ_DATE
               ,'5' as ASSET_TYPE
               ,b.F_INFO_EXCHMARKET as EXCHANGE_TYPE
               ,'L'as SIDE
               ,substr(a.s_info_holdwindcode,1,6) as STOCK_CODE
               ,b.F_INFO_NAME as STOCK_NAME
               ,a.quantity as AMOUNT
               ,null as UNIT_COST
               ,null as COST
               ,null as COST_RATIO
               ,null as PRICE
               ,a.value as BALANCE
               ,null as BALANCE_RATIO
               ,null as PROFIT
               ,null as SUSPENSION_INFO
        from CMFOtherPortfolio a
        inner join ChinaMutualFundDescription b
        on a.s_info_holdwindcode=b.f_info_windcode
        where a.s_info_windcode=x.f_code
              and a.END_DT=x.biz_date 
        
        union all     
        
        select a.s_info_windcode as F_CODE
               ,a.f_prt_enddate as BIZ_DATE
               ,'1' as ASSET_TYPE
               ,null as EXCHANGE_TYPE
               ,'L' as SIDE
               ,null as STOCK_CODE
               ,'现金' as STOCK_NAME
               ,coalesce(a.F_PRT_CASH,0) as AMOUNT
               ,null as UNIT_COST
               ,null as COST
               ,null as COST_RATIO
               ,1 as PRICE
               ,coalesce(a.F_PRT_CASH,0) as BALANCE
               ,null as BALANCE_RATIO
               ,null as PROFIT
               ,null as SUSPENSION_INFO
        from ChinaMutualFundAssetPortfolio a
        where a.s_info_windcode=x.f_code
              and F_PRT_ENDDATE=x.biz_date
              and coalesce(a.F_PRT_CASH,0)<>0
              
        union all

        select a.s_info_windcode as F_CODE
               ,a.f_prt_enddate as BIZ_DATE
               ,'8' as ASSET_TYPE
               ,null as EXCHANGE_TYPE
               ,'L' as SIDE
               ,null as STOCK_CODE
               ,'买入返售' as STOCK_NAME
               ,null as AMOUNT
               ,null as UNIT_COST
               ,null as COST
               ,null as COST_RATIO
               ,null as PRICE
               ,coalesce(a.F_MMF_REVERSEREPO,0) as BALANCE
               ,null as BALANCE_RATIO
               ,null as PROFIT
               ,null as SUSPENSION_INFO 
               
        from ChinaMutualFundAssetPortfolio a
        where a.s_info_windcode=x.f_code
              and F_PRT_ENDDATE=x.biz_date
              and coalesce(a.F_MMF_REVERSEREPO,0)<>0
        union all

        select a.s_info_windcode as F_CODE
               ,a.f_prt_enddate as BIZ_DATE
               ,'0' as ASSET_TYPE
               ,null as EXCHANGE_TYPE
               ,'L' as SIDE
               ,null as STOCK_CODE
               ,'其他' as STOCK_NAME
               ,null as AMOUNT
               ,null as UNIT_COST
               ,null as COST
               ,null as COST_RATIO
               ,null as PRICE
               ,coalesce(a.F_PRT_OTHER,0)-coalesce(a.F_MMF_REVERSEREPO,0) as BALANCE
               ,null as BALANCE_RATIO
               ,null as PROFIT
               ,null as SUSPENSION_INFO 
        from ChinaMutualFundAssetPortfolio a
        where a.s_info_windcode=x.f_code
              and F_PRT_ENDDATE=x.biz_date   
              and coalesce(a.F_PRT_OTHER,0)-coalesce(a.F_MMF_REVERSEREPO,0)<>0

         
        ;
     
        commit;
        
        
        select PRO_FUND_POSITION_ANALYSIS(o_code, o_note, x.f_code, x.biz_date);
        
        
        
        delete from FUND_ASSET_STRUCTUR a
        where a.f_code=x.f_code
              and a.biz_date=x.biz_date
              and a.asset_type in ('0','1','2','4','5','8')
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
        select a.s_info_windcode as f_code
               ,a.s_info_windcode as f_name
               ,a.F_PRT_ENDDATE as biz_Date
               ,'1' as asset_type
               ,coalesce(a.F_PRT_CASH,0) as balance_long
               ,0 as balance_short
        from ChinaMutualFundAssetPortfolio a
        where a.s_info_windcode=x.f_code
              and F_PRT_ENDDATE=x.biz_date
              and coalesce(a.F_PRT_CASH,0)<>0
        union all
        select a.s_info_windcode as f_code
               ,a.s_info_windcode as f_name
               ,a.F_PRT_ENDDATE as biz_Date
               ,'2' as asset_type
               ,coalesce(a.F_PRT_STOCKVALUE,0) as balance_long
               ,0 as balance_short
        from ChinaMutualFundAssetPortfolio a
        where a.s_info_windcode=x.f_code
              and F_PRT_ENDDATE=x.biz_date
              and coalesce(a.F_PRT_STOCKVALUE,0)<>0
        union all
        select a.s_info_windcode as f_code
               ,a.s_info_windcode as f_name
               ,a.F_PRT_ENDDATE as biz_Date
               ,'4' as asset_type
               ,coalesce(a.F_PRT_BONDVALUE,0) as balance_long
               ,0 as balance_short
        from ChinaMutualFundAssetPortfolio a
        where a.s_info_windcode=x.f_code
              and F_PRT_ENDDATE=x.biz_date
              and coalesce(a.F_PRT_BONDVALUE,0)<>0
        union all
        select a.s_info_windcode as f_code
               ,a.s_info_windcode as f_name
               ,a.F_PRT_ENDDATE as biz_Date
               ,'5' as asset_type
               ,coalesce(a.F_PRT_FUNDVALUE,0) as balance_long
               ,0 as balance_short
        from ChinaMutualFundAssetPortfolio a
        where a.s_info_windcode=x.f_code
              and F_PRT_ENDDATE=x.biz_date
              and coalesce(a.F_PRT_FUNDVALUE,0)<>0
        union all
        select a.s_info_windcode as f_code
               ,a.s_info_windcode as f_name
               ,a.F_PRT_ENDDATE as biz_Date
               ,'8' as asset_type
               ,coalesce(a.F_MMF_REVERSEREPO,0) as balance_long
               ,0 as balance_short
        from ChinaMutualFundAssetPortfolio a
        where a.s_info_windcode=x.f_code
              and F_PRT_ENDDATE=x.biz_date
              and coalesce(a.F_MMF_REVERSEREPO,0)<>0
        union all
        select a.s_info_windcode as f_code
               ,a.s_info_windcode as f_name
               ,a.F_PRT_ENDDATE as biz_Date
               ,'0' as asset_type
               ,coalesce(a.F_PRT_OTHER,0)-coalesce(a.F_MMF_REVERSEREPO,0) as balance_long
               ,0 as balance_short
        from ChinaMutualFundAssetPortfolio a
        where a.s_info_windcode=x.f_code
              and F_PRT_ENDDATE=x.biz_date   
              and coalesce(a.F_PRT_OTHER,0)-coalesce(a.F_MMF_REVERSEREPO,0)<>0
              ;
        
        
        
        -- MERGE INTO fund_eq_position t1
        -- USING 
        -- (
        --     select a.f_code
        --            ,a.biz_date
        --            ,a.ref_code
        --            ,a.balance/coalesce(b.F_PRT_STOCKVALUE,0) as balance_ratio
        --     from fund_eq_position a
        --     left join ChinaMutualFundAssetPortfolio b
        --     on a.f_code=b.s_info_windcode
        --        and a.biz_date=b.F_PRT_ENDDATE
        --     where a.f_code=x.f_code
        --           and a.biz_date=x.biz_date
        --           and coalesce(b.F_PRT_STOCKVALUE,0)<>0
            
            
        -- ) t2
        -- ON (t1.f_code=t2.f_code and t1.biz_date=t2.biz_Date and t1.ref_code=t2.ref_code)
        -- WHEN MATCHED THEN UPDATE
        --      SET T1.balance_ratio=T2.balance_ratio
        --          ;
                 
        
        
        -- MERGE INTO FUND_FUND_POSITION t1
        -- USING 
        -- (
        --     select a.f_code
        --            ,a.biz_date
        --            ,a.ref_code
        --            ,a.balance/coalesce(b.F_PRT_FUNDVALUE,0) as balance_ratio
        --     from FUND_FUND_POSITION a
        --     left join ChinaMutualFundAssetPortfolio b
        --     on a.f_code=b.s_info_windcode
        --        and a.biz_date=b.F_PRT_ENDDATE
        --     where a.f_code=x.f_code
        --           and a.biz_date=x.biz_date
        --           and coalesce(b.F_PRT_FUNDVALUE,0)<>0
            
            
        -- ) t2
        -- ON (t1.f_code=t2.f_code and t1.biz_date=t2.biz_Date and t1.ref_code=t2.ref_code)
        -- WHEN MATCHED THEN UPDATE
        --      SET T1.balance_ratio=T2.balance_ratio
        --          ;
        
        
        commit;
        
        
        select PRO_FUND_BRINSON(o_code, o_note, x.f_code, x.biz_date);
        
        select PRO_FUND_RETURN(o_code, o_note, x.f_code, x.biz_date);
        
    
END LOOP;



END;   
end;
$func$ language plpgsql;