/*==============================================================*/
/* table coimtppr : tipologia provenienza dati impianto         */
/*==============================================================*/

create table coimtppr
     ( cod_tppr        char(01)      not null
     , descr_tppr      varchar(35)   not null
     , data_ins        date
     , data_mod        date
     , utente          varchar(10)
     );

create unique index coimtppr_00
    on coimtppr
     ( cod_tppr     
     );
