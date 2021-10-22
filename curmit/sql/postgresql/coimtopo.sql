/*==============================================================*/
/* table coimtopo : tipo toponimo: via/piazza/corso...          */
/*==============================================================*/

create table coimtopo
     ( cod_topo       varchar(08)  not null
     , descr_topo     varchar(50)  not null
     );

create unique index coimtopo_00
    on coimtopo
     ( cod_topo
     );
