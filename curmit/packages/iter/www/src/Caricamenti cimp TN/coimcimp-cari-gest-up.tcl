ad_page_contract {
    Add              form per la tabella "coimcari"
                     Lancio caricamento controlli da file esterno
    @creation-date   06/06/2006

    @param funzione  I=insert V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @cvs-id          coimcimp-cari-gest.tcl
} {
    {funzione        "I"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {uno ""}
    {due ""}
    {tre ""}
    {quattro ""}
    {cinque ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

set current_date [iter_set_sysdate]

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

set link_gest [export_url_vars nome_funz nome_funz_caller caller]

set spool_dir [iter_set_spool_dir]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# preparo i link di testata della pagina per consultazione coda lavori
set nom       "Caricamento controlli/schede rilievo"

# reperisco le colonne della tabella parametri (serve una variabile nell'adp)
iter_get_coimtgen

# Personalizzo la pagina
set titolo "Caricamento controlli/schede rilievo da file esterno"

set page_title "Caricamento controlli/schede rilievo da file esterno"
#ns_return 200 text/html "$uno || $due || $tre || $quattro || $cinque"; return
set nome_funz_caller "cimp-cari"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

set inf 0
set sup 0
set met 0
set gas 0
set sga 0
db_transaction {
    #    caricamento inferiore a 35 KW
    set file_inp [open $spool_dir/$uno r]
    foreach line [split [read $file_inp] \n] {
 	if {[string equal $line ""]} {
 	    continue
 	}
 	set line_split [split $line ";"]
 	set imp_n_dichiarazione [string trim [lindex $line_split 0]]
 	set gen_prog [string trim [lindex $line_split 1]]
 	set cod_inco [string trim [lindex $line_split 2]]
 	set imp_data_controllo [string trim [lindex $line_split 3]]
 	set cod_opve [string trim [lindex $line_split 4]]
 	set presenza_libretto [string trim [lindex $line_split 5]]
 	set stato_coiben [string trim [lindex $line_split 6]]
 	set verifica_areaz [string trim [lindex $line_split 7]]
 	set imp_rendimento_rilevato [string trim [lindex $line_split 8]]
 	set imp_rend_DPR412 [string trim [lindex $line_split 9]]
 	set imp_co2 [string trim [lindex $line_split 10]]
 	set indic_fumosita_1 [string trim [lindex $line_split 11]]
 	set indic_fumosita_2 [string trim [lindex $line_split 12]]
 	set indic_fumosita_3 [string trim [lindex $line_split 13]]
 	set imp_indice_bacharach_ril [string trim [lindex $line_split 14]]
 	set manutenzione_8a [string trim [lindex $line_split 15]]
 	set esito_verifica [string trim [lindex $line_split 16]]
 	set imp_note [string trim [lindex $line_split 17]]
 	set cod_combustibile [string trim [lindex $line_split 18]]
 	set cod_responsabile [string trim [lindex $line_split 19]]
 	set utente [string trim [lindex $line_split 20]]
 	set new1_foro_presente [string trim [lindex $line_split 21]]
 	set new1_foro_corretto [string trim [lindex $line_split 22]]
 	set new1_foro_accessibile [string trim [lindex $line_split 23]]
 	set new1_canali_a_norma [string trim [lindex $line_split 24]]
 	set new1_dimp_pres [string trim [lindex $line_split 25]]
 	set imp_data_ult_manutenzione [string trim [lindex $line_split 26]]
 	set new1_manu_prec_8a [string trim [lindex $line_split 27]]
 	set imp_co_fumisecchi_ril [string trim [lindex $line_split 28]]
 	set imp_puntatore [string trim [lindex $line_split 29]]
 	set imp_numeroserie [string trim [lindex $line_split 30]]
 	set imp_potenza_n [string trim [lindex $line_split 31]]
 	set imp_port_nominale [string trim [lindex $line_split 32]]
 	set imp_ora_inizio [string trim [lindex $line_split 33]]
 	set imp_ora_fine [string trim [lindex $line_split 34]]
 	set imp_anno_costruzione [string trim [lindex $line_split 35]]
 	set imp_anno_installazione [string trim [lindex $line_split 36]]
 	set imp_manutentore [string trim [lindex $line_split 37]]
 	set imp_costruttore [string trim [lindex $line_split 38]]
 	set imp_modello [string trim [lindex $line_split 39]]
 	set imp_tipo_bruciatore [string trim [lindex $line_split 40]]
 	set imp_installazione [string trim [lindex $line_split 41]]
 	set imp_mod_funz [string trim [lindex $line_split 42]]
 	set imp_tipo_foco [string trim [lindex $line_split 43]]
 	set stato_canna_fumaria [string trim [lindex $line_split 44]]
 	set imp_data_ultima_verifica [string trim [lindex $line_split 45]]
 	set imp_port_nominale [string trim [lindex $line_split 46]]
 	set cod_utgi [string trim [lindex $line_split 47]]
	set imp_no_pres_appuntamento             [string trim [lindex $line_split 48]]
	set imp_note_manc_idonea_ventil          [string trim [lindex $line_split 49]]
	set imp_note_vent_inadeguata             [string trim [lindex $line_split 50]]
	set imp_note_manca_foro_fumi             [string trim [lindex $line_split 51]]
	set imp_note_foro_fumi_non_norma         [string trim [lindex $line_split 52]]
	set imp_note_manca_lib_impianto          [string trim [lindex $line_split 53]]
	set imp_note_allegato_H                  [string trim [lindex $line_split 54]]
	set imp_note_sfiato_serbatoio            [string trim [lindex $line_split 55]]
	set imp_note_dep_gasolio_no_norma        [string trim [lindex $line_split 56]]
	set imp_note_serb_gasolio_loc_cald       [string trim [lindex $line_split 57]]
	set imp_note_gpl_sotto_campagna          [string trim [lindex $line_split 58]]
	set imp_note_manca_mant_preced           [string trim [lindex $line_split 59]]
	set imp_note_manca_manut_verif_prec      [string trim [lindex $line_split 60]]
	set imp_note_imp_disattivato             [string trim [lindex $line_split 61]]
	set imp_note_imp_bagno_camer             [string trim [lindex $line_split 62]]
	set imp_note_imp_comun_autorim           [string trim [lindex $line_split 63]]
	set imp_note_imp_instal_autorim          [string trim [lindex $line_split 64]]
	set imp_note_canal_da_sostituire         [string trim [lindex $line_split 65]]
	set imp_note_si_cons_sost_canale         [string trim [lindex $line_split 66]]
	set imp_note_rilasc_dich_potenza         [string trim [lindex $line_split 67]]
	set imp_estrazione                       [string trim [lindex $line_split 68]]
	set imp_note_esito_positivo              [string trim [lindex $line_split 69]]
	set imp_note_aerazione_GPL_loc           [string trim [lindex $line_split 70]]
	set imp_note_aerazione_met_cottura       [string trim [lindex $line_split 71]]
	set imp_note_aerazione_GPL_cottura       [string trim [lindex $line_split 72]]
	set imp_note_porta_autorim_omologata     [string trim [lindex $line_split 73]]
	set imp_note_serb_gasolio_autorimessa    [string trim [lindex $line_split 74]]
	set imp_note_canale_fumo_fuori_norma     [string trim [lindex $line_split 75]]
	set imp_note_gen_tipoB_aria_parti_comuni [string trim [lindex $line_split 76]]
	set imp_note_certif_collaudo_GPL         [string trim [lindex $line_split 77]]
	set imp_note_tubi_gas_pressare           [string trim [lindex $line_split 78]]
	set imp_controllo_rilev                  [string trim [lindex $line_split 79]]
	set imp_negativa                         [string trim [lindex $line_split 80]]
	set imp_rispetta                         [string trim [lindex $line_split 81]]

	if {$imp_potenza_n == "Error"} {
	    set imp_potenza_n 0.00
	}

	if {$imp_anno_costruzione ne ""
         && $imp_anno_costruzione ne "0"} {
	    set anno_costruzione "$imp_anno_costruzione/01/01"
	} else {
	    set anno_costruzione ""
	}
	if {$imp_data_ultima_verifica ne ""} {
	    set ultima_verifica "$imp_data_ultima_verifica/01/01"
	} else {
	    set ultima_verifica ""
	}
	
	set cod_impianto_int [db_string query "select cod_impianto as cod_impianto_int from coimaimp where cod_impianto_est = :imp_n_dichiarazione"]
	set cod_inco [db_string query "select cod_inco from coiminco where cod_impianto = :cod_impianto_int and data_verifica = :imp_data_controllo and stato != '5'" -default ""]

 	db_1row sel_cimp "select nextval('coimcimp_s') as cod_cimp"
 	db_dml ins_cimp "insert into coimcimp
                     ( cod_cimp
                     , ora_inizio_controllo
                     , ora_fine_controllo
                     , data_costruzione
                     , note_manu
                     , cod_impianto
                     , gen_prog
                     , cod_inco
                     , data_controllo
                     , cod_opve
                     , presenza_libretto
                     , stato_coiben
                     , verifica_areaz
                     , rend_comb_conv
                     , rend_comb_8d
                     , co2_md
                     , indic_fumosita_1a
                     , indic_fumosita_2a
                     , indic_fumosita_3a
                     , indic_fumosita_md
                     , manutenzione_8a
                     , esito_verifica
                     , note_conf
                     , cod_combustibile
                     , cod_responsabile
                     , data_ins
                     , utente
                     , new1_foro_presente
                     , new1_foro_corretto
                     , new1_foro_accessibile
                     , new1_canali_a_norma
                     , new1_dimp_pres
                     , new1_data_ultima_manu
                     , new1_manu_prec_8a
                     , new1_co_rilevato
                     , puntatore
                     , strumento
                     , pot_focolare_nom
                     , pot_utile_nom
                     , installazione
                     , stato_canna_fum
                     , ultima_verifica
                     , note_costru
                     , mis_port_combust
                     , flag_tracciato
                     , media_tre_prove
                     , flag_modello
                     , controllo_rilevato
                     , uni_10389
                     )
                       values 
                     ( :cod_cimp
                     , :imp_ora_inizio
                     , :imp_ora_fine
                     , :anno_costruzione
                     , :imp_manutentore
                     , :cod_impianto_int
                     , '1'
                     , :cod_inco
                     , :imp_data_controllo
                     , :cod_opve
                     , :presenza_libretto
                     , :stato_coiben
                     , :verifica_areaz
                     , :imp_rendimento_rilevato
                     , :imp_rend_DPR412
                     , :imp_co2
                     , :indic_fumosita_1
                     , :indic_fumosita_2
                     , :indic_fumosita_3
                     , :imp_indice_bacharach_ril
                     , :manutenzione_8a
                     , :esito_verifica
                     , :imp_note
                     , :cod_combustibile
                     , :cod_responsabile
                     , :current_date
                     , :utente
                     , :new1_foro_presente
                     , :new1_foro_corretto
                     , :new1_foro_accessibile
                     , :new1_canali_a_norma
                     , :new1_dimp_pres
                     , :imp_data_ult_manutenzione
                     , :new1_manu_prec_8a
                     , :imp_co_fumisecchi_ril
                     , :imp_puntatore
                     , :imp_numeroserie
                     , :imp_potenza_n
                     , :imp_port_nominale
                     , :imp_installazione
                     , :stato_canna_fumaria
                     , :ultima_verifica
                     , :imp_costruttore
                     , :imp_port_nominale
                     , 'N1'
                     , 'N'
                     , 'I'
                     , :imp_controllo_rilev
                     , :imp_rispetta
                     )"

	set esito "P"
	if {[string equal $imp_no_pres_appuntamento 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '1'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'1'
                                                      ,'1'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_manc_idonea_ventil 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '2'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'2'
                                                      ,'2'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_vent_inadeguata 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '3'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'3'
                                                      ,'3'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_negativa "S"]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '3'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'3'
                                                      ,'3'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_manca_foro_fumi 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '7'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'7'
                                                      ,'7'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_foro_fumi_non_norma 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '8'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'8'
                                                      ,'8'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}

	if {[string equal $imp_note_manca_lib_impianto 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '18'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'18'
                                                      ,'18'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
		db_1row sel_cod_todo "select nextval('coimtodo_s') as cod_todo"
                db_dml ins_todo "insert
                                   into coimtodo ( 
                                                  cod_todo
                                                , cod_impianto
                                                , cod_cimp_dimp
                                                , tipologia
                                                , note
                                                , data_evento)
                                           values (
                                                  :cod_todo
                                                ,:cod_impianto_int
                                                ,:cod_cimp
                                                ,'2'
                                                ,'Manca libretto impianto'
                                                ,current_date)"
	    }
	}
	if {[string equal $imp_note_allegato_H 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '21'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'21'
                                                      ,'21'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
		db_1row sel_cod_todo "select nextval('coimtodo_s') as cod_todo"
                db_dml ins_todo "insert
                                   into coimtodo ( 
                                                  cod_todo
                                                , cod_impianto
                                                , cod_cimp_dimp
                                                , tipologia
                                                , note
                                                , data_evento)
                                           values (
                                                  :cod_todo
                                                ,:cod_impianto_int
                                                ,:cod_cimp
                                                ,'2'
                                                ,'Manca allegato H'
                                                ,current_date)"
	    }
	}
	if {[string equal $imp_note_sfiato_serbatoio 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '14'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'14'
                                                      ,'14'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_dep_gasolio_no_norma 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '15'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'15'
                                                      ,'15'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_serb_gasolio_loc_cald 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '16'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'16'
                                                      ,'16'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_gpl_sotto_campagna 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '10'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'10'
                                                      ,'10'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_manca_mant_preced 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '19'
                                             and flag_origine = 'RV'"] == 0} {
		    db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'19'
                                                      ,'19'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
		db_1row sel_cod_todo "select nextval('coimtodo_s') as cod_todo"
                db_dml ins_todo "insert
                                   into coimtodo ( 
                                                  cod_todo
                                                , cod_impianto
                                                , cod_cimp_dimp
                                                , tipologia
                                                , note
                                                , data_evento)
                                           values (
                                                  :cod_todo
                                                ,:cod_impianto_int
                                                ,:cod_cimp
                                                ,'2'
                                                ,'Manca manutenzione precedente'
                                                ,current_date)"
	    }
	}
	if {[string equal $imp_note_manca_manut_verif_prec 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '20'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'20'
                                                      ,'20'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
		db_1row sel_cod_todo "select nextval('coimtodo_s') as cod_todo"
                db_dml ins_todo "insert
                                   into coimtodo ( 
                                                  cod_todo
                                                , cod_impianto
                                                , cod_cimp_dimp
                                                , tipologia
                                                , note
                                                , data_evento)
                                           values (
                                                  :cod_todo
                                                ,:cod_impianto_int
                                                ,:cod_cimp
                                                ,'2'
                                                ,'Manca verifica anno precedente'
                                                ,current_date)"
	    }
	}
	if {[string equal $imp_note_imp_disattivato 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '28'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'28'
                                                      ,'28'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_imp_bagno_camer 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '9'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'9'
                                                      ,'9'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_imp_comun_autorim 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '12'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'12'
                                                      ,'12'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_imp_instal_autorim 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '11'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'11'
                                                      ,'11'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_canal_da_sostituire 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '22'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'22'
                                                      ,'22'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_si_cons_sost_canale 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '24'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'24'
                                                      ,'24'
                                                      ,'2'
                                                      ,'RV')"
	    }
	}
	if {[string equal $imp_note_rilasc_dich_potenza 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '26'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'26'
                                                      ,'26'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
		db_1row sel_cod_todo "select nextval('coimtodo_s') as cod_todo"
                db_dml ins_todo "insert
                                   into coimtodo ( 
                                                  cod_todo
                                                , cod_impianto
                                                , cod_cimp_dimp
                                                , tipologia
                                                , note
                                                , data_evento)
                                           values (
                                                  :cod_todo
                                                ,:cod_impianto_int
                                                ,:cod_cimp
                                                ,'2'
                                                ,'Rilasciata dichiarazione di potenza'
                                                ,current_date)"
	    }
	}
	if {[string equal $imp_estrazione 1]} {

	}
	if {[string equal $imp_note_aerazione_GPL_loc 1]} {
	    
	}
	if {[string equal $imp_note_aerazione_met_cottura 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '4'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'4'
                                                      ,'4'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_aerazione_GPL_cottura 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '5'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'5'
                                                      ,'5'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_porta_autorim_omologata 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '13'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'13'
                                                      ,'13'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_serb_gasolio_autorimessa 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '17'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'17'
                                                      ,'17'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_canale_fumo_fuori_norma 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '23'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'23'
                                                      ,'23'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_gen_tipoB_aria_parti_comuni 1]} {
		
	}
	if {[string equal $imp_note_certif_collaudo_GPL 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '25'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'25'
                                                      ,'25'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_tubi_gas_pressare 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimp
                                             and prog_anom = '27'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimp
                                                      ,'27'
                                                      ,'27'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}

	db_dml upd_cimp "update coimcimp set esito_verifica = :esito
                                   where cod_cimp = :cod_cimp"

	# coiminco stato dell'appuntamento mettere flag a effettuato
 	db_dml upd_inco "update coiminco set stato = '8'
                                           , esito = :esito
                                 where cod_inco = :cod_inco"
# aggiornare la destianzione d'uso qua sotto in attesa di conferma
	if {[string equal $imp_anno_installazione ""]
	    || [string equal $imp_anno_installazione "0"]} {
	    set data_installazione ""
	    set agg_anno ""
	} else {
	    set data_installazione "$imp_anno_installazione-01-01"	    
	    set agg_anno "data_installaz = :data_installazione,"
	}
	
 	db_dml upd_aimp "update coimaimp set potenza  = :imp_potenza_n,
                                  potenza_utile    = :imp_port_nominale,
                                  $agg_anno
                                  cod_combustibile = :cod_combustibile
                                where cod_impianto = :cod_impianto_int"
	
 	db_dml upd_gend "update coimgend set pot_focolare_nom = :imp_potenza_n,
                                          pot_utile_nom    = :imp_port_nominale,
                                          cod_combustibile = :cod_combustibile,
                                          tipo_foco        = :imp_tipo_foco,
                                          tipo_bruciatore  = :imp_tipo_bruciatore,
                                          mod_funz         = :imp_mod_funz,
                                          modello          = :imp_modello,
                                          $agg_anno
                                          cod_utgi         = :cod_utgi
                                        where cod_impianto = :cod_impianto_int"
	
 	incr inf
    }    
    close $file_inp


    #     caricamento superiore a 35 kw

    set file_inp [open $spool_dir/$due r]
    foreach line [split [read $file_inp] \n] {
 	if {[string equal $line ""]} {
 	    continue
 	}
 	set line_split [split $line ";"]
 	set imp_n_dich [string trim [lindex $line_split 0]]
 	set gen_prog [string trim [lindex $line_split 1]]
 	set cod_inco [string trim [lindex $line_split 2]]
 	set imp_data_controllo [string trim [lindex $line_split 3]]
 	set cod_opve [string trim [lindex $line_split 4]]
 	set presenza_libretto [string trim [lindex $line_split 5]]
 	set stato_coibeng1 [string trim [lindex $line_split 6]]
 	set imp_rendcombpotnomg1 [string trim [lindex $line_split 7]]
 	set imp_rendmin412g1 [string trim [lindex $line_split 8]]
 	set imp_co2g1 [string trim [lindex $line_split 9]]
 	set imp_bacharachg1 [string trim [lindex $line_split 10]]
 	set manutenzione_8a_g1 [string trim [lindex $line_split 11]]
 	set esito_verificag [string trim [lindex $line_split 12]]
 	set imp_note [string trim [lindex $line_split 13]]
 	set cod_combustibile [string trim [lindex $line_split 14]]
 	set cod_responsabile [string trim [lindex $line_split 15]]
 	set utente [string trim [lindex $line_split 16]]
 	set new1_canali_a_norma [string trim [lindex $line_split 17]]
 	set imp_ultima_manutenzione [string trim [lindex $line_split 18]]
 	set new1_manu_prec_8a_g1 [string trim [lindex $line_split 19]]
 	set imp_cofumisecchig1 [string trim [lindex $line_split 20]]
 	set imp_puntatoreg1 [string trim [lindex $line_split 21]]
 	set imp_numero_serie [string trim [lindex $line_split 22]]
 	set imp_tempfumig1 [string trim [lindex $line_split 23]]
 	set imp_tempambienteg1 [string trim [lindex $line_split 24]]
 	set imp_cog1 [string trim [lindex $line_split 25]]
 	set imp_o2g1 [string trim [lindex $line_split 26]]
 	set imp_statocannafumg1 [string trim [lindex $line_split 27]]
 	set imp_tempmandg1 [string trim [lindex $line_split 28]]
 	set imp_porttermicag [string trim [lindex $line_split 29]]
 	set imp_pot_nomg [string trim [lindex $line_split 30]]
 	set imp_pot_nomg [string trim [lindex $line_split 31]]
 	set totale_pot [string trim [lindex $line_split 32]]
 	set imp_ora_inizio [string trim [lindex $line_split 33]]
 	set imp_ora_fine [string trim [lindex $line_split 34]]
 	set imp_anno_costg1 [string trim [lindex $line_split 35]]
 	set imp_anno_installazione [string trim [lindex $line_split 36]]
 	set imp_manutentditta [string trim [lindex $line_split 37]]
 	set imp_costrg1 [string trim [lindex $line_split 38]]
	set imp_modg1 [string trim [lindex $line_split 39]]
	set cod_utgi [string trim [lindex $line_split 40]]
	set imp_note_non_pres_appuntam           [string trim [lindex $line_split 41]]
	set imp_note_no_disimpegno               [string trim [lindex $line_split 42]]
	set imp_note_no_parete_attest            [string trim [lindex $line_split 43]]
	set imp_note_no_libr_centrale            [string trim [lindex $line_split 44]]
	set imp_note_no_allegato_H               [string trim [lindex $line_split 45]]
	set imp_note_sfiato_gasolio              [string trim [lindex $line_split 46]]
	set imp_note_dep_gasolio_no_norma        [string trim [lindex $line_split 47]]
	set imp_note_serb_gasol_loc_cald         [string trim [lindex $line_split 48]]
	set imp_note_impian_gPL_camoagna         [string trim [lindex $line_split 49]]
	set imp_note_no_manut_prec               [string trim [lindex $line_split 50]]
	set imp_note_no_man_ver_prec             [string trim [lindex $line_split 51]]
	set imp_note_impian_disattivato          [string trim [lindex $line_split 52]]
	set imp_note_imp_camera_bagno            [string trim [lindex $line_split 53]]
	set imp_note_can_fumo_da_sostituire      [string trim [lindex $line_split 54]]
	set imp_note_si_consi_sost_fumo          [string trim [lindex $line_split 55]]
	set imp_note_rila_dich_potenza           [string trim [lindex $line_split 56]]
	set imp_note_imp_instal_autorimessa      [string trim [lindex $line_split 57]]
	set imp_note_canale_fumo_no_norma        [string trim [lindex $line_split 58]]
	set imp_note_serb_gasolio_autorimessa    [string trim [lindex $line_split 59]]
	set imp_note_cert_bombolone              [string trim [lindex $line_split 60]]
	set imp_fluidotermacqua                  [string trim [lindex $line_split 61]]
	set imp_fluidoteraria                    [string trim [lindex $line_split 62]]
	set imp_pot_nomg1                        [string trim [lindex $line_split 63]]
	set imp_porttermicag1                    [string trim [lindex $line_split 64]]
	set imp_ultima_verifica                  [string trim [lindex $line_split 65]]
	set imp_mediadelletreprove               [string trim [lindex $line_split 66]]
	set imp_impiantononinuso                 [string trim [lindex $line_split 67]]
	set imp_costrB1                          [string trim [lindex $line_split 68]]
	set imp_statodispcontrollog1             [string trim [lindex $line_split 69]]
	set imp_taratregcontrg1                  [string trim [lindex $line_split 70]]
	set imp_rispnormag1                      [string trim [lindex $line_split 71]]
	set imp_risp_rend_min_412_g1             [string trim [lindex $line_split 72]]
 	set imp_costrg2                          [string trim [lindex $line_split 73]]
 	set imp_costrg3                          [string trim [lindex $line_split 74]]
	set imp_modg2                            [string trim [lindex $line_split 75]]
	set imp_modg3                            [string trim [lindex $line_split 76]]
	set imp_pot_nomg2                        [string trim [lindex $line_split 77]]
	set imp_pot_nomg3                        [string trim [lindex $line_split 78]]
	set imp_anno_costg2                      [string trim [lindex $line_split 79]]
	set imp_anno_costg3                      [string trim [lindex $line_split 80]]
	set imp_costrB2                          [string trim [lindex $line_split 81]]
	set imp_costrB3                          [string trim [lindex $line_split 82]]
	set imp_tempfumig2                       [string trim [lindex $line_split 83]]
	set imp_tempfumig3                       [string trim [lindex $line_split 84]]
	set imp_tempambienteg2                   [string trim [lindex $line_split 85]]
	set imp_tempambienteg3                   [string trim [lindex $line_split 86]]
	set imp_co2g2                            [string trim [lindex $line_split 87]]
	set imp_co2g3                            [string trim [lindex $line_split 88]]
	set imp_bacharachg2                      [string trim [lindex $line_split 89]]
	set imp_bacharachg3                      [string trim [lindex $line_split 90]]
	set imp_cofumisecchig2                   [string trim [lindex $line_split 91]]
	set imp_cofumisecchig3                   [string trim [lindex $line_split 92]]
	set imp_cog2                             [string trim [lindex $line_split 93]]
	set imp_cog3                             [string trim [lindex $line_split 94]]
	set imp_o2g2                             [string trim [lindex $line_split 95]]
	set imp_o2g3                             [string trim [lindex $line_split 96]]
	set imp_perdcalsensg1                    [string trim [lindex $line_split 97]]
	set imp_perdcalsensg2                    [string trim [lindex $line_split 98]]
	set imp_perdcalsensg3                    [string trim [lindex $line_split 99]]
	set imp_rendcombpotnomg2                 [string trim [lindex $line_split 100]]
	set imp_rendcombpotnomg3                 [string trim [lindex $line_split 101]]
	set imp_rendmisurato2g1                  [string trim [lindex $line_split 102]]
	set imp_rendmisurato2g2                  [string trim [lindex $line_split 103]]
	set imp_rendmisurato2g3                  [string trim [lindex $line_split 104]]
	set imp_rendmin412g2                     [string trim [lindex $line_split 105]]
	set imp_rendmin412g3                     [string trim [lindex $line_split 106]]
	set stato_coibeng2                       [string trim [lindex $line_split 107]]
	set stato_coibeng3                       [string trim [lindex $line_split 108]]
	set imp_statocannafumg2                  [string trim [lindex $line_split 109]]
	set imp_statocannafumg3                  [string trim [lindex $line_split 110]]
	set imp_statodispcontrollog2             [string trim [lindex $line_split 111]]
	set imp_statodispcontrollog3             [string trim [lindex $line_split 112]]
	set imp_taratregcontrg2                  [string trim [lindex $line_split 113]]
	set imp_taratregcontrg3                  [string trim [lindex $line_split 114]]
 	set imp_puntatoreg2                      [string trim [lindex $line_split 115]]
 	set imp_puntatoreg3                      [string trim [lindex $line_split 116]]
 	set imp_tempmandg2                       [string trim [lindex $line_split 117]]
 	set imp_tempmandg3                       [string trim [lindex $line_split 118]]
 	set imp_porttermicag2                    [string trim [lindex $line_split 119]]
 	set imp_porttermicag3                    [string trim [lindex $line_split 120]]
	set imp_ultima_manutenzioneg2            [string trim [lindex $line_split 121]]
	set imp_ultima_manutenzioneg3            [string trim [lindex $line_split 122]]
	set imp_ultima_verificag2                [string trim [lindex $line_split 123]]
	set imp_ultima_verificag3                [string trim [lindex $line_split 124]]
	set imp_risp_rend_min_412_g2             [string trim [lindex $line_split 125]]
	set imp_risp_rend_min_412_g3             [string trim [lindex $line_split 126]]
	set new1_manu_prec_8a_g2                 [string trim [lindex $line_split 127]]
	set new1_manu_prec_8a_g3                 [string trim [lindex $line_split 128]]
 	set manutenzione_8a_g2                   [string trim [lindex $line_split 129]]
 	set manutenzione_8a_g3                   [string trim [lindex $line_split 130]]
	set imp_rispnormag2                      [string trim [lindex $line_split 131]]
	set imp_rispnormag3                      [string trim [lindex $line_split 132]]
	set imp_controllo_ril_sup                [string trim [lindex $line_split 133]]
	set imp_centrale_non_a_norma             [string trim [lindex $line_split 134]]
	set imp_modB1                            [string trim [lindex $line_split 135]]
	set imp_modB2                            [string trim [lindex $line_split 136]]
	set imp_modB3                            [string trim [lindex $line_split 137]]
	set tipo_bruciatore                      [string trim [lindex $line_split 138]]


	set mod_funz "0"
	if {[string equal $imp_fluidotermacqua 1]} {
	    set mod_funz "1"
	}
	if {[string equal $imp_fluidoteraria 1]} {
	    set mod_funz "2"
	}

	if {$imp_mediadelletreprove == "1"} {
	    set imp_mediadelletreprove "S"
	} else {
	    set imp_mediadelletreprove "N"
	}

	if {$imp_impiantononinuso == "1"} {
	    set imp_impiantononinuso "S"
	} else {
	    set imp_impiantononinuso "N"
	}

	set cod_impianto_int [db_string query "select cod_impianto as cod_impianto_int from coimaimp where cod_impianto_est = :imp_n_dich"]
	set cod_inco [db_string query "select cod_inco from coiminco where cod_impianto = :cod_impianto_int and data_verifica = :imp_data_controllo and stato != '5'" -default ""]

	db_1row sel_cimpg1 "select nextval('coimcimp_s') as cod_cimpg"

	db_dml ins_cimpg1 "insert into coimcimp 
                     ( cod_cimp
                     , ora_inizio_controllo
                     , ora_fine_controllo
                     , data_costruzione
                     , note_manu
                     , cod_impianto
                     , gen_prog
                     , cod_inco
                     , data_controllo
                     , cod_opve
                     , presenza_libretto
                     , stato_coiben
                     , rend_comb_conv
                     , rend_comb_min
                     , co2_md
                     , indic_fumosita_md
                     , manutenzione_8a
                     , note_conf
                     , cod_combustibile
                     , cod_responsabile
                     , data_ins
                     , utente
                     , new1_canali_a_norma
                     , new1_data_ultima_manu
                     , new1_manu_prec_8a
                     , co_md
                     , puntatore
                     , strumento
                     , temp_fumi_md
                     , t_aria_comb_md
                     , new1_co_rilevato
                     , o2_md
                     , stato_canna_fum
                     , temp_h2o_out_md
                     , mis_port_combust
                     , pot_focolare_nom
                     , pot_utile_nom
                     , flag_tracciato
                     , media_tre_prove
                     , note_costru
                     , ultima_verifica
                     , flag_modello
                     , impianto_non_in_uso
                     , taratura_dispos
                     , uni_10389
                     , rend_comb_8d
                     , perdita_ai_fumi
                     , rendimento_p_2_perc
                     , verifica_dispo
                     , controllo_rilevato)
                       values 
                     ( :cod_cimpg
                     , :imp_ora_inizio
                     , :imp_ora_fine
                     , :imp_anno_costg1
                     , :imp_manutentditta
                     , :cod_impianto_int
                     , '1'
                     , :cod_inco
                     , :imp_data_controllo
                     , :cod_opve
                     , :presenza_libretto
                     , :stato_coibeng1
                     , :imp_rendcombpotnomg1
                     , :imp_rendmin412g1
                     , :imp_co2g1
                     , :imp_bacharachg1
                     , :manutenzione_8a_g1
                     , :imp_note
                     , :cod_combustibile
                     , :cod_responsabile
                     , :current_date
                     , :utente
                     , :new1_canali_a_norma
                     , :imp_ultima_manutenzione
                     , :new1_manu_prec_8a_g1
                     , :imp_cofumisecchig1
                     , :imp_puntatoreg1
                     , :imp_numero_serie
                     , :imp_tempfumig1
                     , :imp_tempambienteg1
                     , :imp_cog1
                     , :imp_o2g1
                     , :imp_statocannafumg1
                     , :imp_tempmandg1
                     , :imp_porttermicag1
                     , :imp_pot_nomg1
                     , :imp_porttermicag1
                     , 'N1'
                     , :imp_mediadelletreprove
                     , :imp_costrg1
                     , :imp_ultima_verifica
                     , 'S'
                     , :imp_impiantononinuso
                     , :imp_taratregcontrg1
                     , :imp_rispnormag1
                     , :imp_risp_rend_min_412_g1
                     , :imp_perdcalsensg1
                     , :imp_rendmisurato2g1
                     , :imp_statodispcontrollog1
                     , :imp_controllo_ril_sup
                     )"

	if {![string equal $imp_pot_nomg2 ""]
          ||![string equal $imp_porttermicag2 ""]} {
	    db_1row sel_cimpg2 "select nextval('coimcimp_s') as cod_cimpg2"
	    db_dml ins_cimpg2 "insert into coimcimp 
                     ( cod_cimp
                     , ora_inizio_controllo
                     , ora_fine_controllo
                     , data_costruzione
                     , note_manu
                     , cod_impianto
                     , gen_prog
                     , cod_inco
                     , data_controllo
                     , cod_opve
                     , presenza_libretto
                     , stato_coiben
                     , rend_comb_conv
                     , rend_comb_min
                     , co2_md
                     , indic_fumosita_md
                     , manutenzione_8a
                     , note_conf
                     , cod_combustibile
                     , cod_responsabile
                     , data_ins
                     , utente
                     , new1_canali_a_norma
                     , new1_data_ultima_manu
                     , new1_manu_prec_8a
                     , co_md
                     , puntatore
                     , strumento
                     , temp_fumi_md
                     , t_aria_comb_md
                     , new1_co_rilevato
                     , o2_md
                     , stato_canna_fum
                     , temp_h2o_out_md
                     , mis_port_combust
                     , pot_focolare_nom
                     , pot_utile_nom
                     , flag_tracciato
                     , media_tre_prove
                     , note_costru
                     , ultima_verifica
                     , flag_modello
                     , impianto_non_in_uso
                     , taratura_dispos
                     , uni_10389
                     , rend_comb_8d
                     , perdita_ai_fumi
                     , rendimento_p_2_perc
                     , verifica_dispo
                     , controllo_rilevato)
                       values 
                     ( :cod_cimpg2
                     , :imp_ora_inizio
                     , :imp_ora_fine
                     , :imp_anno_costg2
                     , :imp_manutentditta
                     , :cod_impianto_int
                     , '2'
                     , :cod_inco
                     , :imp_data_controllo
                     , :cod_opve
                     , :presenza_libretto
                     , :stato_coibeng2
                     , :imp_rendcombpotnomg2
                     , :imp_rendmin412g2
                     , :imp_co2g2
                     , :imp_bacharachg2
                     , :manutenzione_8a_g2
                     , :imp_note
                     , :cod_combustibile
                     , :cod_responsabile
                     , :current_date
                     , :utente
                     , :new1_canali_a_norma
                     , :imp_ultima_manutenzione
                     , :new1_manu_prec_8a_g2
                     , :imp_cofumisecchig2
                     , :imp_puntatoreg2
                     , :imp_numero_serie
                     , :imp_tempfumig2
                     , :imp_tempambienteg2
                     , :imp_cog2
                     , :imp_o2g2
                     , :imp_statocannafumg2
                     , :imp_tempmandg2
                     , :imp_porttermicag2
                     , :imp_pot_nomg2
                     , :imp_porttermicag2
                     , 'N1'
                     , :imp_mediadelletreprove
                     , :imp_costrg2
                     , :imp_ultima_verifica
                     , 'S'
                     , :imp_impiantononinuso
                     , :imp_taratregcontrg2
                     , :imp_rispnormag2
                     , :imp_risp_rend_min_412_g2
                     , :imp_perdcalsensg2
                     , :imp_rendmisurato2g2
                     , :imp_statodispcontrollog2
                     , :imp_controllo_ril_sup
                     )"
	}

	if {![string equal $imp_pot_nomg3 ""]
          ||![string equal $imp_porttermicag3 ""]} {
	    db_1row sel_cimpg3 "select nextval('coimcimp_s') as cod_cimpg3"
	    db_dml ins_cimpg3 "insert into coimcimp 
                     ( cod_cimp
                     , ora_inizio_controllo
                     , ora_fine_controllo
                     , data_costruzione
                     , note_manu
                     , cod_impianto
                     , gen_prog
                     , cod_inco
                     , data_controllo
                     , cod_opve
                     , presenza_libretto
                     , stato_coiben
                     , rend_comb_conv
                     , rend_comb_min
                     , co2_md
                     , indic_fumosita_md
                     , manutenzione_8a
                     , note_conf
                     , cod_combustibile
                     , cod_responsabile
                     , data_ins
                     , utente
                     , new1_canali_a_norma
                     , new1_data_ultima_manu
                     , new1_manu_prec_8a
                     , co_md
                     , puntatore
                     , strumento
                     , temp_fumi_md
                     , t_aria_comb_md
                     , new1_co_rilevato
                     , o2_md
                     , stato_canna_fum
                     , temp_h2o_out_md
                     , mis_port_combust
                     , pot_focolare_nom
                     , pot_utile_nom
                     , flag_tracciato
                     , media_tre_prove
                     , note_costru
                     , ultima_verifica
                     , flag_modello
                     , impianto_non_in_uso
                     , taratura_dispos
                     , uni_10389
                     , rend_comb_8d
                     , perdita_ai_fumi
                     , rendimento_p_2_perc
                     , verifica_dispo
                     , controllo_rilevato)
                       values 
                     ( :cod_cimpg3
                     , :imp_ora_inizio
                     , :imp_ora_fine
                     , :imp_anno_costg3
                     , :imp_manutentditta
                     , :cod_impianto_int
                     , '3'
                     , :cod_inco
                     , :imp_data_controllo
                     , :cod_opve
                     , :presenza_libretto
                     , :stato_coibeng3
                     , :imp_rendcombpotnomg3
                     , :imp_rendmin412g3
                     , :imp_co2g3
                     , :imp_bacharachg3
                     , :manutenzione_8a_g3
                     , :imp_note
                     , :cod_combustibile
                     , :cod_responsabile
                     , :current_date
                     , :utente
                     , :new1_canali_a_norma
                     , :imp_ultima_manutenzione
                     , :new1_manu_prec_8a_g3
                     , :imp_cofumisecchig3
                     , :imp_puntatoreg3
                     , :imp_numero_serie
                     , :imp_tempfumig3
                     , :imp_tempambienteg3
                     , :imp_cog3
                     , :imp_o2g3
                     , :imp_statocannafumg3
                     , :imp_tempmandg3
                     , :imp_porttermicag3
                     , :imp_pot_nomg3
                     , :imp_porttermicag3
                     , 'N1'
                     , :imp_mediadelletreprove
                     , :imp_costrg3
                     , :imp_ultima_verifica
                     , 'S'
                     , :imp_impiantononinuso
                     , :imp_taratregcontrg3
                     , :imp_rispnormag3
                     , :imp_risp_rend_min_412_g3
                     , :imp_perdcalsensg3
                     , :imp_rendmisurato2g3
                     , :imp_statodispcontrollog3
                     , :imp_controllo_ril_sup
                     )"
	}

	set esito "P"

	if {[string equal $imp_note_non_pres_appuntam 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '1'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'1'
                                                      ,'1'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_no_disimpegno 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '30'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'30'
                                                      ,'30'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_impian_disattivato 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '28'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'28'
                                                      ,'28'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_no_libr_centrale 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '33'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'33'
                                                      ,'33'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
		db_1row sel_cod_todo "select nextval('coimtodo_s') as cod_todo"
                db_dml ins_todo "insert
                                   into coimtodo ( 
                                                  cod_todo
                                                , cod_impianto
                                                , cod_cimp_dimp
                                                , tipologia
                                                , note
                                                , data_evento)
                                           values (
                                                  :cod_todo
                                                ,:cod_impianto_int
                                                ,:cod_cimpg
                                                ,'2'
                                                ,'Manca libretto impianto'
                                                ,current_date)"
	    }
	}
	if {[string equal $imp_note_no_parete_attest 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '31'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'31'
                                                      ,'31'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_centrale_non_a_norma "S"]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '29'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'29'
                                                      ,'29'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_no_allegato_H 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '35'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'35'
                                                      ,'35'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
		db_1row sel_cod_todo "select nextval('coimtodo_s') as cod_todo"
                db_dml ins_todo "insert
                                   into coimtodo ( 
                                                  cod_todo
                                                , cod_impianto
                                                , cod_cimp_dimp
                                                , tipologia
                                                , note
                                                , data_evento)
                                           values (
                                                  :cod_todo
                                                ,:cod_impianto_int
                                                ,:cod_cimpg
                                                ,'2'
                                                ,'Manca allegato H'
                                                ,current_date)"
	    }
	}
	if {[string equal $imp_note_sfiato_gasolio 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '14'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'14'
                                                      ,'14'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	
	if {[string equal $imp_note_dep_gasolio_no_norma 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '15'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'15'
                                                      ,'15'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_serb_gasol_loc_cald 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '16'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'16'
                                                      ,'16'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
		}
	}
	if {[string equal $imp_note_impian_gPL_camoagna 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '10'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'10'
                                                      ,'10'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_no_manut_prec 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '19'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'19'
                                                      ,'19'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
		db_1row sel_cod_todo "select nextval('coimtodo_s') as cod_todo"
                db_dml ins_todo "insert
                                   into coimtodo ( 
                                                  cod_todo
                                                , cod_impianto
                                                , cod_cimp_dimp
                                                , tipologia
                                                , note
                                                , data_evento)
                                           values (
                                                  :cod_todo
                                                ,:cod_impianto_int
                                                ,:cod_cimpg
                                                ,'2'
                                                ,'Manca manutenzione precedente'
                                                ,current_date)"
	    }
	}
	if {[string equal $imp_note_no_man_ver_prec 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '20'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'20'
                                                      ,'20'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
		db_1row sel_cod_todo "select nextval('coimtodo_s') as cod_todo"
                db_dml ins_todo "insert
                                   into coimtodo ( 
                                                  cod_todo
                                                , cod_impianto
                                                , cod_cimp_dimp
                                                , tipologia
                                                , note
                                                , data_evento)
                                           values (
                                                  :cod_todo
                                                ,:cod_impianto_int
                                                ,:cod_cimpg
                                                ,'2'
                                                ,'Manca verfica anno precedente'
                                                ,current_date)"
	    }
	}
	if {[string equal $imp_note_imp_camera_bagno 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '9'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'9'
                                                      ,'9'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	
	if {[string equal $imp_note_can_fumo_da_sostituire 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '22'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'22'
                                                      ,'22'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_si_consi_sost_fumo 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '24'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'24'
                                                      ,'24'
                                                      ,'2'
                                                      ,'RV')"
	    }
	}
	if {[string equal $imp_note_rila_dich_potenza 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '36'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'36'
                                                      ,'36'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
		db_1row sel_cod_todo "select nextval('coimtodo_s') as cod_todo"
                db_dml ins_todo "insert
                                   into coimtodo ( 
                                                  cod_todo
                                                , cod_impianto
                                                , cod_cimp_dimp
                                                , tipologia
                                                , note
                                                , data_evento)
                                           values (
                                                  :cod_todo
                                                ,:cod_impianto_int
                                                ,:cod_cimpg
                                                ,'2'
                                                ,'Manca dichiarazione potenza'
                                                ,current_date)"
	    }
	}
	if {[string equal $imp_note_imp_instal_autorimessa 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '11'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'11'
                                                      ,'11'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_canale_fumo_no_norma 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '23'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'23'
                                                      ,'23'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_serb_gasolio_autorimessa 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '32'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'32'
                                                      ,'32'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}
	if {[string equal $imp_note_cert_bombolone 1]} {
	    if {[db_0or1row sel_anom "select '1' 
                                            from coimanom
                                           where cod_cimp_dimp = :cod_cimpg
                                             and prog_anom = '25'
                                             and flag_origine = 'RV'"] == 0} {
		db_dml ins_anom "insert into coimanom (cod_cimp_dimp
                                                      ,cod_tanom
                                                      ,prog_anom
                                                      ,tipo_anom
                                                      ,flag_origine
                                                      ) values (
                                                       :cod_cimpg
                                                      ,'25'
                                                      ,'25'
                                                      ,'2'
                                                      ,'RV')"
		set esito "N"
	    }
	}

	db_dml upd_cimp "update coimcimp set esito_verifica = :esito
                                   where cod_cimp  = :cod_cimpg"

# 	coiminco stato dell'appuntamento mettere flag a effettuato
 	db_dml upd_gend "update coiminco set stato = '8'
                                           , esito = :esito
                                        where cod_impianto = :cod_impianto_int"

	if {[string equal $imp_anno_installazione ""]
	    || [string equal $imp_anno_installazione "0"]} {
	    set data_installazione ""
	    set agg_anno ""
	} else {
	    set data_installazione "$imp_anno_installazione-01-01"	    
	    set agg_anno "data_installaz = :data_installazione,"
	}

	set imp_costrB1 "$imp_costrB1 - $imp_modB1"
	 db_dml upd_gend1 "update coimgend set pot_focolare_nom = :imp_pot_nomg1,
                                           pot_utile_nom    = :imp_porttermicag1,
                                           cod_combustibile = :cod_combustibile,
                                           modello          = :imp_modg1,
                                           modello_bruc     = :imp_costrB1,
                                           $agg_anno
                                           cod_utgi         = :cod_utgi,
                                           mod_funz         = :mod_funz,
                                           tipo_bruciatore  = :tipo_bruciatore
                                     where cod_impianto = :cod_impianto_int
                                       and gen_prog = '1'"

	if {![string equal $imp_pot_nomg2 ""]
          ||![string equal $imp_porttermicag2 ""]} {
	    if {[db_0or1row sel_gend2 "select '1' from coimgend where gen_prog = '2' and cod_impianto = :cod_impianto_int"] == 0} {
		set imp_costrB2 "$imp_costrB2 - $imp_modB2"
		db_dml ins_gend2 "insert into coimgend ( cod_impianto
                                                   , gen_prog
                                                   , gen_prog_est
                                                   , flag_attivo
                                                   , pot_focolare_nom
                                                   , pot_utile_nom
                                                   , cod_combustibile
                                                   , modello
                                                   , modello_bruc
                                                   , data_installaz
                                                   , cod_utgi
                                                   , mod_funz
                                                   , tipo_bruciatore)
                                                   values
                                                   ( :cod_impianto_int
                                                   , '2'
                                                   , '2'
                                                   , 'S'
                                                   , :imp_pot_nomg2
                                                   , :imp_porttermicag2
                                                   , :cod_combustibile
                                                   , :imp_modg2
                                                   , :imp_costrB2
                                                   , :data_installazione
                                                   , :cod_utgi
                                                   , :mod_funz
                                                   , :tipo_bruciatore)
                                            "
	    } else {
		db_dml upd_gend2 "update coimgend set pot_focolare_nom = :imp_pot_nomg2,
                                           pot_utile_nom    = :imp_porttermicag2,
                                           cod_combustibile = :cod_combustibile,
                                           modello          = :imp_modg2,
                                           modello_bruc     = :imp_costrB2,
                                           $agg_anno
                                           cod_utgi         = :cod_utgi,
                                           mod_funz         = :mod_funz,
                                           tipo_bruciatore  = :tipo_bruciatore
                                     where cod_impianto = :cod_impianto_int
                                       and gen_prog = '2'"
	    }
	    db_dml upd_cimp2 "update coimcimp set esito_verifica = :esito
                                   where cod_cimp  = :cod_cimpg2"
	}

	if {![string equal $imp_pot_nomg3 ""]
          ||![string equal $imp_porttermicag3 ""]} {
	    if {[db_0or1row sel_gend3 "select '1' from coimgend where gen_prog = '3' and cod_impianto = :cod_impianto_int"] == 0} {
		set imp_costrB3 "$imp_costrB3 - $imp_modB3"
		db_dml ins_gend3 "insert into coimgend ( cod_impianto
                                                   , gen_prog
                                                   , gen_prog_est
                                                   , flag_attivo
                                                   , pot_focolare_nom
                                                   , pot_utile_nom
                                                   , cod_combustibile
                                                   , modello
                                                   , modello_bruc
                                                   , data_installaz
                                                   , cod_utgi
                                                   , mod_funz
                                                   , tipo_bruciatore)
                                                   values
                                                   ( :cod_impianto_int
                                                   , '3'
                                                   , '3'
                                                   , 'S'
                                                   , :imp_pot_nomg3
                                                   , :imp_porttermicag3
                                                   , :cod_combustibile
                                                   , :imp_modg3
                                                   , :imp_costrB3
                                                   , :data_installazione
                                                   , :cod_utgi
                                                   , :mod_funz
                                                   , :tipo_bruciatore)
                                            "
	    } else {
		db_dml upd_gend3 "update coimgend set pot_focolare_nom = :imp_pot_nomg3,
                                           pot_utile_nom    = :imp_porttermicag3,
                                           cod_combustibile = :cod_combustibile,
                                           modello          = :imp_modg3,
                                           modello_bruc     = :imp_costrB3,
                                           $agg_anno
                                           cod_utgi         = :cod_utgi,
                                           mod_funz         = :mod_funz,
                                           tipo_bruciatore  = :tipo_bruciatore
                                     where cod_impianto = :cod_impianto_int
                                       and gen_prog = '3'"
	    }
	    db_dml upd_cimp3 "update coimcimp set esito_verifica = :esito
                                   where cod_cimp  = :cod_cimpg3"
	}
	    
	set totale_pot [db_string sel_tot "select sum(pot_focolare_nom) as totale_pot
                                             from coimgend
                                            where cod_impianto = :cod_impianto_int"]

	set totale_port [db_string sel_port "select sum(pot_utile_nom) as totale_port
                                              from coimgend
                                             where cod_impianto = :cod_impianto_int"]

	set n_gen [db_string sel_count "select count(*) from coimgend where cod_impianto = :cod_impianto_int and flag_attivo = 'S'"]

	db_dml upd_aimp "update coimaimp set potenza = :totale_pot,
                                          potenza_utile = :totale_port,
                                          $agg_anno
                                          cod_combustibile = :cod_combustibile,
                                          n_generatori = :n_gen 
                                    where cod_impianto = :cod_impianto_int"

 	incr sup     
     }    
     close $file_inp
    
#     metano
    
     set file_inp [open $spool_dir/$tre r]
     foreach line [split [read $file_inp] \n] {
 	if {[string equal $line ""]} {
 	    continue
 	}
 	set line_split [split $line ";"]
	
 	set imp_n_dichiarazione [string trim [lindex $line_split 0]]
 	set accesso_esterno [string trim [lindex $line_split 1]]
 	set se_intercapedine [string trim [lindex $line_split 2]]
 	set porta_classe_0 [string trim [lindex $line_split 3]]
 	set porta_con_apertura_esterno [string trim [lindex $line_split 4]]
 	set dimensioni_porta [string trim [lindex $line_split 5]]
 	set acces_interno [string trim [lindex $line_split 6]]
 	set disimpegno [string trim [lindex $line_split 7]]
 	set da_disimp_con_lato_est [string trim [lindex $line_split 8]]
 	set da_disimp_rei_30 [string trim [lindex $line_split 9]]
 	set da_disimp_rei_60 [string trim [lindex $line_split 10]]
 	set aeraz_disimpegno [string trim [lindex $line_split 11]]
 	set condotta_aeraz_disimp [string trim [lindex $line_split 12]]
 	set porta_caldaia_rei_30 [string trim [lindex $line_split 13]]
 	set porta_caldaia_rei_60 [string trim [lindex $line_split 14]]
 	set valvola_interc_combustibile [string trim [lindex $line_split 15]]
 	set interr_generale_luce [string trim [lindex $line_split 16]]
 	set estintore [string trim [lindex $line_split 17]]
 	set parete_conf_esterno [string trim [lindex $line_split 18]]
 	set alt_locale_2 [string trim [lindex $line_split 19]]
 	set alt_locale_2_30 [string trim [lindex $line_split 20]]
 	set alt_locale_2_60 [string trim [lindex $line_split 21]]
 	set alt_locale_2_90 [string trim [lindex $line_split 22]]
 	set dispos_di_sicurezza [string trim [lindex $line_split 23]]
 	set ventilazione_qx10 [string trim [lindex $line_split 24]]
 	set ventilazione_qx15 [string trim [lindex $line_split 25]]
 	set ventilazione_qx20 [string trim [lindex $line_split 26]]
 	set ventilazione_qx15_gpl [string trim [lindex $line_split 27]]
 	set ispels [string trim [lindex $line_split 28]]
 	set cpi [string trim [lindex $line_split 29]]
 	set valv_interc_comb_segnaletica [string trim [lindex $line_split 30]]
 	set int_gen_luce_segnaletica [string trim [lindex $line_split 31]]
 	set centr_termica_segnaletica [string trim [lindex $line_split 32]]
 	set estintore_segnaletica [string trim [lindex $line_split 33]]
 	set rampa_a_gas_norma [string trim [lindex $line_split 34]]
	
	set cod_impianto_int [db_string query "select cod_impianto as cod_impianto_int from coimaimp where cod_impianto_est = :imp_n_dichiarazione"]
 	db_1row sel_data "select max(data_ins) as max_data_ins from coimcimp where cod_impianto = :cod_impianto_int and gen_prog = '1'"
 	set cod_cimp [db_string query "select max(cod_cimp) from coimcimp where cod_impianto = :cod_impianto_int and gen_prog = '1'  and data_ins = :max_data_ins"]

 	db_dml ins_srcm "insert into coimsrcm ( cod_cimp
          , accesso_esterno
          , se_intercapedine
          , porta_classe_0
          , porta_con_apertura_esterno
          , dimensioni_porta
          , acces_interno
          , disimpegno
          , da_disimp_con_lato_est
          , da_disimp_rei_30
          , da_disimp_rei_60
          , aeraz_disimpegno
          , condotta_aeraz_disimp
          , porta_caldaia_rei_30
          , porta_caldaia_rei_60
          , valvola_interc_combustibile
          , interr_generale_luce
          , estintore
          , parete_conf_esterno
          , alt_locale_2
          , alt_locale_2_30
          , alt_locale_2_60
          , alt_locale_2_90
          , dispos_di_sicurezza
          , ventilazione_qx10
          , ventilazione_qx15
          , ventilazione_qx20
          , ventilazione_qx15_gpl
          , ispels
          , cpi
          , valv_interc_comb_segnaletica
          , int_gen_luce_segnaletica
          , centr_termica_segnaletica
          , estintore_segnaletica
          , rampa_a_gas_norma
          ) values (
           :cod_cimp
          ,:accesso_esterno
          ,:se_intercapedine
          ,:porta_classe_0
          ,:porta_con_apertura_esterno
          ,:dimensioni_porta
          ,:acces_interno
          ,:disimpegno
          ,:da_disimp_con_lato_est
          ,:da_disimp_rei_30
          ,:da_disimp_rei_60
          ,:aeraz_disimpegno
          ,:condotta_aeraz_disimp
          ,:porta_caldaia_rei_30
          ,:porta_caldaia_rei_60
          ,:valvola_interc_combustibile
          ,:interr_generale_luce
          ,:estintore
          ,:parete_conf_esterno
          ,:alt_locale_2
          ,:alt_locale_2_30
          ,:alt_locale_2_60
          ,:alt_locale_2_90
          ,:dispos_di_sicurezza
          ,:ventilazione_qx10
          ,:ventilazione_qx15
          ,:ventilazione_qx20
          ,:ventilazione_qx15_gpl
          ,:ispels
          ,:cpi
          ,:valv_interc_comb_segnaletica
          ,:int_gen_luce_segnaletica
          ,:centr_termica_segnaletica
          ,:estintore_segnaletica
          ,:rampa_a_gas_norma)"
    
 	incr met
     }    
     close $file_inp
    
#     gasolio
     set file_inp [open $spool_dir/$quattro r]
     foreach line [split [read $file_inp] \n] {
 	if {[string equal $line ""]} {
 	    continue
 	}
 	set line_split [split $line ";"]
 	set imp_n_dichiarazione [string trim [lindex $line_split 0]]
 	set accesso_esterno [string trim [lindex $line_split 1]]
 	set piano_grigliato [string trim [lindex $line_split 2]]
 	set intercapedine [string trim [lindex $line_split 3]]
 	set portaincomb_acc_esterno [string trim [lindex $line_split 4]]
 	set portaincomb_acc_esterno_mag116 [string trim [lindex $line_split 5]]
 	set dimensioni_porta [string trim [lindex $line_split 6]]
 	set accesso_interno [string trim [lindex $line_split 7]]
 	set disimpegno [string trim [lindex $line_split 8]]
 	set struttura_disimp_verificabile [string trim [lindex $line_split 9]]
 	set da_disimpegno_con_lato [string trim [lindex $line_split 10]]
 	set da_disimpegno_senza_lato [string trim [lindex $line_split 11]]
 	set aerazione_disimpegno [string trim [lindex $line_split 12]]
 	set aerazione_tramite_condotto [string trim [lindex $line_split 13]]
 	set porta_disimpegno [string trim [lindex $line_split 14]]
 	set porta_caldaia [string trim [lindex $line_split 15]]
 	set loc_caldaia_rei_60 [string trim [lindex $line_split 16]]
 	set loc_caldaia_rei_120 [string trim [lindex $line_split 17]]
 	set valvola_strappo [string trim [lindex $line_split 18]]
 	set interruttore_gasolio [string trim [lindex $line_split 19]]
 	set estintore [string trim [lindex $line_split 20]]
 	set bocca_di_lupo [string trim [lindex $line_split 21]]
 	set parete_confinante_esterno [string trim [lindex $line_split 22]]
 	set altezza_locale [string trim [lindex $line_split 23]]
 	set altezza_230 [string trim [lindex $line_split 24]]
 	set altezza_250 [string trim [lindex $line_split 25]]
 	set distanza_generatori [string trim [lindex $line_split 26]]
 	set distanza_soff_invol_bollit [string trim [lindex $line_split 27]]
 	set distanza_soff_invol_no_bollit [string trim [lindex $line_split 28]]
 	set pavimento_imperm_soglia [string trim [lindex $line_split 29]]
 	set apert_vent_sino_500000 [string trim [lindex $line_split 30]]
 	set apert_vent_sino_750000 [string trim [lindex $line_split 31]]
 	set apert_vent_sup_750000 [string trim [lindex $line_split 32]]
 	set certif_ispels [string trim [lindex $line_split 33]]
 	set certif_cpi [string trim [lindex $line_split 34]]
 	set serbatoio_esterno [string trim [lindex $line_split 35]]
 	set serbatoio_interno [string trim [lindex $line_split 36]]
 	set serbatoio_loc_caldaia [string trim [lindex $line_split 37]]
 	set sfiato_reticella_h [string trim [lindex $line_split 38]]
 	set segn_valvola_strappo [string trim [lindex $line_split 39]]
 	set segn_interrut_generale [string trim [lindex $line_split 40]]
 	set segn_estintore [string trim [lindex $line_split 41]]
 	set segn_centrale_termica [string trim [lindex $line_split 42]]

	set cod_impianto_int [db_string query "select cod_impianto as cod_impianto_int from coimaimp where cod_impianto_est = :imp_n_dichiarazione"]
 	db_1row sel_data "select max(data_ins) as max_data_ins from coimcimp where cod_impianto = :cod_impianto_int and gen_prog = '1'"
	 set cod_cimp [db_string query "select max(cod_cimp) from coimcimp where cod_impianto = :cod_impianto_int and gen_prog = '1' and data_ins = :max_data_ins"]
	 
 	db_dml ins_srcg "insert into coimsrcg (cod_cimp
              ,accesso_esterno
              ,piano_grigliato
              ,intercapedine
              ,portaincomb_acc_esterno
              ,portaincomb_acc_esterno_mag116
              ,dimensioni_porta
              ,accesso_interno
              ,disimpegno
              ,struttura_disimp_verificabile
              ,da_disimpegno_con_lato
              ,da_disimpegno_senza_lato
              ,aerazione_disimpegno
              ,aerazione_tramite_condotto
              ,porta_disimpegno
              ,porta_caldaia
              ,loc_caldaia_rei_60
              ,loc_caldaia_rei_120
              ,valvola_strappo
              ,interruttore_gasolio
              ,estintore
              ,bocca_di_lupo
              ,parete_confinante_esterno
              ,altezza_locale
              ,altezza_230
              ,altezza_250
              ,distanza_generatori
              ,distanza_soff_invol_bollit
              ,distanza_soff_invol_no_bollit
              ,pavimento_imperm_soglia
              ,apert_vent_sino_500000
              ,apert_vent_sino_750000
              ,apert_vent_sup_750000
              ,certif_ispels
              ,certif_cpi
              ,serbatoio_esterno
              ,serbatoio_interno
              ,serbatoio_loc_caldaia
              ,sfiato_reticella_h
              ,segn_valvola_strappo
              ,segn_interrut_generale
              ,segn_estintore
              ,segn_centrale_termica
              ) values (
              :cod_cimp
              ,:accesso_esterno
              ,:piano_grigliato
              ,:intercapedine
              ,:portaincomb_acc_esterno
              ,:portaincomb_acc_esterno_mag116
              ,:dimensioni_porta
              ,:accesso_interno
              ,:disimpegno
              ,:struttura_disimp_verificabile
              ,:da_disimpegno_con_lato
              ,:da_disimpegno_senza_lato
              ,:aerazione_disimpegno
              ,:aerazione_tramite_condotto
              ,:porta_disimpegno
              ,:porta_caldaia
              ,:loc_caldaia_rei_60
              ,:loc_caldaia_rei_120
              ,:valvola_strappo
              ,:interruttore_gasolio
              ,:estintore
              ,:bocca_di_lupo
              ,:parete_confinante_esterno
              ,:altezza_locale
              ,:altezza_230
              ,:altezza_250
              ,:distanza_generatori
              ,:distanza_soff_invol_bollit
              ,:distanza_soff_invol_no_bollit
              ,:pavimento_imperm_soglia
              ,:apert_vent_sino_500000
              ,:apert_vent_sino_750000
              ,:apert_vent_sup_750000
              ,:certif_ispels
              ,:certif_cpi
              ,:serbatoio_esterno
              ,:serbatoio_interno
              ,:serbatoio_loc_caldaia
              ,:sfiato_reticella_h
              ,:segn_valvola_strappo
              ,:segn_interrut_generale
              ,:segn_estintore
              ,:segn_centrale_termica)"

 	incr gas
	
     }
     close $file_inp
    
#     serbatoio gasolio
     set file_inp [open $spool_dir/$cinque r]
     foreach line [split [read $file_inp] \n] {
 	if {[string equal $line ""]} {
 	    continue
 	}
 	set line_split [split $line ";"]

 	set imp_n_dichiarazione [string trim [lindex $line_split 0]]
 	set loc_escl_deposito_gasolio [string trim [lindex $line_split 1]]
 	set dep_gasolio_esterno [string trim [lindex $line_split 2]]
 	set accesso_ester_con_porta [string trim [lindex $line_split 3]]
 	set loc_materiale_incombustibile [string trim [lindex $line_split 4]]
 	set non_meno_50_cm [string trim [lindex $line_split 5]]
 	set soglia_pavimento [string trim [lindex $line_split 6]]
 	set tra_pareti_60_cm [string trim [lindex $line_split 7]]
 	set comun_con_altri_loc [string trim [lindex $line_split 8]]
 	set dep_serb_in_vista_aperto [string trim [lindex $line_split 9]]
 	set tettoia_all_aperto [string trim [lindex $line_split 10]]
 	set bacino_contenimento [string trim [lindex $line_split 11]]
 	set messa_a_terra [string trim [lindex $line_split 12]]
 	set dep_gasolio_interno_interrato [string trim [lindex $line_split 13]]
 	set porta_solaio_pareti_rei90 [string trim [lindex $line_split 14]]
 	set struttura_locale_a_norma [string trim [lindex $line_split 15]]
 	set dep_gasolio_interno [string trim [lindex $line_split 16]]
 	set locale_caratteristiche_rei120 [string trim [lindex $line_split 17]]
 	set accesso_esterno [string trim [lindex $line_split 18]]
 	set porta_esterna_incombustibile [string trim [lindex $line_split 19]]
 	set disimpegno [string trim [lindex $line_split 20]]
 	set accesso_interno [string trim [lindex $line_split 21]]
 	set da_disimp_lato_esterno [string trim [lindex $line_split 22]]
 	set da_disimp_senza_lato_esterno [string trim [lindex $line_split 23]]
 	set aeraz_disimp_05_mq [string trim [lindex $line_split 24]]
 	set aeraz_disimp_condotta [string trim [lindex $line_split 25]]
 	set porta_disimp [string trim [lindex $line_split 26]]
 	set comunic_con_altri_loc [string trim [lindex $line_split 27]]
 	set porta_deposito [string trim [lindex $line_split 28]]
 	set porta_deposito_h_2_l_08 [string trim [lindex $line_split 29]]
 	set tubo_sfiato [string trim [lindex $line_split 30]]
 	set selle_50_cm_terra [string trim [lindex $line_split 31]]
 	set pavimento_impermeabile [string trim [lindex $line_split 32]]
 	set tra_serb_e_pareti [string trim [lindex $line_split 33]]
 	set valvola_a_strappo [string trim [lindex $line_split 34]]
 	set interruttore_forza_luce [string trim [lindex $line_split 35]]
 	set estintore [string trim [lindex $line_split 36]]
 	set parete_conf_esterno [string trim [lindex $line_split 37]]
 	set ventilazione_locale [string trim [lindex $line_split 38]]
 	set segn_valvola_strappo [string trim [lindex $line_split 39]]
 	set segn_inter_forza_luce [string trim [lindex $line_split 40]]
 	set segn_estintore [string trim [lindex $line_split 41]]
	
	set cod_impianto_int [db_string query "select cod_impianto as cod_impianto_int from coimaimp where cod_impianto_est = :imp_n_dichiarazione"]
 	db_1row sel_data "select max(data_ins) as max_data_ins from coimcimp where cod_impianto = :cod_impianto_int and gen_prog = '1'"
 	set cod_cimp [db_string query "select max(cod_cimp) from coimcimp where cod_impianto = :cod_impianto_int and gen_prog = '1'  and data_ins = :max_data_ins"]

 	db_dml ins_srdg "insert into coimsrdg ( cod_cimp
          , loc_escl_deposito_gasolio
          , dep_gasolio_esterno
          , accesso_ester_con_porta
          , loc_materiale_incombustibile
          , non_meno_50_cm
          , soglia_pavimento
          , tra_pareti_60_cm
          , comun_con_altri_loc
          , dep_serb_in_vista_aperto
          , tettoia_all_aperto
          , bacino_contenimento
          , messa_a_terra
          , dep_gasolio_interno_interrato
          , porta_solaio_pareti_rei90
          , struttura_locale_a_norma
          , dep_gasolio_interno
          , locale_caratteristiche_rei120
          , accesso_esterno
          , porta_esterna_incombustibile
          , disimpegno
          , accesso_interno
          , da_disimp_lato_esterno
          , da_disimp_senza_lato_esterno
          , aeraz_disimp_05_mq
          , aeraz_disimp_condotta
          , porta_disimp
          , comunic_con_altri_loc
          , porta_deposito
          , porta_deposito_h_2_l_08
          , tubo_sfiato
          , selle_50_cm_terra
          , pavimento_impermeabile
          , tra_serb_e_pareti
          , valvola_a_strappo
          , interruttore_forza_luce
          , estintore
          , parete_conf_esterno
          , ventilazione_locale
          , segn_valvola_strappo
          , segn_inter_forza_luce
          , segn_estintore
          ) values (
           :cod_cimp
          ,:loc_escl_deposito_gasolio
          ,:dep_gasolio_esterno
          ,:accesso_ester_con_porta
          ,:loc_materiale_incombustibile
          ,:non_meno_50_cm
          ,:soglia_pavimento
          ,:tra_pareti_60_cm
          ,:comun_con_altri_loc
          ,:dep_serb_in_vista_aperto
          ,:tettoia_all_aperto
          ,:bacino_contenimento
          ,:messa_a_terra
          ,:dep_gasolio_interno_interrato
          ,:porta_solaio_pareti_rei90
          ,:struttura_locale_a_norma
          ,:dep_gasolio_interno
          ,:locale_caratteristiche_rei120
          ,:accesso_esterno
          ,:porta_esterna_incombustibile
          ,:disimpegno
          ,:accesso_interno
          ,:da_disimp_lato_esterno
          ,:da_disimp_senza_lato_esterno
          ,:aeraz_disimp_05_mq
          ,:aeraz_disimp_condotta
          ,:porta_disimp
          ,:comunic_con_altri_loc
          ,:porta_deposito
          ,:porta_deposito_h_2_l_08
          ,:tubo_sfiato
          ,:selle_50_cm_terra
          ,:pavimento_impermeabile
          ,:tra_serb_e_pareti
          ,:valvola_a_strappo
          ,:interruttore_forza_luce
          ,:estintore
          ,:parete_conf_esterno
          ,:ventilazione_locale
          ,:segn_valvola_strappo
          ,:segn_inter_forza_luce
          ,:segn_estintore)"

 	incr sga
	
     }
     close $file_inp
}

ad_return_template

