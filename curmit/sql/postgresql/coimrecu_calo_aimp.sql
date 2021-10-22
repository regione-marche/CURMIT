--===========================================================================================
-- table coimrecu_calo_aimp: Tabella Recuperatori di calore. Sezione 9.6 del libretto.
--===========================================================================================

create table coimrecu_calo_aimp
( cod_recu_calo_aimp	integer      not null
, cod_impianto          varchar(08)  not null
, num_rc                integer      not null
, data_installaz        date
, data_dismissione      date
, tipologia             varchar(35)
, installato_uta_vmc    char(01) --U UTA V VTA
, indipendente          char(01) --S Si  N No
, portata_mandata       numeric(9,2)
, potenza_mandata       numeric(9,2)
, portata_ripresa       numeric(9,2)
, potenza_ripresa       numeric(9,2)
, data_ins              date         not null default current_date
, utente_ins            varchar(10)  not null
, data_mod              date
, utente_mod            varchar(10)
);

create unique index coimrecu_calo_aimp_00
    on coimrecu_calo_aimp
     ( cod_recu_calo_aimp
     );

create unique index coimrecu_calo_aimp_01
    on coimrecu_calo_aimp
     ( cod_impianto
     , num_rc
     );
