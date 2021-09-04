use magazin;

insert into clients(name, email)
values ('Пятерочка', '5@ru'),
       ('ТЦ Аура', 'mess@aura.ru'),
       ('DNS', 'manager@dns.ru'),
       ('F5', 'user@f5.ru');

insert into warehouse(name)
values ('Основной'),
       ('Офис'),
       ('Брак');

insert into type_of_goods(name)
values ('Процессоры'),
       ('Видеокарты'),
       ('Велосипеды');

insert into spec_type_of_goods(name, type_of_goods_id)
values ('Производитель', 1),
       ('Семейство', 1),
       ('Количество ядер', 1),
       ('Производитель', 2),
       ('Производитель', 3),
       ('Назначение', 3);
/*
# select spec_type_of_goods.id,spec_type_of_goods.name,tog.name,tog.id
# from spec_type_of_goods
#          left join type_of_goods tog on tog.id = spec_type_of_goods.type_of_goods_id
# order by type_of_goods_id, spec_type_of_goods.id;
*/
# Видеокарты Производитель
insert into values_of_spec_type(spec_type_of_good_id, `value`)
values (4, 'ASUS'),
       (4, 'Gigabyte'),
       (4, 'MSI');

insert into values_of_spec_type(spec_type_of_good_id, `value`)
values (5, 'Outleap'),
       (5, 'GT'),
       (5, 'Canondale');

insert into values_of_spec_type(spec_type_of_good_id, `value`)
values (6, 'MTB'),
       (6, 'BMG'),
       (6, 'Free Ride');

insert into values_of_spec_type(spec_type_of_good_id, `value`)
values (1, 'AMD'),
       (1, 'Intel'),
       (1, 'Cyrix');

insert into values_of_spec_type(spec_type_of_good_id, `value`)
values (2, 'Ryzen 5000'),
       (2, 'Caby lake'),
       (2, 'Ryzen 3000'),
       (2, 'Bubbleshift');

insert into values_of_spec_type(spec_type_of_good_id, `value`)
values (3, '2'),
       (3, '4'),
       (3, '8');

# select * from type_of_goods;

insert into goods (id, type_of_goods_id, `name`) value (null, 1, 'Домашний процессор');

insert into goods_description(goods_id, spec_type_of_good_id, values_of_spec_type_id) value (1, 1, 10);
insert into goods_description(goods_id, spec_type_of_good_id, values_of_spec_type_id) value (1, 2, 16);
insert into goods_description(goods_id, spec_type_of_good_id, values_of_spec_type_id) value (1, 3, 18);

insert into goods (id, type_of_goods_id, `name`) value (null, 1, 'Офисный процессор');

insert into goods_description(goods_id, spec_type_of_good_id, values_of_spec_type_id) value (2, 1, 11);
insert into goods_description(goods_id, spec_type_of_good_id, values_of_spec_type_id) value (2, 2, 14);
insert into goods_description(goods_id, spec_type_of_good_id, values_of_spec_type_id) value (2, 3, 19);

insert into goods (id, type_of_goods_id, `name`) value (null, 2, 'Видеокарта 1050ТИ');

insert into goods_description(goods_id, spec_type_of_good_id, values_of_spec_type_id) value (3, 4, 1);

insert into goods (id, type_of_goods_id, `name`) value (null, 2, 'Видеокарта 6600');

insert into goods_description(goods_id, spec_type_of_good_id, values_of_spec_type_id) value (4, 4, 2);

insert into goods (id, type_of_goods_id, `name`) value (null, 3, 'NineWave');

insert into goods_description(goods_id, spec_type_of_good_id, values_of_spec_type_id) value (5, 5, 4);
insert into goods_description(goods_id, spec_type_of_good_id, values_of_spec_type_id) value (5, 6, 7);

insert into goods (id, type_of_goods_id, `name`) value (null, 3, 'Block Gripper');

insert into goods_description(goods_id, spec_type_of_good_id, values_of_spec_type_id) value (6, 5, 6);
insert into goods_description(goods_id, spec_type_of_good_id, values_of_spec_type_id) value (6, 6, 9);

