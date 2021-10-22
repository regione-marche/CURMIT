var/*==============================================================*/
/* table coimopma: Anagrafica operatori manutentori             */
/*==============================================================*/

create table coimopma
     ( cod_opma         varchar2(16) not null
     , cod_manutentore  varchar2(08) not null
     , cognome          varchar2(200) 
     , nome             varchar2(100) 
     , matricola        varchar2(50) 
     , stato            char(1) 
     , telefono         varchar2(50)
     , cellulare        varchar2(50)
     , recapito         varchar2(200)
     , codice_fiscale   varchar2(16)
     , note             varchar2(4000)
     , data_ins         date
     , data_mod         date
     , utente_ins       varchar2(10)
     , utente_mod       varchar2(10)
     , flag_portafoglio_admin char(1) default 'F'
     ) tablespace &ts_dat;

create unique index coimopma_00
    on coimopma
     ( cod_opma
     ) tablespace &ts_idx;
