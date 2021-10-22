<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="iter_cari_manu.sel_aimp_check_no_cod">
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

    <fullquery name="iter_cari_manu.sel_aimp_no_cod">
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

    <fullquery name="iter_cari_manu.sel_resp_impianto">
       <querytext>
                   select cod_responsabile as cod_resp_imp
                     from coimaimp
                    where cod_impianto_est = :cod_impianto_est
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_aimp_check">
       <querytext>
                   select cod_impianto_est
                     from coimaimp a
                    where a.cod_impianto_est = :cod_impianto_est
                     $where_indirizzo
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_aimp_gend_check">
       <querytext>
                   select 1
                     from coimaimp a
		        , coimgend g
                    where a.cod_impianto_est = :cod_impianto_est
                      and g.cod_impianto (+) = a.cod_impianto
		      and g.gen_prog         = :gen_prog
		      and g.matricola        = :matricola
		      and g.cod_cost         = :cod_cost
		      $where_indirizzo
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_viae_check">
       <querytext>
             select cod_via
	     from coimviae
	     where upper(descr_topo)  = upper(:toponimo_chk)
	       and upper(descrizione) = upper(:indirizzo_chk)
	     $where_comune
       </querytext>
    </fullquery>
    
    <fullquery name="iter_cari_manu.sel_dual_cod_impianto">
       <querytext>
                   select coimaimp_s.nextval as cod_impianto
                from dual
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_dual_cod_impianto_est">
       <querytext>
                   select coimaimp_est_s.nextval as cod_impianto_est
                from dual
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_dual_cod_via">
       <querytext>
                   select coimviae_s.nextval as cod_via
                from dual
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
	  where cognome = :cognome_citt_chk
          $where_nome_chk
          $where_indirizzo_chk
          $where_comune_chk
          $where_provincia_chk
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_dual_cod_citt">
       <querytext>
          select coimcitt_s.nextval as cod_citt
                from dual
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
                        , cod_comune
                        , cod_provincia
                        , cap
                        , data_ins
			, volimetria_risc
			, cod_combustibile
			, flag_dpr412
			, data_installaz
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
                        ,:cod_comune_chk
                        ,:cod_prov_chk
                        ,:cap_occu
                        ,:data_corrente
			,:volimetria_risc
			,:cod_comb_chk
			, 'S'
			,:data_installazione_aimp
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

    <fullquery name="iter_cari_manu.sel_dimp_check">
       <querytext>
          select '1'
	  from coimdimp
	  where cod_impianto = :cod_impianto
	    and data_controllo = :data_controllo
	    and gen_prog = :gen_prog
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
	  where cod_impianto_est = :cod_impianto_est
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.upd_aimp_citt">
       <querytext>
           update coimaimp
	        set cod_manutentore = :cod_manutentore_upd
		  , cod_proprietario = :cod_proprietario_upd
		  , cod_occupante = :cod_occupante_upd
		  , data_ultim_dich = :data_controllo
		  , data_scad_dich = :data_scadenza
	   where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.upd_aimp_dates">
       <querytext>
	update coimaimp
	    set data_ultim_dich = :data_controllo
	      , data_scad_dich  = :data_scadenza
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
                     , data_ins
                     , num_bollo
                     , costo
                     , tipologia_costo
                     , riferimento_pag
                     , potenza
		     , flag_co_perc
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
                     ,sysdate
                     ,:num_bollo
                     ,:costo
                     ,:tipologia_costo
                     ,:riferimento_pag
		     ,:potenza_foc_nom
		     ,:flag_co_perc
                     ,:flag_tracciato
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
                     )
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_manu.sel_dual_cod_dimp">
       <querytext>
        select coimdimp_s.nextval as cod_dimp
                from dual
       </querytext>
    </fullquery>

</queryset>
