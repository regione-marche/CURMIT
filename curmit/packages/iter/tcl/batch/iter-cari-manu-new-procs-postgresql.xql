<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="iter_cari_manu_new.sel_dimp_check_data_controllo">
       <querytext>
       select '1' 
         from coimdimp
        where cod_impianto   = :cod_impianto
          and data_controllo = :data_controllo
         limit 1
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_aimp_check_no_cod">
       <querytext>
                   select 1
                     from coimaimp a
                        , coimgend b
                    where a.cod_impianto = b.cod_impianto
                      and b.matricola = :matricola_chk
                      and b.cod_cost = :cod_cost
		      $where_indirizzo
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_aimp_no_cod">
       <querytext>
                   select cod_impianto_est
                     from coimaimp a
                        , coimgend b
                    where a.cod_impianto = b.cod_impianto
                      and b.matricola = :matricola_chk
                      and b.cod_cost = :cod_cost
		      $where_indirizzo
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_aimp_check_no_cod_count">
       <querytext>
                   select count(*) as conta_impianti
                     from coimaimp a
                        , coimgend b
                    where a.cod_impianto = b.cod_impianto
                      and b.matricola = :matricola_chk
                      and b.cod_cost = :cod_cost
		      $where_indirizzo
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_resp_impianto">
       <querytext>
                   select cod_responsabile as cod_resp_imp
                     from coimaimp
                    where cod_impianto_est = :cod_impianto_est
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_aimp_check">
       <querytext>
                   select cod_impianto_est
                     from coimaimp a
                    where 1 = 1
                     $where_cod
                     $where_comune
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_aimp_gend_check">
       <querytext>
                   select 1
                     from coimaimp a
		     left outer join coimgend g on g.cod_impianto = a.cod_impianto
                    where a.cod_impianto_est = :cod_impianto_est
		      and g.gen_prog         = :gen_prog
		      $where_comune
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_viae_check">
       <querytext>
             select cod_via
	     from coimviae
	     where upper(descr_topo)  = upper(:toponimo_chk)
	       and upper(descrizione) = upper(:indirizzo_chk)
               and cod_via_new is null
	     $where_comune
              limit 1
       </querytext>
    </fullquery>
    
    <fullquery name="iter_cari_manu_new.sel_dual_cod_impianto">
       <querytext>
                   select nextval('coimaimp_s') as cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_dual_cod_impianto_est">
       <querytext>
                   select nextval('coimaimp_est_s') as cod_impianto_est
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_dual_cod_via">
       <querytext>
                   select nextval('coimviae_s') as cod_via
       </querytext>
    </fullquery>

    <fullquery name ="iter_cari_manu_new.ins_viae">
       <querytext>
          insert into coimviae
		      ( cod_via
		      , cod_comune
		      , descrizione
		      ,	descr_topo
		      , descr_estesa
		      ) 
		  values 
		      ( :cod_via
		      , :cod_comune_chk
		      , :indirizzo_chk
		      , :toponimo_chk
		      , :indirizzo_chk
		      )
			      
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_citt_check">
       <querytext>
          select cod_cittadino as cod_citt
	  from coimcitt
	  where upper(cognome) = upper(:cognome_citt_chk)
          $where_nome_chk
          $where_indirizzo_chk
          $where_comune_chk
          $where_provincia_chk
          limit 1
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_dual_cod_citt">
       <querytext>
          select nextval('coimcitt_s') as cod_citt
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.ins_citt">
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
    <fullquery name="iter_cari_manu_new.ins_aimp">
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
                        , consumo_annuo
                        , stato_conformita
                        , cod_responsabile
                        , flag_resp
                        , cod_intestatario
                        , cod_proprietario
                        , cod_occupante
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
                        , cod_iterman
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
                        ,:consumo_annuo
                        ,:conformita
                        ,:cod_responsabile
                        ,:flag_resp
                        ,:cod_intestatario
                        ,:cod_proprietario
                        ,:cod_occupante
                        ,:cod_manutentore
                        ,:cod_via
                        ,:toponimo_chk
                        ,:indirizzo_chk
                        ,:numero_chk
                        ,:esponente
                        ,:scala
                        ,:piano
                        ,:interno
                        ,:palazzo
                        ,:cod_comune_chk
                        ,:cod_prov_chk
                        ,:cap_occu
                        ,:data_corrente
                        ,:id_utente
			,:volimetria_risc
			,:cod_comb_chk
			, 'S'
			,:data_installazione_aimp
                        ,'1'
                        ,'7'
                        ,:cod_iterman
                        ,:data_rottamaz
                        ,:cod_tpim
                        ,:cod_potenza
                        )
       </querytext>
    </fullquery>



    <fullquery name="iter_cari_manu_new.ins_gend">
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
                        , cod_cost_bruc
                        , matricola_bruc
                        , modello_bruc
                        , tipo_bruciatore
                        , data_costruz_bruc
                        , data_installaz
                        , data_rottamaz
                        , data_installaz_bruc
                        , data_rottamaz_bruc
                        , flag_attivo
                        , pot_focolare_lib
                        , pot_utile_lib
			)
                   values 
                        (:cod_impianto
                        ,:gen_prog
                        ,:matricola
                        ,:modello
                        ,:cod_comb_chk
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
                        ,:cod_cost_bruc
                        ,:matricola_bruc
                        ,:modello_bruc
                        ,:tipo_bruciatore
                        ,:data_costruz_bruc
                        ,:data_installaz
                        ,:data_rottamaz_gen
                        ,:data_installaz_bruc
                        ,:data_rottamaz_bruc
                        ,:flag_attivo
                        ,:pot_focolare_lib
                        ,:pot_utile_lib
                        )
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_liste_csv">
        <querytext>
	select nome_colonna
	       , denominazione
	       , tipo_dato
	       , dimensione
	       , obbligatorio
	       , default_value
	       , range_value
	 from coimtabs 
	 where nome_tabella = :csv_name 
	 order by ordinamento
	</querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_cod_tanom">
        <querytext>
	select cod_tano as codice_anomalia
	  from coimtano
	</querytext>    
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_comuni">
       <querytext>
          select cod_comune
	       , denominazione as nome_comune
	  from coimcomu
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_comb">
       <querytext>
           select cod_combustibile
	        , descr_comb 
	   from coimcomb
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_utente_status">
        <querytext>
	    select id_settore as user_sett
	         , id_ruolo   as user_ruol
	    from coimuten
	    where id_utente = :id_utente
	</querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_manu_check">
       <querytext>
          select '1'
	  from coimmanu
	  where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_prov">
        <querytext>
	   select cod_provincia as cod_prov
	        , sigla as sigla_prov
	   from coimprov
	</querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_dimp_check">
       <querytext>
          select '1'
	  from coimdimp
	  where cod_impianto = :cod_impianto
	    and data_controllo = :data_controllo
	    and gen_prog = :gen_prog
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_aimp_data">
       <querytext>
          select cod_impianto
	       , cod_manutentore as cod_manutentore_ok
	       , cod_proprietario as cod_proprietario_ok
	       , cod_responsabile as cod_responsabile_ok
	       , cod_occupante as cod_occupante_ok
	  from coimaimp
	  $where_codi
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.upd_aimp_citt">
       <querytext>
           update coimaimp
	        set cod_manutentore = :cod_manutentore_upd
		  , cod_proprietario = :cod_proprietario_upd
		  , cod_occupante = :cod_occupante_upd
	   where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.upd_aimp_dates">
       <querytext>
	update coimaimp
	    set data_ultim_dich = :data_controllo
	      , data_scad_dich  = :data_scadenza
              , cod_manutentore = :cod_manutentore
              , stato_conformita = :conf_aimp
	where cod_impianto  = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.ins_dimp">
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
                     , dich_conf
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
                     , schemi_funz_idr
                     , schemi_funz_ele
                     , schemi_funz_idr_note
                     , schemi_funz_ele_note
                     , lib_impianto_note
                     , rapp_contr_note
                     , certificaz_note
                     , dich_conf_note
                     , lib_uso_man_note
                     , libretto_bruc_note
                     , ispesl_note
                     , conformita
                     , pendenza
                     , riflussi_locale
                     , assenza_perdite
                     , antivento
                     , valvola_sicur
                     , circ_aria
                     , guarn_accop
                     , eff_evac_fum
                     , prev_incendi_note
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
                     ,:dich_conf
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
                     ,:schemi_funz_idr
                     ,:schemi_funz_ele
                     ,:schemi_funz_idr_note
                     ,:schemi_funz_ele_note
                     ,:lib_impianto_note
                     ,:rapp_contr_note
                     ,:certificaz_note
                     ,:dich_conf_note
                     ,:lib_uso_man_note
                     ,:libretto_bruc_note
                     ,:ispesl_note
                     ,:conformita
                     ,:pendenza
                     ,:riflussi_locale
                     ,:assenza_perdite
                     ,:antivento
                     ,:valvola_sicur
                     ,:circ_aria
                     ,:guarn_accop
                     ,:eff_evac_fum
                     ,:prev_incendi_note
                     ,:tariffa_reg
                     ,:importo_contr
                     )
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_dual_cod_dimp">
       <querytext>
        select nextval('coimdimp_s') as cod_dimp
       </querytext>
    </fullquery>

    <partialquery name="iter_cari_manu_new.ins_anom">
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

    <fullquery name="iter_cari_manu_new.sel_tari_contributo">
        <querytext>
	select a.importo as importo_contr
          from coimtari a
         where a.cod_potenza = :cod_potenza_tari
           and a.tipo_costo  = '7' 
           and a.cod_listino = '0'
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu_new.sel_cod_potenza">
        <querytext>
	select cod_potenza as cod_potenza_tari
          from coimpote
         where :pot_focolare_nom_check between potenza_min and potenza_max
       </querytext>
    </fullquery>

    <partialquery name="iter_cari_manu_new.ins_trans">
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
