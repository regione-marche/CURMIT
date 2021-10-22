/*==============================================================*/
/* table coimcqua : quartiere                                   */
/*==============================================================*/

create table coimcqua
     ( cod_qua        varchar(08)  not null
     , cod_comune     varchar(08)  not null
     , descrizione    varchar(50)  not null
     );

create unique index coimcqua_00
    on coimcqua
     ( cod_comune
     , cod_qua
     ) ;
