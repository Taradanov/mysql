drop trigger if exists products_before_insert;

create trigger products_before_insert before INSERT on products for each row
begin
    if NEW.name is null and NEW.description is null then
        signal sqlstate '45000'
        set MESSAGE_TEXT = 'Empty field name or description';
    end if;
end;

insert into  products(price) values (100);
insert into  products(name, description, price) values ('foo', 'bar', 100);

drop trigger products_before_update;
create trigger products_before_update
    before UPDATE
    on products
    for each row
begin
    if NEW.name is null and NEW.description is null then
        signal sqlstate '45000'
        set MESSAGE_TEXT = 'Empty field name or description';
    end if;
end;

update products set name = null, description = null where id = 9;