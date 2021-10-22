/*==============================================================*/
/* table coimanec: tabella anomalie enti competenti             */
/*==============================================================*/

create table coimanec
     ( cod_enre           varchar(08)  not null
     , cod_cimp           varchar(08)  not null
     , testo_anomalie     varchar(4000)
     );

create unique index coimanec_00
    on coimanec
     ( cod_enre
     , cod_cimp
     );
