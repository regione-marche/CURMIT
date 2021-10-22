/*==============================================================*/
/* table coimtppr : tipologia provenienza dati impianto         */
/*==============================================================*/

create table coimtppr
     ( cod_tppr        char(01)       not null
     , descr_tppr      varchar2(35)   not null
     , data_ins        date
     , data_mod        date
     , utente          varchar2(10)
     ) tablespace &ts_dat;

create unique index coimtppr_00
    on coimtppr
     ( cod_tppr     
     ) tablespace &ts_idx;
