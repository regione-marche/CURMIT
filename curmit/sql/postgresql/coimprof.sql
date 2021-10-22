/*==============================================================*/
/* table coimprof: tebella profili                              */
/*==============================================================*/

create table coimprof
     ( nome_menu      varchar(20)  not null
     , settore        varchar(20)  not null
     , ruolo          varchar(20)  not null
     );

create unique index coimprof_00
    on coimprof
     ( settore
     , ruolo 
     );
