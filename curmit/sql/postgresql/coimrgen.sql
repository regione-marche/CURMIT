/*==============================================================*/
/* table coimrgen: tabella raggruppamento enti responsabili     */
/*==============================================================*/

create table coimrgen
     ( cod_rgen        varchar(08)
     , descrizione     varchar(100)
     );

create unique index coimrgen_00
    on coimrgen
     ( cod_rgen
     );