/*
# select tog.name,
#        tog.id,
#        stog.name,
#        stog.id,
#        vost.value,
#        vost.id
# from type_of_goods tog
# left join spec_type_of_goods stog on tog.id = stog.type_of_goods_id
# left join values_of_spec_type vost on stog.id = vost.spec_type_of_good_id
# order by tog.id;
*/
# Брак
insert into leftover_goods(warehouse_id, goods_id, received, shipped, data) value (3, 6, 1, 0, '2021-01-30 00:00:00');

# Офис
insert into leftover_goods(warehouse_id, goods_id, received, shipped, data)
values (2, 2, 5, 0, '2021-02-27 00:00:00'),
       (2, 2, 0, 2, '2021-02-28 00:00:00'),
       (2, 2, 0, 1, '2021-03-30 00:00:00');

# Основной склад
insert into leftover_goods(warehouse_id, goods_id, received, shipped, data)
values (1, 2, 7, 0, '2021-02-24 00:00:00'),
       (1, 2, 0, 6, '2021-04-28 00:00:00'),
       (1, 2, 2, 1, '2021-04-10 00:00:00'),
       (1, 2, 2, 0, '2021-04-20 00:00:00'),
       (1, 2, 0, 2, '2021-05-10 00:00:00'),
       (1, 2, 0, 1, '2021-05-30 00:00:00');

insert into leftover_goods(warehouse_id, goods_id, received, shipped, data)
values (1, 3, 10, 0, '2021-02-24 00:00:00'),
       (1, 3, 0, 6, '2021-04-16 00:00:00'),
       (1, 3, 2, 0, '2021-04-25 00:00:00'),
       (1, 3, 0, 5, '2021-06-20 00:00:00'),
       (1, 3, 0, 1, '2021-06-10 00:00:00'),
       (1, 3, 4, 0, '2021-07-30 00:00:00');

insert into leftover_goods(warehouse_id, goods_id, received, shipped, data)
values (1, 4, 1, 0, '2021-02-20 00:00:00'),
       (1, 4, 1, 0, '2021-04-27 00:00:00'),
       (1, 4, 2, 0, '2021-04-11 00:00:00'),
       (1, 4, 1, 0, '2021-04-21 00:00:00'),
       (1, 4, 0, 4, '2021-05-11 00:00:00'),
       (1, 4, 4, 0, '2021-06-03 00:00:00');

insert into leftover_goods(warehouse_id, goods_id, received, shipped, data)
values (1, 5, 10, 0, '2021-03-20 00:00:00'),
       (1, 5, 10, 0, '2021-04-29 00:00:00'),
       (1, 5, 2, 0, '2021-05-11 00:00:00'),
       (1, 5, 1, 0, '2021-06-21 00:00:00'),
       (1, 5, 0, 4, '2021-07-17 00:00:00'),
       (1, 5, 0, 19, '2021-08-23 00:00:00');

insert into leftover_goods(warehouse_id, goods_id, received, shipped, data)
values (1, 6, 10, 0, '2021-05-20 00:00:00'),
       (1, 6, 10, 0, '2021-06-29 00:00:00');

insert into orders(client_id, warehouse_id)
values (1, 1),
       (2, 1),
       (3, 2),
       (4, 3),
       (4, 1);

# truncate table order_rows;

# строки заказов
insert into order_rows (order_id, goods_id, quantity, price)
values (4, 6, 1, 50000),

       (3, 2, 1, 25360),

       (2, 1, 1, 35360),
       (2, 3, 1, 19620),
       (2, 3, 1, 18000),

       (1, 3, 1, 19500),
       (1, 4, 3, 125360),
       (1, 6, 10, 59840);


select id,
       (select name from warehouse where warehouse_id = warehouse.id),
       (select name from clients where client_id = clients.id),
       client_id
from orders;

update order_rows
set quantity = 2
where id = 7;

insert into orders_debt(order_id, debt)
select id                                                                                  as orders_id,
       case
           when (select sum(amount) from order_rows where orders.id = order_rows.order_id) is null then 0
           else (select sum(amount) from order_rows where orders.id = order_rows.order_id)  end as debt
from orders;

delete
from type_of_goods
where id between 0 and 2;