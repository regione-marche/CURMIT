/*==============================================================*/
/* table coimopve: Anagrafica operatori verificatori            */
/*==============================================================*/

create table coimopve
     ( cod_opve         varchar2(08) not null
     , cod_enve         varchar2(08) not null
     , cognome          varchar2(40) 
     , nome             varchar2(40) 
     , matricola        varchar2(10) 
     , stato            char(1) 
     , data_ins         date
     , data_mod         date
     , utente           varchar2(10)
     , telefono         varchar2(15)
     , cellulare        varchar2(15)
     , recapito         varchar2(100)
     , codice_fiscale   varchar2(16)
     , note             varchar2(4000)
     , cod_listino      varchar2(08)
     , marca_strum      varchar2(50)
     , modello_strum    varchar2(50)
     , matr_strum       varchar2(50) 
     , dt_tar_strum     date
     , strumento        varchar2(100)
     )  tablespace &ts_dat;

create unique index coimopve_00
    on coimopve
     ( cod_opve
     ) tablespace &ts_idx;

alter table coimopve
  add constraint chk_stato_coimopve
check (stato in ('0', '1'));
-- 0 = Attivo
-- 1 = Non attivo
