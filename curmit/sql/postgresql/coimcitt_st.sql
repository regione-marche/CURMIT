/*==============================================================*/
/* table coimcitt_st: Anagrafica cittadini                         */
/*==============================================================*/

create table coimcitt_st
     ( cod_cittadino    varchar(08) not null
     , natura_giuridica char(01) 
     , cognome          varchar(100)
     , nome             varchar(100)
     , indirizzo        varchar(100)
     , numero           varchar(08)
     , cap              varchar(05)
     , localita         varchar(40)
     , comune           varchar(40)
     , provincia        varchar(04)
     , cod_fiscale      varchar(16)
     , cod_piva         varchar(16)
     , telefono         varchar(15)
     , cellulare        varchar(15)
     , fax              varchar(15)            
     , email            varchar(35)
     , data_nas         date
     , comune_nas       varchar(40)
     , utente           varchar(10)
     , data_ins         date
     , data_mod         date
     , utente_ult       varchar(10)
     , note             varchar(4000)
     , stato_nas        varchar(8)
     , st_progressivo   integer		not null default nextval('coimcitt_st_seq')
     , st_utente        varchar(10)    
     , st_operazione    character(1)    check (st_operazione in ('I','M','C'))             
     , st_data_validita timestamp with time zone 
     );
