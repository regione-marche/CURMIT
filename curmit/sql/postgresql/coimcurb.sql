/*==============================================================*/
/* table coimcurb : unità urbana                                */
/*==============================================================*/

create table coimcurb
     ( cod_urb        varchar(08)  not null
     , cod_comune     varchar(08)  not null
     , descrizione    varchar(50)  not null
     );

create unique index coimcurb_00
    on coimcurb
     ( cod_urb
     , cod_comune
     );
