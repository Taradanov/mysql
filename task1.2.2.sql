use shop;

drop table if exists users_;

create table users_ like users;

drop table if exists ten;

-- Таблица сделана конструктором pycharm
create table ten
(
	id int UNSIGNED
);

alter table ten
	add constraint ten_pk
		primary key (id);

alter table ten modify id int auto_increment;


-- 10 записей
insert into ten(id) values (null), (null),(null),(null),(null),(null),(null),(null),(null),(null);

-- 1 000 00
insert into users_(name)
select t1.id + t2.id*10 + t3.id * 100 + t4.id * 1000+ t5.id * 10000+ t6.id * 100000 as name from ten t1 cross join ten t2 cross join ten t3 cross join ten t4 cross join ten t5 cross join ten t6;

drop table if exists ten;