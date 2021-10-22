/*==============================================================*/
/* table coimtcar : collegamento tecnici - area di competenza   */
/*==============================================================*/

create table coimtcar
     ( cod_area          varchar(08)  not null
     , cod_opve          varchar(08)  not null
     , data_ins          date
     , data_mod          date
     , utente            varchar(10)
     );

create unique index coimtcar_00
    on coimtcar
     ( cod_area
     , cod_opve
     );
