/*==============================================================*/
/* table coimdocu: Archivio documentazione                      */
/*==============================================================*/
create table coimdocu
     ( cod_documento     varchar(08)  not null
-- Tipo documento AV (avviso) SO (sollecito) CO (comunicazione) 
     , tipo_documento    varchar(02)  not null
-- tipo_soggetto: vedi tab coimtpsg C cittadino D distributore M manutentore T tecnico
     , tipo_soggetto     char(1)
     , cod_soggetto      varchar(8)
     , cod_impianto      varchar(8)   
     , data_stampa       date
     , data_documento    date         not null
     , data_prot_01      date
     , protocollo_01     varchar(20)
     , data_prot_02      date
     , protocollo_02     varchar(20)
     , flag_notifica     char(1)
     , data_notifica     date
     , contenuto         oid
     , tipo_contenuto    varchar(30)
     , descrizione       varchar(50)
     , note              varchar(4000)
   --dati alla modifica
     ,data_ins           date
     ,data_mod           date
     ,utente             varchar(10)
     );

create unique index coimdocu_00
    on coimdocu
     ( cod_documento
     );

create index coimdocu_01
    on coimdocu
     ( tipo_soggetto
     , cod_soggetto
     );

create index coimdocu_02
    on coimdocu
     ( cod_impianto
     );

alter table coimdocu
  add constraint chk_tipo_soggetto_coimdocu
check (tipo_soggetto in ('C',  'D', 'M', 'T'));

alter table coimdocu
  add constraint chk_flag_notifica_coimdocu
check (flag_notifica in ('N', 'S'));
