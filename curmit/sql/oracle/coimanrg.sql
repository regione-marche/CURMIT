/*====================================================================*/
/* table coimenrg: tabella relazioni anomalie / raggruppament enti    */
/*====================================================================*/

create table coimanrg
     ( cod_tano        varchar(08) not null
     , cod_rgen        varchar(08) not null
     ) tablespace &ts_dat;

create unique index coimanrg_00
    on coimanrg
     ( cod_tano
     , cod_rgen
     ) tablespace &ts_idx;

