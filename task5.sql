-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

-- Под активностью буду принимать лайки, посты и запросы в друзья

-- Лайки
select count(*), user_id from `like` group by user_id;

-- Посты
select count(*), user_id from post group by user_id;

-- Запросы в друзья
select count(*), from_user_id from friendship_request group by from_user_id;

-- Запрос
select
    concat_ws(', ',lastname, firstname ),
    (select count(*) from `like` where profile.user_id = `like`.user_id) as likes,
    (select count(*) from post where profile.user_id = post.user_id) * 2 as posts,
    (select count(*) from friendship_request where profile.user_id = friendship_request.from_user_id) * 3 as fr_rqs
from profile

order by likes+posts+fr_rqs
limit 10;