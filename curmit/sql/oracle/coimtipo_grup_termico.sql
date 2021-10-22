/*==============================================================*/
/* table coimtipo_grup_termico: Tipo gruppo termico             */
/*==============================================================*/

create table coimtipo_grup_termico
     ( cod_grup_term   varchar2(08) not null
     , desc_grup_term  varchar2(100)
     , order_grup_term number(08)
     , data_ins        date
     , utente_ins      varchar2(10)
     , data_mod        date
     , utente_mod      varchar2(10)
     ) tablespace &ts_dat;

create unique index coimtipo_grup_termico_00
    on coimtipo_grup_termico
     ( cod_grup_term
     ) tablespace &ts_idx;
