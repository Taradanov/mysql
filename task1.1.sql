-- было интересно попробовать через копирование структуры таблицы, а не через копию базы
use shop;

drop database if exists sample;

create schema sample COLLATE utf8mb4_0900_ai_ci charset utf8mb4;

use sample;

create table user like shop.users;

-- Собственно перенос
start transaction;

insert into sample.user
select *
from shop.users
where id = 1;

delete
from shop.users
where id = 1;

commit;