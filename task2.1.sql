use shop;

create user 'shop_read'@'%' IDENTIFIED BY '123456';

grant select on shop.* TO 'shop_read'@'%';

create user 'shop'@'%' IDENTIFIED BY '123456';

grant all privileges on shop.* TO 'shop'@'%';

select * from mysql.user;

delete from mysql.user where User = 'shop_read_';

delete from mysql.user where User = 'shop_';