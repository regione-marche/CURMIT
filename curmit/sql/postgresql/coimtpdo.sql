/*==============================================================*/
/* table coimtpdo: tipologia to do                              */
/*==============================================================*/

create table coimtpdo
     ( cod_tpdo       varchar(08)          not null
     , descrizione    varchar(50)          not null
     , flag_modifica  char(01) default 'T' not null
     );

create unique index coimtpdo_00
    on coimtpdo
     ( cod_tpdo
     );