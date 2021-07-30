use shop;

-- добавлю фейковые колонки, из которых буду брать дату для преобразования.
-- допустим я просто переименовал старые колонки и вставил новые
alter table users
    add column created_at_vc varchar(16),
    add column updated_at_vc varchar(16);

-- внес фейковые данные,
truncate table users;

-- резервная копия
INSERT INTO shop.users (id, name, birthday_at, created_at, updated_at, created_at_vc, updated_at_vc)
VALUES (1, 'Геннадий', '1990-10-05', null, '2021-07-29 03:12:08', null, null);
INSERT INTO shop.users (id, name, birthday_at, created_at, updated_at, created_at_vc, updated_at_vc)
VALUES (2, 'Наталья', '1984-11-12', null, '2021-07-29 03:12:08', null, null);
INSERT INTO shop.users (id, name, birthday_at, created_at, updated_at, created_at_vc, updated_at_vc)
VALUES (3, 'Александр', '1985-05-20', null, '2021-07-29 03:56:04', '2.1.2017 8:10', '1.1.2018 18:00');
INSERT INTO shop.users (id, name, birthday_at, created_at, updated_at, created_at_vc, updated_at_vc)
VALUES (4, 'Сергей', '1988-02-14', null, '2021-07-29 03:55:59', '20.10.2017 8:10', '1.1.2018 18:00');
INSERT INTO shop.users (id, name, birthday_at, created_at, updated_at, created_at_vc, updated_at_vc)
VALUES (5, 'Иван', '1998-01-12', null, '2021-07-29 03:56:11', '2.10.2011 00:00', '1.1.2018 18:00');
INSERT INTO shop.users (id, name, birthday_at, created_at, updated_at, created_at_vc, updated_at_vc)
VALUES (6, 'Мария', '1992-08-29', null, '2021-07-29 03:23:41', '20.10.2017 8:10', '1.1.2018 18:00');

-- для проверки преобразования
select str_to_date(created_at_vc, '%d.%m.%Y %k:%i')
from users;

-- я догадываюсь что есть более простое решение, без транзакции))
-- и что я не совсем понимаю что такое транзакция на уровне СУБД
start transaction;

-- скопирую таблицу во времянку
create temporary table tmp_users
select *
from users;

-- удаляю старые записи
truncate table users;

insert into users(id, name, birthday_at, created_at, updated_at)
select id                                           as id,
       name                                         as name,
       birthday_at                                  as birthday_at,
       str_to_date(created_at_vc, '%d.%m.%Y %k:%i') as created_at,
       str_to_date(created_at_vc, '%d.%m.%Y %k:%i') as updated_at
from tmp_users;

drop temporary TABLE tmp_users;

commit;
