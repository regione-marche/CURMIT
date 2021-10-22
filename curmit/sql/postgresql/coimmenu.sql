/*==============================================================*/
/* table coimmenu: menu                                         */
/*==============================================================*/

create table coimmenu
     ( nome_menu     varchar(20)  not null
     , livello       varchar(02)  not null 
     , scelta_1      varchar(02)  not null
     , scelta_2      varchar(02)  not null
     , scelta_3      varchar(02)  not null
     , scelta_4      varchar(02)  not null
     , lvl           numeric(02)
     , seq           numeric(02)
     ) ;

create unique index coimmenu_00
    on coimmenu
     ( nome_menu
     , livello
     , scelta_1
     , scelta_2
     , scelta_3
     , scelta_4
     ) ;


