drop schema if exists magazin;

create schema if not exists magazin;

use magazin;

# 3.4 Клиенты
create table if not exists clients
(
    id    int unsigned auto_increment,
    name  varchar(255) not null,
    email varchar(100) not null,
    constraint clients_pk
        primary key (id)
) comment 'Клиенты';

create unique index clients_email_uindex
    on clients (email);

# 2.1 Склады
create table warehouse
(
    id   int unsigned auto_increment,
    name varchar(100) not null,
    constraint warehouse_pk
        primary key (id)
)
comment 'Склады';
# 3.1 Заказы
create table orders
(
    id           int unsigned auto_increment,
    client_id    int unsigned not null,
    warehouse_id int unsigned not null,
    primary key (id),
    constraint orders_clients_id_fk
        foreign key (client_id) references clients (id),
    constraint orders_warehouse_id_fk
        foreign key (warehouse_id) references warehouse (id)
) comment 'Заказы';


create table magazin.orders_debt
(
    id       int unsigned auto_increment,
    order_id int unsigned not null,
    debt     int          not null,
    constraint orders_debt_pk
        primary key (id),
    constraint orders_debt_orders_id_fk
        foreign key (order_id) references magazin.orders (id)
)
    comment 'Задолженность по заказам';

create table type_of_goods
(
    id   int unsigned auto_increment,
    name varchar(50) not null,
    constraint type_of_goods_pk
        primary key (id)
) comment 'Виды номенклатуры';

create unique index type_of_goods_name_uindex
    on type_of_goods (name);

create table spec_type_of_goods
(
    id               int unsigned auto_increment,
    name             varchar(100) not null,
    type_of_goods_id int unsigned not null,
    primary key (id),
    constraint spec_type_of_goods_type_of_goods_id_fk
        foreign key (type_of_goods_id) references type_of_goods (id)
)
    comment 'Состав вида номенклатуры';

create unique index spec_type_of_goods_name_type_of_goods_id_uindex
    on spec_type_of_goods (name, type_of_goods_id);

create table goods
(
    id               int unsigned auto_increment,
    type_of_goods_id int unsigned not null,
    name             varchar(150) not null,
    constraint goods_pk
        primary key (id),
    constraint goods_type_of_goods_id_fk
        foreign key (type_of_goods_id) references type_of_goods (id)
)
    comment 'Товары';

create unique index goods_name_uindex
    on goods (name);

create unique index warehouse_name_uindex
    on warehouse (name);

create table leftover_goods
(
    warehouse_id int unsigned                 not null,
    goods_id     int unsigned                 not null,
    received     decimal(14, 3) default 0     null,
    shipped      decimal(14, 3) default 0     null,
    data         datetime       default now() not null,
    constraint leftover_goods_goods_id_fk
        foreign key (goods_id) references goods (id),
    constraint leftover_goods_warehouse_id_fk
        foreign key (warehouse_id) references warehouse (id)
)
    comment 'Движения товаров';

create table values_of_spec_type
(
    id                   int unsigned auto_increment,
    spec_type_of_good_id int unsigned not null,
    `value`              varchar(100) not null,
    constraint values_of_pk
        primary key (id),
    constraint values_of_spec_type_of_goods_id_fk
        foreign key (spec_type_of_good_id) references spec_type_of_goods (id)
) comment 'Значения характеристики вида номенклатуры';

create unique index values_of_spec_type_of_good_id_value_uindex
    on values_of_spec_type (spec_type_of_good_id, `value`);

create table goods_description
(
    id                     int unsigned auto_increment,
    goods_id               int unsigned not null,
    spec_type_of_good_id   int unsigned not null,
    values_of_spec_type_id int unsigned not null,
    constraint goods_description_pk
        primary key (id)
) comment 'Возможные значения';

create unique index goods_spec_values_uindex
    on goods_description (goods_id, spec_type_of_good_id, values_of_spec_type_id);

alter table goods_description
    add constraint goods_description_goods_id_fk
        foreign key (goods_id) references goods (id);

alter table goods_description
    add constraint goods_description_spec_type_of_goods_id_fk
        foreign key (spec_type_of_good_id) references spec_type_of_goods (id);

alter table goods_description
    add constraint goods_description_values_of_spec_type_id_fk
        foreign key (values_of_spec_type_id) references values_of_spec_type (id);

# 3.2 Строки заказа
create table order_rows
(
	id int unsigned auto_increment,
	order_id int unsigned not null,
	goods_id int unsigned null,
	quantity int unsigned default 0 not null,
	price int unsigned default 0 not null,
	amount  int unsigned  as (price * quantity),
		constraint order_rows_pk
		primary key (id),
	constraint order_rows_goods_id_fk
		foreign key (goods_id) references goods (id),
	constraint order_rows_orders_id_fk
		foreign key (order_id) references orders (id)
			on delete cascade
)
comment 'Строки заказов';



# 4.1 Логирование
create table logs
(
	id int unsigned auto_increment,
	order_id int unsigned null,
	order_rows_id int unsigned null,
	condition_before varchar(1000) null,
	condition_after varchar(1000) null,
	operation varchar(20) not null,
	constraint logs_pk
		primary key (id)

)
comment 'История изменения заказов, логирование';

create index logs_order_id_index
	on logs (order_id);

create index logs_order_rows_id_index
	on logs (order_rows_id);














