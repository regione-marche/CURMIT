/*==============================================================*/
/* table coimflre: anagrafica fluidi refrigeranti               */
/*==============================================================*/

create table coimflre
     ( cod_flre varchar(08) not null
     , sigla    varchar(35) not null
     , fluido   varchar(50)
     , formula  varchar(50)
     , data_ins date
     , data_mod date
     , utente   varchar(10)
     );

create unique index coimflre_00
    on coimflre
     ( cod_flre
     );
