--===========================================================================================
-- table coimvasi_espa_aimp: Tabella Vasi di Espansione       
--===========================================================================================

create table coimvasi_espa_aimp
( cod_vasi_espa_aimp	integer      not null
, cod_impianto          varchar(08)  not null
, num_vx                integer      not null
, capacita              numeric(9,2)
, flag_aperto           character(1) not null --A=Aperto, --C=Chiuso
, pressione             numeric(9,2)
, data_ins              date         not null default current_date
, utente_ins            varchar(10)  not null
, data_mod              date
, utente_mod            varchar(10)
);

create unique index coimvasi_espa_aimp_00
    on coimvasi_espa_aimp
     ( cod_vasi_espa_aimp
     );

create unique index coimvasi_espa_aimp_01
    on coimvasi_espa_aimp
     ( cod_impianto
     , num_vx
     );
