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
    {conta_c_inf ""}
    {conta_c_inf_err ""}
    {conta_sup ""}
    {conta_sup_err ""}
    {conta_schegas ""}
    {conta_schegas_err ""}
    {conta_schemet ""}
    {conta_schemet_err ""}
    {conta_scheserb ""}
    {conta_scheserb_err ""}
    {righe_con_errori ""}
    {righe_con_errori2 ""}
    file_name:trim,optional
    file_name.tmpfile:tmpfile,optional
    file_name2:trim,optional
    file_name2.tmpfile:tmpfile,optional
    file_name3:trim,optional
    file_name3.tmpfile:tmpfile,optional
    file_name4:trim,optional
    file_name4.tmpfile:tmpfile,optional
    file_name5:trim,optional
    file_name5.tmpfile:tmpfile,optional
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}




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
set titolo              "Caricamento controlli/schede rilievo da file esterno"
switch $funzione {
    I {set button_label "Diagnostico"
	set page_title   "Lancio $titolo "}
    V {set button_label ""
	set page_title   "$titolo lanciato"}
}

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name     "coimcimp"
set readonly_key  "readonly"
set readonly_fld  "readonly"
set disabled_fld  "disabled"
set onsubmit_cmd  ""
switch $funzione {
    "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
        set onsubmit_cmd "enctype {multipart/form-data}"
    }
    "M" {set readonly_fld \{\}
        set disabled_fld \{\}
    }
}

form create $form_name \
    -html    $onsubmit_cmd

if {$funzione == "I"} {
    element create $form_name file_name \
	-label   "File da importare" \
	-widget   file \
	-datatype text \
	-html    "size 40 class form_element" \
	-optional
} else {
    element create $form_name file_name \
	-label   "File da importare" \
	-widget   text \
	-datatype text \
	-html    "size 40 readonly {} class form_element" \
	-optional
}

if {$funzione == "I"} {
    element create $form_name file_name2 \
	-label   "File da importare" \
	-widget   file \
	-datatype text \
	-html    "size 40 class form_element" \
	-optional
} else {
    element create $form_name file_name2 \
	-label   "File da importare" \
	-widget   text \
	-datatype text \
	-html    "size 40 readonly {} class form_element" \
	-optional
}

if {$funzione == "I"} {
    element create $form_name file_name3 \
	-label   "File da importare" \
	-widget   file \
	-datatype text \
	-html    "size 40 class form_element" \
	-optional
} else {
    element create $form_name file_name3 \
	-label   "File da importare" \
	-widget   text \
	-datatype text \
	-html    "size 40 readonly {} class form_element" \
	-optional
}

if {$funzione == "I"} {
    element create $form_name file_name4 \
	-label   "File da importare" \
	-widget   file \
	-datatype text \
	-html    "size 40 class form_element" \
	-optional
} else {
    element create $form_name file_name4 \
	-label   "File da importare" \
	-widget   text \
	-datatype text \
	-html    "size 40 readonly {} class form_element" \
	-optional
}

if {$funzione == "I"} {
    element create $form_name file_name5 \
	-label   "File da importare" \
	-widget   file \
	-datatype text \
	-html    "size 40 class form_element" \
	-optional
} else {
    element create $form_name file_name5 \
	-label   "File da importare" \
	-widget   text \
	-datatype text \
	-html    "size 40 readonly {} class form_element" \
	-optional
}

element create $form_name funzione     -widget hidden -datatype text -optional
element create $form_name caller       -widget hidden -datatype text -optional
element create $form_name nome_funz    -widget hidden -datatype text -optional
element create $form_name submit       -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name current_date -widget hidden -datatype text -optional
element create $form_name current_time -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione       -value $funzione
    element set_properties $form_name caller         -value $caller
    element set_properties $form_name nome_funz      -value $nome_funz

    if {$funzione == "I"} {
	set current_date [iter_set_sysdate]
	set current_time [iter_set_systime]

	element set_properties $form_name current_date  -value $current_date
	element set_properties $form_name current_time  -value $current_time
    } 
}

