-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

select count(*)                                                            as cnt,
       (select gender from profile where `like`.user_id = profile.user_id) as gender
from `like`
group by gender
order by cnt desc
limit 1;