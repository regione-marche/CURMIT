/*==============================================================*/
/* table coimtopo : tipo toponimo: via/piazza/corso...          */
/*==============================================================*/

create table coimtopo
     ( cod_topo       varchar2(08)  not null
     , descr_topo     varchar2(50)  not null
     ) tablespace &ts_dat;

create unique index coimtopo_00
    on coimtopo
     ( cod_topo
     ) tablespace &ts_idx;
