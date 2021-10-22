/*==============================================================*/
/* table coimrgen: tabella raggruppamento enti responsabili     */
/*==============================================================*/

create table coimrgen
     ( cod_rgen        varchar2(08)
     , descrizione     varchar2(100)
     ) tablespace &ts_dat;

create unique index coimrgen_00
    on coimrgen
     ( cod_rgen
     ) tablespace &ts_idx;

