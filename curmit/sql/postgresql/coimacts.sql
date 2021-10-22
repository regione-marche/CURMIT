/*==============================================================*/
/* table coimacts: Testata caricamento anagrafiche              */
/*==============================================================*/
create table coimacts
     ( cod_acts          varchar(08)  not null
 -- codice del distributore -provenienza
     , cod_distr         varchar(08)
 -- data caricamento
     , data_caric        date
-- riferimento alla tabella coimdocu
     , cod_documento     varchar(08)
-- contatore dati
-- caricati sulla coimaces
     , caricati          numeric(6,0)
-- scartati, non finiscono sulla coimaces
     , scartati          numeric(6,0)
-- invariati rispetto alla coimaimp (riferimento ai caricati)
     , invariati         numeric(6,0)
-- da analizzare prima di importarli sulla coimaimp (riferimento ai caricati)
     , da_analizzare     numeric(6,0)
-- importati sulla coimaimp (riferimento ai da_analizzare)
     , importati_aimp    numeric(6,0)
-- chiusi in modo forzato (riferimento ai da_analizzare)
     , chiusi_forzat     numeric(6,0)
 -- stato: A=Annullato, C=Chiuso, E=In elaborazione, I=Interrotto
     , stato             char(01)
     , percorso_file     varchar(50)
     , note              varchar(4000)
 --dati alla modifica
     , data_ins          date
     , data_mod          date
     , utente            varchar(10)
     );

create unique index coimacts_00
    on coimacts
     ( cod_acts
     );

create unique index coimacts_01
    on coimacts
     ( cod_distr
     , data_caric
     );

alter table coimacts 
  add constraint chk_stato_coimacts
check (stato in ('A', 'C', 'E', 'I'));