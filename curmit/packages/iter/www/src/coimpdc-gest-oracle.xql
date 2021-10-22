<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


    <partialquery name="sel_aimp_vie">
       <querytext>
      select a.cod_impianto
           , a.numero
           , c.denominazione       as comune
           , nvl(d.descr_topo,'')||' '||
             nvl(d.descrizione,'')||
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
           , nvl(b.cognome,' ')||' '||nvl(b.nome,' ')   as resp
           , b.cognome 
           , b.nome 
           , b.cod_fiscale   as cod_fiscale
        from coimaimp a
           , coimcitt b
           , coimcomu c
	   , coimviae d
           , coimimst f
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
         and c.cod_comune    (+) = a.cod_comune
         and d.cod_comune    (+) = a.cod_comune	
         and d.cod_via       (+) = a.cod_via
         and a.cod_impianto      = :cod_impianto
         and f.cod_imst          = a.stato
 $ordinamento
       </querytext>
    </partialquery>


    <partialquery name="sel_aimp_no_vie">
       <querytext>
      select a.cod_impianto
           , a.numero
           , c.denominazione       as comune
           , nvl(a.toponimo,'')||' '||
             nvl(a.indirizzo,'')||
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
           , nvl(b.cognome,' ')||' '||nvl(b.nome,' ')   as resp
           , b.cognome 
           , b.nome 
        from coimaimp a
           , coimcitt b
           , coimcomu c 
           , coimimst f
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
         and c.cod_comune    (+) = a.cod_comune
         and a.cod_impianto      = :cod_impianto
         and f.cod_imst          = a.stato
    $ordinamento

       </querytext>
    </partialquery>

    <partialquery name="upd_aimp">
       <querytext>
          update coimaimp
	     set stato = 'L'
           where cod_impianto = :cod_impianto
       </querytext>
    </partialquery>

    <fullquery name="sel_cimp_cod_new">
        <querytext>
	  select coimcimp_s.nextval as cod_cimp_new
            from dual
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
                 , sysdate
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
                 , sysdate
                 , null
                 , :id_utente
               from coimcoma
             where cod_impianto = :cod_impianto)
       </querytext>
    </partialquery>

    <fullquery name="sel_dimp_cod_new">
        <querytext>
	  select coimdimp_s.nextval as cod_dimp_new
            from dual
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
         (select coimdocu_s.nextval
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
               , sysdate
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
                   , sysdate
                   , null
                   , :id_utente 
                   , gen_prog_est
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
             and stato not in (5, 8)
       </querytext>
    </partialquery>

    <partialquery name="ins_inco">
       <querytext>
          insert
            into coiminco
         (select coiminco_s.nextval
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
               , sysdate
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
              (select coimmovi_s.nextval
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
                    , sysdate
                    , null
                 from coimmovi 
                where cod_impianto = :destinazione)
       </querytext>
    </partialquery>

    <partialquery name="ins_prvv">
       <querytext>
          insert into coimprvv
               (select coimprvv_s.nextval
                     , causale
                     , :cod_impianto_new
                     , data_provv
                     , cod_documento
                     , nota
                     , :id_utente
                     , sysdate
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
                    , sysdate
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
                   , sysdate
                   , null
                   , :id_utente 
                from coimstub
               where cod_impianto = :destinazione)
       </querytext>
    </partialquery>


    <partialquery name="ins_todo">
       <querytext>
          insert into coimtodo
               (select coimtodo_s.nextval
                     , :cod_impianto_new
                     , tipologia
                     , note
                     , cod_cimp_dimp
                     , flag_evasione
                     , data_evasione
                     , data_evento
                     , data_scadenza
                     , sysdate
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
	  select coimaimp_s.nextval as cod_impianto_new
            from dual
        </querytext>
    </fullquery>

    <fullquery name="get_cod_impianto_est">
       <querytext>
           select coimaimp_est_s.nextval as cod_impianto_est_new
             from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_aimp">
       <querytext>
        insert into coimaimp 
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
                 , cod_amag
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
                 , sysdate
                 , data_mod
                 , :id_utente
                 , flag_dpr412
                 , cod_impianto_dest  
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
