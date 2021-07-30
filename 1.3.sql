use shop;

truncate storehouses_products;

select *
from storehouses_products;

insert into storehouses_products(storehouse_id, product_id, value) values
(1,1,0), (1,2, 2500),(1,3, 0),(1,4, 30),(1,5, 500),(1,6, 1);

select value
from storehouses_products
order by if(value > 0, 0, 1), value;