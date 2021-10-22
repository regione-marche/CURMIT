/*==============================================================*/
/* table coimutgi :Modalita' funzionamento generatore           */
/*==============================================================*/

create table coimfuge
     ( cod_fuge       char(01) not null
     , descr_fuge     varchar(50) not null
     , data_ins       date
     , data_mod       date
     , utente         varchar(10)
     );

create unique index coimfuge_00
    on coimfuge
     ( cod_fuge
     );
