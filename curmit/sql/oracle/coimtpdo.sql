/*==============================================================*/
/* table coimtpdo: tipologia to do                              */
/*==============================================================*/

create table coimtpdo
     ( cod_tpdo       varchar2(08)         not null
     , descrizione    varchar2(50)         not null
     , flag_modifica  char(01) default 'T' not null
     ) tablespace &ts_dat;

create unique index coimtpdo_00
    on coimtpdo
     ( cod_tpdo
     ) tablespace &ts_idx; 
