use magazin;

insert into clients(name, email)
values ('Пятерочка', '5@ru'),
       ('ТЦ Аура', 'mess@aura.ru'),
       ('DNS', 'manager@dns.ru'),
       ('F5', 'user@f5.ru');

insert into orders(client_id)
values (2)