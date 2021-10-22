/*==============================================================*/
/* table coimboll: enti responsabili                            */
/*==============================================================*/

create table coimenre
     ( cod_enre        varchar(08)
     , denominazione   varchar(40)
     , indirizzo       varchar(40)
     , numero          varchar(08)
     , cap             varchar(05)
     , localita        varchar(40)
     , comune          varchar(40)
     , provincia       varchar(04)
     , denominazione2  varchar(40)
     , tipo_soggetto   char(01)
     );

create unique index coimenre_00
    on coimenre
     ( cod_enre
     );


