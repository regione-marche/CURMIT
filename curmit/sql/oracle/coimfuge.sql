/*==============================================================*/
/* table coimutgi :Modalita' funzionamento generatore           */
/*==============================================================*/

create table coimfuge
     ( cod_fuge       char(01) not null
     , descr_fuge     varchar2(50) not null
     , data_ins       date
     , data_mod       date
     , utente         varchar2(10)
     ) tablespace &ts_dat;

create unique index coimfuge_00
    on coimfuge
     ( cod_fuge
     ) tablespace &ts_idx;
