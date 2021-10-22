/*==============================================================*/
/* table coimboll: enti responsabili                            */
/*==============================================================*/

create table coimenre
     ( cod_enre        varchar2(08)
     , denominazione   varchar2(40)
     , indirizzo       varchar2(40)
     , numero          varchar2(08)
     , cap             varchar2(05)
     , localita        varchar2(40)
     , comune          varchar2(40)
     , provincia       varchar2(04)
     , denominazione2  varchar2(40)
     , tipo_soggetto   char(01)
     ) tablespace &ts_dat;

create unique index coimenre_00
    on coimenre
     ( cod_enre
     ) tablespace &ts_idx;


