create temporary table tt(
    id int(1) unsigned not null auto_increment,
    primary key (id)
);

insert into tt (id)
values (null);

select round(exp(sum(log(id))),0)
from tt;