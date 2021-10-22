/*==============================================================*/
/* table coimgage: Agenda manutentori                           */
/*==============================================================*/
create table coimgage
     ( cod_opma            varchar2(08)  not null
     , cod_impianto        varchar2(08)  not null
    -- stato 1= inserito; 2= Eseguito
     , stato               char(01)
     , data_prevista       date
     , data_esecuzione     date
     , note                varchar2(4000)
     , data_ins            date
     , data_mod            date
     , utente              varchar2(10)
     ) tablespace &ts_dat;

create unique index coimgage_00
    on coimgage
     ( cod_opma
     , cod_impianto
     , data_ins
     ) tablespace &ts_idx;
