use shop;
-- честно нарыто) даже запомню ибо понадобится. Только данные можно в отдельную таблицу БД загнать, будет быстрее
CREATE PROCEDURE make_intervals(startdate timestamp, enddate timestamp, intval integer, unitval varchar(10))
BEGIN
    -- *************************************************************************
-- Procedure: make_intervals()
--    Author: Ron Savage
--      Date: 02/03/2009
--
-- Description:
-- This procedure creates a temporary table named time_intervals with the
-- interval_start and interval_end fields specifed from the startdate and
-- enddate arguments, at intervals of intval (unitval) size.
-- *************************************************************************
    declare thisDate timestamp;
    declare nextDate timestamp;
    set thisDate = startdate;

    -- *************************************************************************
    -- Drop / create the temp table
    -- *************************************************************************
    drop temporary table if exists time_intervals;
    create temporary table if not exists time_intervals
    (
        interval_start timestamp,
        interval_end   timestamp
    );

    -- *************************************************************************
    -- Loop through the startdate adding each intval interval until enddate
    -- *************************************************************************
    repeat
        select case unitval
                   when 'MICROSECOND' then timestampadd(MICROSECOND, intval, thisDate)
                   when 'SECOND' then timestampadd(SECOND, intval, thisDate)
                   when 'MINUTE' then timestampadd(MINUTE, intval, thisDate)
                   when 'HOUR' then timestampadd(HOUR, intval, thisDate)
                   when 'DAY' then timestampadd(DAY, intval, thisDate)
                   when 'WEEK' then timestampadd(WEEK, intval, thisDate)
                   when 'MONTH' then timestampadd(MONTH, intval, thisDate)
                   when 'QUARTER' then timestampadd(QUARTER, intval, thisDate)
                   when 'YEAR' then timestampadd(YEAR, intval, thisDate)
                   end
        into nextDate;

        insert into time_intervals select thisDate, timestampadd(MICROSECOND, -1, nextDate);
        set thisDate = nextDate;
    until thisDate >= enddate
        end repeat;

END;

call make_intervals('2021-08-01 00:00:00', '2021-08-31 02:00:00', 1, 'DAY');

select interval_start
from time_intervals;
-- Запрос
select t.interval_start,
       max(o.created_at is not null)
from time_intervals as t
         left join orders o on str_to_date(date_format(o.created_at, '%Y-%m-%d 00-00-00'), '%Y-%m-%d %H-%i-%S') = --  вот тут я не уверен
                               t.interval_start
group by t.interval_start
order by t.interval_start;

drop table time_intervals;
