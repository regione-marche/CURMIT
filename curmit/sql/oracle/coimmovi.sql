/*==============================================================*/
/* table coimmovi: tabella movimenti contabili di pagamento     */
/*==============================================================*/

create table coimmovi
     ( cod_movi         number(08)  
     , tipo_movi        varchar2(2)
-- MH = pagamento per modello h, VC pagamento onere visita di controllo
-- PR = Provvedimenti
     , cod_impianto     varchar2(08) not null 
     , data_scad        date        not null 
--  data di scadenza per il pagamento 
     , importo          float
-- importo dovuto
     , importo_pag      float
-- importo pagato
     , data_pag         date
-- data del pagamento 
     , tipo_pag         varchar2(2)
-- data competenza
     , data_compet      date
-- modalità di pagamento BO bollino prepagato, BP bollettino postale
-- CN allo sportello dell'ente gestore 
     , riferimento      varchar2(08)
-- codice di riferimento della provenienza (modello_h, rapporto di verifica, provvedimento)  
     , nota             varchar2(1000)
     , utente           varchar2(10) 
     , data_ins         date
     , data_mod         date
     , id_caus          integer
     ) tablespace &ts_dat;

create unique index coimmovi_00
    on coimmovi
     ( cod_movi
     ) tablespace &ts_idx;

create        index coimmovi_01
    on coimmovi
     ( cod_impianto
     , cod_movi
     ) tablespace &ts_idx;
