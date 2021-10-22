/*==============================================================*/
/* table coimtpim : tipologia impianti                          */
/*==============================================================*/

create table coimtpim
     ( cod_tpim        varchar2(08)   not null
     , descr_tpim      varchar2(35)   not null
     , data_ins        date
     , data_mod        date
     , utente          varchar2(10)
     ) tablespace &ts_dat;

create unique index coimtpim_00
    on coimtpim
     ( cod_tpim     
     ) tablespace &ts_idx;
