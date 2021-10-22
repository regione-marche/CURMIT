begin;

create table mis_script_menu (
      script_id      integer primary key
      -- full script name
     ,script_name    varchar(200)
      -- name of menù
     ,menu_type      varchar(10)
      -- name of the heading tab
     ,package        varchar(50)
      -- tab sequence
     ,package_seq    integer
      -- name of the part within the tab
     ,submenu        varchar(50)
     ,submenu_seq    integer
      -- sequence of the script
     ,seq            integer
      -- parameters to pass to the script
     ,par            varchar(200)
      -- title the users see
     ,title          varchar(100)
      -- arrow in the yui menù
     ,is_arrow_p     boolean
      -- authorized only if the user is an admin
     ,is_admin_p     boolean
);

end;
