/*==============================================================*/
/* table coimgage: Agenda manutentori                           */
/*==============================================================*/
create table coimgage
     ( cod_opma            varchar(08)  not null
     , cod_impianto        varchar(08)  not null
    -- stato 1= inserito 2= Eseguito
     , stato               char(01)
     , data_prevista       date
     , data_esecuzione     date
     , note                varchar(4000)
     , data_ins            date
     , data_mod            date
     , utente              varchar(10)
     );

create unique index coimgage_00
    on coimgage
     ( cod_opma
     , cod_impianto
     , data_ins
     ) ;
