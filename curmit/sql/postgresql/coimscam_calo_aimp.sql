--===========================================================================================
-- table coimscam_calo_aimp: Tabella Scambiatori di Calore Intermedi. Sezione 9.3 del libretto.
--===========================================================================================

create table coimscam_calo_aimp
( cod_scam_calo_aimp	integer      not null
, cod_impianto          varchar(08)  not null
, num_sc                integer      not null
, data_installaz        date
, data_dismissione      date
, cod_cost              varchar(08)
, modello               varchar(40)
, data_ins              date         not null default current_date
, utente_ins            varchar(10)  not null
, data_mod              date
, utente_mod            varchar(10)
);

create unique index coimscam_calo_aimp_00
    on coimscam_calo_aimp
     ( cod_scam_calo_aimp
     );

create unique index coimscam_calo_aimp_01
    on coimscam_calo_aimp
     ( cod_impianto
     , num_sc
     );
