-- Преобразовал кусок кода С++, код взял здесь:
-- https://ru.wikibooks.org/wiki/%D0%92%D1%8B%D1%87%D0%B8%D1%81%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5_%D1%87%D0%B8%D1%81%D0%B5%D0%BB_%D0%A4%D0%B8%D0%B1%D0%BE%D0%BD%D0%B0%D1%87%D1%87%D0%B8

use vk;

drop function if exists fibonacci;

create function fibonacci(arg1 int ) returns BIGINT unsigned no sql
begin
    declare fib int unsigned default 1;
    declare prev_ int unsigned default 0;

    while arg1 > 1 do
        set fib = fib + prev_;
        set prev_ = fib-prev_;
        set arg1 = arg1 - 1;
    end while;
    return fib;
end;

select fibonacci(10);
select fibonacci(9);