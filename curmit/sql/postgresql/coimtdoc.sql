/*==============================================================*/
/* table coimtdoc : tipo documento AV avviso .........          */
/*==============================================================*/

create table coimtdoc
     ( tipo_documento varchar(02)          not null 
     , descrizione    varchar(100)         not null
     , flag_modifica  char(01) default 'T' not null
     );

create unique index coimtdoc_00
    on coimtdoc
     ( tipo_documento
     );