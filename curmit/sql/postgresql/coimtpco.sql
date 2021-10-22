/*==============================================================*/
/* table coimtpco: tabella anagrafica tipi condizionatore       */
/*==============================================================*/

create table coimtpco
     ( cod_tpco    varchar(08)  not null
     , descr_tpco  varchar(35)  not null
     , data_ins    date
     , data_mod    date
     , utente      varchar(10)
     );
             
create unique index coimtpco_00
    on coimtpco
     ( cod_tpco
     );
