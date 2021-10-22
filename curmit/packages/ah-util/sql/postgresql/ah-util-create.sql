-- Creation script
\i scripts.sql

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

create table mis_script_menu (
      script_id      integer primary key
     ,package        varchar(50)
     ,submenu        varchar(50)
      -- full script name                                                                                                                                              
     ,script_name    varchar(200)
     ,title          varchar(100)
     ,package_seq    integer
     ,submenu_seq    integer
     ,seq            integer
      -- optional condition (tcl code to evaluate)                                                                                                                     
     , condition     text
      -- parameters to pass to the script                                                                                                                              
     ,par            varchar(200)
      -- arrow in the yui menù                                                                                                                                         
     ,is_arrow_p     boolean
      -- authorized only if the user is an admin                                                                                                                       
     ,is_admin_p     boolean
);

