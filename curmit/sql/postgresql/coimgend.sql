/*==============================================================*/
/* table coimgend: tabella dati generatore                      */
/*==============================================================*/

create table coimgend
     ( cod_impianto        varchar(08)   not null
     , gen_prog            numeric(08)   not null
     , descrizione         varchar(100)
     , matricola           varchar(35)
     , modello             varchar(40) 
     , cod_cost            varchar(08)
     , matricola_bruc      varchar(35)
     , modello_bruc        varchar(40)
     , cod_cost_bruc       varchar(08)
    -- tipo_foco tipo focolare A = apero, C = chiuso
     , tipo_foco           char(01)
    -- mod_funz  funzionamento: 1 = aria 2 = acqua
     , mod_funz            char(01)
     , cod_utgi            varchar(08)
    -- tipo_bruciatore A = atmosferico, P = pressurizzato
     , tipo_bruciatore     char(01)
    -- tiraggio F = forzato, N = naturale
     , tiraggio            char(01)
    -- locale T = tecnico, E = esterno , I = interno
     , locale              char(01)
     , cod_emissione       varchar(08)
     , cod_combustibile    varchar(08)
    -- date installazione e rottamazione del singolo generatore
     , data_installaz      date
     , data_rottamaz       date
     , pot_focolare_lib    numeric(9,2)
     , pot_utile_lib       numeric(9,2)
     , pot_focolare_nom    numeric(9,2)
     , pot_utile_nom       numeric(9,2)
    -- flag attivazione (S/N)
     , flag_attivo         char(01)
     , note                varchar(4000)
    -- dati utente/modifica
     , data_ins            date  
     , data_mod            date
     , utente              varchar(10)
     , gen_prog_est        numeric(08)   not null
     , data_costruz_gen    date
     , data_costruz_bruc   date
     , data_installaz_bruc date
     , data_rottamaz_bruc  date
     , marc_effic_energ    varchar(10)
     , campo_funzion_min   numeric(9,2)
     , campo_funzion_max   numeric(9,2)
     , dpr_660_96          char(01)
     , cod_tpco            varchar(08)   -- codice tipo condizionatore (dpr74)
     , cod_flre            varchar(08)   -- codice fluido refrigerante (dpr74)
     , carica_refrigerante numeric(10,2) -- carica refrigerante (pressione) (dpr74)
     , sigillatura_carica  char(01)      -- carica sigillata ermeticamente? S/N
     , cod_mode            integer       -- 17/03/2014 Viene aggiornata anche la col. modello
     , cod_mode_bruc       integer       -- 17/03/2014 Viene aggiornata anche la col. modello_bruc
     , cod_grup_term       varchar(08)   -- 05/01/2015 Sandro (tabella coimtipo_grup_termico)
     , num_circuiti        integer       -- 19/10/2017 Simone - numero circuiti sul generatore del freddo 
     , num_prove_fumi      integer	 -- 22/01/2018 LucaR. - numero prove fumi sul generatore del caldo
     , cop                 numeric(4,2)  -- 23/01/2017 Simone
     , per                 numeric(4,2)  -- 23/01/2017 Simone 
     , tipologia_cogenerazione varchar(1) -- 12/02/2018 Gacalin - tipologia cogeneratore sul cogeneratore
     , temp_h2o_uscita_min decimal(18,2) -- 12/02/2018 Gacalin - temperatura uscita minima
     , temp_h2o_uscita_max decimal(18,2) -- 12/02/2018 Gacalin - temperatura uscita massima
     , temp_h2o_ingresso_min decimal(18,2) -- 12/02/2018 Gacalin - temperatura ingresso minima
     , temp_h2o_ingresso_max decimal(18,2) -- 12/02/2018 Gacalin - temperatura ingresso massima
     , temp_h2o_motore_min decimal(18,2) -- 12/02/2018 Gacalin - temperatura motere minima
     , temp_h2o_motore_max decimal(18,2) -- 12/02/2018 Gacalin - temperatura motere massima
     , temp_fumi_valle_min decimal(18,2) -- 12/02/2018 Gacalin - temperatura fumi valle minima
     , temp_fumi_valle_max decimal(18,2) -- 12/02/2018 Gacalin - temperatura fumi valle massima
     , temp_fumi_monte_min decimal(18,2) -- 12/02/2018 Gacalin - temperatura fumi monte minima
     , temp_fumi_monte_max decimal(18,2) -- 12/02/2018 Gacalin - temperatura fumi monte massima
     , emissioni_monossido_co_max decimal(18,2) -- 12/02/2018 Gacalin - emissioni di monossido massime
     , emissioni_monossido_co_min decimal(18,2) -- 12/02/2018 Gacalin - emissioni di monossido mminime   


     );

create unique index coimgend_00
    on coimgend
     ( cod_impianto
     , gen_prog
     );

create unique index coimgend_01
    on coimgend
     ( cod_impianto
     , gen_prog_est
     );
