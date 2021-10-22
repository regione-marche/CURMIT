--===========================================================================================
-- table coimaccu_aimp: Tabella Accumuli. Sezione 8.1 del libretto.
--===========================================================================================

create table coimaccu_aimp
( cod_accu_aimp	        integer      not null
, cod_impianto          varchar(08)  not null
, num_ac                integer      not null
, data_installaz        date
, data_dismissione      date
, cod_cost              varchar(08)
, modello               varchar(40)
, matricola             varchar(35)
, capacita              numeric(9,2)
, utilizzo              char(1)      -- A acqua sanitaria, R riscaldamento, F Raffreddamento
, coibentazione         char(1)      -- S si, N no
, data_ins              date         not null default current_date
, utente_ins            varchar(10)  not null
, data_mod              date
, utente_mod            varchar(10)
);

create unique index coimaccu_aimp_00
    on coimaccu_aimp
     ( cod_accu_aimp
     );

create unique index coimaccu_aimp_01
    on coimaccu_aimp
     ( cod_impianto
     , num_ac
     );
