use shop;

alter table users add column month varchar(15);

select * from users;

update users set users.month = 'january' where id = 1;
update users set users.month = 'march' where id = 2;
update users set users.month = 'april' where id = 3;
update users set users.month = 'june' where id = 4;
update users set users.month = 'july' where id = 5;
update users set users.month = 'august' where id = 6;

select *
from users where month in ('may', 'august');

alter table users drop month;