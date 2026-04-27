begin;

CREATE TABLE mis_holidays (
   id serial,
   description varchar(50) not null,
   holiday     date        not null
);

insert into mis_holidays (description, holiday) values ('Natale', '2011-12-25');
insert into mis_holidays (description, holiday) values ('Capodanno', '2012-01-01');
insert into mis_holidays (description, holiday) values ('I° Maggio', '2012-05-01');

CREATE OR REPLACE FUNCTION ah_add_business_days(date, integer)
  RETURNS date AS '
declare
   p_date  alias for $1;
   p_days  alias for $2;

   result  date;
begin

select o1.date 
into result
from (
	select i, 
               date, 
               dow 
        from (
	      select i, 
                     date,    
                     extract(''dow'' from date) as dow
	      from (
	           select i,
	           p_date + (i * case when p_days < 0 then -1 else 1 end) as date
	           from generate_series(0,(abs(p_days) + 5)*2) i
                   ) o3
             ) o2 left join mis_holidays h on date = h.holiday
	where h.holiday is null
	  and dow between 1 and 5
	order by i
     ) o1
where case 
        when p_days > 0 then o1.date >= p_date 
        when p_days < 0 then o1.date <= p_date 
        else                 o1.date  = p_date 
      end
limit 1
offset abs(p_days);

return result;

end;'
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION ah_count_business_days(date, date)
  RETURNS integer AS '
declare
   p_from_date  alias for $1;
   p_to_date    alias for $2;

   result  integer;
begin

select greatest(0, count(*) - 1) 
into result
from (
	select date, dow 
        from (
	       select i, 
                      p_from_date + i as date,
                      extract (''dow''  from p_from_date + i) as dow
	       from generate_series(0, p_to_date - p_from_date) i
             ) dt left join mis_holidays h on dt.date = h.holiday
	where h.holiday is null
	  and dow between 1 and 5
	order by date
     ) bd
where date between p_from_date and p_to_date;

return result;

end;'
LANGUAGE 'plpgsql';

end;
