select a.day, to_char(a.day, 'D') as xingqi
              --开始时间
                from (SELECT TO_DATE('20200924', 'YYYY-MM-DD') + LEVEL - 1 DAY
                        FROM DUAL
                      --开始时间
                      CONNECT BY TO_DATE('20200924', 'YYYY-MM-DD') + LEVEL - 1 <=
                                --结束时间
                                 TO_DATE('20200927', 'YYYY-MM-DD')) a


select a.day, to_char(a.day, 'D') as xingqi
              --开始时间
                from (
                    with RECURSIVE cte as 
                                    ( 
                    SELECT cast('20200924' as date) as day ,extract(DOW FROM cast('20200924' as TIMESTAMP))+1 as xingqi,1 as leve
                    union all  
                        select cast(cast('20200924' as date)+cast(leve||' days' as interval) as date) as day ,
                        case when extract(DOW FROM cast(cast('20200924' as date)+cast(leve+1||' days' as interval) as TIMESTAMP))=0
                        then 
                        '7'
                        else 
                        extract(DOW FROM cast(cast('20200924' as date)+cast(leve+1||' days' as interval) as TIMESTAMP))
                        end
                        as xingqi,leve+1 from cte  where leve
                        <date_part('day', cast('20200927' as TIMESTAMP)- cast('20200924' as TIMESTAMP))+1
                )select *  FROM cte
) a