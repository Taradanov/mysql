use magazin;

# въю остатки товара на складах
create or replace view leftovers_view as
select t.goods_id,
       t3.name,
       t2.characteristic,
       (select name from warehouse where warehouse_id = warehouse.id) as warehouse,
       t.received - t.shipped                                         as leftower


from (select sum(received) as received, sum(shipped) as shipped, warehouse_id, goods_id
      from leftover_goods
      group by warehouse_id, goods_id) as t
         left join (select goods_id, group_concat(t.name_, ' ', t.value_) as characteristic
                    from (select goods_id,
                                 (select name
                                  from spec_type_of_goods
                                  where spec_type_of_good_id = spec_type_of_goods.id)    as name_,
                                 (select value
                                  from values_of_spec_type
                                  where values_of_spec_type_id = values_of_spec_type.id) as value_
                          from goods_description) as t
                    group by goods_id) as t2
                   on t.goods_id = t2.goods_id
         left join goods as t3 on t.goods_id = t3.id
where t.received - t.shipped <> 0;

select * from leftovers_view;

#  въю список заказов
create or replace view orders_condition as
select t1.id,
       (select name from clients where client_id = clients.id)        as client,
       (select name from warehouse where warehouse_id = warehouse.id) as warehouse,
       t2.distinct_goods,
       (select sum(amount) from order_rows where order_rows.order_id = t1.id) as amount
from orders as t1
         join (select order_id, count(distinct goods_id) as distinct_goods from order_rows group by order_id) as t2
              on id = t2.order_id;

select *
from orders_condition;

create trigger create_order
    after insert
    on orders
    for each row
begin
    select cast((select name from clients where clients.id = NEW.client_id) as char) into @str;
    select cast((select sum(amount) from order_rows where order_rows.order_id = NEW.id) as char) into @amount;
    insert into logs (order_id, condition_before, condition_after,operation)
        VALUE (NEW.id,
               concat(' ', 'заказ id: ', cast(NEW.id as char ), ' клиент_id: ', cast(NEW.client_id as char), ' клиент: ',
                      @str, ' сумма: ', @amount),
               '',
              'new_order');
end;


create function get_name(name_ varchar(20), id_ int unsigned)
    returns varchar(255)
    deterministic
begin
    set @str = '';
    if name_ = 'clients' then
        select cast((select name from clients where clients.id = id_) as char ) into @str;
    elseif name_ = 'warehouse' then
        select cast((select name from warehouse where warehouse.id = id_) as char ) into @str;
    elseif name_ = 'goods' then
        select cast((select name from goods where goods.id = id_) as char ) into @str;
    end if;
    return @str;
end;

drop procedure if exists log_insert_or_delete_order_row;

create procedure log_insert_or_delete_order_row(
                        IN order_id_ int unsigned,
                        IN order_rows_id_ int unsigned,
                        IN goods_id_ int unsigned,
                        IN quantity_ int unsigned,
                        IN price_ int unsigned,
                        IN amount_ int unsigned,
                        IN operation_ varchar(20))
begin
    set @condition_after =  concat(
        'заказ id: ', cast(order_id_ as char ),
        ' строка заказа: ', cast(order_rows_id_ as char ),
        ' товар: ', get_name('goods', goods_id_),
        ' количество: ', cast(quantity_ as char ),
        ' цена: ', cast(price_ as char ),
        ' сумма: ', cast(amount_ as char )
        );
    insert into logs(order_id, order_rows_id, condition_after, operation)
    value (order_id_,order_rows_id_, @condition_after, operation_ );
end;


create procedure log_update_order_row(
                        IN order_id_ int unsigned,
                        IN order_rows_id_ int unsigned,
                        IN goods_id_ int unsigned,
                        IN quantity_ int unsigned,
                        IN price_ int unsigned,
                        IN amount_ int unsigned,

                        IN goods_id_old int unsigned,
                        IN quantity_old int unsigned,
                        IN price_old int unsigned,
                        IN amount_old int unsigned,

                        IN operation_ varchar(20))
begin

        set @condition_before =  concat(
        'заказ id: ', cast(order_id_ as char ),
        ' строка заказа: ', cast(order_rows_id_ as char ),
        ' товар: ', get_name('goods', goods_id_old),
        ' количество: ', cast(quantity_old as char ),
        ' цена: ', cast(price_old as char ),
        ' сумма: ', cast(amount_old as char )
        );

    set @condition_after =  concat(
        'заказ id: ', cast(order_id_ as char ),
        ' строка заказа: ', cast(order_rows_id_ as char ),
        ' товар: ', get_name('goods', goods_id_),
        ' количество: ', cast(quantity_ as char ),
        ' цена: ', cast(price_ as char ),
        ' сумма: ', cast(amount_ as char )
        );
    insert into logs(order_id, order_rows_id, condition_before, condition_after, operation)
    value (order_id_,order_rows_id_, @condition_before, @condition_after, operation_ );
end;


drop trigger if exists create_row_on_order_rows;

create trigger create_row_on_order_rows
    after insert
    on order_rows
    for each row
begin
    call log_insert_or_delete_order_row(
        NEW.order_id,
        NEW.id,
        NEW.goods_id,
        NEW.quantity,
        NEW.price,
        NEW.amount,
        'insert_row'

        );
end;

create trigger del_row_on_order_rows
    after delete
    on order_rows
    for each row
begin
    call log_insert_or_delete_order_row(
        OLD.order_id,
        OLD.id,
        OLD.goods_id,
        OLD.quantity,
        OLD.price,
        OLD.amount,
        'delete_row'
        );
end;

create trigger update_row_on_order_rows
    after update
    on order_rows
    for each row
begin
    call log_update_order_row(
        NEW.order_id,
        NEW.id,
        NEW.goods_id,
        NEW.quantity,
        NEW.price,
        NEW.amount,

        OLD.goods_id,
        OLD.quantity,
        OLD.price,
        OLD.amount,

        'update_row'
        );
end;

