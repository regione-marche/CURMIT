/*==============================================================*/
/* table coimanom_cnt: evidenza anomalie per controllori            */
/*==============================================================*/

create table coimanom_cnt
     ( cod_cimp_dimp   varchar(08) not null
     , prog_anom       varchar(08) not null
     , tipo_anom       varchar(08) not null
     , cod_tanom       varchar(08) not null
     , dat_utile_inter date
     -- MH origine da modello H, RV origine da rapporto di verifica
     , flag_origine    varchar(02) not null
     );

create unique index coimanom_cnt_00
    on coimanom_cnt
     ( cod_cimp_dimp
     , prog_anom
     -- MH origine da modello H, RV origine da rapporto di verifica
     , flag_origine
     );
