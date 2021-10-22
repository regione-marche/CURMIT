/*==============================================================*/
/* table coimanec: tabella anomalie enti competenti             */
/*==============================================================*/

create table coimanec
     ( cod_enre           varchar2(08)  not null
     , cod_cimp           varchar2(08)  not null
     , testo_anom         varchar2(4000)
     ) tablespace &ts_dat;

create unique index coimanec_00
    on coimanec
     ( cod_enre
     , cod_cimp
     ) tablespace &ts_idx;