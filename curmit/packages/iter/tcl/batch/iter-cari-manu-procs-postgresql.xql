<?xml version="1.0"?>
	
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="iter_cari_manu.ins_trans">
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

    <fullquery name="iter_cari_manu.sel_aimp_check_no_cod">
       <querytext>
                   select '1'
                     from coimaimp a
                        , coimgend b
                    where a.cod_impianto = b.cod_impianto
                      and b.matricola = :matricola_chk
                      and b.cod_cost = :cod_cost
		      $where_indirizzo
                    limit 1
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_aimp_check_no_cod_count">
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

    <fullquery name="iter_cari_manu.sel_aimp_no_cod">
       <querytext>
                   select cod_impianto_est
                        , a.cod_impianto
                     from coimaimp a
                        , coimgend b
                    where a.cod_impianto = b.cod_impianto
                      and b.matricola = :matricola_chk
                      and b.cod_cost = :cod_cost
		      $where_indirizzo
                    limit 1
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_resp_impianto">
       <querytext>
                   select cod_responsabile as cod_resp_imp
                     from coimaimp
                    where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_aimp_check">
       <querytext>
                   select cod_impianto_est
                     from coimaimp a
                    where a.cod_impianto_est = :cod_impianto_est
                     $where_comune
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_aimp_gend_check">
       <querytext>
                   select '1'
                     from coimaimp a
		     left outer join coimgend g on g.cod_impianto = a.cod_impianto
                    where a.cod_impianto_est = :cod_impianto_est
		      and g.gen_prog         = :gen_prog
		      $where_comune
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_viae_check">
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
    
    <fullquery name="iter_cari_manu.sel_dual_cod_impianto">
       <querytext>
                   select nextval('coimaimp_s') as cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_dual_cod_impianto_est">
       <querytext>
                   select nextval('coimaimp_est_s') as cod_impianto_est
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_dual_cod_via">
       <querytext>
                   select nextval('coimviae_s') as cod_via
       </querytext>
    </fullquery>

    <fullquery name ="iter_cari_manu.ins_viae">
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

    <fullquery name="iter_cari_manu.sel_citt_check">
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

    <fullquery name="iter_cari_manu.sel_dual_cod_citt">
       <querytext>
          select nextval('coimcitt_s') as cod_citt
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.ins_citt">
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
			, telefono
            , cod_fiscale
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
			, :telefono_citt_chk
            , :cod_fiscale_citt_chk
			)
       </querytext>
    </fullquery>
    <fullquery name="iter_cari_manu.ins_aimp">
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
                        , cod_potenza
			)
                   values 
                        (:cod_impianto
                        ,:cod_impianto_est
                        ,:potenza_foc_nom
                        ,:potenza_utile_nom
                        ,:stato_tgen
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
                        ,:cod_potenza
                        )
       </querytext>
    </fullquery>



    <fullquery name="iter_cari_manu.ins_gend">
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
                        , flag_attivo
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
			)
                   values 
                        (:cod_impianto
                        ,:gen_prog
                        ,:matricola
                        ,:modello
                        ,:cod_comb_chk
                        ,:potenza_foc_nom
                        ,:potenza_utile_nom
                        ,'S'
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
                        ,:data_installazione_aimp
                        )
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_liste_csv">
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

    <fullquery name="iter_cari_manu.sel_cod_tanom">
        <querytext>
	select cod_tano as codice_anomalia
	  from coimtano
	</querytext>    
    </fullquery>

    <fullquery name="iter_cari_manu.sel_comuni">
       <querytext>
          select cod_comune
	       , denominazione as nome_comune
	  from coimcomu
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_comb">
       <querytext>
           select cod_combustibile
	        , descr_comb 
	   from coimcomb
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_utente_status">
        <querytext>
	    select id_settore as user_sett
	         , id_ruolo   as user_ruol
	    from coimuten
	    where id_utente = :id_utente
	</querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_manu_check">
       <querytext>
          select '1'
	  from coimmanu
	  where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_prov">
        <querytext>
	   select cod_provincia as cod_prov
	        , sigla as sigla_prov
	   from coimprov
	</querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_prov_denom">
        <querytext>
	   select cod_provincia as cod_prov
	        , denominazione as denom_provincia
	   from coimprov
	</querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_dimp_check_data_ins">
       <querytext>
                   select '1'
                     from coimdimp
                    where cod_impianto = :cod_impianto
	              and data_controllo = :data_controllo
                      and data_ins > (to_date(add_months(current_date, -3), 'yyyy-mm-dd'))
          $where_gen_prog
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_dimp_check">
       <querytext>
          select cod_dimp
	  from coimdimp
	  where cod_impianto = :cod_impianto
	    and data_controllo = :data_controllo
          $where_gen_prog
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_aimp_data">
       <querytext>
          select cod_impianto
	       , cod_manutentore as cod_manutentore_ok
	       , cod_proprietario as cod_proprietario_ok
	       , cod_responsabile as cod_responsabile_ok
	       , cod_occupante as cod_occupante_ok
	  from coimaimp
	  $where_cod
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.upd_aimp_citt">
       <querytext>
           update coimaimp
	        set cod_manutentore = :cod_manutentore_upd
		  , cod_proprietario = :cod_proprietario_upd
		  , cod_occupante = :cod_occupante_upd
	   where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.upd_dati_impianto">
       <querytext>
           update coimaimp
	        set potenza          = :potenza_foc_nom
                  , potenza_utile    = :potenza_utile_nom
                  , flag_dichiarato  = 'S'
                  , consumo_annuo    = :consumo_annuo
                  , stato_conformita = :conformita
    	          , volimetria_risc  = :volimetria_risc
	          , cod_combustibile = :cod_comb_chk
		  , data_installaz   = :data_installazione_aimp
                  , cod_responsabile = :cod_responsabile
                  , flag_resp        = :flag_resp
                  , cod_intestatario = :cod_intestatario
                  , cod_proprietario = :cod_proprietario
                  , cod_occupante    = :cod_occupante
                  , cod_manutentore  = :cod_manutentore
                  , cod_via          = :cod_via
                  , toponimo         = :toponimo_chk
                  , indirizzo        = :indirizzo_chk
                  , numero           = :numero_chk
	          , esponente        = :esponente
                  , scala            = :scala
                  , piano            = :piano
                  , interno          = :interno
                  , palazzo          = :palazzo
                  , cod_comune       = :cod_comune_chk
                  , cod_provincia    = :cod_prov_chk
                  , cap              = :cap_occu
                  , cod_potenza      = :cod_potenza
	   where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.upd_dati_generatore">
       <querytext>
             update coimgend set modello          = :modello
                               , cod_combustibile = :cod_comb_chk
                               , pot_focolare_nom = :potenza_foc_nom
                               , pot_utile_nom    = :potenza_utile_nom
			       , tiraggio         = :tiraggio_gend
			       , mod_funz         = :fluido_termovettore_gend
			       , cod_emissione    = :scarico_fumi_gend
			       , data_costruz_gen = :data_costruzione_gend
			       , data_installaz   = :data_installazione_aimp
			       , marc_effic_energ = :marc_effic_energ
			       , cod_utgi         = :cod_utgi
			       , tipo_foco        = :tipo_foco
			       , locale           = :locale
                         where cod_impianto = :cod_impianto
                           and gen_prog     = :gen_prog
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.upd_aimp_dates">
       <querytext>
	update coimaimp
	    set data_ultim_dich  = :data_controllo
	      , data_scad_dich   = :data_scadenza
              , cod_manutentore  = :cod_manutentore
              , stato_conformita = :conf_aimp
	where cod_impianto  = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.ins_dimp">
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
                     , pendenza
                     , scar_ca_si
                     , scar_parete
                     , scar_can_fu
                     , riflussi_locale
                     , assenza_perdite
                     , antivento
                     , valvola_sicur
                     , circ_aria
                     , guarn_accop
                     , eff_evac_fum
                     , conformita
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
                     ,:conformita
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
                     ,:pendenza
                     ,:scar_ca_si
                     ,:scar_parete
                     ,:scar_can_fu
                     ,:riflussi_locale
                     ,:assenza_perdite
                     ,:antivento
                     ,:valvola_sicur
                     ,:circ_aria
                     ,:guarn_accop
                     ,:eff_evac_fum
                     ,:conformita
                     ,:tariffa_reg
                     ,:importo_contr
                     )
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_dual_cod_dimp">
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

    <fullquery name="iter_cari_manu.sel_tari_contributo">
        <querytext>
	select a.importo as importo_contr
          from coimtari a
         where a.cod_potenza = :cod_potenza_tari
           and a.tipo_costo  = '7' 
           and a.cod_listino = '0'
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_cod_potenza">
        <querytext>
	select cod_potenza as cod_potenza_tari
          from coimpote
         where :pot_focolare_nom_check between potenza_min and potenza_max
       </querytext>
    </fullquery>

    <partialquery name="iter_cari_manu.ins_todo">
       <querytext>
                insert
                  into coimtodo ( 
                       cod_todo
                     , cod_impianto
                     , cod_cimp_dimp
                     , tipologia
                     , note
                     , data_evento
                     , data_scadenza
                     , flag_evasione
                     , data_evasione)
                values (
                       nextval('coimtodo_s')
                     ,:cod_impianto
                     ,:cod_dimp
                     ,'4'
                     ,:note_todo
                     ,:data_controllo
                     ,:data_controllo
                     ,'S'
                     ,current_date)
       </querytext>
    </partialquery>

</queryset>
