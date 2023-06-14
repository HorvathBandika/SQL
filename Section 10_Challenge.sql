Section 10 / Challenge

WE want to know and compare the various amounts of films we have per movie rating.
Use CASE and the dvdrental database to re-create this table:
			r	pg	pg13
			195	194	223

select
sum(case rating
	when 'R' then 1
	else 0
end) as r,
sum(case rating
   when 'PG' then 1 
   else 0
end) as pg,
sum(case rating
   when 'PG-13' then 1 
   else 0
end) as pg13
from film