-- Выведите список товаров products и разделов catalogs, который соответствует товару.
select products.name, c.name
from products left join catalogs c on c.id = products.catalog_id