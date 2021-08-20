use sakila;

drop function if exists hello;

create FUNCTION hello() RETURNS varchar(30) no sql
begin

    declare now DATETIME DEFAULT current_time();
    declare message varchar(30) default '';

    IF hour(now) < 6 THEN
        set message = 'Доброй ночи';
    ELSEIf hour(now) < 12 THEN
        set message =  'Доброе утро';
    ELSEIf hour(now) < 18 THEN
        set message =  'Добрый день';
    ELSE
        set message =  'Добрый вечер';
    END IF;

    return message;
end;


select hello();

-- select hour(current_time());

