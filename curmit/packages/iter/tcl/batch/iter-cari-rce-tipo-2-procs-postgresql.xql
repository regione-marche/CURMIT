<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim01 27/06/2016 Se flag_tariffa_impianti_vecchi eq "t" e il combustibile e' Gas o Metano
    sim01            devo verificare se l'impianto e' vecchio e quindi usare un'altra tariffa.
-->
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="iter_cari_rcee_tipo_2.sel_tari_contributo">
        <querytext>
	select a.importo as importo_contr
          from coimtari a
         where a.cod_potenza = :cod_potenza_tari
           and a.tipo_costo  = '8' 
           and a.cod_listino = '0'
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_rcee_tipo_1.sel_tari">
        <querytext>
        select iter_edit_num(a.importo,2) as tariffa  --sim07 aggiunta query
             , a.flag_tariffa_impianti_vecchi                                        
             , a.anni_fine_tariffa_base                                               
             , iter_edit_num(a.tariffa_impianti_vecchi,2) as tariffa_impianti_vecchi 
          from coimtari a
         where a.cod_potenza = :cod_potenza_tari
           and a.tipo_costo  = '1'
           and a.cod_listino = :cod_listino
           and a.data_inizio = (select max(d.data_inizio)
                                  from coimtari d
                                 where d.cod_potenza = :cod_potenza_tari
                                   and d.cod_listino  = :cod_listino
                                   and d.tipo_costo  = '1'
                                   and d.data_inizio <= current_date)
       </querytext>
    </fullquery>


    <fullquery name="iter_cari_rcee_tipo_2.sel_dimp_check_data_controllo">
       <querytext>
       select '1' 
         from coimdimp
        where cod_impianto   = :cod_impianto_catasto
          and data_controllo = :data_controllo
         limit 1
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_rcee_tipo_2.sel_dual_cod_citt">
       <querytext>
          select nextval('coimcitt_s') as cod_citt
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_rcee_tipo_2.ins_citt">
       <querytext>
           insert into coimcitt
	                ( cod_cittadino
			, nome
			, cognome
			, indirizzo
			, comune
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
			, :natura_citt_chk
			, :data_corrente
			, :id_utente
                        , :cap_chk
                        , :cod_fiscale_chk
                        , :telefono_chk
			)
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_rcee_tipo_2.sel_dual_cod_impianto">
       <querytext>
                   select nextval('coimaimp_s') as cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_rcee_tipo_2.sel_dual_cod_impianto_est">
       <querytext>
                   select nextval('coimaimp_est_s') as cod_impianto_est
       </querytext>
    </fullquery>


    <fullquery name="iter_cari_rcee_tipo_2.ins_aimp">
       <querytext>
                   insert
                     into coimaimp 
                        ( cod_impianto
                        , cod_impianto_est
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
                        , cod_comune
                        , cap
                        , data_ins
                        , utente_ins
			, cod_combustibile
			, flag_dpr412
                        , n_generatori
                        , provenienza_dati
			, pdr
			, pod
                        , flag_tipo_impianto
                        , targa
			)
                   values 
                        (:cod_impianto
                        ,:cod_impianto_est
                        ,:stato
                        ,'S'
                        ,:data_controllo
                        ,:data_controllo
                        ,:data_scadenza_autocert
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
                        ,:cod_comune
                        ,:cap_occu
                        ,:data_corrente
                        ,:id_utente
			,:cod_comb
			, 'S'
                        ,'1'
                        ,'7'
			,:pdr
                        ,:pod
                        ,'R' -- flag_tipo_impianto
                        ,:targa
                        )
       </querytext>
    </fullquery>



    <fullquery name="iter_cari_rcee_tipo_2.ins_gend">
       <querytext>
                   insert
                     into coimgend
                        ( cod_impianto
                        , gen_prog
                        , matricola
                        , modello
                        , cod_combustibile
                        , data_ins
                        , utente_ins
			, gen_prog_est
			, tiraggio
                        , cod_cost
			)
                   values 
                        (:cod_impianto
                        ,:gen_prog
                        ,:matricola
                        ,:modello
                        ,:cod_comb
			,:data_corrente
                        ,:id_utente
                        ,:gen_prog
			,:tiraggio_gend
                        ,:cod_cost
                        )
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_rcee_tipo_2.upd_gend">
       <querytext>
                   update coimgend
                      set matricola = :matricola
                        , modello = :modello
                        , cod_combustibile = :cod_comb
			, data_mod = :data_corrente
                        , utente = :id_utente
			, tiraggio = :tiraggio_gend
                        , cod_cost = :cod_cost
                    where cod_impianto = :cod_impianto
                      and gen_prog = :gen_prog
       </querytext>
    </fullquery>


    <fullquery name="iter_cari_rcee_tipo_2.upd_aimp">
       <querytext>
	update coimaimp
	   set stato_conformita   = 'S'
             , cod_manutentore    = :cod_manutentore
             , data_ultim_dich    = :data_controllo 
	     , data_scad_dich     = :data_scadenza_autocert
             , flag_resp          = :flag_responsabile
             , cod_responsabile   = :cod_responsabile
             , cod_proprietario   = :cod_proprietario
             , cod_occupante      = :cod_occupante
             , cod_intestatario   = :cod_intestatario
             , cod_amministratore = :cod_amministratore
	     , pdr                = :pdr
	     , pod                = :pod
	     , targa              = :targa 
	 where cod_impianto       = :cod_impianto_catasto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_rcee_tipo_2.upd_gen_rott">
       <querytext>
	update coimgend
	   set flag_attivo       = 'N'
	 where cod_impianto      = :cod_impianto_catasto
	   and gen_prog          = :gen_prog_catasto
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_rcee_tipo_2.ins_dimp">
       <querytext>
                insert
                  into coimdimp 
                     ( cod_dimp
                     , cod_impianto
                     , data_controllo
                     , gen_prog
                     , cod_manutentore
		     , cod_opmanu_new
                     , cod_responsabile
                     , flag_status
                     , lib_impianto
                     , lib_uso_man
                     , ap_vent_ostruz
                     , rct_lib_uso_man_comp
		     , rct_dur_acqua
                     , rct_tratt_in_risc
		     , idoneita_locale
		     , fr_linee_ele
		     , fr_coibentazione
		     , fr_assenza_perdita_ref
		     , fr_leak_detector
		     , fr_pres_ril_fughe
		     , fr_scambiatore_puliti
		     , cont_rend
                     , osservazioni
                     , raccomandazioni
                     , prescrizioni
                     , utente_ins
                     , data_ins
                     , costo
                     , tipologia_costo
                     , ora_inizio
                     , ora_fine
		     , data_scadenza
                     , num_autocert
                     , consumo_annuo
                     , consumo_annuo2
                     , stagione_risc
                     , stagione_risc2
                     , conformita
                     , tariffa
                     , importo_tariffa
                     , fr_check_list_1
                     , fr_check_list_2
                     , fr_check_list_3
                     , fr_check_list_4
		     , flag_tracciato
		     , cod_tprc
		     , data_prox_manut
		     , data_ultima_manu
                     , flag_pagato 
                     )
                values 
                     (:cod_dimp
                     ,:cod_impianto
                     ,:data_controllo
                     ,:gen_prog
                     ,:cod_manutentore
		     ,:cod_opmanu_new
                     ,:cod_responsabile
                     ,:flag_status
                     ,:lib_impianto
                     ,:lib_uso_man
                     ,:ap_vent_ostruz
		     ,:rct_lib_uso_man_comp
		     ,:rct_dur_acqua
                     ,:rct_tratt_in_risc
		     ,:idoneita_locale
		     ,:fr_linee_ele
		     ,:fr_coibentazione
		     ,:fr_assenza_perdita_ref
		     ,:fr_leak_detector
		     ,:fr_pres_ril_fughe
		     ,:fr_scambiatore_puliti
		     ,:cont_rend  
                     ,:osservazioni
                     ,:raccomandazioni
                     ,:prescrizioni
                     ,:id_utente
                     ,current_date
                     ,:costo
		     ,upper(:tipologia_costo)
                     ,:ora_inizio
                     ,:ora_fine
                     ,:data_scadenza_autocert
                     ,:num_autocert
                     ,:consumo_annuo
                     ,:consumo_annuo2
                     ,:stagione_risc
                     ,:stagione_risc2
                     ,:conformita
                     ,:tariffa_reg
                     ,:importo_contr
                     ,:fr_check_list_1
                     ,:fr_check_list_2
                     ,:fr_check_list_3
                     ,:fr_check_list_4
		     ,'R2'
		     ,:cod_tprc
                     ,:data_prox_manut
            	     ,:data_ultima_manu
		     ,:flag_pagato
		     )
       </querytext>
    </fullquery>

    <fullquery name="iter_cari_rcee_tipo_2.sel_dual_cod_dimp">
       <querytext>
        select nextval('coimdimp_s') as cod_dimp
       </querytext>
    </fullquery>


    <partialquery name="iter_cari_rcee_tipo_2.ins_trans">
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
