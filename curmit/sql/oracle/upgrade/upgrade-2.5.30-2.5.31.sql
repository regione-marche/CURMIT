-- Simone 16/03/2016

begin;

alter table coimtano add ente_competente char(01); -- Sandro

-- Aggiunte colonne per portafoglio
alter table coimmanu add wallet_id varchar(18);
alter table coimmanu add iban_code varchar(27);	

alter table coimopma add flag_portafoglio_admin char(1) default 'F';	

-- Aggiunte nuove colonne alla tabella coimdimp_stn per portarla a pari con la coimdimp       
-- Usata dallo storno del portafoglio
alter table  coimdimp_stn add cod_cind                  varchar(8);
alter table  coimdimp_stn add rct_dur_acqua             numeric(10,2);
alter table  coimdimp_stn add rct_tratt_in_risc         varchar(2);
alter table  coimdimp_stn add rct_tratt_in_acs          varchar(2);
alter table  coimdimp_stn add rct_install_interna       varchar(1);
alter table  coimdimp_stn add rct_install_esterna       varchar(1);
alter table  coimdimp_stn add rct_canale_fumo_idoneo    varchar(1);
alter table  coimdimp_stn add rct_sistema_reg_temp_amb  varchar(1);
alter table  coimdimp_stn add rct_assenza_per_comb      varchar(1);
alter table  coimdimp_stn add rct_idonea_tenuta         varchar(1);
alter table  coimdimp_stn add rct_scambiatore_lato_fumi varchar(1);
alter table  coimdimp_stn add rct_riflussi_comb         varchar(1);
alter table  coimdimp_stn add rct_uni_10389             varchar(1);
alter table  coimdimp_stn add rct_rend_min_legge        numeric(10,2);
alter table  coimdimp_stn add rct_check_list_1          varchar(1);
alter table  coimdimp_stn add rct_check_list_2          varchar(1);
alter table  coimdimp_stn add rct_check_list_3          varchar(1);
alter table  coimdimp_stn add rct_check_list_4          varchar(1);
alter table  coimdimp_stn add rct_gruppo_termico        varchar(2);
alter table  coimdimp_stn add rct_valv_sicurezza        varchar(1);
alter table  coimdimp_stn add fr_linee_ele              varchar(1); --1
alter table  coimdimp_stn add fr_coibentazione          varchar(1); --2
alter table  coimdimp_stn add fr_assorb_recupero        varchar(1); --3
alter table  coimdimp_stn add fr_assorb_fiamma          varchar(1); --4
alter table  coimdimp_stn add fr_ciclo_compressione     varchar(1); --5
alter table  coimdimp_stn add fr_assenza_perdita_ref    varchar(1); --6
alter table  coimdimp_stn add fr_leak_detector          varchar(1); --7
alter table  coimdimp_stn add fr_pres_ril_fughe         varchar(1); --8
alter table  coimdimp_stn add fr_scambiatore_puliti     varchar(1); --9
alter table  coimdimp_stn add fr_prova_modalita         varchar(1); --10
alter table  coimdimp_stn add fr_surrisc                numeric(10,2); --11
alter table  coimdimp_stn add fr_sottoraff              numeric(10,2); --12
alter table  coimdimp_stn add fr_tcondens               numeric(10,2); --13
alter table  coimdimp_stn add fr_tevapor                numeric(10,2); --14
alter table  coimdimp_stn add fr_t_ing_lato_est         numeric(10,2); --15
alter table  coimdimp_stn add fr_t_usc_lato_est         numeric(10,2); --16
alter table  coimdimp_stn add fr_t_ing_lato_ute         numeric(10,2); --17
alter table  coimdimp_stn add fr_t_usc_lato_ute         numeric(10,2); --18
alter table  coimdimp_stn add fr_nr_circuito            numeric(10,0); --19
alter table  coimdimp_stn add fr_check_list_1           varchar(1); --20
alter table  coimdimp_stn add fr_check_list_2           varchar(1); --21
alter table  coimdimp_stn add fr_check_list_3           varchar(1);  --22
alter table  coimdimp_stn add fr_check_list_4           varchar(1); --23 
alter table  coimdimp_stn add rct_lib_uso_man_comp      varchar(1);
alter table  coimdimp_stn add rct_modulo_termico        varchar(08);
alter table  coimdimp_stn add dam_tipo_manutenzione     char(1); -- M=Manutenzione programmata, N=Nuova installazione/ristrutturazione, R=Riattivazione impianto/generatore
alter table  coimdimp_stn add dam_flag_osservazioni     boolean not null default 'f';
alter table  coimdimp_stn add dam_flag_raccomandazioni  boolean not null default 'f';
alter table  coimdimp_stn add dam_flag_prescrizioni     boolean not null default 'f';
alter table  coimdimp_stn add dam_cognome_dichiarante   varchar(100);
alter table  coimdimp_stn add dam_nome_dichiarante      varchar(100);
alter table  coimdimp_stn add dam_tipo_tecnico          char(01);  -- In qualita di A=Affidatario della manutenzione, T=Terzo
alter table  coimdimp_stn alter column riferimento_pag type varchar(100);

