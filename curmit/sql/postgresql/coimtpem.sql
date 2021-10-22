/*==============================================================*/
/* table coimtpem : tipologia di emissione                      */
/*==============================================================*/

create table coimtpem
     ( cod_emissione     varchar(08)   not null
     , descr_emissione   varchar(35)   not null
     , data_ins          date
     , data_mod          date
     , utente            varchar(10)
     , descr_e_emissione varchar(100)
     );

create unique index coimtpem_00
    on coimtpem
     ( cod_emissione
     );
