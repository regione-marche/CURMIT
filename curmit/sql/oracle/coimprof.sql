/*==============================================================*/
/* table coimprof: tebella profili                              */
/*==============================================================*/

create table coimprof
     ( nome_menu      varchar2(20)  not null
     , settore        varchar2(20)  not null
     , ruolo          varchar2(20)  not null
     ) tablespace &ts_dat;

create unique index coimprof_00
    on coimprof
     ( settore
     , ruolo 
     ) tablespace &ts_idx;