alter table coimdimp drop column dam_manutenzione; -- Documentato in una upgrade ma non nella tabella e non presente su iter-dev e sempre null per la regione Marche e non usato dai programmi
alter table coimdimp drop column dam_note;         -- Documentato in una upgrade ma non nella tabella e non presente su iter-dev e sempre null per la regione Marche e non usato dai programmi

insert
  into coimfunz
     ( nome_funz
     , desc_funz
     , tipo_funz
     , dett_funz
     , azione
     )
values
     ( 'transactions'
     , 'Filtro movimenti portafoglio'
     , 'primario'
     , 'transactions-filter'
     , 'src/'
     );

insert
  into coimfunz
     ( nome_funz
     , desc_funz
     , tipo_funz
     , dett_funz
     , azione
     )
values
     ( 'transactions'
     , 'Lista movimenti portafoglio'
     , 'secondario'
     , 'transactions'
     , 'src/'
     );

insert
  into coimfunz
     ( nome_funz
     , desc_funz
     , tipo_funz
     , dett_funz
     , azione
     )
values
     ( 'transactions'
     , 'Inserimento movimenti portafoglio'
     , 'secondario'
     , 'transactions-gest'
     , 'src/'
     );

insert
  into coimfunz
     ( nome_funz
     , desc_funz
     , tipo_funz
     , dett_funz
     , azione
     )
values
     ( 'transactions'
     , 'Storno movimenti portafoglio'
     , 'secondario'
     , 'storno'
     , 'src/'
     );

insert
  into coimfunz
     ( nome_funz
     , desc_funz
     , tipo_funz
     , dett_funz
     , azione
     )
values
     ( 'transactions'
     , 'Storno movimenti portafoglio'
     , 'secondario'
     , 'storno-2'
     , 'src/'
     );

insert
  into coimfunz
     ( nome_funz
     , desc_funz
     , tipo_funz
     , dett_funz
     , azione
     )
values
     ( 'manutentori'
     , 'Elenco movimenti di portafoglio'
     , 'secondario'
     , 'ec'
     , 'src/'
     );


insert
  into coimfunz
     ( nome_funz
     , desc_funz
     , tipo_funz
     , dett_funz
     , azione
     )
values
     ( 'ec'
     , 'Lista movimenti portafoglio per utenti manutentori'
     , 'primario'
     , 'ec-manu'
     , 'src/'
     );

insert
  into coimfunz
     ( nome_funz
     , desc_funz
     , tipo_funz
     , dett_funz
     , azione
     )
values
     ( 'ec'
     , 'Lista movimenti portafoglio per utenti manutentori'
     , 'secondario'
     , 'ec'
     , 'src/'
     );

insert
  into coimogge
     ( livello, scelta_1, scelta_2, scelta_3, scelta_4, tipo      , descrizione      , nome_funz)
values
     ( 2      , 17      , 33      , 0       , 0       , 'funzione', 'Lista Movimenti','transactions');

insert
  into coimogge
     ( livello, scelta_1, scelta_2, scelta_3, scelta_4, tipo      , descrizione      , nome_funz)
values
     ( 2      , 23      , 61      , 0       , 0       , 'funzione', 'Lista Movimenti','ec');

--La tipologia Lottomatica deve diventare Bollino virtuale.
update coimtp_pag
   set descrizione  = 'Bollino virtuale'
 where cod_tipo_pag = 'LM';

end;
