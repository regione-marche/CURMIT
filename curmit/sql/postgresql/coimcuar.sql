/*==============================================================*/
/* table coimcuar: tabella Area urbana / Area Territoriale      */
/*==============================================================*/

create table coimcuar
     ( cod_area       varchar(08)  not null
     , cod_comune     varchar(08)  not null
     , cod_urb        varchar(08)  not null
     , data_ins       date
     , data_mod       date
     , utente         varchar(10)
     );

create unique index coimcuar_00
    on coimcuar
     ( cod_area
     , cod_comune
     , cod_urb
     );
