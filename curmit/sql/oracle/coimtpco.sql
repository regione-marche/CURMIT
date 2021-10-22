/*==============================================================*/
/* table coimtpco: tabella anagrafica tipi condizionatore       */
/*==============================================================*/

create table coimtpco
     ( cod_tpco    varchar2(08)  not null
     , descr_tpco  varchar2(35)  not null
     , data_ins    date
     , data_mod    date
     , utente      varchar2(10)
     ) tablespace &ts_dat;
             
create unique index coimtpco_00
    on coimtpco
     ( cod_tpco
     ) tablespace &ts_idx;
