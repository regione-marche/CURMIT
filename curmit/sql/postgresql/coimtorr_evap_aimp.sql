--===========================================================================================
-- table coimtorr_evap_aimp: Tabella Torri Evaporative. Sezione 9.1 del libretto.
--===========================================================================================

create table coimtorr_evap_aimp
( cod_torr_evap_aimp	integer      not null
, cod_impianto          varchar(08)  not null
, num_te                integer      not null
, data_installaz        date
, data_dismissione      date
, cod_cost              varchar(08)
, modello               varchar(40)
, matricola             varchar(35)
, capacita              numeric(9,2)
, num_ventilatori       integer
, tipi_ventilatori      varchar(40)
, data_ins              date         not null default current_date
, utente_ins            varchar(10)  not null
, data_mod              date
, utente_mod            varchar(10)
);

create unique index coimtorr_evap_aimp_00
    on coimtorr_evap_aimp
     ( cod_torr_evap_aimp
     );

create unique index coimtorr_evap_aimp_01
    on coimtorr_evap_aimp
     ( cod_impianto
     , num_te
     );
