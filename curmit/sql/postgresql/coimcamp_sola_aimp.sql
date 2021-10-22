--===========================================================================================
-- table coimcamp_sola_aimp: Tabella Campi Solari Termici     
--===========================================================================================

create table coimcamp_sola_aimp
( cod_camp_sola_aimp	integer      not null
, cod_impianto          varchar(08)  not null
, num_cs                integer      not null
, data_installaz        date
, cod_cost              varchar(08)
, collettori            integer
, sup_totale            numeric(9,2)
, data_ins              date         not null default current_date
, utente_ins            varchar(10)  not null
, data_mod              date
, utente_mod            varchar(10)
);

create unique index coimcamp_sola_aimp_00
    on coimcamp_sola_aimp
     ( cod_camp_sola_aimp
     );

create unique index coimcamp_sola_aimp_01
    on coimcamp_sola_aimp
     ( cod_impianto
     , num_cs
     );
