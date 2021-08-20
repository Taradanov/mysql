use bank; -- схема из книжки Алана Бъюли

create view username_vw AS
select a.account_id as id,
        concat(e.fname, ', ', e.lname) as name
from account as a left join employee e on e.emp_id = a.open_emp_id;

create user 'user_read'@'%' IDENTIFIED BY '123456';

grant select on bank.username_vw TO 'user_read'@'%';