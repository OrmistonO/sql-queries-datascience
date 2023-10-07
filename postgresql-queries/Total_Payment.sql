WITH t1 as 	(select c.customer_id, concat(c.first_name, '  ', c.last_name) as fullname
            		from customer c
           		 order by create_date desc
           		 limit 10)
select cast(Date_trunc('month', p.payment_date) AS varchar(10)) as payment_month, 
t1.fullname,
sum (p.amount) as payment_total
from payment p
join t1
on p.customer_id = t1.customer_id 
group by 1,2
order by 2