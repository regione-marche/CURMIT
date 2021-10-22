ad_page_contract {
    @author          Giulio Laurenzi Adhoc
    @creation-date   08/07/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimaces-filter.tcl
} {
    
   {funzione          "V"}
   {caller        "index"}
   {nome_funz          ""}
   {nome_funz_caller   ""} 
   {f_stato            ""} 
   {f_data_iniz        ""} 
   {f_data_fine        ""} 
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# B80: RECUPERO LO USER - INTRUSIONE
set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente_loggato_vero [ad_get_client_property iter logged_user_id]
set session_id [ad_conn session_id]
set adsession [ad_get_cookie "ad_session_id"]
set referrer [ns_set get [ad_conn headers] Referer]
set clientip [lindex [ns_set iget [ns_conn headers] x-forwarded-for] end]

# if {$referrer == ""} {
# 	set login [ad_conn package_url]
#	ns_log Notice "********AUTH-CHECK-GAGE-KO-REFERER;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#	iter_return_complaint "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#	return 0
#    } 
# if {$id_utente != $id_utente_loggato_vero} {
#	set login [ad_conn package_url]
#	ns_log Notice "********AUTH-CHECK-GAGE-KO-USER;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#	iter_return_complaint "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#	return 0
#    } else {
#	ns_log Notice "********AUTH-CHECK-GAGE-OK;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#    }
# ***

# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set titolo       "Selezione controlli agenda manutentore"
set button_label "Seleziona" 
set page_title   "Selezione controlli agenda manutentore"

iter_get_coimtgen
set flag_ente    $coimtgen(flag_ente)
set flag_viario  $coimtgen(flag_viario)
set cod_comune   $coimtgen(cod_comu)

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimaces"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

set options_stato ""
lappend options_stato [list "" ""]
lappend options_stato [list "Da eseguire" "1"]
lappend options_stato [list "Eseguito"    "2"]

element create $form_name f_stato \
-label   "stato" \
-widget   select \
-options $options_stato \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \

element create $form_name f_data_iniz \
-label   "Data inizio intervallo" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name f_data_fine \
-label   "Data fine intervallo" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {
    element set_properties $form_name funzione       -value $funzione
    element set_properties $form_name caller         -value $caller
    element set_properties $form_name nome_funz      -value $nome_funz

    # valorizzo i valori dell'ultimo filtro (quando si ritorna dalla lista).
    set f_data_iniz [iter_edit_date $f_data_iniz]
    set f_data_fine [iter_edit_date $f_data_fine]

    element set_properties $form_name f_stato        -value $f_stato
    element set_properties $form_name f_data_iniz    -value $f_data_iniz
    element set_properties $form_name f_data_fine    -value $f_data_fine
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set f_stato            [element::get_value $form_name f_stato]
    set f_data_iniz        [element::get_value $form_name f_data_iniz]
    set f_data_fine        [element::get_value $form_name f_data_fine]
    set error_num 0 

    if {(![string equal $f_data_iniz ""]
    ||   ![string equal $f_data_fine ""])
    &&   $f_stato == 0
    } {
	element::set_error $form_name f_stato "Per i controlli da completare non &egrave; possibile<br> selezionare un intervallo di tempo"
	incr error_num
    }
 
    set flag_dt_iniz_ok "f"
    if {![string equal $f_data_iniz ""]} {
	set f_data_iniz [iter_check_date $f_data_iniz]
	if {$f_data_iniz == 0} {
	    element::set_error $form_name f_data_iniz "Inserire correttamente la data"
	    incr error_num
	} else {
	    set flag_dt_iniz_ok "t"
	}
    }

    set flag_dt_fine_ok "f"
    if {![string equal $f_data_fine ""]} {
	set f_data_fine [iter_check_date $f_data_fine]
	if {$f_data_fine == 0} {
	    element::set_error $form_name f_data_fine "Inserire correttamente la data"
	    incr error_num
	} else {
	    set flag_dt_fine_ok "t"
	}
    }

    if {![string equal $f_data_iniz ""]
    &&	![string equal $f_data_fine ""]
    &&  $flag_dt_iniz_ok == "t"
    &&  $flag_dt_fine_ok == "t"
    &&  $f_data_fine < $f_data_iniz
    } {
	element::set_error $form_name f_data_fine "Data inferiore alla data iniziale dell'intervallo"
	incr error_num
    }
    
    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    set link_list [export_url_vars f_stato f_data_iniz f_data_fine caller nome_funz nome_funz_caller]

    set return_url "coimgage-list?$link_list"    
    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
