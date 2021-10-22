ad_page_contract {
    @author          Giulio Laurenzi
    @creation-date   26/04/2005

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimaces-filter.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom01 21/10/2020 Su segnalazione di Salerno modificato page_title per renderlo
    rom01            uguale al nome del menu', Sandro ha detto che va bene per tutti.

} {
    
   {caller        "index"}
   {nome_funz          ""}
   {nome_funz_caller   ""} 
   {da_data            ""}
   {a_data             ""}
   {cod_cind           ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# Personalizzo la pagina
#rom01set titolo       "Numero modelli H"
set titolo       "Statistiche dich. per campagna";#rom01
set button_label "Seleziona" 
#rom01set page_title   "Numero modelli H"
set page_title   "Statistiche dich. per campagna";#rom01

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimstco"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

element create $form_name da_data \
-label   "da_data" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name a_data \
-label   "a_data" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_cind \
-label   "Campagna esclusa" \
-widget   select \
-options  [iter_selbox_from_table coimcind cod_cind descrizione] \
-datatype text \
-html    "class form_element" \
-optional



element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name dummy       -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"


if {[form is_request $form_name]} {


    element set_properties $form_name caller         -value $caller
    element set_properties $form_name nome_funz      -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name cod_cind         -value $cod_cind
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set da_data            [element::get_value $form_name da_data]
    set a_data             [element::get_value $form_name a_data]
    set cod_cind           [element::get_value $form_name cod_cind]
    set error_num 0 

    if {![string equal $da_data ""]} {
	set da_data [iter_check_date $da_data]
	if {$da_data == 0} {
	    element::set_error $form_name da_data "Data non corretta"
	    incr error_num
	}
    }    

    if {![string equal $a_data ""]} {
	set a_data [iter_check_date $a_data]
	if {$a_data == 0} {
	    element::set_error $form_name a_data "Data non corretta"
	    incr error_num
	}
    }    

    if {[string equal $cod_cind ""]} {
	element::set_error $form_name cod_cind "Inserire campagna di riferimento"
	incr error_num
    }    

    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    set link_gest [export_url_vars da_data a_data cod_cind nome_funz nome_funz_caller]

    set return_url "coimstco1-gest?$link_gest"    
    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
