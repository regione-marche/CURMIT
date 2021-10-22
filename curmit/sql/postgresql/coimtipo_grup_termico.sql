/*==============================================================*/
/* table coimtipo_grup_termico: Tipo gruppo termico             */
/*==============================================================*/

create table coimtipo_grup_termico
     ( cod_grup_term   varchar(08) not null
     , desc_grup_term  varchar(100)
     , order_grup_term integer
     , data_ins        date
     , utente_ins      varchar(10)
     , data_mod        date
     , utente_mod      varchar(10)
     );

create unique index coimtipo_grup_termico_00
    on coimtipo_grup_termico
     ( cod_grup_term
     );
