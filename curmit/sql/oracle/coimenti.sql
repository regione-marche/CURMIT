/*==============================================================*/
/* table coimenti: enti responsabili(dettaglio)                  */
/*==============================================================*/

create table coimenti
     ( cod_enre        varchar(08)
     , cod_ente        varchar(08)
     , denominazione   varchar(40)
     , indirizzo       varchar(40)
     , numero          varchar(08)
     , cap             varchar(05)
     , localita        varchar(40)
     , comune          varchar(40)
     , provincia       varchar(04)
     , cod_area        varchar(08)
     )  tablespace &ts_dat;

create unique index coimenti_00
    on coimenti
     ( cod_enre
     , cod_ente
     )  tablespace &ts_idx;


