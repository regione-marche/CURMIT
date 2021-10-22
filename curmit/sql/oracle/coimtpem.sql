/*==============================================================*/
/* table coimtpem : tipologia di emissione                      */
/*==============================================================*/

create table coimtpem
     ( cod_emissione   varchar2(08)   not null
     , descr_emissione varchar2(35)   not null
     , data_ins        date
     , data_mod        date
     , utente          varchar2(10)
     ) tablespace &ts_dat;

create unique index coimtpem_00
    on coimtpem
     ( cod_emissione
     ) tablespace &ts_idx;
