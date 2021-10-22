--===========================================================================================
-- table coimvent_aimp: Tabella Impianti di ventilazione. Sezione 10.1 del libretto.
--===========================================================================================

create table coimvent_aimp
( cod_vent_aimp 	integer      not null
, cod_impianto          varchar(08)  not null
, num_vm                integer      not null
, data_installaz        date
, data_dismissione      date
, cod_cost 		varchar(8)
, modello		varchar(40)
, tipologia             char(1) --S sola estrazione, I Flusso doppio con recupero tramite scam. inc., T Flusso doppio con recupero termodinamico, A altro
, note_tipologia_altro  varchar(4000)
, portata_aria          numeric(9,2)
, rendimento_rec        numeric(9,2)
, data_ins              date         not null default current_date
, utente_ins            varchar(10)  not null
, data_mod              date
, utente_mod            varchar(10)
);

create unique index coimvent_aimp_00
    on coimvent_aimp
     ( cod_vent_aimp
     );

create unique index coimvent_aimp_01
    on coimvent_aimp
     ( cod_impianto
     , num_vm
     );
