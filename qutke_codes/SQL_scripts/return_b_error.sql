with market_industry as
    (

        select a.industry
               ,avg(coalesce(a.weight,0)) as weight_b
               ,sum(a.weight*(case when a.biz_date=20210714 then 0 else a.pct end)*a.adj_factor/(case when c.FT11<>b.FT11 then ln(c.FT11/b.FT11)/(c.FT11/b.FT11-1) else 1 end))/avg(coalesce(a.weight,0)) as return_b
        from refdatauser.industry_weight a
        left join refdatauser.FT_TABLE18 b
        on b.FT01=20210714
        left join refdatauser.FT_TABLE18 c
        on c.FT01=20210715
        where a.index_type='沪深300'
              and a.biz_date>=20210714
              and a.biz_date<=20210715
        group by a.industry

    )
    
    
    select t.industry
               ,t.weight_b/b.weight_market as weight_b
               ,case when b.return_market=0 then t.return_b else t.return_b/b.return_market*a.total_return end as return_b
        from market_industry t,(

            select (b.s_dq_close-a.s_dq_close)/a.s_dq_close as total_return,
            b.s_dq_close,
            a.s_dq_close,
            a.s_dq_close
            from wind.AIndexEODPrices a
            left join wind.AIndexEODPrices b
            on b.s_info_windcode='399300.SZ'
               and b.trade_dt=20210715
            where a.s_info_windcode='399300.SZ'
                  and a.trade_dt=20210714) a,
                  (
            select sum(weight_b) as weight_market
                   ,sum(weight_b*return_b) as return_market
            from market_industry 
        ) b
                  
select * from wind.AIndexEODPrices where s_info_windcode='399300.SZ' and trade_dt=20210405