if {[form is_valid $form_name]} {

    #lo setto null in attesa di decidere se torglierlo o no
    set cod_inco ""
    
    # form valido dal punto di vista del templating system
    
    set current_date       [element::get_value $form_name current_date]
    set current_time       [element::get_value $form_name current_time]
    set file_name          [element::get_value $form_name file_name]
    set file_name2         [element::get_value $form_name file_name2]
    set file_name3         [element::get_value $form_name file_name3]
    set file_name4         [element::get_value $form_name file_name4]
    set file_name5         [element::get_value $form_name file_name5]
    
    
    # controlli standard su numeri e date, per Ins ed Upd
    # verifico l'estensione dei file dichiarati in input
    # verifico che tutti i file di acquisizione dati siano stati dichiarati dall'utente

    set error_num 0
    
    if {$funzione == "I"} {
	
	if {![string equal $file_name ""]} {
	    set extension [file extension $file_name]
	    if {($extension != ".csv") && ($extension != ".txt")} {
		element::set_error $form_name file_name "Il file non ha estensione csv o txt"
		incr error_num
	    } else {
		set tmpfile ${file_name.tmpfile}
		if {![file exists $tmpfile]} {
		    element::set_error $form_name file_name "File con estensione errata"
		    incr error_num
		}
	    }
	} else {
	    element::set_error $form_name file_name "File non trovato o mancante"
	    incr error_num
	}

	if {![string equal $file_name2 ""]} {
	    set extension [file extension $file_name2]
	    if {($extension != ".csv") && ($extension != ".txt")} {
		element::set_error $form_name file_name2 "Il file non ha estensione csv o txt"
		incr error_num
	    } else {
		set tmpfile2 ${file_name2.tmpfile}
		if {![file exists $tmpfile2]} {
		    element::set_error $form_name file_name2 "File con estensione errata"
		    incr error_num
		}
	    }
	} else {
	    element::set_error $form_name file_name2 "File non trovato o mancante"
	    incr error_num
	}

	if {![string equal $file_name3 ""]} {
	    set extension [file extension $file_name3]
	    if {($extension != ".csv") && ($extension != ".txt")} {
		element::set_error $form_name file_name3 "Il file non ha estensione csv o txt"
		incr error_num		
	    } else {
		set tmpfile3 ${file_name3.tmpfile}
		if {![file exists $tmpfile3]} {
		    element::set_error $form_name file_name3 "File con estensione errata"
		    incr error_num
		}
	    }
	} else {
	    element::set_error $form_name file_name3 "File non trovato o mancante"
	    incr error_num
	}

	if {![string equal $file_name4 ""]} {
	    set extension [file extension $file_name4]
	    if {($extension != ".csv") && ($extension != ".txt")} {
		element::set_error $form_name file_name4 "Il file non ha estensione csv o txt"
		incr error_num
	    } else {
		set tmpfile4 ${file_name4.tmpfile}
		if {![file exists $tmpfile4]} {
		    element::set_error $form_name file_name4 "File con estensione errata"
		    incr error_num
		}
	    }
	} else {
	    element::set_error $form_name file_name4 "File non trovato o mancante"
	    incr error_num
	}

	if {![string equal $file_name5 ""]} {
	    set extension [file extension $file_name5]
	    if {($extension != ".csv") && ($extension != ".txt")} {
		element::set_error $form_name file_name5 "Il file non ha estensione csv o txt"
		incr error_num
	    } else {
		set tmpfile5 ${file_name5.tmpfile}
		if {![file exists $tmpfile5]} {
		    element::set_error $form_name file_name5 "File con estensione errata"
		    incr error_num
		}
	    }
	} else {
	    element::set_error $form_name file_name5 "File non trovato"
	    incr error_num
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }
    if {$funzione == "I"} {

	set conta_c_inf 0
	set conta_c_inf_err 0
	set counter 0

	db_transaction {
	    set file_inp [open $tmpfile r]
	    set filout [open $spool_dir/rapporti-ver-inf.txt w]
	    set file_ok [open $spool_dir/rapporti-ver-inf-chr.txt w]	    
	    set utente "INS"
	    set righe_con_errori 0
	    foreach line [split [read $file_inp] \n] {
		set conta_errori 0
		set errori ""		    
		#salto la prima riga perchè contiene i dati di definiione della tabella
		if {[string equal $counter 0]} {
		    set counter 1
		    continue
		}
		#salto eventuali righe bianche che potrebbero formarsi alla fine del flusso dati in caricamento
		if {[string equal $line ""]} {
		    continue
		}
		
		set line_split [split $line ";"]

		set imp_n_dichiarazione                  [string trim [lindex $line_split 0]]
		set imp_data_controllo                   [string trim [lindex $line_split 1]]
		set imp_ora_inizio                       [string trim [lindex $line_split 2]]
		### non gestiti(manca sul database)
		set imp_ora_fine                         [string trim [lindex $line_split 3]]
		set imp_numeroserie                      [string trim [lindex $line_split 4]]
		
		### aggiungi campo su cimp
		set imp_puntatore                        [string trim [lindex $line_split 5]]
		set imp_nomeverificatore                 [string trim [lindex $line_split 6]]
		set imp_costruttore                      [string trim [lindex $line_split 7]]
		
		### modello (su generatore)
		set imp_modello                          [string trim [lindex $line_split 8]]
		set imp_potenza_n                        [string trim [lindex $line_split 9]]
		
		### non gestita(manca sul database)
		set imp_anno_costruzione                 [string trim [lindex $line_split 10]]
		set imp_anno_installazione               [string trim [lindex $line_split 11]]
		set imp_metano                           [string trim [lindex $line_split 12]]
		set imp_gpl                              [string trim [lindex $line_split 13]]
		set imp_gasolio                          [string trim [lindex $line_split 14]]
		
		### non gestita (vado a testare il campo imp_legna)
		set imp_altrospec                        [string trim [lindex $line_split 15]]
      		set imp_tipo_b                           [string trim [lindex $line_split 16]]
		set imp_tipo_c                           [string trim [lindex $line_split 17]]
		
		### non gestiti(manca sul database)
		set imp_a_muro                           [string trim [lindex $line_split 18]]
		set imp_a_terra                          [string trim [lindex $line_split 19]]
		set imp_acqua                            [string trim [lindex $line_split 20]]
		set imp_aria                             [string trim [lindex $line_split 21]]
		set imp_soffiato                         [string trim [lindex $line_split 22]]
		set imp_atmosferico                      [string trim [lindex $line_split 23]]
		
		### non gestiti(manca sul database)(data verifica e' un doppione di data controllo)
		set imp_dallo_strumento                  [string trim [lindex $line_split 24]]
		set imp_dal_libretto                     [string trim [lindex $line_split 25]]
		set imp_data_verifica                    [string trim [lindex $line_split 26]]
		set imp_co2                              [string trim [lindex $line_split 27]]
		set imp_bacharach                        [string trim [lindex $line_split 28]]
		
		### non gestito(come rendimento uso il campo rendimento rilevato)
		set imp_rend_misurato                    [string trim [lindex $line_split 29]]
		set imp_rend_misurato2                   [string trim [lindex $line_split 30]]
		set imp_rend_DPR412                      [string trim [lindex $line_split 31]]
		
		### ???
		set imp_rispetta_si                      [string trim [lindex $line_split 32]]
		set imp_rispetta_no                      [string trim [lindex $line_split 33]]
		
		set imp_buona_coib                       [string trim [lindex $line_split 34]]
		set imp_mediocre_coib                    [string trim [lindex $line_split 35]]
		set imp_scadente_coib                    [string trim [lindex $line_split 36]]
		
		### stato canna fumaria
		set imp_buona_fumar                      [string trim [lindex $line_split 37]]
		set imp_mediocre_fumar                   [string trim [lindex $line_split 38]]
		set imp_scadente_fumar                   [string trim [lindex $line_split 39]]
		
		set imp_positiva                         [string trim [lindex $line_split 40]]
		set imp_negativa                         [string trim [lindex $line_split 41]]
		
		### non gestiti(colonna vuota)
		set imp_valorehPa                        [string trim [lindex $line_split 42]]
		set imp_hPa_nonrilevato                  [string trim [lindex $line_split 43]]
		
		### note_conf
		set imp_note                             [string trim [lindex $line_split 44]]
		
		### non gestito(colonna vuota)
		set imp_mese_controllo                   [string trim [lindex $line_split 45]]
		
		### ???
		set imp_controllo_rilev_si               [string trim [lindex $line_split 46]]
		set imp_controllo_rilev_no               [string trim [lindex $line_split 47]]
		
		set imp_manutentore                      [string trim [lindex $line_split 48]]
		
		### non gestito(il campo contiene sempre 'NO')
		set imp_destinatoa                       [string trim [lindex $line_split 49]]
		
		set imp_riscald                          [string trim [lindex $line_split 50]]
		set imp_riscald_sanit                    [string trim [lindex $line_split 51]]
		set imp_solo_sanit                       [string trim [lindex $line_split 52]]
		
		### stato impianto
		set imp_imp_non_in_uso                   [string trim [lindex $line_split 53]]
		
		set imp_port_nominale                    [string trim [lindex $line_split 54]]
		
		### non gestito(manca sul database)
		set imp_data_ultima_verifica             [string trim [lindex $line_split 55]]
      		set imp_co_fumisecchi_ril                [string trim [lindex $line_split 56]]
		set imp_indice_bacharach_ril             [string trim [lindex $line_split 57]]
		set imp_rendimento_rilevato              [string trim [lindex $line_split 58]]
		
		### ???
		set imp_differrenza_perc                 [string trim [lindex $line_split 59]]
		
		set imp_man1994                          [string trim [lindex $line_split 60]]
		set imp_man1995                          [string trim [lindex $line_split 61]]
		set imp_man1996                          [string trim [lindex $line_split 62]]
		set imp_man1997                          [string trim [lindex $line_split 63]]
		set imp_man1999                          [string trim [lindex $line_split 64]]
		set imp_man2000                          [string trim [lindex $line_split 65]]
		set imp_man2001                          [string trim [lindex $line_split 66]]
		set imp_man2002                          [string trim [lindex $line_split 67]]
		set imp_man1998                          [string trim [lindex $line_split 68]]
		set imp_man2003                          [string trim [lindex $line_split 69]]
		set imp_man2004                          [string trim [lindex $line_split 70]]
		
		### non gestiti(manca sul database)
		set imp_ver1994                          [string trim [lindex $line_split 71]]
		set imp_ver1995                          [string trim [lindex $line_split 72]]
		set imp_ver1996                          [string trim [lindex $line_split 73]]
		set imp_ver1997                          [string trim [lindex $line_split 74]]
		set imp_ver1999                          [string trim [lindex $line_split 75]]
		set imp_ver2000                          [string trim [lindex $line_split 76]]
		set imp_ver2001                          [string trim [lindex $line_split 77]]
		set imp_ver2002                          [string trim [lindex $line_split 78]]
		set imp_ver1998                          [string trim [lindex $line_split 79]]
		set imp_ver2003                          [string trim [lindex $line_split 80]]
		set imp_ver2004                          [string trim [lindex $line_split 81]]
		
		set imp_data_ult_manutenzione            [string trim [lindex $line_split 82]]

		### non gestiti(manca sul database)
		set imp_data_ult_verifica                [string trim [lindex $line_split 83]]
		set imp_data_invio                       [string trim [lindex $line_split 84]]
		set imp_data_risposta                    [string trim [lindex $line_split 85]]
		set imp_data_invio_no_manut_verif        [string trim [lindex $line_split 86]]
		set imp_data_invio_DPR412                [string trim [lindex $line_split 87]]
		set imp_data_invio_no_lib_impianto       [string trim [lindex $line_split 88]]
		set imp_data_rispetta_DPR412si           [string trim [lindex $line_split 89]]
		set imp_data_rispetta_DPR412no           [string trim [lindex $line_split 90]]
		set imp_data_invio_contr_portata         [string trim [lindex $line_split 91]]
		set imp_data_invio_no_manut_45_g         [string trim [lindex $line_split 92]]
		set imp_data_no_all_H                    [string trim [lindex $line_split 93]]
		
		set imp_legna                            [string trim [lindex $line_split 94]]
		
		### ???
		set imp_no_pres_appuntamento             [string trim [lindex $line_split 95]]
		
		set imp_note_manc_idonea_ventil          [string trim [lindex $line_split 96]]
		set imp_note_vent_inadeguata             [string trim [lindex $line_split 97]]
		set imp_note_manca_foro_fumi             [string trim [lindex $line_split 98]]
		set imp_note_foro_fumi_non_norma         [string trim [lindex $line_split 99]]
		set imp_note_manca_lib_impianto          [string trim [lindex $line_split 100]]
		
		### ???
		set imp_note_allegato_H                  [string trim [lindex $line_split 101]]
		set imp_note_sfiato_serbatoio            [string trim [lindex $line_split 102]]
		set imp_note_dep_gasolio_no_norma        [string trim [lindex $line_split 103]]
		set imp_note_serb_gasolio_loc_cald       [string trim [lindex $line_split 104]]
		set imp_note_gpl_sotto_campagna          [string trim [lindex $line_split 105]]
		set imp_note_manca_mant_preced           [string trim [lindex $line_split 106]]
		
		set imp_note_manca_manut_verif_prec      [string trim [lindex $line_split 107]]
		
		### ???
		set imp_note_imp_disattivato             [string trim [lindex $line_split 108]]
		set imp_note_imp_bagno_camer             [string trim [lindex $line_split 109]]
		set imp_note_imp_comun_autorim           [string trim [lindex $line_split 110]]
		set imp_note_imp_instal_autorim          [string trim [lindex $line_split 111]]
		set imp_note_canal_da_sostituire         [string trim [lindex $line_split 112]]
		set imp_note_si_cons_sost_canale         [string trim [lindex $line_split 113]]
		set imp_note_rilasc_dich_potenza         [string trim [lindex $line_split 114]]
		set imp_estrazione                       [string trim [lindex $line_split 115]]
		set imp_note_esito_positivo              [string trim [lindex $line_split 116]]
		set imp_note_aerazione_GPL_loc           [string trim [lindex $line_split 117]]
		set imp_note_aerazione_met_cottura       [string trim [lindex $line_split 118]]
		set imp_note_aerazione_GPL_cottura       [string trim [lindex $line_split 119]]
		set imp_note_porta_autorim_omologata     [string trim [lindex $line_split 120]]
		set imp_note_serb_gasolio_autorimessa    [string trim [lindex $line_split 121]]
		
		set imp_note_canale_fumo_fuori_norma     [string trim [lindex $line_split 122]]

		### ???
		set imp_note_gen_tipoB_aria_parti_comuni [string trim [lindex $line_split 123]]
		set imp_note_certif_collaudo_GPL         [string trim [lindex $line_split 124]]
		set imp_note_tubi_gas_pressare           [string trim [lindex $line_split 125]]

		set ora_controllo_2 $imp_data_controllo



		if {[db_0or1row sel_aimp "select cod_combustibile,
                                         cod_responsabile,
                                         stato,
                                         cod_manutentore,
                                         data_installaz
                                    from coimaimp
                                   where cod_impianto_est = :imp_n_dichiarazione"] == 0} {
		    puts $filout "$line;impianto mancante o impianto non codificato correttamente"
		    incr conta_c_inf_err
		    incr righe_con_errori
		    continue
		} else {

		    ### data controllo
		    if {![string equal $imp_data_controllo ""]} {
			set imp_data_controllo [db_string query "select to_date(:imp_data_controllo, 'DD MM YYYY')"]
			set yy_dtat [string range $imp_data_controllo 0 4]
		    } else {
			set errori "$errori;manca data controllo"
			incr conta_c_inf_err
			if {[string equal $conta_errori 0]} {
			    incr conta_errori
			    incr righe_con_errori
			}
		    }

		    ### flag manutenzione anno in corso
		    set anno $yy_dtat
		    set manutenzione_8a "N"
		    if {[exists_and_not_null imp_man$anno]} {
			set comodo [set imp_man$anno]
			switch $comodo {
			    "1,00" {set manutenzione_8a "S"}
			    "0,00" {set manutenzione_8a "N"}
			    default {}
			}
		    }

		    switch $imp_rispetta_no {
			"0" {set imp_rispetta "S"}
			"1" {set imp_rispetta "N"}
			default {set imp_rispetta "S"} 
		    }
		    
		    ### flag manutenzione anni precedenti
		    if {$imp_man1994 == "1,00"||$imp_man1995 == "1,00"||$imp_man1996 == "1,00"||$imp_man1997 == "1,00"||$imp_man1998 == "1,00"||$imp_man1999 == "1,00"||$imp_man2000 == "1,00"||$imp_man2001 == "1,00"||$imp_man2002 == "1,00"||$imp_man2003 == "1,00"||$imp_man2004 == "1,00"} {
			set new1_manu_prec_8a "S"
		    } else {
			set new1_manu_prec_8a "N"
		    }
		    
		    ### nome verificatore
		    if {![string equal $imp_nomeverificatore ""]} {
			if {[string equal $imp_nomeverificatore "NON RILEVATO"]} {
			    set cod_opve "VE1000"
			} else {
			    set cod_opve [db_string query "select cod_opve from coimopve where upper(trim(cognome)) || ' ' || upper(trim(nome)) = upper(:imp_nomeverificatore)" -default "Error"]
			    if {[string equal $cod_opve "Error"]} {
				set errori "$errori;verificatore non trovato."
				incr conta_c_inf_err
				if {[string equal $conta_errori 0]} {
				    incr conta_errori
				    incr righe_con_errori
				}
			    } else {
				###verifico se esiste appuntamento per il controllo, questo controllo è bloccante
				set cod_impianto_int [db_string query "select cod_impianto as cod_impianto_int from coimaimp where cod_impianto_est = :imp_n_dichiarazione" -default "Error"]
 				set appuntamento_ok [db_string query "select 1 from coiminco where cod_opve=:cod_opve and cod_impianto = :cod_impianto_int limit 1" -default "Error"]
 				if {[string equal $appuntamento_ok "Error"]} {
 				    puts $filout "$line;verificare se esiste l'appuntamento relativo a questo controllo"
 				    incr conta_c_inf_err
 				    #incr righe_con_errori
 				    continue
 				}
			    }
			}
		    } else {
			set errori "$errori;verificatore non trovato"
			incr conta_c_inf_err
			if {[string equal $conta_errori 0]} {
                            incr conta_errori
			    incr righe_con_errori
                        }
		    }
		    
		    ### strumento
# 		    if {![string equal $imp_numeroserie ""]} {
# 			set pos_virg [string first "," $imp_numeroserie]
# 			set imp_numeroserie [string range $imp_numeroserie 0 [expr $pos_virg -1]]
# 		    }

		    ### c02
		    if {[string equal $imp_co2 "0,00"]||[string equal $imp_co2 ""]||[string equal $imp_co2 "0"]} {
			set imp_co2 ""
		    } else {
			set imp_co2 [iter_check_num $imp_co2 2]
			if {$imp_co2 == "Error"} {
			    set errori "$errori;co2 errato"
			    incr conta_c_inf_err
			    if {[string equal $conta_errori 0]} {
				incr conta_errori
				incr righe_con_errori
			    }
			}
		    }
		    if {[string length $imp_co2] > 6} {
			set errori "$errori;co2 troppo lungo"
			incr conta_c_inf_err
			if {[string equal $conta_errori 0]} {
                            incr conta_errori
			    incr righe_con_errori
                        }
		    }

		    set imp_controllo_rilev ""
		    switch $imp_controllo_rilev_si {
			"1" {set imp_controllo_rilev "S"}
			"1,00" {set imp_controllo_rilev "S"}
			default {}
		    }
		    switch $imp_controllo_rilev_no {
			"1" {set imp_controllo_rilev "N"}
			"1,00" {set imp_controllo_rilev "N"}
			default {}
		    }


		    ### rend_comb_conv 
		    if {[string equal $imp_rendimento_rilevato "0"]||[string equal $imp_rendimento_rilevato ""]||[string equal $imp_rendimento_rilevato "0,00"]} {
			set imp_rendimento_rilevato ""
		    } else {
			set imp_rendimento_rilevato [iter_check_num $imp_rendimento_rilevato 2]
			if {$imp_rendimento_rilevato == "Error"} {
			    set errori "$errori;rendimento ril. errato"
			    incr conta_c_inf_err
			    if {[string equal $conta_errori 0]} {
				incr conta_errori
				incr righe_con_errori
			    }
			}
		    }

		    ### rend_comb_min
		    if {[string equal $imp_rend_DPR412 "0"]||[string equal $imp_rend_DPR412 ""]||[string equal $imp_rend_DPR412 "0,00"]} {
			set imp_rend_DPR412 ""
		    } else {
			set imp_rend_DPR412 [iter_check_num $imp_rend_DPR412 2]
			if {$imp_rend_DPR412 == "Error"} {
			    set errori "$errori;rendimento DPR12 errato"
			    incr conta_c_inf_err
			    if {[string equal $conta_errori 0]} {
				incr conta_errori
				incr righe_con_errori
			    }
			}
		    }

		    switch $imp_rend_DPR412 {
			"0" {set imp_rend_DPR412 "S"}
			"1" {set imp_rend_DPR412 "N"}
			default {set imp_rend_DPR412 "S"} 
		    }


		    ### stato_coiben
		    set stato_coiben "V"
		    switch $imp_buona_coib {
			"1" {set stato_coiben "B"}
			"0" {}
			default {} 
		    }
		    switch $imp_mediocre_coib {
			"1" {set stato_coiben "M"}
			"0" {}
			default {} 
		    }
		    switch $imp_scadente_coib {
			"1" {set stato_coiben "S"}
			"0" {}
			default {} 
		    }

		    ### stato_canna_fumaria

		    set stato_canna_fumaria ""
		    switch $imp_buona_fumar {
			"1" {set stato_canna_fumaria "B"}
			"0" {}
			default {} 
		    }
		    switch $imp_mediocre_fumar {
			"1" {set stato_canna_fumaria "N"}
			"0" {}
			default {} 
		    }
		    switch $imp_scadente_fumar {
			"1" {set stato_canna_fumaria "S"}
			"0" {}
			default {} 
		    }

		    ### tipo_bruciatore
		    set tipo_bruciatore ""
		    switch $imp_soffiato {
			"1" {set tipo_bruciatore "S"}
			"0" {}
			default {} 
		    }
		    switch $imp_atmosferico {
			"1" {set tipo_bruciatore "A"}
			"0" {}
			default {} 
		    }

		    ### installazione
		    set installazione ""
		    switch $imp_a_terra {
			"1" {set installazione "T"}
			"0" {}
			default {} 
		    }
		    switch $imp_a_muro {
			"1" {set installazione "M"}
			"0" {}
			default {} 
		    }

		    ### mod_funz
		    set mod_funz ""
		    switch $imp_acqua {
			"1" {set mod_funz "1"}
			"0" {}
			default {} 
		    }
		    switch $imp_aria {
			"1" {set mod_funz "2"}
			"0" {}
			default {} 
		    }

		    ### tipo_foco
		    set tipo_foco ""
		    switch $imp_tipo_b {
			"1" {set tipo_foco "A"}
			"0" {}
			default {} 
		    }
		    switch $imp_tipo_c {
			"1" {set tipo_foco "C"}
			"0" {}
			default {} 
		    }

		    ### esito_verifica
#		    set esito_verifica ""
#		    switch $imp_positiva {
#			"1" {set esito_verifica "P"}
#			"0" {}
#			default {} 
#		    }
		    switch $imp_negativa {
			"1" {set imp_negativa "S"}
			"0" {}
			default {} 
		    }
#		    if {[string equal $esito_verifica ""]} {
			set esito_verifica "P"
#		    }

		    ### data ultima manutenzione
		    if {![string equal $imp_data_ult_manutenzione ""]} {
			if {![string is integer $imp_data_ult_manutenzione]} {
			    set errori "$errori;anno ultima man. errata"
			    incr conta_c_inf_err
			    if {[string equal $conta_errori 0]} {
				incr conta_errori
				incr righe_con_errori
			    }
			} else {
			    if {[string length $imp_data_ult_manutenzione] == 4} {
				append imp_data_ult_manutenzione "0101"
			    } else {
				set errori "$errori;anno ultima man. errato"
				incr conta_c_inf_err
				if {[string equal $conta_errori 0]} {
				    incr conta_errori
				    incr righe_con_errori
				}
			    }
			}
		    }

		    ### new1_co_rilevato
		    if {![string equal $imp_co_fumisecchi_ril ""]} {
			set imp_co_fumisecchi_ril [iter_check_num $imp_co_fumisecchi_ril 2]
			if {$imp_co_fumisecchi_ril == "Error"} {
			    set errori "$errori;co fumisecchi errato o mancante"
			    incr conta_c_inf_err
			    if {[string equal $conta_errori 0]} {
				incr conta_errori
				incr righe_con_errori
			    }
			}
		    }
		    
		    ### indic_fumosita_md (se ci sono:indic_fumosita_1 indic_fumosita_2 indic_fumosita_3)
		    set indic_fumosita_1 ""
		    set indic_fumosita_2 ""
		    set indic_fumosita_3 ""
		    if {[string equal $imp_indice_bacharach_ril "NO"]||[string equal $imp_indice_bacharach_ril "-"]} {
			set imp_indice_bacharach_ril "0"
		    } else {
			##controllo il tipo di combustibile, 
			##verifico che sia valorizatto un solo tipo di combustibile per volta
			set comb 0
			if {[string equal $imp_metano 0]} {
			    set comb [expr $comb+1]
			} else {
			    set comb [expr $comb-1]			    
			}
			if {[string equal $imp_gpl 0]} {
			    set comb [expr $comb+1]			    
			} else {
			    set comb [expr $comb-1]			    
			}
			if {[string equal $imp_gasolio 0]} {
			    set comb [expr $comb+1]			    
			} else {
			    set comb [expr $comb-1]			    
			}
			if {[string equal $imp_legna 0]} {
			    set comb [expr $comb+1]			    
			} else {
			    set comb [expr $comb-1]			    
			}
			if {$comb>=-4 && $comb <2} {
			    set errori "$errori;sono definiti troppi tipi di combustibile"
			    incr conta_c_inf_err
                            if {[string equal $conta_errori 0]} {
                                incr conta_errori
				incr righe_con_errori
                            }
			}
# 			if {[string equal $comb 4]} {
# 			    set errori "$errori;non sono definiti tipi di combustibile"
# 			    incr conta_c_inf_err
#                             if {[string equal $conta_errori 0]} {
#                                 incr conta_errori
# 				incr righe_con_errori
#                             }
# 			}

			### Controllo qua se la caldaia è a gasolio o a olio, con una condizione di if, se la caldaia è tale e num_valori è maggiore di 1 allora proseguo, altrimenti se la caldaia è tale ma num_valori è a zero scateno l'errore, infine se num_valori è diverso da zero e la caldaia non è ne a gasolio nè a olio allora scateno un warning
			set ind_bacharach [split $imp_bacharach "-"]
			set num_valori [llength $ind_bacharach]

			if {[string equal $imp_gasolio 1]} {

			    if {[string equal $num_valori 0]} {
				set errori "$errori;caldaia a gasolio ma indice bacharach non valorizzato"
				incr conta_c_inf_err
				if {[string equal $conta_errori 0]} {
				    incr conta_errori
				    incr righe_con_errori
				}
			    }
			} 
			set cc 0
			for {set i 0} {$i<=$num_valori} {incr i} {
			    set indic_fumosita_$i [string trim [lindex  $i]]
			    set cc [expr $cc+[string trim [lindex  $i]]]
			}
			if {$num_valori > 0} {
			    set cc [expr $cc / $num_valori]
			}

		    }

		    ### bacharach
		    if {[string equal $imp_bacharach "0"]||[string equal $imp_bacharach ""]||[string equal $imp_bacharach "0,00"]} {
			set imp_bacharach ""
		    } else {
			set imp_bacharach [iter_check_num $imp_bacharach 2]
			if {$imp_bacharach == "Error"} {
			    set errori "$errori;bacharach errato"
			    incr conta_c_inf_err
			    if {[string equal $conta_errori 0]} {
				incr conta_errori
				incr righe_con_errori
			    }
			} else {
			    if {[string equal $imp_indice_bacharach_ril ""]} {
				set imp_indice_bacharach_ril $imp_bacharach
			    }
			}
		    }

		    ### verifica_areaz
		    set verifica_areaz "P"
		    switch $imp_note_vent_inadeguata {
			"1" {set verifica_areaz "N"}
			"0" {}
			default {} 
		    }	    
		    switch $imp_note_manc_idonea_ventil {
			"1" {set verifica_areaz "A"}
			"0" {}
			default {} 
		    }

		    ### new1_foro_presente new1_foro_corretto new1_foro_accessibile
		    set new1_foro_presente "S"
		    set new1_foro_corretto "S"
		    set new1_foro_accessibile "S"
		    switch $imp_note_manca_foro_fumi {
			"1" {set new1_foro_presente "N"}
			"0" {}
			default {} 
		    }	    
		    switch $imp_note_foro_fumi_non_norma {
			"1" {set new1_foro_corretto "N"
			    set new1_foro_accessibile "N"}
			"0" {}
			default {} 
		    }

		    ### presenza_libretto
		    set presenza_libretto "S"
		    switch $imp_note_manca_lib_impianto {
			"1" {set presenza_libretto "N"}
			"0" {}
			default {} 
		    }

		    ### new1_dimp_pres
		    set new1_dimp_pres "S"
		    switch $imp_note_manca_manut_verif_prec {
			"1" {set new1_dimp_pres "N"}
			"0" {}
			default {} 
		    }	    

		    ### new1_canali_a_norma
		    set new1_canali_a_norma "S"
		    switch $imp_note_canale_fumo_fuori_norma {
			"1" {set new1_canali_a_norma "N"}
			"0" {}
			default {} 
		    }

		    ### potenza (su impianto e generatore)
		    if {[string equal $imp_potenza_n "0"]||[string equal $imp_potenza_n ""]||[string equal $imp_potenza_n "0,00"]} {
			set imp_potenza_n "0.01"
		    } else {
			set imp_potenza_n [iter_check_num $imp_potenza_n 2]
			if {$imp_potenza_n == "Error"} {
			    set errori "$errori;potenza nominale errata"
			    incr conta_c_inf_err
                            if {[string equal $conta_errori 0]} {
                                incr conta_errori
				incr righe_con_errori
                            }
			}
		    }

		    ### potenza utile (su impianto e generatore)
		    if {[string equal $imp_port_nominale "0"]||[string equal $imp_port_nominale ""]||[string equal $imp_port_nominale "0,00"]} {
			set imp_port_nominale "0.01"
		    } else {
			#bloccato perchè gestito da vfox
			set imp_port_nominale [iter_check_num $imp_port_nominale 2]
			if {$imp_port_nominale == "Error"} {
			    set errori "$errori;potenza nominale errata"
			    incr conta_c_inf_err
                            if {[string equal $conta_errori 0]} {
                                incr conta_errori
				incr righe_con_errori
                            }
			}
		    }

		    #imposto di default il combustibile non noto 
		    set cod_combustibile "0"
		    
		    ### combustibile (su impianto e generatore)
		    switch $imp_metano {
			"1" {set cod_combustibile "G"}
			"0" {}
			default {} 
		    }
		    switch $imp_gpl {
			"1" {set cod_combustibile "P"}
			"0" {}
			default {} 
		    }
		    switch $imp_gasolio {
			"1" {set cod_combustibile "O"}
			"0" {}
			default {} 
		    }
		    switch $imp_legna {
			"1" {set cod_combustibile "X"}
			"0" {}
			default {} 
		    }

		    ### cod_utgi (destinazione d'uso su generatore)
		    set cod_utgi "0"
		    switch $imp_riscald {
			"1" {set cod_utgi "R"}
			"0" {}
			default {} 
		    }
		    switch $imp_riscald_sanit {
			"1" {set cod_utgi "E"}
			"0" {}
			default {} 
		    }
		    switch $imp_solo_sanit {
			"1" {set cod_utgi "A"}
			"0" {}
			default {} 
		    }
		}

		set cod_imp_est [db_string sel_cod_impianto "select cod_impianto from coimaimp where cod_impianto_est = :imp_n_dichiarazione"]

		set scheda_presente_1 [db_string query "select 1 from coimcimp where cod_impianto=:cod_imp_est and data_controllo=:imp_data_controllo limit 1" -default "OK"]

		if {![string equal $scheda_presente_1 "OK"]} {
		    set errori "$errori;impianto già inserito"
		    incr conta_c_inf_err
		    if {[string equal $conta_errori 0]} {
			incr conta_errori
			incr righe_con_errori
		    }
		} else {

		    incr conta_c_inf
		    set gen_prog 1

		    puts $file_ok "$imp_n_dichiarazione;$gen_prog;$cod_inco;$imp_data_controllo;$cod_opve;$presenza_libretto;$stato_coiben;$verifica_areaz;$imp_rendimento_rilevato;$imp_rend_DPR412;$imp_co2;$indic_fumosita_1;$indic_fumosita_2;$indic_fumosita_3;$imp_indice_bacharach_ril;$manutenzione_8a;$esito_verifica;$imp_note;$cod_combustibile;$cod_responsabile;$utente;$new1_foro_presente;$new1_foro_corretto;$new1_foro_accessibile;$new1_canali_a_norma;$new1_dimp_pres;$imp_data_ult_manutenzione;$new1_manu_prec_8a;$imp_co_fumisecchi_ril;$imp_puntatore;$imp_numeroserie;$imp_potenza_n;$imp_port_nominale;$imp_ora_inizio;$imp_ora_fine;$imp_anno_costruzione;$imp_anno_installazione;$imp_manutentore;$imp_costruttore;$imp_modello;$tipo_bruciatore;$installazione;$mod_funz;$tipo_foco;$stato_canna_fumaria;$imp_data_ult_verifica;$imp_port_nominale;$cod_utgi;$imp_no_pres_appuntamento;$imp_note_manc_idonea_ventil;$imp_note_vent_inadeguata;$imp_note_manca_foro_fumi;$imp_note_foro_fumi_non_norma;$imp_note_manca_lib_impianto;$imp_note_allegato_H;$imp_note_sfiato_serbatoio;$imp_note_dep_gasolio_no_norma;$imp_note_serb_gasolio_loc_cald;$imp_note_gpl_sotto_campagna;$imp_note_manca_mant_preced;$imp_note_manca_manut_verif_prec;$imp_note_imp_disattivato;$imp_note_imp_bagno_camer;$imp_note_imp_comun_autorim;$imp_note_imp_instal_autorim;$imp_note_canal_da_sostituire;$imp_note_si_cons_sost_canale;$imp_note_rilasc_dich_potenza;$imp_estrazione;$imp_note_esito_positivo;$imp_note_aerazione_GPL_loc;$imp_note_aerazione_met_cottura;$imp_note_aerazione_GPL_cottura;$imp_note_porta_autorim_omologata;$imp_note_serb_gasolio_autorimessa;$imp_note_canale_fumo_fuori_norma;$imp_note_gen_tipoB_aria_parti_comuni;$imp_note_certif_collaudo_GPL;$imp_note_tubi_gas_pressare;$imp_controllo_rilev;$imp_negativa;$imp_rispetta"
		}
		#scrivo gli errori e li stampo nel file esterno
		if {$conta_errori > 0} {
		    puts $filout "$line;$errori"
		    continue
		}
	    }		
	    close $file_inp
	    close $filout
	    close $file_ok

#	    ns_return 200 text/html "$conta_errori"; return

	    set counter 0
	    set conta_sup 0
	    set conta_sup_err 0
            set righe_con_errori2 0
	    set rapporti_verifica_impianti_corretti ""
	    set rapporti_verifica_date_corretti ""
	    set file_inp [open $tmpfile2 r]
	    set filout2 [open $spool_dir/rapporti-ver-sup.txt w]
	    set file_ok [open $spool_dir/rapporti-ver-sup-chr.txt w]	    	    
	    
	    set utente "INS"
	    
	    foreach line [split [read $file_inp] \n] {
		set conta_errori 0
		set errori ""		
		#scarto la prima riga perchè il programma vfox estrae anche le testate delle tabelle
		if {[string equal $counter 0]} {
		    set counter 1
		    continue
		}

		if {[string equal $line ""]} {
		    continue
		}
		
		set line_split [split $line ";"]
		
		set imp_n_dich                           [string trim [lindex $line_split 0]]
		set imp_data_controllo                   [string trim [lindex $line_split 1]]
		set imp_ora_inizio                       [string trim [lindex $line_split 2]]
		
		### non gestiti(manca sul database)
		set imp_ora_fine                         [string trim [lindex $line_split 3]]
		set imp_numero_serie                     [string trim [lindex $line_split 4]]
		set imp_nomeverificatore                 [string trim [lindex $line_split 5]]
		set imp_costrg1                          [string trim [lindex $line_split 6]]
		set imp_costrg2                          [string trim [lindex $line_split 7]]
		set imp_costrg3                          [string trim [lindex $line_split 8]]
		
		### modello (su generatore)
		set imp_modg1                            [string trim [lindex $line_split 9]]
		set imp_modg2                            [string trim [lindex $line_split 10]]
		set imp_modg3                            [string trim [lindex $line_split 11]]
		set imp_pot_nomg1                        [string trim [lindex $line_split 12]]
		set imp_pot_nomg2                        [string trim [lindex $line_split 13]]
		set imp_pot_nomg3                        [string trim [lindex $line_split 14]]
		
		### non gestita(manca sul database)
		set imp_anno_costg1                      [string trim [lindex $line_split 15]]
		set imp_anno_costg2                      [string trim [lindex $line_split 16]]
		set imp_anno_costg3                      [string trim [lindex $line_split 17]]
		set imp_costrB1                          [string trim [lindex $line_split 18]]
		set imp_costrB2                          [string trim [lindex $line_split 19]]
		set imp_costrB3                          [string trim [lindex $line_split 20]]
		set imp_modB1                            [string trim [lindex $line_split 21]]
		set imp_modB2                            [string trim [lindex $line_split 22]]
		set imp_modB3                            [string trim [lindex $line_split 23]]
		
		### temp_fumi_md
		set imp_tempfumig1                       [string trim [lindex $line_split 24]]
		set imp_tempfumig2                       [string trim [lindex $line_split 25]]
		set imp_tempfumig3                       [string trim [lindex $line_split 26]]
		
		### t_aria_comb_md
		set imp_tempambienteg1                   [string trim [lindex $line_split 27]]
		set imp_tempambienteg2                   [string trim [lindex $line_split 28]]
		set imp_tempambienteg3                   [string trim [lindex $line_split 29]]
		set imp_co2g1                            [string trim [lindex $line_split 30]]
		set imp_co2g2                            [string trim [lindex $line_split 31]]
		set imp_co2g3                            [string trim [lindex $line_split 32]]
		set imp_bacharachg1                      [string trim [lindex $line_split 33]]
		set imp_bacharachg2                      [string trim [lindex $line_split 34]]
		set imp_bacharachg3                      [string trim [lindex $line_split 35]]
		set imp_cofumisecchig1                   [string trim [lindex $line_split 36]]
		set imp_cofumisecchig2                   [string trim [lindex $line_split 37]]
		set imp_cofumisecchig3                   [string trim [lindex $line_split 38]]
		set imp_cog1                             [string trim [lindex $line_split 39]]
		set imp_cog2                             [string trim [lindex $line_split 40]]
		set imp_cog3                             [string trim [lindex $line_split 41]]
		set imp_o2g1                             [string trim [lindex $line_split 42]]
		set imp_o2g2                             [string trim [lindex $line_split 43]]
		set imp_o2g3                             [string trim [lindex $line_split 44]]
		
		### ???
		set imp_perdcalsensg1                    [string trim [lindex $line_split 45]]
		set imp_perdcalsensg2                    [string trim [lindex $line_split 46]]
		set imp_perdcalsensg3                    [string trim [lindex $line_split 47]]
		set imp_rendcombpotnomg1                 [string trim [lindex $line_split 48]]
		set imp_rendcombpotnomg2                 [string trim [lindex $line_split 49]]
		set imp_rendcombpotnomg3                 [string trim [lindex $line_split 50]]
		
		### non c e'
		set imp_rendmisurato2g1                 [string trim [lindex $line_split 51]]
		set imp_rendmisurato2g2                 [string trim [lindex $line_split 52]]
		set imp_rendmisurato2g3                 [string trim [lindex $line_split 53]]
		set imp_rendmin412g1                     [string trim [lindex $line_split 54]]
		set imp_rendmin412g2                     [string trim [lindex $line_split 55]]
		set imp_rendmin412g3                     [string trim [lindex $line_split 56]]
		set imp_statocoimbg1                     [string trim [lindex $line_split 57]]
		set imp_statocoimbg2                     [string trim [lindex $line_split 58]]
		set imp_statocoimbg3                     [string trim [lindex $line_split 59]]
		set imp_statocannafumg1                  [string trim [lindex $line_split 60]]
		set imp_statocannafumg2                  [string trim [lindex $line_split 61]]
		set imp_statocannafumg3                  [string trim [lindex $line_split 62]]

		### ???
		set imp_statodispcontrollog1             [string trim [lindex $line_split 63]]
		set imp_statodispcontrollog2             [string trim [lindex $line_split 64]]
		set imp_statodispcontrollog3             [string trim [lindex $line_split 65]]

		### ???
		set imp_taratregcontrg1                  [string trim [lindex $line_split 66]]
		set imp_taratregcontrg2                  [string trim [lindex $line_split 67]]
		set imp_taratregcontrg3                  [string trim [lindex $line_split 68]]
		set imp_soffiato                         [string trim [lindex $line_split 69]]
		set imp_atmosferico                      [string trim [lindex $line_split 70]]

		### note_conf
		set imp_note                             [string trim [lindex $line_split 71]]
		set imp_metano                           [string trim [lindex $line_split 72]]
		set imp_gpl                              [string trim [lindex $line_split 73]]
		set imp_gasolio                          [string trim [lindex $line_split 74]]
		set imp_altrospec                        [string trim [lindex $line_split 75]]
		set imp_puntatoreg1                      [string trim [lindex $line_split 76]]
		set imp_puntatoreg2                      [string trim [lindex $line_split 77]]
		set imp_puntatoreg3                      [string trim [lindex $line_split 78]]
		set imp_tempmandg1                       [string trim [lindex $line_split 79]]
		set imp_tempmandg2                       [string trim [lindex $line_split 80]]
		set imp_tempmandg3                       [string trim [lindex $line_split 81]]

		### esito verifica
		set imp_rispnormaSIg1                    [string trim [lindex $line_split 82]]
		set imp_rispnormaNOg1                    [string trim [lindex $line_split 83]]

		### ???
		set imp_controllo_ril_sup_si             [string trim [lindex $line_split 84]]
		set imp_controllo_ril_sup_no             [string trim [lindex $line_split 85]]
		set imp_porttermicag1                    [string trim [lindex $line_split 86]]
		set imp_porttermicag2                    [string trim [lindex $line_split 87]]
		set imp_porttermicag3                    [string trim [lindex $line_split 88]]
		set imp_manutentditta                    [string trim [lindex $line_split 89]]

		### ???
		set imp_fluidotermacqua                  [string trim [lindex $line_split 90]]
		set imp_fluidoteraria                    [string trim [lindex $line_split 91]]
		set imp_risc                             [string trim [lindex $line_split 92]]
		set imp_riscpiusanit                     [string trim [lindex $line_split 93]]
		set imp_solosanitario                    [string trim [lindex $line_split 94]]
		set imp_impiantononinuso                 [string trim [lindex $line_split 95]]

		### ???
		set imp_mediadelletreprove               [string trim [lindex $line_split 96]]

		### esito verifica
		set imp_rispnormaSIg2                    [string trim [lindex $line_split 97]]
		set imp_rispnormaNOg2                    [string trim [lindex $line_split 98]]
		set imp_rispnormaSIg3                    [string trim [lindex $line_split 99]]
		set imp_rispnormaNOg3                    [string trim [lindex $line_split 100]]
		set imp_ultima_verifica                  [string trim [lindex $line_split 101]]
		set imp_ultima_manutenzione              [string trim [lindex $line_split 102]]
		set imp_ultima_manutenzioneg2            [string trim [lindex $line_split 103]]
		set imp_ultima_verificag2                [string trim [lindex $line_split 104]]
		set imp_ultima_manutenzioneg3            [string trim [lindex $line_split 105]]
		set imp_ultima_verificag3                [string trim [lindex $line_split 106]]
		set imp_dataultimaverifica               [string trim [lindex $line_split 107]]

		### ho gia questo dato (imp_cofumisecchig1)
		set imp_COfumisecchippm                  [string trim [lindex $line_split 108]]

		### ???
		set imp_indicedinerofumo                 [string trim [lindex $line_split 109]]

		### ???
		set imp_rendimentomisu                   [string trim [lindex $line_split 110]]
		set imp_differenza                       [string trim [lindex $line_split 111]]
		set imp_dataultimaverificag2             [string trim [lindex $line_split 112]]
		set imp_COfumisecchippmg2                [string trim [lindex $line_split 113]]
		set imp_rendimentomisug2                 [string trim [lindex $line_split 114]]
		set imp_indicedinerofumog2               [string trim [lindex $line_split 115]]
		set imp_dataultimaverificag3             [string trim [lindex $line_split 116]]
		set imp_COfumisecchippmg3                [string trim [lindex $line_split 117]]
		set imp_rendimentomisug3                 [string trim [lindex $line_split 118]]
		set imp_indicedinerofumog3               [string trim [lindex $line_split 119]]
		set imp_dati_ril_libretto                [string trim [lindex $line_split 120]]
		set imp_man1994                          [string trim [lindex $line_split 121]]
		set imp_man1995                          [string trim [lindex $line_split 122]]
		set imp_man1996                          [string trim [lindex $line_split 123]]
		set imp_man1997                          [string trim [lindex $line_split 124]]
		set imp_man1998                          [string trim [lindex $line_split 125]]
		set imp_man2000                          [string trim [lindex $line_split 126]]
		set imp_man2001                          [string trim [lindex $line_split 127]]
		set imp_man2002                          [string trim [lindex $line_split 128]]
		set imp_man1999                          [string trim [lindex $line_split 129]]
		set imp_man2003                          [string trim [lindex $line_split 130]]
		set imp_man2004                          [string trim [lindex $line_split 131]]

		### ???
		set imp_ver1994                          [string trim [lindex $line_split 132]]
		set imp_ver1995                          [string trim [lindex $line_split 133]]
		set imp_ver1996                          [string trim [lindex $line_split 134]]
		set imp_ver1997                          [string trim [lindex $line_split 135]]
		set imp_ver1998                          [string trim [lindex $line_split 136]]
		set imp_ver2000                          [string trim [lindex $line_split 137]]
		set imp_ver2001                          [string trim [lindex $line_split 138]]
		set imp_ver2002                          [string trim [lindex $line_split 139]]
		set imp_ver1999                          [string trim [lindex $line_split 140]]
		set imp_ver2003                          [string trim [lindex $line_split 141]]
		set imp_ver2004                          [string trim [lindex $line_split 142]]
		set imp_mang21994                        [string trim [lindex $line_split 143]]
		set imp_mang21995                        [string trim [lindex $line_split 144]]
		set imp_mang21996                        [string trim [lindex $line_split 145]]
		set imp_mang21997                        [string trim [lindex $line_split 146]]
		set imp_mang21998                        [string trim [lindex $line_split 147]]
		set imp_mang22000                        [string trim [lindex $line_split 148]]
		set imp_mang22001                        [string trim [lindex $line_split 149]]
		set imp_mang22002                        [string trim [lindex $line_split 150]]
		set imp_mang21999                        [string trim [lindex $line_split 151]]
		set imp_mang22003                        [string trim [lindex $line_split 152]]
		set imp_mang22004                        [string trim [lindex $line_split 153]]

		### ???
		set imp_ver1994g2                        [string trim [lindex $line_split 154]]
		set imp_ver1995g2                        [string trim [lindex $line_split 155]]
		set imp_ver1996g2                        [string trim [lindex $line_split 156]]
		set imp_ver1997g2                        [string trim [lindex $line_split 157]]
		set imp_ver1998g2                        [string trim [lindex $line_split 158]]
		set imp_ver2000g2                        [string trim [lindex $line_split 159]]
		set imp_ver2001g2                        [string trim [lindex $line_split 160]]
		set imp_ver2002g2                        [string trim [lindex $line_split 161]]
		set imp_ver1999g2                        [string trim [lindex $line_split 162]]
		set imp_ver2003g2                        [string trim [lindex $line_split 163]]
		set imp_ver2004g2                        [string trim [lindex $line_split 164]]
		set imp_mang31994                        [string trim [lindex $line_split 165]]
		set imp_mang31995                        [string trim [lindex $line_split 166]]
		set imp_mang31996                        [string trim [lindex $line_split 167]]
		set imp_mang31997                        [string trim [lindex $line_split 168]]
		set imp_mang31998                        [string trim [lindex $line_split 169]]
		set imp_mang32000                        [string trim [lindex $line_split 170]]
		set imp_mang32001                        [string trim [lindex $line_split 171]]
		set imp_mang32002                        [string trim [lindex $line_split 172]]
		set imp_mang31999                        [string trim [lindex $line_split 173]]
		set imp_mang32003                        [string trim [lindex $line_split 174]]
		set imp_mang32004                        [string trim [lindex $line_split 175]]

		### ???
		set imp_ver1994g3                        [string trim [lindex $line_split 176]]
		set imp_ver1995g3                        [string trim [lindex $line_split 177]]
		set imp_ver1996g3                        [string trim [lindex $line_split 178]]
		set imp_ver1997g3                        [string trim [lindex $line_split 179]]
		set imp_ver1998g3                        [string trim [lindex $line_split 180]]
		set imp_ver2000g3                        [string trim [lindex $line_split 181]]
		set imp_ver2001g3                        [string trim [lindex $line_split 182]]
		set imp_ver2002g3                        [string trim [lindex $line_split 183]]
		set imp_ver1999g3                        [string trim [lindex $line_split 184]]
		set imp_ver2003g3                        [string trim [lindex $line_split 185]]
		set imp_ver2004g3                        [string trim [lindex $line_split 186]]
		set imp_data_invio_no_manut              [string trim [lindex $line_split 187]]
		set imp_data_invio_no_UNI10389           [string trim [lindex $line_split 188]]
		set imp_data_invio_no_lib_centrale       [string trim [lindex $line_split 189]]
		set imp_data_invio_no_DPR                [string trim [lindex $line_split 190]]
		set imp_data_invio_controll_potenza      [string trim [lindex $line_split 191]]
		set imp_data_di_risposta_positiva        [string trim [lindex $line_split 192]]
		set imp_data_no_alleg_H                  [string trim [lindex $line_split 193]]

		### ???
		set imp_centrale_non_a_norma_si          [string trim [lindex $line_split 194]]
		set imp_centrale_non_a_norma_no          [string trim [lindex $line_split 195]]
		set imp_risp_rend_min_412_g1_si          [string trim [lindex $line_split 196]]
		set imp_risp_rend_min_412_g1_no          [string trim [lindex $line_split 197]]
		set imp_risp_rend_min_412_g2_si          [string trim [lindex $line_split 198]]
		set imp_risp_rend_min_412_g2_no          [string trim [lindex $line_split 199]]
		set imp_risp_rend_min_412_g3_si          [string trim [lindex $line_split 200]]
		set imp_risp_rend_min_412_g3_no          [string trim [lindex $line_split 201]]
		set imp_invio_no_manut_30gg              [string trim [lindex $line_split 202]]
		set imp_note_non_pres_appuntam           [string trim [lindex $line_split 203]]
		set imp_note_no_disimpegno               [string trim [lindex $line_split 204]]
		set imp_note_no_parete_attest            [string trim [lindex $line_split 205]]
		set imp_note_no_libr_centrale            [string trim [lindex $line_split 206]]
		set imp_note_no_allegato_H               [string trim [lindex $line_split 207]]
		set imp_note_sfiato_gasolio              [string trim [lindex $line_split 208]]
		set imp_note_dep_gasolio_no_norma        [string trim [lindex $line_split 209]]
		set imp_note_serb_gasol_loc_cald         [string trim [lindex $line_split 210]]
		set imp_note_impian_gPL_camoagna         [string trim [lindex $line_split 211]]
		set imp_note_no_manut_prec               [string trim [lindex $line_split 212]]
		set imp_note_no_man_ver_prec             [string trim [lindex $line_split 213]]
		set imp_note_impian_disattivato          [string trim [lindex $line_split 214]]
		set imp_note_imp_camera_bagno            [string trim [lindex $line_split 215]]
		set imp_note_can_fumo_da_sostituire      [string trim [lindex $line_split 216]]
		set imp_note_si_consi_sost_fumo          [string trim [lindex $line_split 217]]
		set imp_note_rila_dich_potenza           [string trim [lindex $line_split 218]]
		set imp_note_imp_instal_autorimessa      [string trim [lindex $line_split 219]]
		set imp_note_canale_fumo_no_norma        [string trim [lindex $line_split 220]]
		set imp_note_serb_gasolio_autorimessa    [string trim [lindex $line_split 221]]
		set imp_note_cert_bombolone              [string trim [lindex $line_split 222]]


		if {[db_0or1row sel_aimp "select cod_combustibile,
                                         cod_responsabile,
                                         stato,
                                         cod_manutentore,
                                         data_installaz
                                    from coimaimp
                                   where cod_impianto_est = :imp_n_dich"] == 0} {
		    puts $filout2 "$line; impianto mancante o impianto non codificato correttamente"
		    incr conta_sup_err
		    incr righe_con_errori2
		    continue
		} else {
	 
		    ### data controllo
		    if {![string equal $imp_data_controllo ""]} {
			set imp_data_controllo [db_string query "select to_date(:imp_data_controllo, 'DD MM YYYY')"]
			#estraggo la data del controllo
			set yy_data [string range $imp_data_controllo 0 3]
		    } 
# 		    else {
# 			set errori "$errori;manca data di controllo"
# 			incr conta_sup_err
# 			if {[string equal $conta_errori 0]} {
#                                 incr conta_errori
#                                 incr righe_con_errori2
# 			}
# 		    }

		    ### nome verificatore
		    if {![string equal $imp_nomeverificatore ""]} {
			if {[string equal $imp_nomeverificatore "NON RILEVATO"]} {
			    set cod_opve "VE1000"
			} else {
			    set cod_opve [db_string query "select cod_opve from coimopve where cognome || ' ' || nome = :imp_nomeverificatore" -default "Error"]
			    if {[string equal $cod_opve "Error"]} {
				set errori "$errori;verificatore non trovato"
				incr conta_sup_err
				if {[string equal $conta_errori 0]} {
				    incr conta_errori
				    incr righe_con_errori2
				}
			    } else {
				set cod_impianto_int [db_string query "select cod_impianto as cod_impianto_int from coimaimp where cod_impianto_est = :imp_n_dich" -default "Error"]
 				set appuntamento_ok [db_string query "select 1 from coiminco where cod_opve=:cod_opve and cod_impianto=:cod_impianto_int limit 1" -default "Error"]
 				if {[string equal $appuntamento_ok "Error"]} {
 				    puts $filout2 "$line;verificare se esiste l'appuntamento relativo a questo controllo"
 				    incr conta_sup_err
 				    incr righe_con_errori
 				    continue
 				}
			    }
			}
		    } else {
			set errori "$errori;verificatore non trovato"
			incr conta_sup_err
			if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			}
		    }
		    
		    ### potenza
		    if {[string equal $imp_pot_nomg1 "0,00"]||[string equal $imp_pot_nomg1 ""]||[string equal $imp_pot_nomg1 "0"]} {
			set imp_pot_nomg1 ""
		    } else {
			set imp_pot_nomg1 [iter_check_num $imp_pot_nomg1 2]
			if {$imp_pot_nomg1 == "Error"} {
			    set imp_pot_nomg1 ""		  
#			    set errori "$errori;potenza nominale errata"
#			    incr conta_sup_err
#                            if {[string equal $conta_errori 0]} {
#                                incr conta_errori
#                                incr righe_con_errori2
#                            }
			}
		    }
		    
		    if {[string equal $imp_pot_nomg2 "0,00"]||[string equal $imp_pot_nomg2 ""]||[string equal $imp_pot_nomg2 "0"]} {
			set imp_pot_nomg2 ""
		    } else {
			set imp_pot_nomg2 [iter_check_num $imp_pot_nomg2 2]
			if {$imp_pot_nomg2 == "Error"} {
			    set imp_pot_nomg2 ""
#			    set errori "$errori;potenza nominale errata"
#			    incr conta_sup_err
#			    if {[string equal $conta_errori 0]} {
#                                incr conta_errori
#                                incr righe_con_errori2
#			    }
			}
		    }

		    if {[string equal $imp_pot_nomg3 "0,00"]||[string equal $imp_pot_nomg3 ""]||[string equal $imp_pot_nomg3 "0"]} {
			set imp_pot_nomg3 ""
		    } else {
			set imp_pot_nomg3 [iter_check_num $imp_pot_nomg3 2]
			if {$imp_pot_nomg3 == "Error"} {
			    set imp_pot_nomg3 ""
#			    set errori "$errori;potenza nominale errata"
#			    incr conta_sup_err
#			    if {[string equal $conta_errori 0]} {
#                                incr conta_errori
#                                incr righe_con_errori2
#			    }
			}
		    }

		    if {$imp_anno_costg1 ne ""
			&& $imp_anno_costg1 ne "0"} {
			set imp_anno_costg1 "$imp_anno_costg1/01/01"
		    } else {
			set imp_anno_costg1 ""
		    }

		    if {$imp_anno_costg2 ne ""
			&& $imp_anno_costg2 ne "0"} {
			set imp_anno_costg2 "$imp_anno_costg2/01/01"
		    } else {
			set imp_anno_costg2 ""
		    }

		    if {$imp_anno_costg3 ne ""
			&& $imp_anno_costg3 ne "0"} {
			set imp_anno_costg3 "$imp_anno_costg3/01/01"
		    } else {
			set imp_anno_costg3 ""
		    }

		    set imp_controllo_ril_sup ""
		    switch $imp_controllo_ril_sup_si {
			"1" {set imp_controllo_ril_sup "S"}
			"1,00" {set imp_controllo_ril_sup "S"}
			default {}
		    }
		    switch $imp_controllo_ril_sup_no {
			"1" {set imp_controllo_ril_sup "N"}
			"1,00" {set imp_controllo_ril_sup "N"}
			default {}
		    }

		    #temp_fumi_md
		    if {[string equal $imp_tempfumig1 "0,00"]||[string equal $imp_tempfumig1 ""]||[string equal $imp_tempfumig1 "0"]} {
			set imp_tempfumig1 ""
		    } else {
			set imp_tempfumig1 [iter_check_num $imp_tempfumig1 2]
			if {$imp_tempfumig1 == "Error"} {
			    set errori "$errori;temperatura fumi errata"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }

		    if {[string equal $imp_tempfumig2 "0,00"]||[string equal $imp_tempfumig2 ""]||[string equal $imp_tempfumig2 "0"]} {
			set imp_tempfumig2 ""
		    } else {
			set imp_tempfumig2 [iter_check_num $imp_tempfumig2 2]
			if {$imp_tempfumig2 == "Error"} {
			    set errori "$errori;temperatura fumi errrata"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_tempfumig3 "0,00"]||[string equal $imp_tempfumig3 ""]||[string equal $imp_tempfumig3 "0"]} {
			set imp_tempfumig3 ""
		    } else {
			set imp_tempfumig3 [iter_check_num $imp_tempfumig3 2]
			if {$imp_tempfumig3 == "Error"} {
			    set errori "$errori;temperatura fumi errata"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_perdcalsensg1 "0,00"]||[string equal $imp_perdcalsensg1 ""]||[string equal $imp_perdcalsensg1 "0"]} {
			set imp_perdcalsensg1 ""
		    } else {
			set imp_perdcalsensg1 [iter_check_num $imp_perdcalsensg1 2]
			if {$imp_perdcalsensg1 == "Error"} {
			    set errori "$errori;perd. cal. sens. errata"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }

		    if {[string equal $imp_perdcalsensg2 "0,00"]||[string equal $imp_perdcalsensg2 ""]||[string equal $imp_perdcalsensg2 "0"]} {
			set imp_perdcalsensg2 ""
		    } else {
			set imp_perdcalsensg2 [iter_check_num $imp_perdcalsensg2 2]
			if {$imp_perdcalsensg2 == "Error"} {
			    set errori "$errori;perd. cal. sens. errata"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }

		    if {[string equal $imp_perdcalsensg3 "0,00"]||[string equal $imp_perdcalsensg3 ""]||[string equal $imp_perdcalsensg3 "0"]} {
			set imp_perdcalsensg3 ""
		    } else {
			set imp_perdcalsensg3 [iter_check_num $imp_perdcalsensg3 2]
			if {$imp_perdcalsensg3 == "Error"} {
			    set errori "$errori;perd. cal. sens. errata"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }

		    if {[string equal $imp_rendmisurato2g1 "0,00"]||[string equal $imp_rendmisurato2g1 ""]||[string equal $imp_rendmisurato2g1 "0"]} {
			set imp_rendmisurato2g1 ""
		    } else {
			set imp_rendmisurato2g1 [iter_check_num $imp_rendmisurato2g1 2]
			if {$imp_rendmisurato2g1 == "Error"} {
			    set errori "$errori;perd. cal. sens. errata"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }

		    if {[string equal $imp_rendmisurato2g2 "0,00"]||[string equal $imp_rendmisurato2g2 ""]||[string equal $imp_rendmisurato2g2 "0"]} {
			set imp_rendmisurato2g2 ""
		    } else {
			set imp_rendmisurato2g2 [iter_check_num $imp_rendmisurato2g2 2]
			if {$imp_rendmisurato2g2 == "Error"} {
			    set errori "$errori;perd. cal. sens. errata"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }

		    if {[string equal $imp_rendmisurato2g3 "0,00"]||[string equal $imp_rendmisurato2g3 ""]||[string equal $imp_rendmisurato2g3 "0"]} {
			set imp_rendmisurato2g3 ""
		    } else {
			set imp_rendmisurato2g3 [iter_check_num $imp_rendmisurato2g3 2]
			if {$imp_rendmisurato2g3 == "Error"} {
			    set errori "$errori;perd. cal. sens. errata"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }

		    ### t_aria_comb_md
		    if {[string equal $imp_tempambienteg1 "0,00"]||[string equal $imp_tempambienteg1 ""]||[string equal $imp_tempambienteg1 "0"]} {
			set imp_tempambienteg1 ""
		    } else {
			set imp_tempambienteg1 [iter_check_num $imp_tempambienteg1 2]
			if {$imp_tempambienteg1 == "Error"} {
			    set errori "$errori;temperatura ambiente errata"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }

		    if {[string equal $imp_tempambienteg2 "0,00"]||[string equal $imp_tempambienteg2 ""]||[string equal $imp_tempambienteg2 "0"]} {
			set imp_tempambienteg2 ""
		    } else {
			set imp_tempambienteg2 [iter_check_num $imp_tempambienteg2 2]
			if {$imp_tempambienteg2 == "Error"} {
			    set errori "$errori;temperatura ambiente errata"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_tempambienteg3 "0,00"]||[string equal $imp_tempambienteg3 ""]||[string equal $imp_tempambienteg3 "0"]} {
			set imp_tempambienteg3 ""
		    } else {
			set imp_tempambienteg3 [iter_check_num $imp_tempambienteg3 2]
			if {$imp_tempambienteg3 == "Error"} {
			    set errori "$errori;temperatura ambiente errata"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }

		    ### c02
		    if {[string equal $imp_co2g1 "0,00"]||[string equal $imp_co2g1 ""]||[string equal $imp_co2g1 "0"]} {
			set imp_co2g1 ""
		    } else {
			set imp_co2g1 [iter_check_num $imp_co2g1 2]
			if {$imp_co2g1 == "Error"} {
			    set errori "$errori;co2 errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_co2g2 "0,00"]||[string equal $imp_co2g2 ""]||[string equal $imp_co2g2 "0"]} {
			set imp_co2g2 ""
		    } else {
			set imp_co2g2 [iter_check_num $imp_co2g2 2]
			if {$imp_co2g2 == "Error"} {
			    set errori "$errori;co2 errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }

		    if {[string equal $imp_co2g3 "0,00"]||[string equal $imp_co2g3 ""]||[string equal $imp_co2g3 "0"]} {
			set imp_co2g3 ""
		    } else {
			set imp_co2g3 [iter_check_num $imp_co2g3 2]
			if {$imp_co2g3 == "Error"} {
			    set errori "$errori;co2 errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }


			##controllo il tipo di combustibile, 
			##verifico che sia valorizatto un solo tipo di combustibile per volta
			set comb 0
			if {[string equal $imp_metano 0]} {
			    set comb [expr $comb+1]
			} else {
			    set comb [expr $comb-1]			    
			}
			if {[string equal $imp_gpl 0]} {
			    set comb [expr $comb+1]			    
			} else {
			    set comb [expr $comb-1]			    
			}
			if {[string equal $imp_gasolio 0]} {
			    set comb [expr $comb+1]			    
			} else {
			    set comb [expr $comb-1]			    
			}
			if {$comb>=-3 && $comb <1} {
			    set errori "$errori;sono definiti troppo tipi di combustibile"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
# 			if {[string equal $comb 4]} {
# 			    set errori "$errori;non sono definiti tipi di combustibile"
# 			    incr conta_sup_err			    
# 			    if {[string equal $conta_errori 0]} {
#                                 incr conta_errori
#                                 incr righe_con_errori2
# 			    }
# 			}

		    ### indic_fumosita_md
		    if {[string equal $imp_bacharachg1 "0,00"]||[string equal $imp_bacharachg1 ""]||[string equal $imp_bacharachg1 "0"]} {
			set imp_bacharachg1 ""
		    } else {
			set imp_bacharachg1 [iter_check_num $imp_bacharachg1 2]
			if {$imp_bacharachg1 == "Error"} {
			    set errori "$errori;bacharach errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_bacharachg2 "0,00"]||[string equal $imp_bacharachg2 ""]||[string equal $imp_bacharachg2 "0"]} {
			set imp_bacharachg2 ""
		    } else {
			set imp_bacharachg2 [iter_check_num $imp_bacharachg2 2]
			if {$imp_bacharachg2 == "Error"} {
			    set errori "$errori;bacharach errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_bacharachg3 "0,00"]||[string equal $imp_bacharachg3 ""]||[string equal $imp_bacharachg3 "0"]} {
			set imp_bacharachg3 ""
		    } else {
			set imp_bacharachg3 [iter_check_num $imp_bacharachg3 2]
			if {$imp_bacharachg3 == "Error"} {
			    set errori "$errori;bacharach errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    ### new1_co_rilevato
		    if {[string equal $imp_cofumisecchig1 "0,00"]||[string equal $imp_cofumisecchig1 ""]||[string equal $imp_cofumisecchig1 "0"]} {
			set imp_cofumisecchig1 ""
		    } else {
			set imp_cofumisecchig1 [iter_check_num $imp_cofumisecchig1 2]
			if {$imp_cofumisecchig1 == "Error"} {
			    set errori "$errori;co fumi secchi errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_cofumisecchig2 "0,00"]||[string equal $imp_cofumisecchig2 ""]||[string equal $imp_cofumisecchig2 "0"]} {
			set imp_cofumisecchig2 ""
		    } else {
			set imp_cofumisecchig2 [iter_check_num $imp_cofumisecchig2 2]
			if {$imp_cofumisecchig2 == "Error"} {
			    set errori "$errori;co fumi secchi errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_cofumisecchig3 "0,00"]||[string equal $imp_cofumisecchig3 ""]||[string equal $imp_cofumisecchig3 "0"]} {
			set imp_cofumisecchig3 ""
		    } else {
			set imp_cofumisecchig3 [iter_check_num $imp_cofumisecchig3 2]
			if {$imp_cofumisecchig3 == "Error"} {
			    set errori "$errori;co fumi secchi errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    ### co_md
		    if {[string equal $imp_cog1 "0,00"]||[string equal $imp_cog1 ""]||[string equal $imp_cog1 "0"]} {
			set imp_cog1 ""
		    } else {
			set imp_cog1 [iter_check_num $imp_cog1 2]
			if {$imp_cog1 == "Error"} {
			    set errori "$errori;co errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_cog2 "0,00"]||[string equal $imp_cog2 ""]||[string equal $imp_cog2 "0"]} {
			set imp_cog2 ""
		    } else {
			set imp_cog2 [iter_check_num $imp_cog2 2]
			if {$imp_cog2 == "Error"} {
			    set errori "$errori;co errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_cog3 "0,00"]||[string equal $imp_cog3 ""]||[string equal $imp_cog3 "0"]} {
			set imp_cog3 ""
		    } else {
			set imp_cog3 [iter_check_num $imp_cog3 2]
			if {$imp_cog3 == "Error"} {
			    set errori "$errori;co errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    set esito_verificag ""
		    switch $imp_rispnormaSIg1 {
			"1" {set imp_rispnormag1 "S"}
			"0" {}
			default {}
		    }
		    switch $imp_rispnormaNOg1 {
			"1" {set imp_rispnormag1 "N"}
			"0" {}
			default {} 
		    }
		    switch $imp_rispnormaSIg2 {
			"1" {set imp_rispnormag2 "P"}
			"0" {}
			default {} 
		    }
		    switch $imp_rispnormaNOg2 {
			"1" {set imp_rispnormag2 "N"}
			"0" {}
			default {} 
		    }
		    
		    switch $imp_rispnormaSIg3 {
			"1" {set imp_rispnormag3 "P"}
			"0" {}
			default {} 
		    }
		    switch $imp_rispnormaNOg3 {
			"1" {set imp_rispnormag3 "N"}
			"0" {}
			default {} 
		    }

		    switch $imp_risp_rend_min_412_g1_si {
			"1" {set imp_risp_rend_min_412_g1 "S"}
			"0" {}
			default {} 
		    }
		    switch $imp_risp_rend_min_412_g1_no {
			"1" {set imp_risp_rend_min_412_g1 "N"}
			"0" {}
			default {} 
		    }

		    switch $imp_risp_rend_min_412_g2_si {
			"1" {set imp_risp_rend_min_412_g2 "S"}
			"0" {}
			default {} 
		    }
		    switch $imp_risp_rend_min_412_g2_no {
			"1" {set imp_risp_rend_min_412_g2 "N"}
			"0" {}
			default {} 
		    }
		    
		    switch $imp_risp_rend_min_412_g3_si {
			"1" {set imp_risp_rend_min_412_g3 "S"}
			"0" {}
			default {} 
		    }
		    switch $imp_risp_rend_min_412_g3_no {
			"1" {set imp_risp_rend_min_412_g3 "N"}
			"0" {}
			default {} 
		    }

		    ### o2_md
		    if {[string equal $imp_o2g1 "0,00"]||[string equal $imp_o2g1 ""]||[string equal $imp_o2g1 "0"]} {
			set imp_o2g1 ""
		    } else {
			set imp_o2g1 [iter_check_num $imp_o2g1 2]
			if {$imp_o2g1 == "Error"} {
			    set errori "$errori;o2 errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_o2g2 "0,00"]||[string equal $imp_o2g2 ""]||[string equal $imp_o2g2 "0"]} {
			set imp_o2g2 ""
		    } else {
			set imp_o2g2 [iter_check_num $imp_o2g2 2]
			if {$imp_o2g2 == "Error"} {
			    set errori "$errori;o2 errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_o2g3 "0,00"]||[string equal $imp_o2g3 ""]||[string equal $imp_o2g3 "0"]} {
			set imp_o2g3 ""
		    } else {
			set imp_o2g3 [iter_check_num $imp_o2g3 2]
			if {$imp_o2g3 == "Error"} {
			    set errori "$errori;o2 errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    ### rend_comb_conv
		    if {[string equal $imp_rendcombpotnomg1 "0,00"]||[string equal $imp_rendcombpotnomg1 ""]||[string equal $imp_rendcombpotnomg1 "0"]} {
			set imp_rendcombpotnomg1 ""
		    } else {
			set imp_rendcombpotnomg1 [iter_check_num $imp_rendcombpotnomg1 2]
			if {$imp_rendcombpotnomg1 == "Error"} {
			    set errori "$errori;rendimento combustibile convezionale errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }

		    if {[string equal $imp_rendcombpotnomg2 "0,00"]||[string equal $imp_rendcombpotnomg2 ""]||[string equal $imp_rendcombpotnomg2 "0"]} {
			set imp_rendcombpotnomg2 ""
		    } else {
			set imp_rendcombpotnomg2 [iter_check_num $imp_rendcombpotnomg2 2]
			if {$imp_rendcombpotnomg2 == "Error"} {
			    set errori "$errori;rendimento combustibile convenzionale errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_rendcombpotnomg3 "0,00"]||[string equal $imp_rendcombpotnomg3 ""]||[string equal $imp_rendcombpotnomg3 "0"]} {
			set imp_rendcombpotnomg3 ""
		    } else {
			set imp_rendcombpotnomg3 [iter_check_num $imp_rendcombpotnomg3 2]
			if {$imp_rendcombpotnomg3 == "Error"} {
			    set errori "$errori;rend. comb. conv. errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    ### rend_comb_min
		    if {[string equal $imp_rendmin412g1 "0,00"]||[string equal $imp_rendmin412g1 ""]||[string equal $imp_rendmin412g1 "0"]} {
			set imp_rendmin412g1 ""
		    } else {
			set imp_rendmin412g1 [iter_check_num $imp_rendmin412g1 2]
			if {$imp_rendmin412g1 == "Error"} {
			    set errori "$errori;rend. min. 412 errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_rendmin412g2 "0,00"]||[string equal $imp_rendmin412g2 ""]||[string equal $imp_rendmin412g2 "0"]} {
			set imp_rendmin412g2 ""
		    } else {
			set imp_rendmin412g2 [iter_check_num $imp_rendmin412g2 2]
			if {$imp_rendmin412g2 == "Error"} {
			    set errori "$errori;rend. min. 412 errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_rendmin412g3 "0,00"]||[string equal $imp_rendmin412g3 ""]||[string equal $imp_rendmin412g3 "0"]} {
			set imp_rendmin412g3 ""
		    } else {
			set imp_rendmin412g3 [iter_check_num $imp_rendmin412g3 2]
			if {$imp_rendmin412g3 == "Error"} {
			    set errori "$errori;rend. min. 412 errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    ### stato_coiben
		    set stato_coibeng1 "V"
		    switch $imp_statocoimbg1 {
			"B" {set stato_coibeng1 "B"}
			"M" {set stato_coibeng1 "M"}
			"S" {set stato_coibeng1 "S"}
			default {} 
		    }
		    
		    set stato_coibeng2 "V"
		    switch $imp_statocoimbg2 {
			"B" {set stato_coibeng2 "B"}
			"M" {set stato_coibeng2 "M"}
			"S" {set stato_coibeng2 "S"}
			default {} 
		    }
		    
		    set stato_coibeng3 "V"
		    switch $imp_statocoimbg3 {
			"B" {set stato_coibeng3 "B"}
			"M" {set stato_coibeng3 "M"}
			"S" {set stato_coibeng3 "S"}
			default {} 
		    }
		    
		    ### stato_canna_fum
		    switch $imp_statocannafumg1 {
			"B" {set imp_statocannafumg1 "B"}
			"M" {set imp_statocannafumg1 "N"}
			"S" {set imp_statocannafumg1 "S"}
			default {} 
		    }
		    
		    switch $imp_statocannafumg2 {
			"B" {set imp_statocannafumg2 "B"}
			"M" {set imp_statocannafumg2 "N"}
			"S" {set imp_statocannafumg2 "S"}
			default {} 
		    }

		    switch $imp_statocannafumg3 {
			"B" {set imp_statocannafumg3 "B"}
			"M" {set imp_statocannafumg3 "N"}
			"S" {set imp_statocannafumg3 "S"}
			default {} 
		    }

		    switch $imp_statodispcontrollog1 {
			"C"  {set imp_statodispcontrollog1 "P"}
			"NC" {set imp_statodispcontrollog1 "NC"}
			default {} 
		    }
		    switch $imp_statodispcontrollog2 {
			"C"  {set imp_statodispcontrollog2 "P"}
			"NC" {set imp_statodispcontrollog2 "NC"}
			default {} 
		    }
		    switch $imp_statodispcontrollog3 {
			"C"  {set imp_statodispcontrollog3 "P"}
			"NC" {set imp_statodispcontrollog3 "NC"}
			default {} 
		    }

		    switch $imp_taratregcontrg1 {
			"E" {set imp_taratregcontrg1 "E"}
			"NE" {set imp_taratregcontrg1 "N"}
			default {} 
		    }
		    switch $imp_taratregcontrg2 {
			"E" {set imp_taratregcontrg2 "E"}
			"NE" {set imp_taratregcontrg2 "N"}
			default {} 
		    }
		    switch $imp_taratregcontrg3 {
			"E" {set imp_taratregcontrg3 "E"}
			"NE" {set imp_taratregcontrg3 "N"}
			default {} 
		    }
		    
		    ### tipo_bruciatore (su generatore)
		    set tipo_bruciatore ""
		    switch $imp_soffiato {
			"1" {set tipo_bruciatore "S"}
			"0" {}
			default {} 
		    }
		    switch $imp_atmosferico {
			"1" {set tipo_bruciatore "A"}
			"0" {}
			default {} 
		    }

		    #imposto di default il combustibile a "non noto" 0
		    set cod_combustibile 0
		    ### combustibile (su impianto e generatore)
		    switch $imp_metano {
			"1" {set cod_combustibile "G"}
			"0" {}
			default {} 
		    }
		    switch $imp_gpl {
			"1" {set cod_combustibile "P"}
			"0" {}
			default {} 
		    }
		    switch $imp_gasolio {
			"1" {set cod_combustibile "O"}
			"0" {}
			default {} 
		    }
		    switch $imp_altrospec {
			"LEGNA" {set cod_combustibile "X"
			    set flag_DPR412 "N"}
			"0" {}
			default {} 
		    }
		    
		    ### temp_h2o_out_md
		    if {[string equal $imp_tempmandg1 "0,00"]||[string equal $imp_tempmandg1 ""]||[string equal $imp_tempmandg1 "0"]} {
			set  imp_tempmandg1 ""
		    } else {
			set imp_tempmandg1 [iter_check_num $imp_tempmandg1 2]
			if {$imp_tempmandg1 == "Error"} {
			    set errori "$errori;temp. mand. errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_tempmandg2 "0,00"]||[string equal $imp_tempmandg2 ""]||[string equal $imp_tempmandg2 "0"]} {
			set  imp_tempmandg2 ""
		    } else {
			set imp_tempmandg2 [iter_check_num $imp_tempmandg2 2]
			if {$imp_tempmandg2 == "Error"} {
			    set errori "$errori;temp. mand. errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_tempmandg3 "0,00"]||[string equal $imp_tempmandg3 ""]||[string equal $imp_tempmandg3 "0"]} {
			set  imp_tempmandg3 ""
		    } else {
			set imp_tempmandg3 [iter_check_num $imp_tempmandg3 2]
			if {$imp_tempmandg3 == "Error"} {
			    set errori "$errori;temp. mand. errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    set imp_porttermicag ""
		    set imp_pot_nomg ""
		    set totale_pot ""
		    ### mis_port_combust
		    if {[string equal $imp_porttermicag1 "0,00"]||[string equal $imp_porttermicag1 ""]||[string equal $imp_porttermicag1 "0"]} {
			set imp_porttermicag1 ""
		    } else {
			set imp_porttermicag1 [iter_check_num $imp_porttermicag1 2]
			if {$imp_porttermicag1 == "Error"} {
			    set errori "$errori;port. termica errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_porttermicag2 "0,00"]||[string equal $imp_porttermicag2 ""]||[string equal $imp_porttermicag2 "0"]} {
			set imp_porttermicag2 ""
		    } else {
			set imp_porttermicag2 [iter_check_num $imp_porttermicag2 2]
			if {$imp_porttermicag2 == "Error"} {
			    set errori "$errori;port. termica errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    
		    if {[string equal $imp_porttermicag3 "0,00"]||[string equal $imp_porttermicag3 ""]||[string equal $imp_porttermicag3 "0"]} {
			set imp_porttermicag3 ""
		    } else {
			set imp_porttermicag3 [iter_check_num $imp_porttermicag3 2]
			if {$imp_porttermicag3 == "Error"} {
			    set errori "$errori;port. termica errato"
			    incr conta_sup_err
			    if {[string equal $conta_errori 0]} {
                                incr conta_errori
                                incr righe_con_errori2
			    }
			}
		    }
		    ### manutentore(su impianto)
		    if {[string equal cod_manutentore ""]} {
			if {![string equal $imp_manutentditta ""]} {		
			    set cognome_manu [string range $imp_manutentditta 0 37]
			    set nome_manu [string range $imp_manutentditta 38 45]
			    if {![string equal $nome_manu ""]} {
				set where_nome " and nome = upper(:nome_manu)"
			    } else {
				set where_nome " and nome is null"
			    }
			    if {[db_0or1row sel_manu "select cod_manutentore
                                                from coimmanu
                                               where cognome = upper(:cognome_manu)
                                              $where_nome"] == 0} {
				set errori "$errori;port. termica errato"
				incr conta_sup_err
				if {[string equal $conta_errori 0]} {
				    incr conta_errori
				    incr righe_con_errori2
				}
			    }
			}
		    }
		    
		    ### cod_utgi (destinazione d'uso su generatore)
		    set cod_utgi "0"
		    switch $imp_risc {
			"1" {set cod_utgi "R"}
			"0" {}
			default {} 
		    }
		    switch $imp_riscpiusanit {
			"1" {set cod_utgi "E"}
			"0" {}
			default {} 
		    }
		    switch $imp_solosanitario {
			"1" {set cod_utgi "A"}
			"0" {}
			default {} 
		    }
		    
		    ### data ultima verifica
		    if {![string equal $imp_ultima_verifica ""]} {
			if {![string is integer $imp_ultima_verifica]} {
			    set imp_ultima_verifica ""
			} else {
			    if {[string length $imp_ultima_verifica] == 4} {
				set imp_ultima_verifica "$imp_ultima_verifica-01-01"
			    } else {
				set errori "$errori;anno ult. ver. errato"
				incr conta_sup_err
				if {[string equal $conta_errori 0]} {
				    incr conta_errori
				    incr righe_con_errori2
				}
			    }
			}
		    }

		    if {![string equal $imp_ultima_verificag2 ""]} {
			if {![string is integer $imp_ultima_verificag2]} {
			    set imp_ultima_verificag2 ""
			} else {
			    if {[string length $imp_ultima_verificag2] == 4} {
				set imp_ultima_verificag2 "$imp_ultima_verificag2-01-01"
			    } else {
				set errori "$errori;anno ult. ver. errato"
				incr conta_sup_err
				if {[string equal $conta_errori 0]} {
				    incr conta_errori
				    incr righe_con_errori2
				}
			    }
			}
		    }

		    if {![string equal $imp_ultima_verificag3 ""]} {
			if {![string is integer $imp_ultima_verificag3]} {
			    set imp_ultima_verificag3 ""
			} else {
			    if {[string length $imp_ultima_verificag3] == 4} {
				set imp_ultima_verificag3 "$imp_ultima_verificag3-01-01"
			    } else {
				set errori "$errori;anno ult. ver. errato"
				incr conta_sup_err
				if {[string equal $conta_errori 0]} {
				    incr conta_errori
				    incr righe_con_errori2
				}
			    }
			}
		    }

		    ### data ultima manutenzione
		    if {![string equal $imp_ultima_manutenzione ""]} {
			if {![string is integer $imp_ultima_manutenzione]} {
			    set imp_ultima_manutenzione ""
			} else {
			    if {[string length $imp_ultima_manutenzione] == 4} {
				append imp_ultima_manutenzione "0101"
			    } else {
				set errori "$errori;anno ult. man. errato"
				incr conta_sup_err
				if {[string equal $conta_errori 0]} {
				    incr conta_errori
				    incr righe_con_errori2
				}
			    }
			}
		    }
		    
		    if {![string equal $imp_ultima_manutenzioneg2 ""]} {
			if {![string is integer $imp_ultima_manutenzioneg2]} {
			    set imp_ultima_manutenzioneg2 ""
			} else {
			    if {[string length $imp_ultima_manutenzioneg2] == 4} {
				append imp_ultima_manutenzioneg2 "0101"
			    } else {
				set errori "$errori;anno ult. man. errato"
				incr conta_sup_err
				if {[string equal $conta_errori 0]} {
				    incr conta_errori
				    incr righe_con_errori2
				}
			    }
			}
		    }
		    
		    if {![string equal $imp_ultima_manutenzioneg3 ""]} {
			if {![string is integer $imp_ultima_manutenzioneg3]} {
			    set imp_ultima_manutenzioneg3 ""
			} else {
			    if {[string length $imp_ultima_manutenzioneg3] == 4} {
				append imp_ultima_manutenzioneg3 "0101"
			    } else {
				set errori "$errori;anno ult. man. errato"
				incr conta_sup_err
				if {[string equal $conta_errori 0]} {
				    incr conta_errori
				    incr righe_con_errori2
				}
			    }
			}
		    }
		    
		    ### presenza_libretto
		    set presenza_libretto "S"
		    switch $imp_dati_ril_libretto {
			"1" {set presenza_libretto "S"}
			"0" {}
			default {} 
		    }
		    
		    ### flag manutenzione anno in corso
		    if {[string equal $yy_data "2005"]||[string equal $yy_data ""]||[string equal $yy_data "0202"]||[string equal $yy_data "2006"]||[string equal $yy_data "2007"]||[string equal $yy_data "2008"]||[string equal $yy_data "2009"]||[string equal $yy_data "2010"]||[string equal $yy_data "2011"]||[string equal $yy_data "2012"]} {
			set manutenzione_8a_g1 "N"
			set manutenzione_8a_g2 "N"
			set manutenzione_8a_g3 "N"
		    } else {
			set comodo1 [set imp_man$yy_data]
			switch $comodo1 {
			    "1" {set manutenzione_8a_g1 "S"}
			    "0" {set manutenzione_8a_g1 "N"}
			    default {}
			}

			set comodo2 [set imp_mang2$yy_data]
			switch $comodo2 {
			    "1" {set manutenzione_8a_g2 "S"}
			    "0" {set manutenzione_8a_g2 "N"}
			    default {} 
			}

			set comodo3 [set imp_mang3$yy_data]
			switch $comodo3 {
			    "1" {set manutenzione_8a_g3 "S"}
			    "0" {set manutenzione_8a_g3 "N"}
			    default {} 
			}
		    }
		    
		    ### flag manutenzione anni precedenti
		    if {$imp_man1994 == "1,00" || $imp_man1995 == "1,00" || $imp_man1996 == "1,00" || $imp_man1997 == "1,00" || $imp_man1998 == "1,00" || $imp_man1999 == "1,00" || $imp_man2000 == "1,00" || $imp_man2001 == "1,00" || $imp_man2002 == "1,00" || $imp_man2003 == "1,00" || $imp_man2004 == "1,00"} {
			set new1_manu_prec_8a_g1 "S"
		    } else {
			set new1_manu_prec_8a_g1 "N"
		    }
		    
		    if {$imp_mang21994 == "1,00" || $imp_mang21995 == "1,00" || $imp_mang21996 == "1,00" || $imp_mang21997 == "1,00" || $imp_mang21998 == "1,00" || $imp_mang21999 == "1,00" || $imp_mang22000 == "1,00" || $imp_mang22001 == "1,00" || $imp_mang22002 == "1,00" || $imp_mang22003 == "1,00" || $imp_mang22004 == "1,00"} {
			set new1_manu_prec_8a_g2 "S"
		    } else {
			set new1_manu_prec_8a_g2 "N"
		    }
		    
		    if {$imp_mang31994 == "1,00" || $imp_mang31995 == "1,00" || $imp_mang31996 == "1,00" || $imp_mang31997 == "1,00" || $imp_mang31998 == "1,00" || $imp_mang31999 == "1,00" || $imp_mang32000 == "1,00" || $imp_mang32001 == "1,00" || $imp_mang32002 == "1,00" || $imp_mang32003 == "1,00" || $imp_mang32004 == "1,00"} {
			set new1_manu_prec_8a_g3 "S"
		    } else {
			set new1_manu_prec_8a_g3 "N"
		    }
		    
		    ### new1_canali_a_norma
		    set new1_canali_a_norma "S"
		    switch $imp_note_canale_fumo_no_norma {
			"1" {set new1_canali_a_norma "N"}
			"0" {}
			default {} 
		    }

		    set imp_centrale_non_a_norma ""
		    switch $imp_centrale_non_a_norma_no {
			"1" {set imp_centrale_non_a_norma "S"}
			"1,00" {set imp_centrale_non_a_norma "S"}
			default {}
		    }

		    set gen_prog 1

		    set cod_imp_est [db_string sel_cod_impianto "select cod_impianto from coimaimp where cod_impianto_est = :imp_n_dich"]
		    set scheda_presente [db_string query "select 1 from coimcimp where cod_impianto=:cod_imp_est and gen_prog=:gen_prog and data_controllo=:imp_data_controllo limit 1" -default "OK"]			
		    if {![string equal $scheda_presente "OK"]} {
			set errori "$errori;impianto già inserito"
			incr conta_sup_err
			if {[string equal $conta_errori 0]} {
			    incr conta_errori
			    incr righe_con_errori2
			}
		    } else {

			set imp_anno_installazione ""
			lappend rapporti_verifica_impianti_corretti $imp_n_dich 
			lappend rapporti_verifica_date_corretti $imp_data_controllo
			puts $file_ok "$imp_n_dich;$gen_prog;$cod_inco;$imp_data_controllo;$cod_opve;$presenza_libretto;$stato_coibeng1;$imp_rendcombpotnomg1;$imp_rendmin412g1;$imp_co2g1;$imp_bacharachg1;$manutenzione_8a_g1;$esito_verificag;$imp_note;$cod_combustibile;$cod_responsabile;$utente;$new1_canali_a_norma;$imp_ultima_manutenzione;$new1_manu_prec_8a_g1;$imp_cofumisecchig1;$imp_puntatoreg1;$imp_numero_serie;$imp_tempfumig1;$imp_tempambienteg1;$imp_cog1;$imp_o2g1;$imp_statocannafumg1;$imp_tempmandg1;$imp_porttermicag;$imp_pot_nomg;$imp_pot_nomg;$totale_pot;$imp_ora_inizio;$imp_ora_fine;$imp_anno_costg1;$imp_anno_installazione;$imp_manutentditta;$imp_costrg1;$imp_modg1;$cod_utgi;$imp_note_non_pres_appuntam;$imp_note_no_disimpegno;$imp_note_no_parete_attest;$imp_note_no_libr_centrale;$imp_note_no_allegato_H;$imp_note_sfiato_gasolio;$imp_note_dep_gasolio_no_norma;$imp_note_serb_gasol_loc_cald;$imp_note_impian_gPL_camoagna;$imp_note_no_manut_prec;$imp_note_no_man_ver_prec;$imp_note_impian_disattivato;$imp_note_imp_camera_bagno;$imp_note_can_fumo_da_sostituire;$imp_note_si_consi_sost_fumo;$imp_note_rila_dich_potenza;$imp_note_imp_instal_autorimessa;$imp_note_canale_fumo_no_norma;$imp_note_serb_gasolio_autorimessa;$imp_note_cert_bombolone;$imp_fluidotermacqua;$imp_fluidoteraria;$imp_pot_nomg1;$imp_porttermicag1;$imp_ultima_verifica;$imp_mediadelletreprove;$imp_impiantononinuso;$imp_costrB1;$imp_statodispcontrollog1;$imp_taratregcontrg1;$imp_rispnormag1;$imp_risp_rend_min_412_g1;$imp_costrg2;$imp_costrg3;$imp_modg2;$imp_modg3;$imp_pot_nomg2;$imp_pot_nomg3;$imp_anno_costg2;$imp_anno_costg3;$imp_costrB2;$imp_costrB3;$imp_tempfumig2;$imp_tempfumig3;$imp_tempambienteg2;$imp_tempambienteg3;$imp_co2g2;$imp_co2g3;$imp_bacharachg2;$imp_bacharachg3;$imp_cofumisecchig2;$imp_cofumisecchig3;$imp_cog2;$imp_cog3;$imp_o2g2;$imp_o2g3;$imp_perdcalsensg1;$imp_perdcalsensg2;$imp_perdcalsensg3;$imp_rendcombpotnomg2;$imp_rendcombpotnomg3;$imp_rendmisurato2g1;$imp_rendmisurato2g2;$imp_rendmisurato2g3;$imp_rendmin412g2;$imp_rendmin412g3;$stato_coibeng2;$stato_coibeng3;$imp_statocannafumg2;$imp_statocannafumg3;$imp_statodispcontrollog2;$imp_statodispcontrollog3;$imp_taratregcontrg2;$imp_taratregcontrg3;$imp_puntatoreg2;$imp_puntatoreg3;$imp_tempmandg2;$imp_tempmandg3;$imp_porttermicag2;$imp_porttermicag3;$imp_ultima_manutenzioneg2;$imp_ultima_manutenzioneg3;$imp_ultima_verificag2;$imp_ultima_verificag3;$imp_risp_rend_min_412_g2;$imp_risp_rend_min_412_g3;$new1_manu_prec_8a_g2;$new1_manu_prec_8a_g3;$manutenzione_8a_g2;$manutenzione_8a_g3;$imp_rispnormag2;$imp_rispnormag3;$imp_controllo_ril_sup;$imp_centrale_non_a_norma;$imp_modB1;$imp_modB2;$imp_modB3;$tipo_bruciatore"
			incr conta_sup
		    }

		    #scrivo gli errori e li stampo nel file esterno
		    if {$conta_errori > 0} {
			puts $filout2 "$line;$errori"
			continue
		    }
		}
	    }
	    close $file_inp
	    close $filout2
	    close $file_ok

	    set numero_impianti_vidimati [llength $rapporti_verifica_impianti_corretti]
	    set schere_gasolio_corrette_rilevate ""
	    set counter_gas 0
	    set conta_schegas 0
	    set conta_schegas_err 0	
	    set file_inp_gas [open $tmpfile3 r]
	    set filout3 [open $spool_dir/scheda-ril-gasolio.txt w]
	    set file_gas [open $spool_dir/scheda-ril-gasolio-chr.txt w]	    

	    set utente "INS"

	    foreach line [split [read $file_inp_gas] \n] {
		set errori ""
		#non leggo la prima riga perchè contiene i nomi dei campi della tabella di rifermiento
		if {[string equal $counter_gas 0]} {
		    set counter_gas 1
		    continue
		}
		if {[string equal $line ""]} {
		    continue
		}
		
		set line_split [split $line ";"]
		
		set imp_n_dichiarazione            [string trim [lindex $line_split 0]]
		set accesso_esterno                [string trim [lindex $line_split 1]]
		set piano_grigliato                [string trim [lindex $line_split 2]]
		set intercapedine                  [string trim [lindex $line_split 3]]
		set portaincomb_acc_esterno        [string trim [lindex $line_split 4]]
		set portaincomb_acc_esterno_mag116 [string trim [lindex $line_split 5]]
		set dimensioni_porta               [string trim [lindex $line_split 6]]
		set accesso_interno                [string trim [lindex $line_split 7]]
		set disimpegno                     [string trim [lindex $line_split 8]]
		set struttura_disimp_verificabile  [string trim [lindex $line_split 9]]
		set da_disimpegno_con_lato         [string trim [lindex $line_split 10]]
		set da_disimpegno_senza_lato       [string trim [lindex $line_split 11]]
		set aerazione_disimpegno           [string trim [lindex $line_split 12]]
		set aerazione_tramite_condotto     [string trim [lindex $line_split 13]]
		set porta_disimpegno               [string trim [lindex $line_split 14]]
		set porta_caldaia                  [string trim [lindex $line_split 15]]
		set loc_caldaia_rei_60             [string trim [lindex $line_split 16]]
		set loc_caldaia_rei_120            [string trim [lindex $line_split 17]]
		set valvola_strappo                [string trim [lindex $line_split 18]]
		set interruttore_gasolio           [string trim [lindex $line_split 19]]
		set estintore                      [string trim [lindex $line_split 20]]
		set bocca_di_lupo                  [string trim [lindex $line_split 21]]
		set parete_confinante_esterno      [string trim [lindex $line_split 22]]
		set altezza_locale                 [string trim [lindex $line_split 23]]
		set altezza_230                    [string trim [lindex $line_split 24]]
		set altezza_250                    [string trim [lindex $line_split 25]]
		set distanza_generatori            [string trim [lindex $line_split 26]]
		set distanza_soff_invol_bollit     [string trim [lindex $line_split 27]]
		set distanza_soff_invol_no_bollit  [string trim [lindex $line_split 28]]
		set pavimento_imperm_soglia        [string trim [lindex $line_split 29]]
		set apert_vent_sino_500000         [string trim [lindex $line_split 30]]
		set apert_vent_sino_750000         [string trim [lindex $line_split 31]]
		set apert_vent_sup_750000          [string trim [lindex $line_split 32]]
		set certif_ispels                  [string trim [lindex $line_split 33]]
		set certif_cpi                     [string trim [lindex $line_split 34]]
		set serbatoio_esterno              [string trim [lindex $line_split 35]]
		set serbatoio_interno              [string trim [lindex $line_split 36]]
		set serbatoio_loc_caldaia          [string trim [lindex $line_split 37]]
		set sfiato_reticella_h             [string trim [lindex $line_split 38]]
		set segn_valvola_strappo           [string trim [lindex $line_split 39]]
		set segn_interrut_generale         [string trim [lindex $line_split 40]]
		set segn_estintore                 [string trim [lindex $line_split 41]]
		set segn_centrale_termica          [string trim [lindex $line_split 42]]
		
		set ok 0
		for {set x 0} {$x<$numero_impianti_vidimati} {incr x} {
		    set impianto_controllato [lindex $rapporti_verifica_impianti_corretti $x]
		    if {[string equal $impianto_controllato $imp_n_dichiarazione]} {
			lappend $schere_gasolio_corrette_rilevate $imp_n_dichiarazione
			puts $file_gas "$imp_n_dichiarazione;$accesso_esterno;$piano_grigliato;$intercapedine;$portaincomb_acc_esterno;$portaincomb_acc_esterno_mag116;$dimensioni_porta;$accesso_interno;$disimpegno;$struttura_disimp_verificabile;$da_disimpegno_con_lato;$da_disimpegno_senza_lato;$aerazione_disimpegno;$aerazione_tramite_condotto;$porta_disimpegno;$porta_caldaia;$loc_caldaia_rei_60;$loc_caldaia_rei_120;$valvola_strappo;$interruttore_gasolio;$estintore;$bocca_di_lupo;$parete_confinante_esterno;$altezza_locale;$altezza_230;$altezza_250;$distanza_generatori;$distanza_soff_invol_bollit;$distanza_soff_invol_no_bollit;$pavimento_imperm_soglia;$apert_vent_sino_500000;$apert_vent_sino_750000;$apert_vent_sup_750000;$certif_ispels;$certif_cpi;$serbatoio_esterno;$serbatoio_interno;$serbatoio_loc_caldaia;$sfiato_reticella_h;$segn_valvola_strappo;$segn_interrut_generale;$segn_estintore;$segn_centrale_termica"
			incr conta_schegas
			set ok 1
		    } 
		}
		if {[string equal $ok 0]} {
 		    puts $filout3 "$line; non sono presenti impianti di riferimento."
 		    incr conta_schegas_err
 		    continue		    
		}
	    }
	    close $file_inp
	    close $filout3
	    close $file_gas


	    set counter_met 0
	    set conta_schemet 0
	    set conta_schemet_err 0
	    set file_inp_met [open $tmpfile4 r]
	    set filout4 [open $spool_dir/scheda-ril-metano.txt w]
	    set file_met [open $spool_dir/scheda-ril-metano-chr.txt w]
	    set utente "INS"
	    
	    foreach line [split [read $file_inp_met] \n] {
		set errori ""
		#non leggo la prima riga perchè contiene i nomi dei campi della tabella di riferimento
		if {[string equal $counter_met 0]} {
		    set counter_met 1
		    continue
		}

		if {[string equal $line ""]} {
		    continue
		}
		
		set line_split [split $line ";"]
		
		set imp_n_dichiarazione          [string trim [lindex $line_split 0]]
		set accesso_esterno              [string trim [lindex $line_split 1]]
		set se_intercapedine             [string trim [lindex $line_split 2]]
		set porta_classe_0               [string trim [lindex $line_split 3]]
		set porta_con_apertura_esterno   [string trim [lindex $line_split 4]]
		set dimensioni_porta             [string trim [lindex $line_split 5]]
		set acces_interno                [string trim [lindex $line_split 6]]
		set disimpegno                   [string trim [lindex $line_split 7]]
		set da_disimp_con_lato_est       [string trim [lindex $line_split 8]]
		set da_disimp_rei_30             [string trim [lindex $line_split 9]]
		set da_disimp_rei_60             [string trim [lindex $line_split 10]]
		set aeraz_disimpegno             [string trim [lindex $line_split 11]]
		set condotta_aeraz_disimp        [string trim [lindex $line_split 12]]
		set porta_caldaia_rei_30         [string trim [lindex $line_split 13]]
		set porta_caldaia_rei_60         [string trim [lindex $line_split 14]]
		set valvola_interc_combustibile  [string trim [lindex $line_split 15]]
		set interr_generale_luce         [string trim [lindex $line_split 16]]
		set estintore                    [string trim [lindex $line_split 17]]
		set parete_conf_esterno          [string trim [lindex $line_split 18]]
		set alt_locale_2                 [string trim [lindex $line_split 19]]
		set alt_locale_2_30              [string trim [lindex $line_split 20]]
		set alt_locale_2_60              [string trim [lindex $line_split 21]]
		set alt_locale_2_90              [string trim [lindex $line_split 22]]
		set dispos_di_sicurezza          [string trim [lindex $line_split 23]]
		set ventilazione_qx10            [string trim [lindex $line_split 24]]
		set ventilazione_qx15            [string trim [lindex $line_split 25]]
		set ventilazione_qx20            [string trim [lindex $line_split 26]]
		set ventilazione_qx15_gpl        [string trim [lindex $line_split 27]]
		set ispels                       [string trim [lindex $line_split 28]]
		set cpi                          [string trim [lindex $line_split 29]]
		set valv_interc_comb_segnaletica [string trim [lindex $line_split 30]]
		set int_gen_luce_segnaletica     [string trim [lindex $line_split 31]]
		set centr_termica_segnaletica    [string trim [lindex $line_split 32]]
		set estintore_segnaletica        [string trim [lindex $line_split 33]]
		set rampa_a_gas_norma            [string trim [lindex $line_split 34]]

		set ok 0		
		for {set x 0} {$x<$numero_impianti_vidimati} {incr x} {
		    set impianto_controllato [lindex $rapporti_verifica_impianti_corretti $x]
		    if {[string equal $impianto_controllato $imp_n_dichiarazione]} {
			puts $file_met "$imp_n_dichiarazione;$accesso_esterno;$se_intercapedine;$porta_classe_0;$porta_con_apertura_esterno;$dimensioni_porta;$acces_interno;$disimpegno;$da_disimp_con_lato_est;$da_disimp_rei_30;$da_disimp_rei_60;$aeraz_disimpegno;$condotta_aeraz_disimp;$porta_caldaia_rei_30;$porta_caldaia_rei_60;$valvola_interc_combustibile;$interr_generale_luce;$estintore;$parete_conf_esterno;$alt_locale_2;$alt_locale_2_30;$alt_locale_2_60;$alt_locale_2_90;$dispos_di_sicurezza;$ventilazione_qx10;$ventilazione_qx15;$ventilazione_qx20;$ventilazione_qx15_gpl;$ispels;$cpi;$valv_interc_comb_segnaletica;$int_gen_luce_segnaletica;$centr_termica_segnaletica;$estintore_segnaletica;$rampa_a_gas_norma"
			incr conta_schemet
			set ok 1
		    }
		}
		if {[string equal $ok 0]} {
 		    puts $filout4 "$line; non sono presenti impianti di riferimento."
 		    incr conta_schemet_err
 		    continue		    
		}
	    }
	    close $file_inp
	    close $filout4
	    close $file_met


	    set counter_sg 0
	    set conta_scheserb 0
	    set conta_scheserb_err 0
	    
	    set file_inp_sg [open $tmpfile5 r]
	    set filout5 [open $spool_dir/scheda-serb-gasolio.txt w]
	    set file_sg [open $spool_dir/scheda-serb-gasolio-chr.txt w] 
	    set utente "INS"
	    
	    foreach line [split [read $file_inp_sg] \n] {
		set errori ""
		#non leggo la prima riga perchè contiene i nomi dei campi della tabella di riferimento
		if {[string equal $counter_sg 0]} {
		    set counter_sg 1
		    continue
		}
		if {[string equal $line ""]} {
		    continue
		}
		
		set line_split [split $line ";"]
		
		set imp_n_dichiarazione           [string trim [lindex $line_split 0]]
		set loc_escl_deposito_gasolio     [string trim [lindex $line_split 1]]
		set dep_gasolio_esterno           [string trim [lindex $line_split 2]]
		set accesso_ester_con_porta       [string trim [lindex $line_split 3]]
		set loc_materiale_incombustibile  [string trim [lindex $line_split 4]]
		set non_meno_50_cm                [string trim [lindex $line_split 5]]
		set soglia_pavimento              [string trim [lindex $line_split 6]]
		set tra_pareti_60_cm              [string trim [lindex $line_split 7]]
		set comun_con_altri_loc           [string trim [lindex $line_split 8]]
		set dep_serb_in_vista_aperto      [string trim [lindex $line_split 9]]
		set tettoia_all_aperto            [string trim [lindex $line_split 10]]
		set bacino_contenimento           [string trim [lindex $line_split 11]]
		set messa_a_terra                 [string trim [lindex $line_split 12]]
		set dep_gasolio_interno_interrato [string trim [lindex $line_split 13]]
		set porta_solaio_pareti_rei90     [string trim [lindex $line_split 14]]
		set struttura_locale_a_norma      [string trim [lindex $line_split 15]]
		set dep_gasolio_interno           [string trim [lindex $line_split 16]]
		set locale_caratteristiche_rei120 [string trim [lindex $line_split 17]]
		set accesso_esterno               [string trim [lindex $line_split 18]]
		set porta_esterna_incombustibile  [string trim [lindex $line_split 19]]
		set disimpegno                    [string trim [lindex $line_split 20]]
		set accesso_interno               [string trim [lindex $line_split 21]]
		set da_disimp_lato_esterno        [string trim [lindex $line_split 22]]
		set da_disimp_senza_lato_esterno  [string trim [lindex $line_split 23]]
		set aeraz_disimp_05_mq            [string trim [lindex $line_split 24]]
		set aeraz_disimp_condotta         [string trim [lindex $line_split 25]]
		set porta_disimp                  [string trim [lindex $line_split 26]]
		set comunic_con_altri_loc         [string trim [lindex $line_split 27]]
		set porta_deposito                [string trim [lindex $line_split 28]]
		set porta_deposito_h_2_l_08       [string trim [lindex $line_split 29]]
		set tubo_sfiato                   [string trim [lindex $line_split 30]]
		set selle_50_cm_terra             [string trim [lindex $line_split 31]]
		set pavimento_impermeabile        [string trim [lindex $line_split 32]]
		set tra_serb_e_pareti             [string trim [lindex $line_split 33]]
		set valvola_a_strappo             [string trim [lindex $line_split 34]]
		set interruttore_forza_luce       [string trim [lindex $line_split 35]]
		set estintore                     [string trim [lindex $line_split 36]]
		set parete_conf_esterno           [string trim [lindex $line_split 37]]
		set ventilazione_locale           [string trim [lindex $line_split 38]]
		set segn_valvola_strappo          [string trim [lindex $line_split 39]]
		set segn_inter_forza_luce         [string trim [lindex $line_split 40]]
		set segn_estintore                [string trim [lindex $line_split 41]]
	

                set ok 0
                for {set x 0} {$x<$numero_impianti_vidimati} {incr x} {
                    set impianto_controllato [lindex $rapporti_verifica_impianti_corretti $x]
                    if {[string equal $impianto_controllato $imp_n_dichiarazione]} {
			puts $file_sg "$imp_n_dichiarazione;$loc_escl_deposito_gasolio;$dep_gasolio_esterno;$accesso_ester_con_porta;$loc_materiale_incombustibile;$non_meno_50_cm;$soglia_pavimento;$tra_pareti_60_cm;$comun_con_altri_loc;$dep_serb_in_vista_aperto;$tettoia_all_aperto;$bacino_contenimento;$messa_a_terra;$dep_gasolio_interno_interrato;$porta_solaio_pareti_rei90;$struttura_locale_a_norma;$dep_gasolio_interno;$locale_caratteristiche_rei120;$accesso_esterno;$porta_esterna_incombustibile;$disimpegno;$accesso_interno;$da_disimp_lato_esterno;$da_disimp_senza_lato_esterno;$aeraz_disimp_05_mq;$aeraz_disimp_condotta;$porta_disimp;$comunic_con_altri_loc;$porta_deposito;$porta_deposito_h_2_l_08;$tubo_sfiato;$selle_50_cm_terra;$pavimento_impermeabile;$tra_serb_e_pareti;$valvola_a_strappo;$interruttore_forza_luce;$estintore;$parete_conf_esterno;$ventilazione_locale;$segn_valvola_strappo;$segn_inter_forza_luce;$segn_estintore"
			incr conta_scheserb
                        set ok 1
                    }
                }
                if {[string equal $ok 0]} {
                    puts $filout5 "$line; non sono presenti impianti di riferimento."
                    incr conta_scheserb_err
                    continue
                }
	    }
	    close $file_inp
	    close $filout5
	    close $file_sg

	    set link_gest [export_url_vars nome_funz nome_funz_caller caller]
	    switch $funzione {
		I {set return_url   "coimcimp-cari-gest?funzione=V&$link_gest&conta_c_inf=$conta_c_inf&conta_c_inf_err=$conta_c_inf_err&conta_sup=$conta_sup&conta_sup_err=$conta_sup_err&conta_schegas=$conta_schegas&conta_schegas_err=$conta_schegas_err&conta_schemet=$conta_schemet&conta_schemet_err=$conta_schemet_err&conta_scheserb=$conta_scheserb&conta_scheserb_err=$conta_scheserb_err&righe_con_errori=$righe_con_errori&righe_con_errori2=$righe_con_errori2"}
		V {set return_url   ""}
	    }
	    ad_returnredirect $return_url
	    ad_script_abort
	}
    }
}
ad_return_template



# #indicazione del file da caricare
# Il file non ha estensione csv o txt
# File con estensione errata
# File non trovato o mancante

# #verifica dell'impianto
# impianto mancante o impianto non codificato correttamente
# manca data di controllo
# verificatore non trovato
# verificare se esiste l'appuntamento relativo a questo controllo
# co2 errato
# co2 troppo lungo
# rendimento rilevato errato
# rendimento DPR12 errato
# anno ultima manutenzione errata
# fumi secchi errato o mancante
# sono definiti troppi tipi di combustibile
# non sono definiti tipi di combustibile
# caldaia a gasolio ma indice bacharach non valorizzato
# caldaia non a gasolio ma indice bacharach non valorizzato
# bacharach errato
# potenza nominale errata

# #>35kw
# potenza mancante
# temperatura fumi errata
# temperatura ambiente errata
# impianto mancante o impianto non codificato correttamente
# manca data di controllo
# verificatore non trovato
# verificare se esiste l'appuntamento relativo a questo controllo
# co2 errato
# sono definiti troppi tipi di combustibile
# non sono definiti tipi di combustibile
# bacharach errato
# co fumi secchi errato
# co errato
# o2 errato
# rendimento combustibile convenzionale errato
# sono definiti troppi tipi di comburtibile 
# non sono definiti tipi di combustibile
# caldaia a gasolio ma indice bacharach non valorizzato
# caldaia non a gasolio ma indice bacharach non valorizzato
# potenza nominale errata

# #scheda controllo gasolio
# potenza inferiore a 35 kw
# scheda gasolio già presente
# non sono presenti rapporti di verifica

# #scheda controllo metano
# potenza inferiore a 35 kw
# scheda gasolio già presente
# non sono presenti rapporti di verifica

# #scheda serbatoio gasolio
# potenza inferiore a 35 kw
# scheda gasolio già presente
# non sono presenti rapporti di verifica
