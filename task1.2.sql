use shop;

drop table if exists users_;

drop procedure if exists make_1_000_000_users;

create table users_ like users;

create procedure make_1_000_000_users()
begin

    declare i integer default 0;

    while i <= 1000000 do
        insert into users_(name) values ('name');
        set i = i + 1;
    end while;

end;
-- ооооооооооооооооооооооооооочень долго, вариант побыстрее в 1.2.2
call make_1_000_000_users();

