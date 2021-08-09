/*Пусть задан некоторый пользователь.
Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.*/

-- Под "общался" буду принимать сумму сообщений в обе стороны

-- Друзья пользователя с определенным id
set @userid = 27;

-- а результат этого запроса можно и во временную таблицу, но нет, времянки и join'ы для слабаков)
select distinct if(from_user_id = @userid, to_user_id, from_user_id) as friend_id
from friendship_request
where status = 1
  and case when from_user_id = @userid then TRUE when to_user_id = @userid then TRUE else FALSE end;

-- Запрос
select count(id) as cnt_id, if(from_user_id = @userid, to_user_id, from_user_id) as friend_id
from message
where (from_user_id = @userid or to_user_id = @userid)
group by if(from_user_id = @userid, to_user_id, from_user_id)
having friend_id in
       (select *
        from (select distinct if(from_user_id = @userid, to_user_id, from_user_id) as friend_id
              from friendship_request
              where status = 1
                and case when from_user_id = @userid then TRUE when to_user_id = @userid then TRUE else FALSE end) t)
order by cnt_id desc
limit 1;

