/*==============================================================*/
/* table coimopma: Anagrafica operatori manutentori             */
/*==============================================================*/

create table coimopma
     ( cod_opma         varchar(16) not null
     , cod_manutentore  varchar(08) not null
     , cognome          varchar(200) 
     , nome             varchar(100) 
     , matricola        varchar(50) 
     , stato            char(1) 
     , telefono         varchar(50)
     , cellulare        varchar(50)
     , recapito         varchar(200)
     , codice_fiscale   varchar(16)
     , note             varchar(4000)
     , data_ins         date
     , data_mod         date
     , utente_ins       varchar(10)
     , utente_mod       varchar(10)
     , flag_portafoglio_admin char(1) default 'F'
     );

create unique index coimopma_00
    on coimopma
     ( cod_opma
     );

