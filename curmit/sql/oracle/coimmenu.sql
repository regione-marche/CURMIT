/*==============================================================*/
/* table coimmenu: menu                                         */
/*==============================================================*/

create table coimmenu
     ( nome_menu     varchar2(20)  not null
     , livello       varchar2(02)  not null 
     , scelta_1      varchar2(02)  not null
     , scelta_2      varchar2(02)  not null
     , scelta_3      varchar2(02)  not null
     , scelta_4      varchar2(02)  not null
     , lvl           number(02)
     , seq           number(02)
     ) tablespace &ts_dat;

create unique index coimmenu_00
    on coimmenu
     ( nome_menu
     , livello
     , scelta_1
     , scelta_2
     , scelta_3
     , scelta_4
     ) tablespace &ts_idx;
