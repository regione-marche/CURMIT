/*==============================================================*/
/* table coimtpdu : Destinazione d'uso                          */
/*==============================================================*/

create table coimtpdu
     ( cod_tpdu       varchar(08) not null
     , descr_tpdu     varchar(50) not null
     , data_ins       date
     , data_mod       date
     , utente         varchar(10)
     );

create unique index coimtpdu_00
    on coimtpdu
     ( cod_tpdu
     );
