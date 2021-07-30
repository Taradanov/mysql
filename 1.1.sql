use shop;

update users
set created_at = now(),
    updated_at= now();