-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

-- 10 самых молодых
select user_id, firstname, lastname, gender, birthday
from profile
order by birthday desc
limit 10;

--  Лайки по пользователям
select user_id, sum(if(`like`.post_id is null , 0, 1) +if(`like`.media_id is null , 0, 1) + if(`like`.message_id is null , 0, 1))
from `like`
WHERE user_id in (select * from(select user_id from profile order by birthday desc limit 10) t)
GROUP BY user_id;

-- Запрос
select  sum(if(`like`.post_id is null , 0, 1) +if(`like`.media_id is null , 0, 1) + if(`like`.message_id is null , 0, 1))
from `like`
WHERE user_id in (select * from(select user_id from profile order by birthday desc limit 10) t);