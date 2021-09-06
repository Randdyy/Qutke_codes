create or replace function PRO_FUND_DEL(
      i_f_code      in     varchar,      -- 基金内部编码
      i_biz_date    in     varchar       -- 计算日期
)
returns void as $func$
declare

/*

基金持仓删除


*/


   v_f_code       varchar(4000);
   v_lastday      varchar(8);
   v_nextday      varchar(8);
   
  
BEGIN
  
    v_f_code := ';'||REPLACE(REPLACE(REPLACE(i_f_code, ',', ';'), '，', ';'), '；', ';')||';';
    


    IF(i_f_code is null) THEN
            
        RETURN;
        
    END IF;
    
    
    /* 删除 基金持仓解析表	ORIG_POSITION */
       
    delete from ORIG_POSITION a
    where (a.biz_date=i_biz_date or i_biz_date is null)
          and a.f_code=i_f_code 
    ;
    
    /* 删除 基金汇总解析表	ORIG_FUND_SUMMARY */
       
    delete from ORIG_FUND_SUMMARY a
    where (a.biz_date=i_biz_date or i_biz_date is null)
          and a.f_code=i_f_code 
    ;

    
    /* 删除 基金资产结构表	FUND_ASSET_STRUCTUR */
       
    delete from FUND_ASSET_STRUCTUR a
    where (a.biz_date=i_biz_date or i_biz_date is null)
          and a.f_code=i_f_code 
    ;
    

    
    /* 删除 基金股票持仓表	 FUND_EQ_POSITION */
       
    delete from FUND_EQ_POSITION a
    where (a.biz_date=i_biz_date or i_biz_date is null)
          and a.f_code=i_f_code 
    ;

    

    /* 删除 基金股票行业集中度	 FUND_EQ_INDUSTRY */

    delete from FUND_EQ_INDUSTRY a
    where (a.biz_date=i_biz_date or i_biz_date is null)
          and a.f_code=i_f_code 
    ;

                
    /* 删除 基金股票投资风格表	 FUND_EQ_STYLE*/

    delete from FUND_EQ_STYLE a
    where (a.biz_date=i_biz_date or i_biz_date is null)
          and a.f_code=i_f_code 
    ;
                
                
    /* 删除 基金股票投资概念表	 FUND_EQ_CONCEPT  */

    delete from FUND_EQ_CONCEPT a
    where (a.biz_date=i_biz_date or i_biz_date is null)
          and a.f_code=i_f_code 
    ;


    /* 删除 基金期货持仓明细表	 FUND_FUT_POSITION  */

    delete from FUND_FUT_POSITION a
    where (a.biz_date=i_biz_date or i_biz_date is null)
          and a.f_code=i_f_code 
    ;


    /* 删除 基金期货持仓品种表	 FUND_FUT_TYPE  */

    delete from FUND_FUT_TYPE a
    where (a.biz_date=i_biz_date or i_biz_date is null)
          and a.f_code=i_f_code 
    ;


    /* 删除 基金债券持仓表	 FUND_BOND_POSITION  */

    delete from FUND_BOND_POSITION a
    where (a.biz_date=i_biz_date or i_biz_date is null)
          and a.f_code=i_f_code 
    ;
  
    /* 删除 基金债券投资概念表	 FUND_BOND_CONCEPT  */

    delete from FUND_BOND_CONCEPT a
    where (a.biz_date=i_biz_date or i_biz_date is null)
          and a.f_code=i_f_code 
    ;
    
    /* 删除 量化基金分析表	 FUND_QUANT_ANALYSIS  */

    delete from FUND_QUANT_ANALYSIS a
    where (a.biz_date=i_biz_date or i_biz_date is null)
          and a.f_code=i_f_code 
    ;
    
    /* 删除 VAR分析表	 FUND_VAR  */

    delete from FUND_VAR a
    where (a.biz_date=i_biz_date or i_biz_date is null)
          and a.f_code=i_f_code 
    ;
     

    /* 删除 业绩归因,收益分解	 FUND_EQ_BRINSON_DETAIL  FUND_EQ_BRINSON_SUM  FUND_RETURN_DETAIL */



        FOR x IN (
                    SELECT regexp_substr(i_f_code, '[^;]+', 1, LEVEL) F_CODE
                    FROM dual 
                    CONNECT BY LEVEL <= LENGTH(i_f_code) - LENGTH(REPLACE(i_f_code, ';')) + 1
                 ) LOOP
        
            select max(a.biz_date) into v_lastday
            from FUND_ANALYSIS_INFO a
            where a.f_code=x.F_CODE
                  and a.biz_date<i_biz_date
            ;
            
            select min(a.biz_date) into v_nextday
            from FUND_ANALYSIS_INFO a
            where a.f_code=x.F_CODE
                  and a.biz_date>i_biz_date
            ;
            
            delete from FUND_EQ_BRINSON_DETAIL a
            where a.f_code=x.F_CODE
                  and ((a.start_date=i_biz_date or a.end_date=i_biz_date) or i_biz_date is null)
            ;
        
            delete from FUND_EQ_BRINSON_SUM a
            where a.f_code=x.F_CODE
                  and ((a.start_date=i_biz_date or a.end_date=i_biz_date) or i_biz_date is null)
            ;
            
            delete from FUND_RETURN_DETAIL a
            where a.f_code=x.F_CODE
                  and ((a.start_date=i_biz_date or a.end_date=i_biz_date) or i_biz_date is null)
            ;
        
        
            IF(v_lastday is not null and v_nextday is not null and i_biz_date is not null) THEN
            
                PRO_FUND_EQ_BRINSON(o_code, o_note, x.F_CODE, v_lastday, v_nextday);
                
                PRO_FUND_RETURN_ANALYSIS(o_code, o_note, x.F_CODE, v_lastday, v_nextday);
                
                if o_code = -1 then
                  return;
                end if;
                
            END IF;
            
        
        END LOOP;
    
    
    
    
    /* 删除 基金解析情况表	 FUND_ANALYSIS_INFO  */

    delete from FUND_ANALYSIS_INFO a
    where (a.biz_date=i_biz_date or i_biz_date is null)
          and a.f_code=i_f_code 
    ;

        commit;
    
$func$ language plpgsql;         