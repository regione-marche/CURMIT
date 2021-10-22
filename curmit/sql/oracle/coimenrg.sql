/*=========================================================================*/
/* table coimenrg: tabella relazioni raggruppamenti enti/enti responsabili */
/*=========================================================================*/

create table coimenrg
     ( cod_rgen        varchar2(08) not null
     , cod_enre        varchar2(08) not null
     ) tablespace &ts_dat;

create unique index coimenrg_00
    on coimenrg
     ( cod_rgen
     , cod_enre
     ) tablespace &ts_idx;

