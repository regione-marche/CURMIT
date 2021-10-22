/*==============================================================*/
/* table coimtpim : tipologia impianti                          */
/*==============================================================*/

create table coimtpim
     ( cod_tpim        varchar(08)   not null
     , descr_tpim      varchar(35)   not null
     , data_ins        date
     , data_mod        date
     , utente          varchar(10)
     );

create unique index coimtpim_00
    on coimtpim
     ( cod_tpim     
     );
