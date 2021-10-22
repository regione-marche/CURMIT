/*==============================================================*/
/* table coimgend: tabella dati generatore                      */
/*==============================================================*/

create table coimgend
     ( cod_impianto        varchar2(08)   not null
     , gen_prog            number(08)   not null
     , descrizione         varchar2(100)
     , matricola           varchar2(35)
     , modello             varchar2(40) 
     , cod_cost            varchar2(08)
     , matricola_bruc      varchar2(35)
     , modello_bruc        varchar2(40)
     , cod_cost_bruc       varchar2(08)
    -- tipo_foco tipo focolare A = apero, C = chiuso
     , tipo_foco           char(01)
    -- mod_funz  funzionamento: 1 = aria 2 = acqua
     , mod_funz            char(01)
     , cod_utgi            varchar2(08)
    -- tipo_bruciatore A = atmosferico, P = pressurizzato
     , tipo_bruciatore     char(01)
    -- tiraggio F = forzato, N = naturale
     , tiraggio            char(01)
    -- locale T = tecnico, E = esterno , I = interno
     , locale              char(01)
     , cod_emissione       varchar2(08)
     , cod_combustibile    varchar2(08)
    -- date installazione e rottamazione del singolo generatore
     , data_installaz      date
     , data_rottamaz       date
     , pot_focolare_lib    number(9,2)
     , pot_utile_lib       number(9,2)
     , pot_focolare_nom    number(9,2)
     , pot_utile_nom       number(9,2)
    -- flag attivazione (S/N)
     , flag_attivo         char(01)
     , note                varchar2(4000)
    -- dati utente/modifica
     , data_ins            date  
     , data_mod            date
     , utente              varchar2(10)
     , gen_prog_est        numeric(08)   not null
     , data_costruz_gen    date
     , data_costruz_bruc   date
     , data_installaz_bruc date
     , data_rottamaz_bruc  date
     , marc_effic_energ    varchar2(10)
     , campo_funzion_min   number(9,2)
     , campo_funzion_max   number(9,2)
     , dpr_660_96          char(01)
     , cod_tpco            varchar2(08) -- codice tipo condizionatore (dpr74)
     , cod_flre            varchar2(08) -- codice fluido refrigerante (dpr74)
     , carica_refrigerante number(10,2) -- carica refrigerante (pressione) (dpr74)
     , sigillatura_carica  char(01)     -- carica sigillata ermeticamente? S/N
     , cod_mode            integer      -- 17/03/2014 Viene aggiornata anche la col. modello
     , cod_mode_bruc       integer      -- 17/03/2014 Viene aggiornata anche la col. modello_bruc
     , cod_grup_term       varchar2(08) -- 05/01/2015 Sandro (tabella coimtipo_grup_termico)
     ) tablespace &ts_dat;

create unique index coimgend_00
    on coimgend
     ( cod_impianto
     , gen_prog
     ) tablespace &ts_idx;

create unique index coimgend_01
    on coimgend
     ( cod_impianto
     , gen_prog_est
     ) tablespace &ts_idx;
