<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_aimp_vie">
       <querytext>
           select a.cod_impianto
                , a.numero
                , c.denominazione       as comune
                , coalesce(d.descr_topo,'')||' '||
                  coalesce(d.descrizione,'')||
                  case
                    when a.numero is null then ''
                    else ', '||a.numero
                  end ||
                  case
                    when a.esponente is null then ''
                    else '/'||a.esponente
                  end ||
                  case
                    when a.scala is null then ''
                    else ' S.'||a.scala
                  end ||
                  case
                    when a.piano is null then ''
                    else ' P.'||a.piano
                  end ||
                  case
                    when a.interno is null then ''
                    else ' In.'||a.interno
                  end
                                        as indir
                , d.descrizione as via
                , f.descr_imst as stato
		, a.stato
                , coalesce(b.cognome,' ')||' '||coalesce(b.nome,' ')   as resp
                , b.cognome 
                , b.nome
             from coimimst f
                , coimaimp a
   $citt_join_pos coimcitt b on b.cod_cittadino = a.cod_responsabile
  left outer join coimcomu c on c.cod_comune    = a.cod_comune
  left outer join coimviae d on d.cod_comune    = a.cod_comune	
              and d.cod_via       = a.cod_via
            where a.cod_impianto = :cod_impianto
              and f.cod_imst     = a.stato
           $ordinamento
       </querytext>
    </fullquery>


    <fullquery name="sel_aimp_no_vie">
       <querytext>
           select a.cod_impianto
                , a.numero
                , c.denominazione       as comune
                , coalesce(a.toponimo,'')||' '||
                  coalesce(a.indirizzo,'')||
                  case
                    when a.numero is null then ''
                    else ', '||a.numero
                  end ||
                  case
                    when a.esponente is null then ''
                    else '/'||a.esponente
                  end ||
                  case
                    when a.scala is null then ''
                    else ' S.'||a.scala
                  end ||
                  case
                    when a.piano is null then ''
                    else ' P.'||a.piano
                  end ||
                  case
                    when a.interno is null then ''
                    else ' In.'||a.interno
                  end
                              as indir
                , a.indirizzo as via
                , f.descr_imst as stato
                , coalesce(b.cognome)||' '||coalesce(b.nome,' ')   as resp
                , b.cognome 
                , b.nome 

             from coimimst f
                , coimaimp a
   $citt_join_pos coimcitt b on b.cod_cittadino = a.cod_responsabile
  left outer join coimcomu c on c.cod_comune    = a.cod_comune
            where a.cod_impianto = :cod_impianto
              and f.cod_imst     = a.stato
           $ordinamento
       </querytext>
    </fullquery>

    <partialquery name="upd_aimp">
       <querytext>
          update coimaimp
	     set stato = 'L'
           where cod_impianto = :cod_impianto
       </querytext>
    </partialquery>

    <fullquery name="sel_cimp_cod_new">
        <querytext>
	  select nextval('coimcimp_s') as cod_cimp_new
        </querytext>
    </fullquery>

    <partialquery name="ins_cimp">
       <querytext>
        insert into coimcimp 
          (select :cod_cimp_new
                 ,:cod_impianto_new
                 , cod_documento
                 , gen_prog
                 , cod_inco
                 , data_controllo
                 , verb_n
                 , data_verb
                 , cod_opve
                 , costo
                 , nominativo_pres
                 , presenza_libretto
                 , libretto_corretto
                 , dich_conformita
                 , libretto_manutenz
                 , mis_port_combust
                 , mis_pot_focolare
                 , stato_coiben
                 , stato_canna_fum
                 , verifica_dispo
                 , verifica_areaz
                 , taratura_dispos
                 , co_fumi_secchi
                 , ppm
                 , eccesso_aria_perc
                 , perdita_ai_fumi
                 , rend_comb_conv
                 , rend_comb_min
                 , temp_fumi_1a
                 , temp_fumi_2a
                 , temp_fumi_3a
                 , temp_fumi_md
                 , t_aria_comb_1a
                 , t_aria_comb_2a
                 , t_aria_comb_3a
                 , t_aria_comb_md
                 , temp_mant_1a
                 , temp_mant_2a
                 , temp_mant_3a
                 , temp_mant_md
                 , temp_h2o_out_1a
                 , temp_h2o_out_2a
                 , temp_h2o_out_3a
                 , temp_h2o_out_md
                 , co2_1a
                 , co2_2a
                 , co2_3a
                 , co2_md
                 , o2_1a
                 , o2_2a
                 , o2_3a
                 , o2_md
                 , co_1a
                 , co_2a
                 , co_3a
                 , co_md
                 , indic_fumosita_1a
                 , indic_fumosita_2a
                 , indic_fumosita_3a
                 , indic_fumosita_md
                 , manutenzione_8a
                 , co_fumi_secchi_8b
                 , indic_fumosita_8c
                 , rend_comb_8d
                 , esito_verifica
                 , strumento
                 , note_verificatore
                 , note_resp
                 , note_conf
                 , tipologia_costo
                 , riferimento_pag
                 , :id_utente
                 , current_date
                 , null
                 , pot_utile_nom
                 , pot_focolare_nom
                 , cod_combustibile
                 , cod_responsabile
                 , flag_cpi
                 , flag_ispes
                 , flag_pericolosita
                 , flag_tracciato
                 , new1_data_dimp
                 , new1_data_paga_dimp
                 , new1_conf_locale
                 , new1_conf_accesso
                 , new1_pres_intercet
                 , new1_pres_interrut
                 , new1_asse_mate_estr
                 , new1_pres_mezzi
                 , new1_pres_cartell
                 , new1_disp_regolaz
                 , new1_foro_presente
                 , new1_foro_corretto
                 , new1_foro_accessibile
                 , new1_canali_a_norma
                 , new1_lavoro_nom_iniz
                 , new1_lavoro_nom_fine
                 , new1_lavoro_lib_iniz
                 , new1_lavoro_lib_fine
                 , new1_note_manu
                 , new1_dimp_pres
                 , new1_dimp_prescriz
                 , new1_data_ultima_manu
                 , new1_data_ultima_anal
                 , new1_manu_prec_8a
                 , new1_co_rilevato
                 , new1_flag_peri_8p
                 , flag_uso
                 , flag_diffida
                 , eccesso_aria_perc_2a
                 , eccesso_aria_perc_3a
                 , eccesso_aria_perc_md
                 , n_prot
                 , data_prot
                 , sezioni_corr
                 , curve_corr
                 , lungh_corr
                 , riflussi_loc
                 , perdite_cond
                 , disp_funz
                 , assenza_fughe
                 , effic_evac
                 , autodich
                 , dich_conf
                 , manut_prog
                 , marca_strum
                 , modello_strum
                 , matr_strum
                 , dt_tar_strum
                 , indice_aria
                 , perd_cal_sens
                 , doc_ispesl
                 , doc_prev_incendi
                 , libr_manut_bruc
                 , ubic_locale_norma
                 , disp_chius_porta
                 , spazi_norma
                 , apert_soffitto
                 , rubin_manuale_acces
                 , assenza_app_peric
                 , rubin_chiuso
                 , elettrovalv_esterne
                 , tubaz_press
                 , tolta_tensione
                 , termost_esterno
                 , chiusura_foro
                 , accens_funz_gen
                 , pendenza
                 , ventilaz_lib_ostruz
                 , disp_reg_cont_pre
                 , disp_reg_cont_funz
                 , disp_reg_clim_funz
                 , conf_imp_elettrico
                 , volumetria
                 , comsumi_ultima_stag
                 , ora_inizio
                 , ora_fine
              from coimcimp
             where cod_impianto = :cod_impianto
               and cod_cimp     = :cod_cimp)
       </querytext>
    </partialquery>

    <partialquery name="ins_coma">
       <querytext>
       insert into coimcoma 
          (select :cod_impianto_new
                 , cod_manutentore
                 , data_ini_valid
                 , data_fin_valid
                 , note
                 , current_date
                 , null
                 , :id_utente
               from coimcoma
             where cod_impianto = :cod_impianto)
       </querytext>
    </partialquery>

    <fullquery name="sel_dimp_cod_new">
        <querytext>
	  select nextval('coimdimp_s') as cod_dimp_new
        </querytext>
    </fullquery>

    <partialquery name="ins_dimp">
       <querytext>
          insert into coimdimp 
           (select :cod_dimp_new
                  ,:cod_impianto_new
                  , data_controllo
                  , gen_prog
                  , cod_manutentore
                  , cod_responsabile
                  , cod_proprietario
                  , cod_occupante
                  , cod_documento
                  , flag_status
                  , garanzia
                  , conformita
                  , lib_impianto
                  , lib_uso_man
                  , inst_in_out
                  , idoneita_locale
                  , ap_ventilaz
                  , ap_vent_ostruz
                  , pendenza
                  , sezioni
                  , curve
                  , lunghezza
                  , conservazione
                  , scar_ca_si
                  , scar_parete
                  , riflussi_locale
                  , assenza_perdite
                  , pulizia_ugelli
                  , antivento
                  , scambiatore
                  , accens_reg
                  , disp_comando
                  , ass_perdite
                  , valvola_sicur
                  , vaso_esp
                  , disp_sic_manom
                  , organi_integri
                  , circ_aria
                  , guarn_accop
                  , assenza_fughe
                  , coibentazione
                  , eff_evac_fum
                  , cont_rend
                  , pot_focolare_mis
                  , portata_comb_mis
                  , temp_fumi
                  , temp_ambi
                  , o2
                  , co2
                  , bacharach
                  , co
                  , rend_combust
                  , osservazioni
                  , raccomandazioni
                  , prescrizioni
                  , data_utile_inter
                  , n_prot
                  , data_prot
                  , delega_resp
                  , delega_manut
                  , num_bollo
                  , costo
                  , tipologia_costo
                  , riferimento_pag
                  , utente
                  , data_ins
                  , data_mod
                  , potenza
                  , flag_pericolosita
                  , flag_co_perc
                  , flag_tracciato
                  , cod_docu_distinta
                  , scar_can_fu
                  , tiraggio
                  , ora_inizio
                  , ora_fine
                  , rapp_contr
                  , rapp_contr_note
                  , certificaz
                  , certificaz_note
                  , dich_conf
                  , dich_conf_note
                  , libretto_bruc
                  , libretto_bruc_note
                  , prev_incendi
                  , prev_incendi_note
                  , lib_impianto_note
                  , ispesl
                  , ispesl_note
                  , data_scadenza
                  , num_autocert
                  , esame_vis_l_elet
                  , funz_corr_bruc
                  , lib_uso_man_note
                  , volimetria_risc
                  , consumo_annuo
                  , cod_opmanu
                  , utente_ins
                  , data_arrivo_ente
                  , fl_firma_tecnico
                  , fl_firma_resp
                  , igni_progressivo
                  , cod_opmanu_new
                  , consumo_annuo2
                  , stagione_risc
                  , stagione_risc2
                  , schemi_funz_idr
                  , schemi_funz_ele
                  , schemi_funz_idr_note
                  , schemi_funz_ele_note
              from coimdimp
             where cod_impianto = :cod_impianto
               and cod_dimp     = :cod_dimp)
       </querytext>
    </partialquery>

    <partialquery name="ins_anom">
       <querytext>
         insert into coimanom 
           (select :cod_cimp_dimp_new
                 , prog_anom
                 , tipo_anom
                 , cod_tanom
                 , dat_utile_inter
                 , flag_origine
              from coimanom
             where cod_cimp_dimp = :cod_cimp_dimp)
       </querytext>
    </partialquery>

    <partialquery name="ins_docu">
       <querytext>
       insert into coimdocu 
         (select nextval('coimdocu_s') as cod_documento
               , tipo_documento
               , tipo_soggetto
               , cod_soggetto
               , :cod_impianto_new
               , data_stampa
               , data_documento
               , data_prot_01
               , protocollo_01
               , data_prot_02
               , protocollo_02
               , flag_notifica
               , data_notifica
               , contenuto
               , tipo_contenuto
               , descrizione
               , note
               , current_date
               , null
               , :id_utente
            from coimdocu
           where cod_impianto = :cod_impianto)
       </querytext>
    </partialquery>


    <partialquery name="upd_gage">
       <querytext>
             update coimgage
                set cod_impianto = :cod_impianto_new
              where cod_impianto = :destinazione
       </querytext>
    </partialquery>


    <partialquery name="ins_gend">
       <querytext>
          insert into coimgend
                ( cod_impianto
                , gen_prog
                , descrizione
                , matricola
                , modello
                , cod_cost
                , matricola_bruc
                , modello_bruc
                , cod_cost_bruc
                , tipo_foco
                , mod_funz
                , cod_utgi
                , tipo_bruciatore
                , tiraggio
                , locale
                , cod_emissione
                , cod_combustibile
                , data_installaz
                , data_rottamaz
                , pot_focolare_lib
                , pot_utile_lib
                , pot_focolare_nom
                , pot_utile_nom
                , flag_attivo
                , note
                , data_ins
                , data_mod
                , utente 
                , gen_prog_est
                , data_costruz_gen
                , data_costruz_bruc
                , data_installaz_bruc
                , data_rottamaz_bruc
                , marc_effic_energ
                , campo_funzion_min
                , campo_funzion_max
                , dpr_660_96
                , utente_ins
                , igni_progressivo
                , portata_comb
                , portata_termica
                , cod_tpco            -- dpr74
                , cod_flre            -- dpr74
                , carica_refrigerante -- dpr74
                , sigillatura_carica  -- dpr74
		, cod_mode            -- 2014-05-16
		, cod_mode_bruc       -- 2014-05-16
		, cod_grup_term
                )
             (select :cod_impianto_new
                   , gen_prog
                   , descrizione
                   , matricola
                   , modello
                   , cod_cost
                   , matricola_bruc
                   , modello_bruc
                   , cod_cost_bruc
                   , tipo_foco
                   , mod_funz
                   , cod_utgi
                   , tipo_bruciatore
                   , tiraggio
                   , locale
                   , cod_emissione
                   , cod_combustibile
                   , data_installaz
                   , data_rottamaz
                   , pot_focolare_lib
                   , pot_utile_lib
                   , pot_focolare_nom
                   , pot_utile_nom
                   , flag_attivo
                   , note
                   , current_date
                   , null
                   , :id_utente 
                   , gen_prog_est
		   , data_costruz_gen
		   , data_costruz_bruc
		   , data_installaz_bruc
		   , data_rottamaz_bruc
		   , marc_effic_energ   
		   , campo_funzion_min 
		   , campo_funzion_max
		   , dpr_660_96
                   , :id_utente
                   , igni_progressivo
                   , portata_comb
                   , portata_termica
                   , cod_tpco            -- dpr74
                   , cod_flre            -- dpr74
                   , carica_refrigerante -- dpr74
                   , sigillatura_carica  -- dpr74
                   , cod_mode            -- 2014-05-16
                   , cod_mode_bruc       -- 2014-05-16
		   , cod_grup_term
                 from coimgend
               where cod_impianto = :destinazione)
       </querytext>
    </partialquery>

    <partialquery name="upd_inco">
       <querytext>
          update coiminco
	     set stato = '5'
               , note  = 'Incontro annullato in conseguenza a bonifica'
           where cod_impianto = :cod_impianto
             and stato not in ('5', '8')
       </querytext>
    </partialquery>

    <partialquery name="ins_inco">
       <querytext>
          insert
            into coiminco
         (select nextval('coiminco_s') as cod_inco
               , cod_cinc
               , tipo_estrazione
               ,:cod_impianto_new
               , data_estrazione
               , data_assegn
               , cod_opve
               , data_verifica
               , ora_verifica 
               , data_avviso_01
               , cod_documento_01
               , data_avviso_02
               , cod_documento_02
               , stato
               , esito
               , note
               , current_date
               , null
               ,:id_utente
               , tipo_lettera
            from coiminco
           where cod_impianto = :destinazione)
       </querytext>
    </partialquery>

    <partialquery name="ins_movi">
       <querytext>
          insert into coimmovi
              (select nextval('coimmovi_s') as cod_movi
                    , tipo_movi
                    , :cod_impianto_new
                    , data_scad
                    , importo
                    , importo_pag
                    , data_pag
                    , tipo_pag
                    , data_compet
                    , riferimento
                    , nota
                    , :id_utente
                    , current_date
                    , null
                    , flag_pagato
                    , id_caus
                 from coimmovi 
                where cod_impianto = :destinazione)
       </querytext>
    </partialquery>

    <partialquery name="ins_prvv">
       <querytext>
          insert into coimprvv
               (select nextval('coimprvv_s') as cod_prvv
                     , causale
                     , :cod_impianto_new
                     , data_provv
                     , cod_documento
                     , nota
                     , :id_utente
                     , current_date
                     , null   
                  from coimprvv
                 where cod_impianto = :destinazione)
       </querytext>
    </partialquery>

    <partialquery name="ins_rife">
       <querytext>
           insert into coimrife
              (select :cod_impianto_new
                    , ruolo
                    , data_fin_valid
                    , cod_soggetto
                    , current_date
                    , null
                    , :id_utente  
                  from coimrife 
                where cod_impianto = :destinazione)
       </querytext>
    </partialquery>

    <partialquery name="ins_stub">
       <querytext>
          insert into coimstub
             (select :cod_impianto_new
                   , data_fin_valid
                   , cod_ubicazione
                   , localita
                   , cod_via
                   , toponimo 
                   , indirizzo
                   , numero
                   , esponente
                   , scala
                   , piano 
                   , interno
                   , cod_comune
                   , cod_provincia
                   , cap
                   , cod_catasto
                   , cod_tpdu
                   , cod_qua
                   , cod_urb
                   , current_date
                   , null
                   , :id_utente 
                from coimstub
               where cod_impianto = :destinazione)
       </querytext>
    </partialquery>


    <partialquery name="ins_todo">
       <querytext>
          insert into coimtodo
               (select nextval('coimtodo_s') as cod_todo
                     , :cod_impianto_new
                     , tipologia
                     , note
                     , cod_cimp_dimp
                     , flag_evasione
                     , data_evasione
                     , data_evento
                     , data_scadenza
                     , current_date
                     , null
                     , :id_utente
                  from coimtodo
                 where cod_impianto = :cod_impianto)
       </querytext>
    </partialquery>

    <fullquery name="sel_aimp_stato_cod_est">
        <querytext>
              select stato as stato_aimp_destinazione
	           , cod_impianto_est as cod_impianto_est_destinazione
                from coimaimp
	       where cod_impianto = :destinazione
        </querytext>
    </fullquery>

    <fullquery name="sel_aimp_cod">
        <querytext>
	  select nextval('coimaimp_s') as cod_impianto_new
        </querytext>
    </fullquery>

    <fullquery name="get_cod_impianto_est_old">
       <querytext>
           select coalesce('ITER25'||lpad((max(to_number(substr(cod_impianto_est, 7, 14), '99999999999999999990') ) + 1), 14, '0'), 'ITER2500000000000001') as cod_impianto_est_new from coimaimp
       </querytext>
    </fullquery>

    <fullquery name="get_cod_impianto_est">
       <querytext>
          select nextval('coimaimp_est_s') as cod_impianto_est_new
       </querytext>
    </fullquery>

    <fullquery name="sel_dati_codifica">
       <querytext>
           select coalesce(lpad((a.progressivo + 1), 7, '0'), '0000001') as progressivo
                , a.cod_istat
                , b.potenza
                , b.cod_potenza
                , a.cod_comune
             from coimcomu a
                , coimaimp b
            where a.cod_comune = b.cod_comune
              and b.cod_impianto = :destinazione
       </querytext>
    </fullquery>

   <partialquery name="upd_prog_comu">
       <querytext>
                update coimcomu
                   set progressivo = :progressivo
                 where cod_comune  = :cod_comune
       </querytext>
    </partialquery>

    <partialquery name="ins_aimp">
       <querytext>
        insert into coimaimp
                 ( cod_impianto
                 , cod_impianto_est
                 , cod_impianto_prov
                 , descrizione
                 , provenienza_dati
                 , cod_combustibile
                 , cod_potenza
                 , potenza
                 , potenza_utile
                 , data_installaz
                 , data_attivaz
                 , data_rottamaz
                 , note
                 , stato
                 , flag_dichiarato
                 , data_prima_dich
                 , data_ultim_dich
                 , cod_tpim
                 , consumo_annuo
                 , n_generatori
                 , stato_conformita
                 , cod_cted
                 , tariffa
                 , cod_responsabile
                 , flag_resp
                 , cod_intestatario
                 , flag_intestatario
                 , cod_proprietario
                 , cod_occupante
                 , cod_amministratore
                 , cod_manutentore
                 , cod_installatore
                 , cod_distributore
                 , cod_progettista
                 , cod_ubicazione
                 , localita
                 , cod_via
                 , toponimo
                 , indirizzo
                 , numero
                 , esponente
                 , scala
                 , piano
                 , interno
                 , cod_comune
                 , cod_provincia
                 , cap
      -- dpr74   , cod_catasto
                 , foglio        -- dpr74
                 , cod_tpdu
                 , cod_qua
                 , cod_urb
                 , data_ins
                 , data_mod
                 , utente
                 , flag_dpr412
                 , cod_impianto_dest
                 , anno_costruzione
                 , marc_effic_energ
                 , volimetria_risc
                 , gb_x
                 , gb_y
                 , data_scad_dich
                 , flag_coordinate
                 , flag_targa_stampata
                 , cod_impianto_old
                 , portata
                 , palazzo
                 , n_unita_immob
                 , cod_tipo_attivita
                 , adibito_a
                 , utente_ins
                 , igni_progressivo
                 , cod_iterman
                 , circuito_primario
		 , distr_calore
                 , n_scambiatori
                 , potenza_scamb_tot
                 , nome_rete
                 , cod_alim
                 , cod_fdc
                 , note_dest
                 , cop
                 , per
                 , cod_amag
                 , dati_scheda
                 , data_scheda
                 , flag_tipo_impianto -- dpr74
                 , mappale            -- dpr74 
                 , denominatore       -- dpr74
                 , subalterno         -- dpr74
                 , cod_distributore_el            -- fer 270614
                 , pdr                            -- fer 270614
                 , pod                            -- fer 270614
                 , cod_impianto_princ                   
                 , cat_catastale                        
                 , pres_certificazione                  
                 , certificazione                       
                 , tratt_acqua_contenuto                
                 , tratt_acqua_durezza                  
                 , tratt_acqua_clima_tipo               
                 , tratt_acqua_clima_addolc             
                 , tratt_acqua_clima_prot_gelo          
                 , tratt_acqua_clima_prot_gelo_eti      
                 , tratt_acqua_clima_prot_gelo_eti_perc 
                 , tratt_acqua_clima_prot_gelo_pro      
                 , tratt_acqua_clima_prot_gelo_pro_perc 
                 , tratt_acqua_calda_sanit_tipo         
                 , tratt_acqua_calda_sanit_addolc       
                 , tratt_acqua_raff_assente             
                 , tratt_acqua_raff_tipo_circuito       
                 , tratt_acqua_raff_origine             
                 , tratt_acqua_raff_filtraz_flag        
                 , tratt_acqua_raff_filtraz_1           
                 , tratt_acqua_raff_filtraz_2           
                 , tratt_acqua_raff_filtraz_3           
                 , tratt_acqua_raff_filtraz_4           
                 , tratt_acqua_raff_tratt_flag          
                 , tratt_acqua_raff_tratt_1             
                 , tratt_acqua_raff_tratt_2             
                 , tratt_acqua_raff_tratt_3             
                 , tratt_acqua_raff_tratt_4             
                 , tratt_acqua_raff_tratt_5             
                 , tratt_acqua_raff_cond_flag           
                 , tratt_acqua_raff_cond_1              
                 , tratt_acqua_raff_cond_2              
                 , tratt_acqua_raff_cond_3              
                 , tratt_acqua_raff_cond_4              
                 , tratt_acqua_raff_cond_5              
                 , tratt_acqua_raff_cond_6              
                 , tratt_acqua_raff_spurgo_flag         
                 , tratt_acqua_raff_spurgo_cond_ing     
                 , tratt_acqua_raff_spurgo_tara_cond
		 , regol_curva_integrata            
                 , regol_curva_indipendente         
                 , regol_curva_ind_iniz_data_inst   
                 , regol_curva_ind_iniz_data_dism   
                 , regol_curva_ind_iniz_fabbricante 
                 , regol_curva_ind_iniz_modello     
                 , regol_curva_ind_iniz_n_punti_reg 
                 , regol_curva_ind_iniz_n_liv_temp  
                 , regol_valv_regolazione           
                 , regol_valv_ind_iniz_data_inst    
                 , regol_valv_ind_iniz_data_dism    
                 , regol_valv_ind_iniz_fabbricante  
                 , regol_valv_ind_iniz_modello      
                 , regol_valv_ind_iniz_n_vie        
                 , regol_valv_ind_iniz_servo_motore 
                 , regol_sist_multigradino          
                 , regol_sist_inverter              
                 , regol_altri_flag                 
                 , regol_altri_desc_sistema         
                 , regol_cod_tprg                   
                 , regol_valv_termostatiche         
                 , regol_valv_due_vie               
                 , regol_valv_tre_vie               
                 , regol_valv_note                  
                 , regol_telettura                  
                 , regol_telegestione               
                 , regol_desc_sistema_iniz          
                 , regol_data_sost_sistema          
                 , regol_desc_sistema_sost          
                 , contab_si_no                     
                 , contab_tipo_contabiliz           
                 , contab_tipo_sistema              
                 , contab_desc_sistema_iniz         
                 , contab_data_sost_sistema         
                 , contab_desc_sistema_sost
                 )  
          (select :cod_impianto_new
                 , :cod_impianto_est_new
                 , cod_impianto_prov
                 , descrizione
                 , provenienza_dati
                 , cod_combustibile
                 , cod_potenza
                 , potenza
                 , potenza_utile
                 , data_installaz
                 , data_attivaz
                 , data_rottamaz
                 , note
                 , 'A'
                 , flag_dichiarato
                 , data_prima_dich
                 , data_ultim_dich
                 , cod_tpim
                 , consumo_annuo
                 , n_generatori
                 , stato_conformita
                 , cod_cted
                 , tariffa
                 , cod_responsabile
                 , flag_resp
                 , cod_intestatario
                 , flag_intestatario
                 , cod_proprietario
                 , cod_occupante
                 , cod_amministratore
                 , cod_manutentore
                 , cod_installatore
                 , cod_distributore
                 , cod_progettista
                 --, cod_amag
                 , cod_ubicazione
                 , localita
                 , cod_via
                 , toponimo
                 , indirizzo
                 , numero
                 , esponente
                 , scala
                 , piano
                 , interno
                 , cod_comune
                 , cod_provincia
                 , cap
      -- dpr74   , cod_catasto
                 , foglio        -- dpr74
                 , cod_tpdu
                 , cod_qua
                 , cod_urb
                 , current_date
                 , data_mod
                 , :id_utente
                 , flag_dpr412
                 , cod_impianto_dest  
                 , anno_costruzione                     
                 , marc_effic_energ                     
                 , volimetria_risc                      
                 , gb_x                                 
                 , gb_y                                 
                 , data_scad_dich                       
                 , flag_coordinate                      
                 , flag_targa_stampata                  
                 , cod_impianto_old                     
                 , portata                              
                 , palazzo                              
                 , n_unita_immob                        
                 , cod_tipo_attivita                    
                 , adibito_a                            
                 , :id_utente                           
                 , igni_progressivo                     
                 , cod_iterman                          
                 , circuito_primario                    
                 , distr_calore                         
                 , n_scambiatori                        
                 , potenza_scamb_tot                    
                 , nome_rete                            
                 , cod_alim                             
                 , cod_fdc                              
                 , note_dest                            
                 , cop                                  
                 , per                                  
                 , cod_amag                             
                 , dati_scheda                          
                 , data_scheda                          
                 , flag_tipo_impianto                   
                 , mappale                              
                 , denominatore                         
                 , subalterno                           
                 , cod_distributore_el                  
                 , pdr                                  
                 , pod                                  
                 , cod_impianto_princ                   
                 , cat_catastale                        
                 , pres_certificazione                  
                 , certificazione                       
                 , tratt_acqua_contenuto                
                 , tratt_acqua_durezza                  
                 , tratt_acqua_clima_tipo               
                 , tratt_acqua_clima_addolc             
                 , tratt_acqua_clima_prot_gelo          
                 , tratt_acqua_clima_prot_gelo_eti      
                 , tratt_acqua_clima_prot_gelo_eti_perc 
                 , tratt_acqua_clima_prot_gelo_pro      
                 , tratt_acqua_clima_prot_gelo_pro_perc 
                 , tratt_acqua_calda_sanit_tipo         
                 , tratt_acqua_calda_sanit_addolc       
                 , tratt_acqua_raff_assente             
                 , tratt_acqua_raff_tipo_circuito       
                 , tratt_acqua_raff_origine             
                 , tratt_acqua_raff_filtraz_flag        
                 , tratt_acqua_raff_filtraz_1           
                 , tratt_acqua_raff_filtraz_2           
                 , tratt_acqua_raff_filtraz_3           
                 , tratt_acqua_raff_filtraz_4           
                 , tratt_acqua_raff_tratt_flag          
                 , tratt_acqua_raff_tratt_1             
                 , tratt_acqua_raff_tratt_2             
                 , tratt_acqua_raff_tratt_3             
                 , tratt_acqua_raff_tratt_4             
                 , tratt_acqua_raff_tratt_5             
                 , tratt_acqua_raff_cond_flag           
                 , tratt_acqua_raff_cond_1              
                 , tratt_acqua_raff_cond_2              
                 , tratt_acqua_raff_cond_3              
                 , tratt_acqua_raff_cond_4              
                 , tratt_acqua_raff_cond_5              
                 , tratt_acqua_raff_cond_6              
                 , tratt_acqua_raff_spurgo_flag         
                 , tratt_acqua_raff_spurgo_cond_ing     
                 , tratt_acqua_raff_spurgo_tara_cond
		 , regol_curva_integrata            
                 , regol_curva_indipendente         
                 , regol_curva_ind_iniz_data_inst   
                 , regol_curva_ind_iniz_data_dism   
                 , regol_curva_ind_iniz_fabbricante 
                 , regol_curva_ind_iniz_modello     
                 , regol_curva_ind_iniz_n_punti_reg 
                 , regol_curva_ind_iniz_n_liv_temp  
                 , regol_valv_regolazione           
                 , regol_valv_ind_iniz_data_inst    
                 , regol_valv_ind_iniz_data_dism    
                 , regol_valv_ind_iniz_fabbricante  
                 , regol_valv_ind_iniz_modello      
                 , regol_valv_ind_iniz_n_vie        
                 , regol_valv_ind_iniz_servo_motore 
                 , regol_sist_multigradino          
                 , regol_sist_inverter              
                 , regol_altri_flag                 
                 , regol_altri_desc_sistema         
                 , regol_cod_tprg                   
                 , regol_valv_termostatiche         
                 , regol_valv_due_vie               
                 , regol_valv_tre_vie               
                 , regol_valv_note                  
                 , regol_telettura                  
                 , regol_telegestione               
                 , regol_desc_sistema_iniz          
                 , regol_data_sost_sistema          
                 , regol_desc_sistema_sost          
                 , contab_si_no                     
                 , contab_tipo_contabiliz           
                 , contab_tipo_sistema              
                 , contab_desc_sistema_iniz         
                 , contab_data_sost_sistema         
                 , contab_desc_sistema_sost  
              from coimaimp
             where cod_impianto = :destinazione)
          </querytext>
       </partialquery>

    <fullquery name="sel_cimp_cod">
        <querytext>
           select cod_cimp 
             from coimcimp 
            where cod_impianto = :cod_impianto
        </querytext>
    </fullquery>

    <fullquery name="sel_dimp_cod">
        <querytext>
           select cod_dimp 
             from coimdimp 
            where cod_impianto = :cod_impianto
        </querytext>
    </fullquery>

    <fullquery name="sel_aimp_check_cod_est">
        <querytext>
           select '1'
             from coimaimp 
            where cod_impianto_est = :cod_impianto_est_new
        </querytext>
    </fullquery>

    
</queryset>
