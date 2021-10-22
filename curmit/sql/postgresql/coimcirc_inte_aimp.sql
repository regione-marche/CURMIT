--===========================================================================================
-- table coimcirc_inte_aimp: Tabella Circuiti Interrati a condensazione/espansione diretta. Sezione 9.4 del libretto.
--===========================================================================================

create table coimcirc_inte_aimp
( cod_circ_inte_aimp	integer      not null
, cod_impianto          varchar(08)  not null
, num_ci                integer      not null
, data_installaz        date
, data_dismissione      date
, lunghezza             numeric(9,2)
, superficie            numeric(9,2)
, profondita            numeric(9,2)
, data_ins              date         not null default current_date
, utente_ins            varchar(10)  not null
, data_mod              date
, utente_mod            varchar(10)
);

create unique index coimcirc_inte_aimp_00
    on coimcirc_inte_aimp
     ( cod_circ_inte_aimp
     );

create unique index coimcirc_inte_aimp_01
    on coimcirc_inte_aimp
     ( cod_impianto
     , num_ci
     );
