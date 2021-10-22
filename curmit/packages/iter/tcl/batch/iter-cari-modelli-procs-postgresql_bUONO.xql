<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="iter_cari_modelli.sel_tari_contributo">
        <querytext>
	select a.importo as importo_contr
          from coimtari a
         where a.cod_potenza = :cod_potenza_tari
           and a.tipo_costo  = '7' 
           and a.cod_listino = '0'
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_modelli.sel_cod_potenza">
        <querytext>
	select cod_potenza as cod_potenza_tari
          from coimpote
         where :pot_focolare_nom_check between potenza_min and potenza_max
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_modelli.sel_dimp_check_data_controllo">
       <querytext>
       select '1' 
         from coimdimp
        where cod_impianto   = :cod_impianto_catasto
          and data_controllo = :data_controllo
         limit 1
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_modelli.sel_dual_cod_citt">
       <querytext>
          select nextval('coimcitt_s') as cod_citt
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_modelli.ins_citt">
       <querytext>
           insert into coimcitt
	                ( cod_cittadino
			, nome
			, cognome
			, indirizzo
			, comune
			, provincia
			, natura_giuridica
			, data_ins
			, utente
                        , cap
                        , cod_fiscale
                        , telefono
			)
		 values ( :cod_citt
			, :nome_citt_chk
			, :cognome_citt_chk
			, :indirizzo_citt_chk
			, :comune_citt_chk
			, :provincia_citt_chk
			, :natura_citt_chk
			, :data_corrente
			, :id_utente
                        , :cap_chk
                        , :cod_fiscale_chk
                        , :telefono_chk
			)
       </querytext>
    </fullquery>


    <fullquery name="iter_cari_modelli.sel_dual_cod_impianto">
       <querytext>
                   select nextval('coimaimp_s') as cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_modelli.sel_dual_cod_impianto_est">
       <querytext>
                   select nextval('coimaimp_est_s') as cod_impianto_est
       </querytext>
    </fullquery>


    <fullquery name="iter_cari_modelli.ins_aimp">
       <querytext>
                   insert
                     into coimaimp 
                        ( cod_impianto
                        , cod_impianto_est
                        , potenza
                        , potenza_utile
                        , stato
                        , flag_dichiarato
                        , data_prima_dich
                        , data_ultim_dich
                        , data_scad_dich
                        , consumo_annuo
                        , stato_conformita
                        , cod_responsabile
                        , flag_resp
                        , cod_intestatario
                        , cod_proprietario
                        , cod_occupante
                        , cod_amministratore
                        , cod_manutentore
                        , cod_via
                        , toponimo
                        , indirizzo
                        , numero
			, esponente
                        , scala
                        , piano
                        , interno
                        , palazzo
                        , cod_comune
                        , cod_provincia
                        , cap
                        , data_ins
                        , utente_ins
			, volimetria_risc
			, cod_combustibile
			, flag_dpr412
			, data_installaz
                        , n_generatori
                        , provenienza_dati
                        , data_rottamaz
                        , cod_tpim
                        , cod_potenza
			)
                   values 
                        (:cod_impianto
                        ,:cod_impianto_est
                        ,:potenza_foc_nom
                        ,:potenza_utile_nom
                        ,:stato
                        ,'S'
                        ,:data_controllo
                        ,:data_controllo
                        ,:data_scadenza
                        ,:consumo_annuo
                        ,'S'
                        ,:cod_responsabile
                        ,:flag_responsabile
                        ,:cod_intestatario
                        ,:cod_proprietario
                        ,:cod_occupante
                        ,:cod_amministratore
                        ,:cod_manutentore
                        ,:cod_via
                        ,:toponimo
                        ,:indirizzo
                        ,:civico
                        ,:esponente
                        ,:scala
                        ,:piano
                        ,substring(:interno,1,3)
                        ,:palazzo
                        ,:cod_comune
                        ,:cod_prov
                        ,:cap_occu
                        ,:data_corrente
                        ,:id_utente
			,:volimetria_risc
			,:cod_comb
			, 'S'
			,:data_installazione_aimp
                        ,'1'
                        ,'7'
                        ,:data_rottamaz
                        ,:cod_tpim
                        ,:cod_potenza
                        )
       </querytext>
    </fullquery>



    <fullquery name="iter_cari_modelli.ins_gend">
       <querytext>
                   insert
                     into coimgend
                        ( cod_impianto
                        , gen_prog
                        , matricola
                        , modello
                        , cod_combustibile
                        , pot_focolare_nom
                        , pot_utile_nom
                        , data_ins
                        , utente_ins
			, gen_prog_est
			, tiraggio
			, mod_funz
			, cod_emissione
			, data_costruz_gen
			, marc_effic_energ
			, cod_utgi
			, tipo_foco
			, locale
                        , cod_cost
                        , data_installaz
                        , data_rottamaz
                        , flag_attivo
			)
                   values 
                        (:cod_impianto
                        ,:gen_prog
                        ,:matricola
                        ,:modello
                        ,:cod_comb
                        ,:potenza_foc_nom
                        ,:potenza_utile_nom
			,:data_corrente
                        ,:id_utente
                        ,:gen_prog
			,:tiraggio_gend
			,:fluido_termovettore_gend
			,:scarico_fumi_gend
			,:data_costruzione_gend
			,:marc_effic_energ
			,:cod_utgi
			,:tipo_foco
			,:locale
                        ,:cod_cost
                        ,:data_installaz
                        ,:data_rottamaz_gen
                        ,:flag_attivo
                        )
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_modelli.upd_gend">
       <querytext>
                   update coimgend
                      set matricola           = :matricola
                        , modello             = :modello
                        , cod_combustibile    = :cod_comb
                        , pot_focolare_nom    = :potenza_foc_nom
                        , pot_utile_nom       = :potenza_utile_nom
			, data_mod            = :data_corrente
                        , utente              = :id_utente
			, tiraggio            = :tiraggio_gend
			, mod_funz            = :fluido_termovettore_gend
			, cod_emissione       = :scarico_fumi_gend
			, data_costruz_gen    = :data_costruzione_gend
			, marc_effic_energ    = :marc_effic_energ
			, cod_utgi            = :cod_utgi
			, tipo_foco           = :tipo_foco
			, locale              = :locale
                        , cod_cost            = :cod_cost
                        , data_installaz      = :data_installaz
                        , data_rottamaz       = :data_rottamaz_gen
                        , flag_attivo         = :flag_attivo
                    where cod_impianto = :cod_impianto
                      and gen_prog     = :gen_prog
       </querytext>
    </fullquery>


    <fullquery name="iter_cari_modelli.upd_aimp">
       <querytext>
	update coimaimp
	    set stato_conformita = 'S'
              , cod_manutentore    = :cod_manutentore
              , data_ultim_dich    = :data_controllo 
	      , data_scad_dich     = :data_scadenza
              , flag_resp          = :flag_responsabile
              , cod_responsabile   = :cod_responsabile
              , cod_proprietario   = :cod_proprietario
              , cod_occupante      = :cod_occupante
              , cod_intestatario   = :cod_intestatario
              , cod_amministratore = :cod_amministratore
              , potenza            = :tot_potenza_aimp
              , potenza_utile      = :tot_potenza_utile_aimp
              , cod_combustibile   = :cod_comb
              , volimetria_risc    = :volimetria_risc
	where cod_impianto  = :cod_impianto_catasto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_modelli.upd_gen_rott">
       <querytext>
	update coimgend
	    set flag_attivo = 'N'
              , data_rottamazione = :data_rottamaz_gen
	where cod_impianto  = :cod_impianto_catasto
	  and gen_prog = :gen_prog_catasto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_modelli.ins_dimp">
       <querytext>
                insert
                  into coimdimp 
                     ( cod_dimp
                     , cod_impianto
                     , data_controllo
                     , gen_prog
                     , cod_manutentore
                     , cod_responsabile
                     , cod_proprietario
                     , cod_occupante
                     , flag_status
                     , lib_impianto
                     , lib_uso_man
                     , inst_in_out
                     , idoneita_locale
                     , ap_ventilaz
                     , ap_vent_ostruz
                     , conservazione
                     , pulizia_ugelli
                     , scambiatore
                     , accens_reg
                     , disp_comando
                     , ass_perdite
                     , vaso_esp
                     , disp_sic_manom
                     , organi_integri
                     , assenza_fughe
                     , coibentazione
                     , cont_rend
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
                     , utente_ins
                     , data_ins
                     , num_bollo
                     , costo
                     , tipologia_costo
                     , riferimento_pag
                     , potenza
                     , flag_tracciato
                     , tiraggio
                     , ora_inizio
                     , ora_fine
		     , rapp_contr
                     , certificaz
                     , libretto_bruc
                     , prev_incendi
                     , ispesl
                     , data_scadenza
                     , num_autocert
                     , esame_vis_l_elet
                     , funz_corr_bruc
                     , volimetria_risc
                     , consumo_annuo
		     , sezioni
		     , curve
		     , lunghezza
                     , scar_can_fu
                     , scar_ca_si
                     , scar_parete
                     , cod_opmanu_new
                     , consumo_annuo2
                     , stagione_risc
                     , stagione_risc2
                     , conformita
                     , pendenza
                     , riflussi_locale
                     , assenza_perdite
                     , antivento
                     , valvola_sicur
                     , circ_aria
                     , guarn_accop
                     , eff_evac_fum
                     , tariffa
                     , importo_tariffa
                     )
                values 
                     (:cod_dimp
                     ,:cod_impianto
                     ,:data_controllo
                     ,:gen_prog
                     ,:cod_manutentore
                     ,:cod_responsabile
                     ,:cod_proprietario
                     ,:cod_occupante
                     ,:flag_status
                     ,:lib_impianto
                     ,:lib_uso_man
                     ,:inst_in_out
                     ,:idoneita_locale
                     ,:ap_ventilaz
                     ,:ap_vent_ostruz
                     ,:conservazione
                     ,:pulizia_ugelli
                     ,:scambiatore
                     ,:accens_reg
                     ,:disp_comando
                     ,:ass_perdite
                     ,:vaso_esp
                     ,:disp_sic_manom
                     ,:organi_integri
                     ,:assenza_fughe
                     ,:coibentazione
                     ,:cont_rend
                     ,:temp_fumi
                     ,:temp_ambi
                     ,:o2
                     ,:co2
                     ,:bacharach
                     ,:co
                     ,:rend_combust
                     ,:osservazioni
                     ,:raccomandazioni
                     ,:prescrizioni
                     ,:data_utile_inter
                     ,:n_prot
                     ,:data_prot
                     ,:delega_resp
                     ,:delega_manut
                     ,:id_utente
                     ,current_date
                     ,:num_bollo
                     ,:costo
                     ,upper(:tipologia_costo)
                     ,:riferimento_pag
		     ,:potenza_utile_nom
                     ,upper(:flag_tracciato)
                     ,:tiraggio
                     ,:ora_inizio
                     ,:ora_fine
                     ,:rapp_contr
                     ,:certificaz
                     ,:libretto_bruc
                     ,:prev_incendi
                     ,:ispesl
                     ,:data_scadenza
                     ,:num_autocert
                     ,:esame_vis_l_elet
                     ,:funz_corr_bruc
                     ,:volimetria_risc
                     ,:consumo_annuo
		     ,:sezioni
		     ,:curve
		     ,:lunghezza
                     ,:scar_can_fu
                     ,:scar_ca_si
                     ,:scar_parete
                     ,:cod_opmanu
                     ,:consumo_annuo2
                     ,:stagione_risc
                     ,:stagione_risc2
                     ,:conformita
                     ,:pendenza
                     ,:riflussi_locale
                     ,:assenza_perdite
                     ,:antivento
                     ,:valvola_sicur
                     ,:circ_aria
                     ,:guarn_accop
                     ,:eff_evac_fum
                     ,:tariffa_reg
                     ,:importo_contr
                     )
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_modelli.sel_dual_cod_dimp">
       <querytext>
        select nextval('coimdimp_s') as cod_dimp
       </querytext>
    </fullquery>

    <partialquery name="iter_cari_modelli.ins_anomalie_di_merda">
       <querytext>
                insert
                  into coimanom 
                     ( cod_cimp_dimp
                     , prog_anom
                     , tipo_anom
                     , cod_tanom
		     , flag_origine)
                values 
                     (:cod_dimp
                     ,:prog_anom
                     ,'1'
                     ,:anomalia
		     ,'MH')
       </querytext>
    </partialquery>

    <partialquery name="iter_cari_modelli.ins_trans">
       <querytext>
                insert
                  into coimtrans_manu
                     ( id_transazione
                     , cod_dimp
                     , num_gen
                     , rimborso_reg
                     , costo_bollino
                     , azione
                     , data_ora
                     , utente)
                values
                     (nextval('coimtrans_manu_s')
                     ,:cod_dimp
                     ,:gen_prog
                     ,:importo_contr
                     ,:costo
                     ,:azione
                     ,current_timestamp
                     ,:id_utente)
       </querytext>
    </partialquery>

</queryset>
