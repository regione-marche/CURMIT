/*==============================================================*/
/* table coimmovi: tabella movimenti contabili di pagamento     */
/*==============================================================*/

create table coimmovi
     ( cod_movi         integer  
     , tipo_movi        char(2)
-- MH = pagamento per modello h, VC pagamento onere visita di controllo
-- PR = provvedimento
     , cod_impianto     varchar(08) not null 
     , data_scad        date        not null 
--  data di scadenza per il pagamento 
     , importo          float
-- importo dovuto
     , importo_pag      float
-- importo pagato
     , data_pag         date
-- data del pagamento 
     , tipo_pag         char(2)
-- data competenza
     , data_compet      date
-- modalità di pagamento BO bollino prepagato, BP bollettino postale
-- CN allo sportello dell'ente gestore 
     , riferimento      varchar(08)
-- codice di riferimento della provenienza (modello_h, rapporto di verifica, provvedimento)  
     , nota             varchar(1000)
     , utente           varchar(10) 
     , data_ins         date
     , data_mod         date
     , tipo_soggetto     char(01)
     , cod_soggetto      varchar(08)
     , riduzione_importo float
     , cod_sanzione_1    varchar(08)
     , cod_sanzione_2    varchar(08)
     , data_rich_audiz   date
     , note_rich_audiz   varchar(4000)
     , data_pres_deduz   date
     , note_pres_deduz   varchar(4000)
     , data_ric_giudice  date
     , note_ric_giudice  varchar(4000)
     , data_ric_tar      date
     , note_ric_tar      varchar(4000)
     , data_ric_ulter    date
     , note_ric_ulter    varchar(4000)
     , data_ruolo        date
     , note_ruolo        varchar(4000)
     , flag_pagato       char(01)
     , id_caus		 integer
     , data_incasso      date
     , cod_fatt          varchar(8)  --rom01 04/04/2018
     );

create unique index coimmovi_00
    on coimmovi
     ( cod_movi
     ); 

create        index coimmovi_01
    on coimmovi
     ( cod_impianto
     , cod_movi
     ); 
