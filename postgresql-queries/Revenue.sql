WITH t1 as (select Date_trunc('month', p.payment_date) as rental_month,
            sum (p.amount) as revenue
            from payment p         
            group by 1
            order by 1)
select rental_month, revenue,
LAG(revenue) OVER (ORDER BY rental_month) AS lag,
revenue - LAG(revenue) OVER (ORDER BY rental_month) AS revenue_growth
from t1
group by 1,2
order by 1