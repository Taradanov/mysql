use shop;

select dayofweek(date_add(birthday_at, interval year(now()) - year(birthday_at) YEAR)) as day_of_week,
       count(birthday_at)                                                              as count_of_users
from users
group by day_of_week;