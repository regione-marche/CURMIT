/*==============================================================*/
/* table coimsanz : sanzioni                                    */
/*==============================================================*/

create table coimsanz
     ( id_sanzione      integer     not null
     , cod_sanzione     varchar(08) not null
     , descr_breve      varchar(200)
     , descr_estesa     varchar(2000)
     , importo_min      numeric(10, 2)
     , importo_max      numeric(10, 2)
     , tipo_soggetto    char(01)
     );

create unique index coimsanz_00
    on coimsanz
     ( id_sanzione
     );
