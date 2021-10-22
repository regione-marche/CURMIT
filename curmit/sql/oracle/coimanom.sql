/*==============================================================*/
/* table coimanom: evidenza anomalie per controllori            */
/*==============================================================*/

create table coimanom
     ( cod_cimp_dimp   varchar2(08) not null
     , prog_anom       varchar2(08) not null
     , tipo_anom       varchar2(08) not null
     , cod_tanom       varchar2(08) not null
     , dat_utile_inter date
     -- MH origine da modello H, RV origine da rapporto di verifica
     , flag_origine    varchar2(02) not null
     ) tablespace &ts_dat;

create unique index coimanom_00
    on coimanom
     ( cod_cimp_dimp
     , prog_anom
     -- MH origine da modello H, RV origine da rapporto di verifica
     , flag_origine
     ) tablespace &ts_idx;
