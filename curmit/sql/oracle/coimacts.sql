/*==============================================================*/
/* table coimacts: Testata caricamento anagrafiche              */
/*==============================================================*/
create table coimacts
     ( cod_acts          varchar2(08)  not null
 -- codice del distributore -provenienza
     , cod_distr         varchar2(08)
 -- data caricamento
     , data_caric        date
-- riferimento alla tabella coimdocu
     , cod_documento     varchar2(08)
-- contatore dati
-- caricati sulla coimaces
     , caricati          number(6,0)
-- scartati, non finiscono sulla coimaces
     , scartati          number(6,0)
-- invariati rispetto alla coimaimp (riferimento ai caricati)
     , invariati         number(6,0)
-- da analizzare prima di importarli sulla coimaimp (riferimento ai caricati)
     , da_analizzare     number(6,0)
-- importati sulla coimaimp (riferimento ai da_analizzare)
     , importati_aimp    number(6,0)
-- chiusi in modo forzato (riferimento ai da_analizzare)
     , chiusi_forzat     number(6,0)
 -- stato: A=Annullato, C=Chiuso, E=In elaborazione, I=Interrotto
     , stato             char(01)
     , percorso_file     varchar2(50)
     , note              varchar2(4000)
 --dati alla modifica
     , data_ins          date
     , data_mod          date
     , utente            varchar2(10)
     ) tablespace &ts_dat;

create unique index coimacts_00
    on coimacts
     ( cod_acts
     ) tablespace &ts_idx;

create unique index coimacts_01
    on coimacts
     ( cod_distr
     , data_caric
     ) tablespace &ts_idx;

alter table coimacts 
  add constraint chk_stato_coimacts
check (stato in ('A', 'C', 'E', 'I'));