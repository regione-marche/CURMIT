/*==============================================================*/
/* table coimtopo_cnt : tipo toponimo: via/piazza/corso...          */
/*==============================================================*/

create table coimtopo_cnt
     ( cod_topo       varchar(08)  not null
     , descr_topo     varchar(50)  not null
     );

create unique index coimtopo_cnt_00
    on coimtopo_cnt
     ( cod_topo
     );
