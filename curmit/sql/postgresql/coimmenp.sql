/*==============================================================*/
/* table coimmenu: menu - fittizio                              */
/*==============================================================*/

create table coimmenp
     ( nome_menu     varchar(20)  not null
     , descrizione   varchar(60)  
     );

create unique index coimmenp_00
    on coimmenp
     ( nome_menu
     );
