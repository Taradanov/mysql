use shop;
-- 5 свежих
select *, id
from products
order by created_at desc
limit 5;

-- запрос
delete
from products
where id not in (select * from (select id
                 from products
                 order by created_at desc
                 limit 5) t);
