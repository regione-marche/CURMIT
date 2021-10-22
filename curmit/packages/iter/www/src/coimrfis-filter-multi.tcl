ad_page_contract {
    @author          Valentina Catte
    @creation-date   15/03/2012

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimaces-filter.tcl
} {
    
   {caller        "index"}
   {nome_funz          ""}
   {nome_funz_caller   ""}
   {f_da_num_rfis         ""}
   {f_a_num_rfis     ""}
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
set titolo       "Filtro Stampa ricevute"
set button_label "Seleziona" 
set page_title   "Filtro Stampa ricevute"


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimrfis"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

element create $form_name f_da_num_rfis \
-label   "f_da_num_rfis" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name f_a_num_rfis \
-label   "f_a_num_rfis" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
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
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
  
    set f_da_num_rfis      [element::get_value $form_name f_da_num_rfis]
    set f_a_num_rfis       [element::get_value $form_name f_a_num_rfis]
    set error_num 0

    if {![string equal $f_da_num_rfis ""]
	&& [string equal $f_a_num_rfis ""]} {
  	element::set_error $form_name f_a_num_rfis "Indicare anche numero rfisura finale"
	incr error_num
    }

    if {![string equal $f_a_num_rfis ""]
        && [string equal $f_da_num_rfis ""]} {
	element::set_error $form_name f_da_num_rfis "Indicare anche numero rfisura iniziale"
        incr error_num
    }

    if {$f_a_num_rfis < $f_da_num_rfis} {
	element::set_error $form_name f_da_num_rfis "Numero rfisura finale minore di numero rfisura iniziale"
        incr error_num
    }
    set numero 0

	db_1row sel_num_rfis "select count(*) as numero from coimrfis where  (to_number(num_rfis, '9999999999')) >= :f_da_num_rfis and  (to_number(num_rfis, '9999999999')) <= :f_a_num_rfis" 

    ns_log notice "prova mar $numero"
     
    if {$numero == 0} {
	element::set_error $form_name f_da_num_rfis "Non esistono i numeri di rfisura"
	incr error_num
    }
	
    if {$error_num > 0} {
	ad_return_template
	return
    }

    set link_gest [export_url_vars f_da_num_rfis f_a_num_rfis nome_funz nome_funz_caller]


   
    set return_url "coimrfis-layout-multi?$link_gest"    

    ad_returnredirect $return_url
    ad_script_abort
   
}

ad_return_template
