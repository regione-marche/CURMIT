/*==============================================================*/
/* table coimesit: Gestione esiti esecuzione lavori             */
/*==============================================================*/
create table coimesit
     ( cod_batc           integer not null
     , ctr                smallint not null
     , nom                varchar(30)
     , url                varchar(100)
     , pat                varchar(200)
     );

create unique index coimesit_00
    on coimesit
     ( cod_batc
     , ctr
     );
