use shop;

select avg(year(now()) - year(birthday_at))
from users;