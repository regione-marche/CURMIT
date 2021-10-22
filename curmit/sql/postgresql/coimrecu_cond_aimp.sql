--===========================================================================================
-- table coimrecu_cond_aimp: Tabella Recuperatori/condensatori. Sezione 4.3 del libretto.
--===========================================================================================

create table coimrecu_cond_aimp
( cod_recu_cond_aimp	integer      not null
, cod_impianto          varchar(08)  not null
, num_rc                integer      not null
, data_installaz        date
, data_dismissione      date
, cod_cost              varchar(08)
, modello               varchar(40)
, matricola             varchar(35)
, portata_term_max      numeric(9,2)
, portata_term_min      numeric(9,2)
, data_ins              date         not null default current_date
, utente_ins            varchar(10)  not null
, data_mod              date
, utente_mod            varchar(10)
);

create unique index coimrecu_cond_aimp_00
    on coimrecu_cond_aimp
     ( cod_recu_cond_aimp
     );

create unique index coimrecu_cond_aimp_01
    on coimrecu_cond_aimp
     ( cod_impianto
     , num_rc
     );
