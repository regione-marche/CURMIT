--===========================================================================================
-- table coimtrat_aria_aimp: Tabella Unità trattamento aria. Sezione 9.5 del libretto.
--===========================================================================================

create table coimtrat_aria_aimp
( cod_trat_aria_aimp	integer      not null
, cod_impianto          varchar(08)  not null
, num_ut                integer      not null
, data_installaz        date
, data_dismissione      date
, cod_cost              varchar(08)
, modello               varchar(40)
, matricola             varchar(35)
, portata_mandata       numeric(9,2)
, potenza_mandata       numeric(9,2)
, portata_ripresa       numeric(9,2)
, potenza_ripresa       numeric(9,2)
, data_ins              date         not null default current_date
, utente_ins            varchar(10)  not null
, data_mod              date
, utente_mod            varchar(10)
);

create unique index coimtrat_aria_aimp_00
    on coimtrat_aria_aimp
     ( cod_trat_aria_aimp
     );

create unique index coimtrat_aria_aimp_01
    on coimtrat_aria_aimp
     ( cod_impianto
     , num_ut
     );
