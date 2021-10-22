/*==============================================================*/
/* table coimtplg                                               */
/*==============================================================*/

create table coimtplg
     ( id_tplg             integer       not null
     , cod_tplg            varchar(10)   not null
     , descrizione         varchar(100)     
     );

create unique index coimtplg_00
    on coimtplg
     ( id_tplg
     );

create unique index coimtplg_01
    on coimtplg
     ( cod_tplg
     );

