/*==============================================================*/
/* table coimesit: Gestione esiti esecuzione lavori             */
/*==============================================================*/
create table coimesit
     ( cod_batc           number(08) not null
     , ctr                number(04) not null
     , nom                varchar2(30)
     , url                varchar2(100)
     , pat                varchar2(200)
     ) tablespace &ts_dat;

create unique index coimesit_00
    on coimesit
     ( cod_batc
     , ctr
     ) tablespace &ts_idx;
