--===========================================================================================
-- table coimaltr_gend_aimp: Tabella Altri Generatori     
--===========================================================================================

create table coimaltr_gend_aimp
( cod_altr_gend_aimp	integer      not null
, cod_impianto          varchar(08)  not null
, num_ag                integer
, data_installaz        date
, data_dismissione      date
, cod_cost              varchar(08)
, modello               varchar(40)
, matricola             varchar(35)
, tipologia             varchar(100)
, potenza_utile         numeric(9,2)
, data_ins              date         not null default current_date
, utente_ins            varchar(10)  not null
, data_mod              date
, utente_mod            varchar(10)
);

create unique index coimaltr_gend_aimp_00
    on coimaltr_gend_aimp
     ( cod_altr_gend_aimp
     );

create unique index coimaltr_gend_aimp_01
    on coimaltr_gend_aimp
     ( cod_impianto
     , num_ag
     );
