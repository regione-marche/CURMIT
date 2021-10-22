/*==============================================================*/
/* table coimcitt_st: Anagrafica cittadini                         */
/*==============================================================*/

create table coimcitt_st
     ( cod_cittadino    varchar2(08) not null
     , natura_giuridica char(01) 
     , cognome          varchar2(100)
     , nome             varchar2(100)
     , indirizzo        varchar2(100)
     , numero           varchar2(08)
     , cap              varchar2(05)
     , localita         varchar2(40)
     , comune           varchar2(40)
     , provincia        varchar2(04)
     , cod_fiscale      varchar2(16)
     , cod_piva         varchar2(16)
     , telefono         varchar2(15)
     , cellulare        varchar2(15)
     , fax              varchar2(15)            
     , email            varchar2(35)
     , data_nas         date
     , comune_nas       varchar2(40)
     , utente           varchar2(10)
     , data_ins         date
     , data_mod         date
     , utente_ult       varchar2(10)
     , note             varchar2(4000)
     , stato_nas        varchar2(8)
     , st_progressivo   integer		not null default nextval('coimcitt_st_seq')
     , st_utente        varchar2(10)    
     , st_operazione    char(1)    check (st_operazione in ('I','M','C'))             
     , st_data_validita timestamp with time zone 
     ) tablespace &ts_dat;
