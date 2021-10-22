/*==============================================================*/
/* table coimgend_st: tabella dati generatore                      */
/*==============================================================*/

create table coimgend_st
     ( cod_impianto        varchar2(08)   not null
     , gen_prog            numeric(08)   not null
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
     , pot_focolare_lib    numeric(9,2)
     , pot_utile_lib       numeric(9,2)
     , pot_focolare_nom    numeric(9,2)
     , pot_utile_nom       numeric(9,2)
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
     , campo_funzion_min   numeric(9,2)
     , campo_funzion_max   numeric(9,2)
     , dpr_660_96          char(01)
     , utente_ins	   varchar2(10)
     , igni_progressivo	   numeric(5,0)     
     , portata_comb	   numeric(9,2)
     , portata_termica	   numeric(9,2)
     , st_progressivo	   integer      not null default nextval('coimgend_st_seq'::regclass)
     , st_utente	   varchar2(10)
     , st_operazione	   char(01)
     , st_data_validita    timestamp with time zone
 ) tablespace &ts_dat;

