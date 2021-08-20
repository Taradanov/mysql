use shop;

create or replace view nomenclatura as
select p.name as product, c.name as catalog
from products p
         left join catalogs c on c.id = p.catalog_id;

select *
from nomenclatura;
