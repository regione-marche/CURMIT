/*==============================================================*/
/* table coimdocu: Archivio documentazione                      */
/*==============================================================*/
create table coimdocu
     ( cod_documento     varchar2(08)  not null
-- Tipo documento AV (avviso) SO (sollecito) CO (comunicazione) 
     , tipo_documento    varchar2(02)  not null
-- tipo_soggetto: C cittadino D distributore M manutentore T tecnico
     , tipo_soggetto     char(1)      
     , cod_soggetto      varchar2(8)  
     , cod_impianto      varchar2(8)   
     , data_stampa       date
     , data_documento    date         not null
     , data_prot_01      date
     , protocollo_01     varchar2(20)
     , data_prot_02      date
     , protocollo_02     varchar2(20)
     , flag_notifica     char(1)
     , data_notifica     date
     , contenuto         blob
     , tipo_contenuto    varchar2(30)
     , descrizione       varchar2(50)
     , note              varchar2(4000)
   --dati alla modifica
     ,data_ins           date
     ,data_mod           date
     ,utente             varchar2(10)
     ) tablespace &ts_dat;

create unique index coimdocu_00
    on coimdocu
     ( cod_documento
     ) tablespace &ts_idx;

create index coimdocu_01
    on coimdocu
     ( tipo_soggetto
     , cod_soggetto
     ) tablespace &ts_idx;

create index coimdocu_02
    on coimdocu
     ( cod_impianto
     ) tablespace &ts_idx;

alter table coimdocu
  add constraint chk_tipo_soggetto_coimdocu
check (tipo_soggetto in ('C',  'D', 'M', 'T'));

alter table coimdocu
  add constraint chk_flag_notifica_coimdocu
check (flag_notifica in ('N', 'S'));