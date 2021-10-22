ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimopdi"
    @author          Giulio Laurenzi
    @creation-date   26/09/2005

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimopdi-gest.tcl
} {   
   {cod_opve         ""}
   {prog_disp        ""}
   {last_prog_disp   ""}
   {caller      "index"}
   {nome_funz        ""}
   {nome_funz_caller ""}
   {extra_par        ""}
   {mese             ""}
   {anno             ""}
   {url_enve         ""}
   {cod_enve         ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
  # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

db_1row sel_tgen "select flag_asse_data,
                              numincora 
                    from coimtgen"

if {$flag_asse_data == "N"} {
 iter_return_complaint "Funzione non abilitata, contattare il responsabile del sistema. Funziona attiva solo per coloro che utilizzano l'agenda"
}


set page_title "Agenda disponibilit&agrave; ispettore"

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {$nome_funz_caller == [iter_get_nomefunz coimdisp-filter]} {
    set caller "disp-list"
    set link_return "coimdisp-filter?[export_url_vars cod_opve caller nome_funz nome_funz_caller mese anno cod_enve]"
} else {
    set link_return "coimopve-gest?[export_url_vars cod_opve cod_enve prog_disp last_prog_disp caller nome_funz_caller url_enve]&nome_funz=[iter_get_nomefunz coimopve-gest]"
}

#iter_set_func_class $funzione

set context_bar  [iter_context_bar -nome_funz $nome_funz]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimdisp"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
set button_label "Conferma"

# acquisisco la data odierna e estraggo il mese successivo

if {[string equal $mese ""]
&&  [string equal $anno ""]
} {
    set data_odierna [iter_set_sysdate]
    set mese [clock format [clock scan "$data_odierna 1 month"]  -f %m ]
    set anno [string range $data_odierna 0 3]
}

if {[db_0or1row sel_cinc_cod ""] == 0} {
    set cod_cinc ""
}

if {[db_0or1row sel_opve_nome ""] == 0} {
    set nome_opve ""
}

switch $mese {
    "01" {set giorni 31
          set mese_nome "Gennaio"
    }
    "02" {set giorni 29
	  set data_check "$giorni/$mese/$anno"
	  if {[iter_check_date $data_check] == 0} {
	      set giorni 28
	  }
	  set mese_nome "Febbraio"
    }
    "03" {set giorni 31
	  set mese_nome "Marzo"
    }
    "04" {set giorni 30
	  set mese_nome "Aprile"
    }
    "05" {set giorni 31
	  set mese_nome "Maggio"
    }
    "06" {set giorni 30
	  set mese_nome "Giugno"
    }
    "07" {set giorni 31
	  set mese_nome "Luglio"
    }
    "08" {set giorni 31
	  set mese_nome "Agosto"
    }
    "09" {set giorni 30
	  set mese_nome "Settembre"
    }
    "10" {set giorni 31
	  set mese_nome "Ottobre"
    }
    "11" {set giorni 30
	  set mese_nome "Novembre"
    }
    "12" {set giorni 31
	  set mese_nome "Dicembre"
    }  
}

set testata ""
set num_fasce 0
db_foreach sel_opdi "" {
    incr num_fasce
    append testata "<th>da $ora_da<br>a $ora_a</th>"
}

set colspan [expr $num_fasce + 1]

multirow create multiple_col fascia

set conta_fasce 1
while {$conta_fasce <= $num_fasce} {
    multirow append multiple_col $conta_fasce
    incr conta_fasce
}

form create $form_name \
-html    $onsubmit_cmd

multirow create multiple_righe gg

set conta_gg 1
while {$conta_gg <= $giorni} {
    
    set data_while "$anno$mese"
    if {$conta_gg < 10} {
	append data_while "0$conta_gg"
    } else {
	append data_while $conta_gg
    }
    set abb_weekday_name [clock format [clock scan "$data_while"]  -f %a ]
    if {$abb_weekday_name == "Sat"
    ||  $abb_weekday_name == "Sun"
    } {
	set color($conta_gg) "#D80000"
    } else {
	set color($conta_gg) "#f8f8f8"
    }

    set conta_fasce 1

    multirow append multiple_righe $conta_gg

    while {$conta_fasce <= $num_fasce} {

	set indice "$conta_gg.$conta_fasce"

	if {$conta_gg < 10} {
	    set giorno "0$conta_gg"
	} else {
	    set giorno $conta_gg
	}

        set data_inco "$anno$mese$giorno"

	if {[db_0or1row sel_opdi_ore ""] == 0} {
	    set fascia_da ""
	    set fascia_a  ""
	}
	if {[db_0or1row sel_inco_check ""] == 1} {
	    set checked "checked"
	    if {![string equal $impianto_check ""]} {
		set disabled "disabled"
	    } else {
		set disabled "{}"
	    }
	} else {
	    set checked "{}"
	    set disabled "{}"
	}
#metto il .0 perche se no viene considerato come decimale e elimina gli zeri inutili (es. 1.10 viene letto come 1.1)
	element create $form_name $conta_gg.$conta_fasce.0 \
        -label   "fascia da rendere disponibile" \
	-widget   checkbox \
	-datatype text \
        -html    "class form_element value $indice $checked {} $disabled {}" \
	-optional \
	-options [list [list Si $indice]]
	incr conta_fasce	
    }

    incr conta_gg
}
   

#element create $form_name funzione   -widget hidden -datatype text -optional
element create $form_name caller     -widget hidden -datatype text -optional
element create $form_name nome_funz  -widget hidden -datatype text -optional
element create $form_name submit     -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name cod_opve   -widget hidden -datatype text -optional
element create $form_name prog_disp  -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name url_enve   -widget hidden -datatype text -optional
element create $form_name cod_enve   -widget hidden -datatype text -optional
element create $form_name mese       -widget hidden -datatype text -optional
element create $form_name anno       -widget hidden -datatype text -optional

element create $form_name submit1    -widget submit -datatype text -label "<--" -html "class form_submit"
element create $form_name submit2    -widget submit -datatype text -label "-->" -html "class form_submit"
element create $form_name submit3    -widget submit -datatype text -label "<--" -html "class form_submit"
element create $form_name submit4    -widget submit -datatype text -label "-->" -html "class form_submit"


if {$nome_funz_caller == [iter_get_nomefunz coimenve-list]} {
    set disable_opve "disabled"
} else {
    set disable_opve "{}"
}

element create $form_name submit5    -widget submit -datatype text -label "<--" -html "class form_submit $disable_opve {}"
element create $form_name submit6    -widget submit -datatype text -label "-->" -html "class form_submit $disable_opve {}"


if {[form is_request $form_name]} {

#    element set_properties $form_name funzione       -value $funzione
    element set_properties $form_name caller         -value $caller
    element set_properties $form_name nome_funz      -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name mese           -value $mese
    element set_properties $form_name anno           -value $anno
    element set_properties $form_name url_enve       -value $url_enve
    element set_properties $form_name cod_enve       -value $cod_enve
    element set_properties $form_name cod_opve       -value $cod_opve 
    
}

if {[form is_valid $form_name]} {
    set submit1     [element::get_value $form_name submit1]
    set submit2     [element::get_value $form_name submit2]
    set submit3     [element::get_value $form_name submit3]
    set submit4     [element::get_value $form_name submit4]
    set submit5     [element::get_value $form_name submit5]
    set submit6     [element::get_value $form_name submit6]

    # submit1 e submit2 vengono utilizzati per "navigare" sul mese
    if {![string is space $submit1]} {
	set dat "$anno$mese"
	append dat "01"
	set mese [clock format [clock scan "$dat - 1 month"]  -f %m ]	
	set return_url "coimdisp-list?[export_url_vars cod_opve prog_disp last_prog_disp  caller nome_funz nome_funz_caller extra_par anno url_enve cod_enve mese]"
	ad_returnredirect $return_url
	ad_script_abort
    }

    if {![string is space $submit2]} {
	set dat "$anno$mese"
	append dat "01"
	set mese [clock format [clock scan "$dat + 1 month"]  -f %m ]	
	set return_url "coimdisp-list?[export_url_vars cod_opve prog_disp last_prog_disp  caller nome_funz nome_funz_caller extra_par anno url_enve cod_enve mese]"
	ad_returnredirect $return_url
	ad_script_abort
    }
    # submit3 e submit4 vengono utilizzati per "navigare" sul'anno
    if {![string is space $submit3]} {
	set dat "$anno$mese"
	append dat "01"
	set anno [clock format [clock scan "$dat - 1 year"]  -f %Y ]	
	set return_url "coimdisp-list?[export_url_vars cod_opve prog_disp last_prog_disp  caller nome_funz nome_funz_caller extra_par anno url_enve cod_enve mese]"
	ad_returnredirect $return_url
	ad_script_abort
    }

    if {![string is space $submit4]} {
	set dat "$anno$mese"
	append dat "01"
	set anno [clock format [clock scan "$dat + 1 year"]  -f %Y ]	
	set return_url "coimdisp-list?[export_url_vars cod_opve prog_disp last_prog_disp  caller nome_funz nome_funz_caller extra_par anno url_enve cod_enve mese]"
	ad_returnredirect $return_url
	ad_script_abort
    }
    # submit5 e submit6 vengono utilizzati per "navigare" sul verificatore
    if {![string is space $submit5]} {

	if {[db_0or1row sel_opve_prew ""] == 0} {
	    db_1row sel_opve_max ""
	}
	set return_url "coimdisp-list?[export_url_vars cod_opve prog_disp last_prog_disp  caller nome_funz nome_funz_caller extra_par anno url_enve cod_enve mese]"
	ad_returnredirect $return_url
	ad_script_abort
    }

    if {![string is space $submit6]} {

	if {[db_0or1row sel_opve_next ""] == 0} {
	    set cod_opve $cod_enve
	    append cod_opve "000"
	}
	set return_url "coimdisp-list?[export_url_vars cod_opve prog_disp last_prog_disp  caller nome_funz nome_funz_caller extra_par anno url_enve cod_enve mese]"
	ad_returnredirect $return_url
	ad_script_abort
    }

  # form valido dal punto di vista del templating system
    set lista_dispo [list]
    set conta_gg 1
    while {$conta_gg <= $giorni} {
	
	set conta_fasce 1
	multirow append multiple_righe $conta_gg 
	while {$conta_fasce <= $num_fasce} {
	    set dispo [element::get_value $form_name $conta_gg.$conta_fasce.0]
	    if {![string equal $dispo ""]} {
		if {[db_0or1row sel_fascia_ora_iniz ""] == 0} {
		    set ora_iniz ""
		}
		if {$conta_gg < 10} {
		    set giorno "0$conta_gg"
		} else {
		    set giorno $conta_gg
		}
		set data "$anno$mese$giorno"
		lappend lista_dispo [list $data $ora_iniz]
	    }
	    incr conta_fasce	
	}
	incr conta_gg
    }
#    ns_return 200 text/html $lista_dispo; return
    with_catch error_msg {
	
   	db_transaction {
	    set mese_inizio "$anno$mese"
            set mese_fine "$mese_inizio$giorni"
            append mese_inizio "01"

	    set dml_del_inco [db_map del_inco_no_aimp]
	    db_dml del_inco $dml_del_inco

	    foreach elemento $lista_dispo {
		set data [lindex $elemento 0]
		set ora  [lindex $elemento 1]
		set dml_ins_inco [db_map dml_ins_inco]

		set numinc 1
		while {$numinc <= $numincora} {  		
		    db_0or1row sel_inco_dual ""
		    db_dml dml_inco $dml_ins_inco
		    incr numinc
		}

		set data ""
		set ora ""
	    }
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }

    set return_url  "coimdisp-list?[export_url_vars cod_opve prog_disp last_prog_disp  caller nome_funz nome_funz_caller extra_par anno url_enve cod_enve mese]"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
