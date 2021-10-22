--===========================================================================================
-- table coimpomp_circ_aimp: Tabella Pompe di Circolazione
--===========================================================================================

create table coimpomp_circ_aimp
( cod_pomp_circ_aimp	integer      not null
, cod_impianto          varchar(08)  not null
, num_po                integer      not null
, data_installaz        date
, data_dismissione      date
, cod_cost              varchar(08)
, modello               varchar(40)
, flag_giri_variabili   char(01)     -- S=Si, N=No
, pot_nom               numeric(9,2)
, data_ins              date         not null default current_date
, utente_ins            varchar(10)  not null
, data_mod              date
, utente_mod            varchar(10)
);

create unique index coimpomp_circ_aimp_00
    on coimpomp_circ_aimp
     ( cod_pomp_circ_aimp
     );

create unique index coimpomp_circ_aimp_01
    on coimpomp_circ_aimp
     ( cod_impianto
     , num_po
     );
