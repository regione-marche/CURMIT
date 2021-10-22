/*==============================================================*/
/* table coimcurb : unità urbana                                */
/*==============================================================*/

create table coimcurb
     ( cod_urb        varchar2(08)  not null
     , cod_comune     varchar2(08)  not null
     , descrizione    varchar2(50)  not null
     ) tablespace &ts_dat;

create unique index coimcurb_00
    on coimcurb
     ( cod_urb
     , cod_comune
     ) tablespace &ts_idx;
