/*==============================================================*/
/* table coimcmar : associazione comuni area                    */
/*==============================================================*/

create table coimcmar
     ( cod_area    varchar(08) not null
     , cod_comune  varchar(08) not null
     , data_ins       date
     , data_mod       date
     , utente         varchar(10)
     );

create unique index coimcmar_00
    on coimcmar
     ( cod_area
     , cod_comune
     );
