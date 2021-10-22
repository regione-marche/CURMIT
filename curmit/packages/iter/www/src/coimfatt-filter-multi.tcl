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
   {f_da_num_fatt         ""}
   {f_a_num_fatt     ""}
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
set titolo       "Filtro Stampa Multipla Fatture"
set button_label "Seleziona" 
set page_title   "Filtro Stampa Multipla Fatture"


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimfatt"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

element create $form_name f_da_num_fatt \
-label   "f_da_num_fatt" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name f_a_num_fatt \
-label   "f_a_num_fatt" \
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
  
    set f_da_num_fatt      [element::get_value $form_name f_da_num_fatt]
    set f_a_num_fatt       [element::get_value $form_name f_a_num_fatt]
    set error_num 0

    if {![string equal $f_da_num_fatt ""]
	&& [string equal $f_a_num_fatt ""]} {
  	element::set_error $form_name f_a_num_fatt "Indicare anche numero fattura finale"
	incr error_num
    }

    if {![string equal $f_a_num_fatt ""]
        && [string equal $f_da_num_fatt ""]} {
	element::set_error $form_name f_da_num_fatt "Indicare anche numero fattura iniziale"
        incr error_num
    }

    if {$f_a_num_fatt < $f_da_num_fatt} {
	element::set_error $form_name f_da_num_fatt "Numero fattura finale minore di numero fattura iniziale"
        incr error_num
    }
    set numero 0

	db_1row sel_num_fatt "select count(*) as numero from coimfatt where  (to_number(num_fatt, '9999999999')) >= :f_da_num_fatt and  (to_number(num_fatt, '9999999999')) <= :f_a_num_fatt" 

    ns_log notice "prova mar $numero"
     
    if {$numero == 0} {
	element::set_error $form_name f_da_num_fatt "Non esistono i numeri di fattura"
	incr error_num
    }
	
    if {$error_num > 0} {
	ad_return_template
	return
    }

    set link_gest [export_url_vars f_da_num_fatt f_a_num_fatt nome_funz nome_funz_caller]


    #set return_url "coimfatt-list?$link_gest"    
    set return_url "coimfatt-layout-multi?$link_gest"    

    ad_returnredirect $return_url
    ad_script_abort
   
}

ad_return_template
