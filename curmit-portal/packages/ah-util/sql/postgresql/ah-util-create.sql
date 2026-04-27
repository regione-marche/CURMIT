begin;

-- Creation script
\i scripts.sql
\i menu.sql

-- define custom privileges
select acs_privilege__create_privilege('exec',null,null);
select acs_privilege__add_child('admin','exec');
select acs_privilege__add_child('exec','read');

\i ah-functions.sql

create table mis_monitoring (
      ipaddr         varchar(20)
     ,logdate        timestamp
     ,url            varchar(100)
     ,query_args     varchar(500)
     ,user_id        integer 
);

create index mis_monitoring_indx_logdate on mis_monitoring(logdate);
create index mis_monitoring_indx_url     on mis_monitoring(url);
create index mis_monitoring_indx_user_id on mis_monitoring(user_id);

end;

