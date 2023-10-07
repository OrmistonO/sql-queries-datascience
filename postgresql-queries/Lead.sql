WITH t1 as (select concat(c.first_name, ' ', c.last_name) as fullname,
            Date_trunc('month', p.payment_date) as rental_month,
            sum (p.amount) as payment_total
            from customer c
            join payment p
            on p.customer_id = c.customer_id 
            group by 1,2
            order by 1
	    limit 50)
select fullname, cast (rental_month AS varchar(10)), payment_total,
LEAD(payment_total) OVER (PARTITION BY fullname ORDER BY rental_month) - payment_total AS lead_difference
from t1
group by 1,rental_month, 3
order by 1,2