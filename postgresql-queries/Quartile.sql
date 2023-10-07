WITH t1 as (select Date_part('year', r.rental_date) as rental_year,
Date_trunc('day', r.rental_date)  as rent_date,
count (r.rental_id) as rent_total
from rental r
group by 1,2)
select rental_year, rent_date, rent_total,
Ntile(4) Over (Partition by rental_year Order by rent_total) as quartile
from t1
group by 1,2,3
order by 1,2