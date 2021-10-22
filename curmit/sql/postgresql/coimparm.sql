/*==============================================================*/
/* table coimparm : parametri                                   */
/*==============================================================*/

create table coimparm
     ( gruppo           varchar(35) not null
     , chiave           varchar(35) not null
     , descrizione      varchar(4000) not null
     , tab_prov         varchar(10)
     );

create unique index coimparm_00
    on coimparm
     ( gruppo
     , chiave
     );
