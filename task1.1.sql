use shop;

drop table if exists logs_;

drop procedure if exists write_log;

drop trigger if exists catalogs_log_before_insert;
drop trigger if exists users_log_before_insert;
drop trigger if exists products_log_before_insert;

delete from catalogs where name = 'Корпуса';

-- не плодить сущности. Считаю что:
-- уникальный ид записи ДЛЯ ЭТОЙ таблицы по данной задаче не нужен.
-- если будем джойнить то можно и по имени таблицы (table_name), поэтому внешних ключей не будет.
create table logs_
(
	create_datetime datetime default now() not null,
	table_name set('users', 'catalogs', 'products') not null,
	id int not null,
	name varchar(255) null
) engine 'Archive' ;

-- Собственно запись сделаю через отдельную процедуру,
-- а в триггере буду вызывать её для каждой записи

create procedure write_log(in table_name_ varchar(10),
                            in id_ int,
                            in name_ varchar(255)
                            )
begin
    insert into logs_(table_name, id, name) values (table_name_, id_, name_);
end;

-- Триггеры
create trigger users_log_before_insert
    AFTER INSERT
    on users
    for each row
begin
    call write_log('users', NEW.id, NEW.name);
end;

create trigger catalogs_log_before_insert
    AFTER INSERT
    on catalogs
    for each row
begin
    call write_log('catalogs', NEW.id, NEW.name);
end;

create trigger products_log_before_insert
    AFTER INSERT
    on products
    for each row
begin
    call write_log('products', NEW.id, NEW.name);
end;

insert into catalogs(name) values ('Корпуса');