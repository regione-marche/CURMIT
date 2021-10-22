/*==============================================================*/
/* table coimtpdu : Destinazione d'uso                          */
/*==============================================================*/

create table coimtpdu
     ( cod_tpdu       varchar2(08) not null
     , descr_tpdu     varchar2(50) not null
     , data_ins       date
     , data_mod       date
     , utente         varchar2(10)
     ) tablespace &ts_dat;

create unique index coimtpdu_00
    on coimtpdu
     ( cod_tpdu
     ) tablespace &ts_idx;
