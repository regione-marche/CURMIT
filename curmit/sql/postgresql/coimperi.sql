/*==============================================================*/
/* table coimperi: periodi addizionali                          */
/*==============================================================*/
create table coimperi
     ( periodo_rif       varchar(06)  not null
     , data_inizio      date         not null
     , data_fine        date         not null
     );

create unique index coimperi_00
    on coimperi
     ( periodo_rif
     );
