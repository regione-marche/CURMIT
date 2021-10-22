/*==============================================================*/
/* table coimopve: Anagrafica operatori verificatori            */
/*==============================================================*/

create table coimopve
     ( cod_opve         varchar(08) not null
     , cod_enve         varchar(08) not null
     , cognome          varchar(100) 
     , nome             varchar(100) 
     , matricola        varchar(10) 
     , stato            char(1) 
     , data_ins         date
     , data_mod         date
     , utente           varchar(10)
     , telefono         varchar(15)
     , cellulare        varchar(15)
     , recapito         varchar(100)
     , codice_fiscale   varchar(16)
     , note             varchar(4000)
     , cod_listino      varchar(8)
     , marca_strum      varchar(50)
     , modello_strum    varchar(50)
     , matr_strum       varchar(50) 
     , dt_tar_strum     date
     , strumento        varchar(100)
     );

create unique index coimopve_00
    on coimopve
     ( cod_opve
     );

alter table coimopve
  add constraint chk_stato_coimopve
check (stato in ('0', '1'));
-- 0 = Attivo
-- 1 = Non attivo
