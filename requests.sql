use magazin;

# Список заказов
select *
from orders_condition;

# Список остатки товаров на складах
select *
from leftovers_view;

# Задолженность по заказам
select order_id                                         as Номер_документа,
       get_name('slients', o.client_id)      as Клиент,
       get_name('warehouse', o.warehouse_id) as Склад,
       debt                                             as Задолженность
from orders_debt
         left join orders o on o.id = orders_debt.order_id;