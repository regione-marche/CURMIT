ad_page_contract {

    @author          Serena Saccani
    @creation-date   27.01.2013

    @cvs-id          ucit-allgsc-gest.tcl
} {
    {id                   ""}
    {funzione            "V"}
    {caller          "index"}
    {nome_funz            ""}
    {nome_funz_caller     ""}
    {extra_par            ""}
    {id                   ""}
    {last_id_impianto     ""}
    {id_cod_impianto      ""}
    {f_cognome            ""}
    {f_nome               ""}
    {f_data_inizio        ""}
    {f_data_fine          ""}
    {url_aimp             ""} 
    {url_aimp             ""}
    {url_list_aimp        ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "M" {set lvl 3}
}

# ( Controlla lo user )
if {![string is space $nome_funz]} {
    set lvl       1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
    # ( Se la lista viene chiamata da un cerca, allora nome_funz non viene passato e bisogna reperire id_utente dai cookie )
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {[string equal $url_aimp ""]} {
    set url_aimp [list [ad_conn url]?[export_ns_set_vars url "url_list_aimp url_aimp"]]
}
if {$nome_funz_caller == [iter_get_nomefunz coimmai2-filter] && $url_list_aimp == ""} {
    set url_list_aimp  [list coimmai2-filter?[export_ns_set_vars url "url_list_aimp url_aimp nome_funz"]&nome_funz=[iter_get_nomefunz coimmai2-filter]]
}


db_1row sel_cod_comb "select cod_combustibile as cod_tele from coimcomb where descr_comb = 'TELERISCALDAMENTO'"
db_1row sel_cod_comb "select cod_combustibile as cod_pomp from coimcomb where descr_comb = 'POMPA DI CALORE'"

set link_list [export_url_vars caller nome_funz receiving_element f_cognome f_nome f_data_inizio f_data_fine]
set return_url "coim-r-dimp-admin-list?$link_list"

set link_gest "\[export_url_vars id id_cod_impianto respnom respind respcom respcap respcivico data_controllo data_protocollo url_list_aimp url_aimp last_id_impianto nome_funz_caller extra_par \]"

set current_date [iter_set_sysdate]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set link_dimp ""
set link_cimp ""
set link_resp ""
set link_ubic ""
set link_util ""
set link_ricodifica ""

set classe "func-menu"
set titolo "Allegato"
switch $funzione {
    M {set button_label "Conferma Modifica" 
	set page_title   "Modifica $titolo"}
    V {set button_label "Torna alla lista"
	set page_title   "Visualizzazione $titolo"}
}

set context_bar  [iter_context_bar \
		      [list /iter/main "Home"] \
		      [list $return_url "Lista allegati"] \
		      "$page_title"]

iter_get_coimtgen
set valid_mod_h        $coimtgen(valid_mod_h)
set flag_cod_aimp_auto $coimtgen(flag_cod_aimp_auto)
set flag_codifica_reg  $coimtgen(flag_codifica_reg)

set cod_imst_annu_manu $coimtgen(cod_imst_annu_manu)
set max_gg_modimp      $coimtgen(max_gg_modimp)

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimaimp"
set readonly_key "readonly"
set readonly_fld "readonly"
set readonly_cod "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
    "M" {set readonly_fld \{\}
        set disabled_fld \{\}
    }
}

form create $form_name \
    -html    $onsubmit_cmd

# Valorizzo il titolo in una variabile.
# In visualizzazion verra' valorizzata con un link.
set imp_provenienza "Imp. provenienza"
element create $form_name data_controllo_pretty \
    -label   "Data Controllo" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_cod {} class form_element" \
    -optional

element create $form_name data_protocollo_pretty \
    -label   "Data Protocollo" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_cod {} class form_element" \
    -optional

element create $form_name respnom \
    -label   "RESPONSABILE Imp." \
    -widget   text \
    -datatype text \
    -html    "size 80 maxlength 80 $readonly_fld {} class form_element" \
    -optional

element create $form_name tecnid \
    -label   "MANUTENTORE" \
    -widget   text \
    -datatype text \
    -html    "size 80 maxlength 80 $readonly_fld {} class form_element" \
    -optional

element create $form_name respindirizzo \
    -label   "RESPONSABILE Indirizzo" \
    -widget   text \
    -datatype text \
    -html    "size 80 maxlength 80 $readonly_fld {} class form_element" \
    -optional

element create $form_name caldcostr \
    -label   "Costruttore" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
    -optional

element create $form_name caldmodel \
    -label   "Modello" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
    -optional

element create $form_name caldpotkw \
    -label   "Potenza" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
    -optional

element create $form_name caldmatr \
    -label   "Matricola" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
    -optional

element create $form_name id               -widget hidden -datatype text -optional
element create $form_name last_id_impianto -widget hidden -datatype text -optional
element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par        -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name url_aimp         -widget hidden -datatype text -optional
element create $form_name url_list_aimp    -widget hidden -datatype text -optional
element create $form_name conferma_inco    -widget hidden -datatype text -optional -html "id conferma_inco"

set color "gainsboro"

if {[form is_request $form_name]} {
    element set_properties $form_name id                -value $id
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name nome_funz_caller  -value $nome_funz_caller
    element set_properties $form_name extra_par         -value $extra_par
    element set_properties $form_name last_id_impianto  -value $last_id_impianto
    element set_properties $form_name url_aimp          -value $url_aimp
    element set_properties $form_name url_list_aimp     -value $url_list_aimp

    # leggo riga
    if {[db_0or1row sel_ucit_allgsc {}] == 0} {
	iter_return_complaint "Record non trovato"
    }
    
    set id_ruolo [db_string sel_ruolo "select id_ruolo from coimuten where id_utente = :id_utente"]

    element set_properties $form_name id                     -value $id
    element set_properties $form_name tecnid                 -value $tecnid
    element set_properties $form_name data_controllo_pretty  -value $data_controllo_pretty
    element set_properties $form_name data_protocollo_pretty -value $data_protocollo_pretty
    element set_properties $form_name respnom                -value $respnom
    element set_properties $form_name respindirizzo          -value $respindirizzo
    element set_properties $form_name caldcostr              -value $caldcostr
    element set_properties $form_name caldmodel              -value $caldmodel
    element set_properties $form_name caldpotkw              -value $caldpotkw
    element set_properties $form_name caldmatr               -value $caldmatr
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set id                        [string trim [element::get_value $form_name id]]
    set tecnid                    [string trim [element::get_value $form_name tecnid]]
    set data_controllo_pretty     [string trim [element::get_value $form_name data_controllo_pretty]]
    set data_protocollo_pretty    [string trim [element::get_value $form_name data_protocollo_pretty]]
    set respnom                   [string trim [element::get_value $form_name respnom]]
    set respindirizzo             [string trim [element::get_value $form_name respindirizzo]]
    set caldcostr                 [string trim [element::get_value $form_name caldcostr]]
    set caldmodel                 [string trim [element::get_value $form_name caldmodel]]
    set caldpotkw                 [string trim [element::get_value $form_name caldpotkw]]
    set caldmatr                  [string trim [element::get_value $form_name caldmatr]]

    set error_num 0
    if {$funzione == "M"} {

        if {[string equal $data_controllo_pretty ""]} {
	    element::set_error $form_name data_controllo_pretty "Inserire Data inst."
	    incr error_num
	} else {
            set data_controllo [iter_check_date $data_controllo_pretty]
            if {$data_controllo == 0} {
                element::set_error $form_name data_controllo_pretty "Data controlloione deve essere una data"
                incr error_num
            } else {
		if {$data_controllo > $current_date} {
		    element::set_error $form_name data_controllo_pretty "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

        if {[string equal $data_protocollo_pretty ""]} {
	    element::set_error $form_name data_protocollo_pretty "Inserire Data inst."
	    incr error_num
	} else {
            set data_protocollo [iter_check_date $data_protocollo_pretty]
            if {$data_protocollo == 0} {
                element::set_error $form_name data_protocollo_pretty "Data protocollo deve essere una data"
                incr error_num
            } else {
		if {$data_protocollo > $current_date} {
		    element::set_error $form_name data_protocollo_pretty "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

        set flag_potenza_ok "f"
        if {[string equal $potenza_utile ""]} {
	    set potenza_utile 0
	} else {
            set potenza_utile [iter_check_num $potenza_utile 2]
            if {$potenza_utile == "Error"} {
                element::set_error $form_name potenza_utile "numerico con al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $potenza_utile] >=  [expr pow(10,7)]
		    ||  [iter_set_double $potenza_utile] <= -[expr pow(10,7)]} {
                    element::set_error $form_name potenza_utile "deve essere < di 10.000.000"
                    incr error_num
                } else {
		    set flag_potenza_ok "t"
		}
                set potenza_tot $potenza_utile
		if {$flag_potenza_ok == "t" &&  [db_0or1row check_fascia_pote ""]== 0} {
		    element::set_error $form_name potenza_utile "non &egrave; compresa in nessuna fascia"
		    incr error_num
		}           
            }
        }

        if {[string equal $portata ""]} {
	    set portata 0
	} else {
            set portata [iter_check_num $portata 2]
            if {$portata == "Error"} {
                element::set_error $form_name portata "numerico con al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $portata] >=  [expr pow(10,7)]
		    ||  [iter_set_double $portata] <= -[expr pow(10,7)]} {
                    element::set_error $form_name portata "deve essere < di 10.000.000"
                    incr error_num
                }
            }
        }
    }

    # se sono in assegnazione dell'impianto (funzione per manutentori) 
    # aggiorno il manutentore e aggiorno lo storico dei soggetti
    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        M {
	    if {$flag_cod_aimp_auto == "F"} {
		set cod_aimp_est [db_map udp_aimp_est]
	    } else {
		set cod_aimp_est ""
	    }
	    set dml_sql  [db_map upd_aimp]
	}
    }

    
    # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
		
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

    set link_gest [export_url_vars id last_id_impianto nome_funz nome_funz_caller extra_par url_list_aimp url_aimp caller]
    
    if {$nome_funz_caller != [iter_get_nomefunz coimaimp-isrt-veloce]} {
	set link_del $url_list_aimp
    } else {
        set link_del "coimaimp-isrt-veloce?nome_funz=$nome_funz_caller"
    }
    set link_del "coimaimp-filter"

    switch $funzione {
        M {set return_url   "coimaimp-gest?funzione=V&$link_gest"}
        V {set return_url   $url_list_aimp}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
