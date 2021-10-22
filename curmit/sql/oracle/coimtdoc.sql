/*==============================================================*/
/* table coimtdoc : tipo documento AV avviso .........          */
/*==============================================================*/

create table coimtdoc
     ( tipo_documento varchar2(02)         not null 
     , descrizione    varchar2(100)        not null
     , flag_modifica  char(01) default 'T' not null
     ) tablespace &ts_dat;

create unique index coimtdoc_00
    on coimtdoc
     ( tipo_documento
     ) tablespace &ts_idx;