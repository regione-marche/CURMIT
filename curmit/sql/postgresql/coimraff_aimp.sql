--===========================================================================================
-- table coimraff_aimp: Tabella Raffreddatori di Liquido. Sezione 9.2 del libretto.
--===========================================================================================

create table coimraff_aimp
( cod_raff_aimp  	integer      not null
, cod_impianto          varchar(08)  not null
, num_rv                integer      not null
, data_installaz        date
, data_dismissione      date
, cod_cost              varchar(08)
, modello               varchar(40)
, matricola             varchar(35)
, num_ventilatori       integer
, tipi_ventilatori      varchar(40)
, data_ins              date         not null default current_date
, utente_ins            varchar(10)  not null
, data_mod              date
, utente_mod            varchar(10)
);

create unique index coimraff_aimp_00
    on coimraff_aimp
     ( cod_raff_aimp
     );

create unique index coimraff_aimp_01
    on coimraff_aimp
     ( cod_impianto
     , num_rv
     );
