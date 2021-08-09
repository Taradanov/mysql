-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
-- Тут есть костыль, два раза на временную таблицу в одном запросе нельзя сослаться, поэтому с городами такое(документация B.3.6.2)
drop temporary TABLE if exists flights;

drop temporary TABLE if exists cities;

drop temporary TABLE if exists cities2;

CREATE temporary TABLE if not exists flights
(
    id    INT UNSIGNED,
    from_ VARCHAR(255),
    to_   VARCHAR(20),
    constraint primary key (id)
);

CREATE temporary TABLE if not exists cities
(
    label VARCHAR(255),
    name  VARCHAR(20)
);

insert into flights
values (1, 'moscow', 'omsk'),
       (2, 'novgorod', 'kazan'),
       (3, 'irkutsk', 'moscow'),
       (4, 'omsk', 'irkutsk'),
       (5, 'moscow', 'kazan');

select *
from flights;

insert into cities
values ('moscow', 'Москва'),
       ('irkutsk', 'Иркутск'),
       ('novgorod', 'Новгород'),
       ('kazan', 'Казань'),
       ('omsk', 'Омск');

select *
from cities;

create temporary TABLE cities2
    select * from cities;

select f.id,
       c1.name,
       c2.name
from flights as f
left join cities c1 on f.from_ = c1.label
left join cities2 c2 on  f.to_ = c2.label;