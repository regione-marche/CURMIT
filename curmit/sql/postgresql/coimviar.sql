/*==============================================================*/
/* table coimviar : vie/comune - area territoriale              */
/*==============================================================*/

create table coimviar
     ( cod_area          varchar(08)    not null
     , cod_comune        varchar(08)    not null
     , cod_via           varchar(08)    not null
     , civico_iniz       varchar(08)    not null
     , civico_fine       varchar(08)    not null
     , data_ins          date
     , data_mod          date
     , utente            varchar(10)
     );

create unique index coimviar_00
    on coimviar
     ( cod_area
     , cod_comune
     , cod_via
     );
