/*==============================================================*/
/* table coimmenu: menu - fittizio                              */
/*==============================================================*/

create table coimmenp
     ( nome_menu     varchar2(20)  not null
     , descrizione   varchar2(60)  
     ) tablespace &ts_dat;

create unique index coimmenp_00
    on coimmenp
     ( nome_menu
     ) tablespace &ts_idx;
