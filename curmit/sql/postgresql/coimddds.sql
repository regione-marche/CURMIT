/*==============================================================*/
/* table coimddds: Nominativi acquisiti esternamente            */
/*==============================================================*/
create table coimddds
     ( cod_ddds           varchar(08)  not null
     , cod_ddts           varchar(08)  not null
     , ragione_sociale    varchar(100)
     , toponimo           varchar(08)
     , indirizzo          varchar(50)
     , civico             varchar(08)
     , cap                varchar(05)
     , comune             varchar(40)
     , cod_istat          varchar(08)
     , telefono           varchar(15)
     , combustibile       varchar(35)
     , cod_utenza         varchar(10)
     , cod_impianto_est   varchar(20)
     , consumo_annuo      numeric(9,2)
     , un_mis_consumo     varchar(02)
     , tipo_contratto     varchar(02)
     , volumetria_risc    numeric(9,2)
     , codice_fisc_utente varchar(16)
     , piva_utente        varchar(11)
     , smistato           char(01)
     );

create unique index coimddds_00
    on coimddds
     ( cod_ddds
     );
