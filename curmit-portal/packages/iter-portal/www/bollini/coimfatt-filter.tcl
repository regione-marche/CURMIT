ad_page_contract {
    @author          Valentina Catte
    @creation-date   26/04/2005

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimaces-filter.tcl

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    nic01  09/01/2014 Sistemato per segnalazione di Chiara Paravan di Ucit: nella context_bar
                      compariva Gestione Amministrativa che andava in errore.
                      Lo rendo coerente con la lista fatture e manutentori.
} {
    {caller        "index"}
    {nome_funz          ""}
    {nome_funz_caller   ""}
    {f_cod_manu         ""}
    {f_num_fatt         ""}
    {f_da_data_fatt     ""}
    {f_a_data_fatt      ""}
    {f_flag_pag         ""}
    {is_admin_p         ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
set id_utente [auth::require_login]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set titolo       "Filtro Fatture"
set button_label "Seleziona" 
set page_title   "Filtro Fatture"

#set context [list [list services "Servizi per i manutentori"] [list ordboll-list {Lista Ordini Bollini}] $page_title]
#nic01 set context [iter_context_bar -nome_funz $nome_funz_caller]
set context [list [list ../admin "Amministrazione Portale"] $page_title];#nic01


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

set l_of_l_manu [db_list_of_lists query "select name, iter_code from iter_maintainers order by name"]
set l_of_l_manu [linsert $l_of_l_manu 0 [list "" ""]]

element create $form_name f_cod_manu \
    -label   "Manutentore" \
    -widget   select \
    -datatype text \
    -options $l_of_l_manu\
    -optional

element create $form_name f_num_fatt \
    -label   "f_num_data" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name f_da_data_fatt \
    -label   "f_da_data" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name f_a_data_fatt \
    -label   "f_a_data" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional


element create $form_name f_flag_pag \
    -label   "f_flag_pag" \
    -widget   select \
    -datatype text \
    -html    "size 1 maxlength 1 $readonly_fld {} class form_element" \
    -optional \
    -options {{{} {}} {Si S} {No N}}

element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name dummy            -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {

    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set f_cod_manu      [element::get_value $form_name f_cod_manu]
    set f_num_fatt         [element::get_value $form_name f_num_fatt]
    set f_da_data_fatt     [element::get_value $form_name f_da_data_fatt]
    set f_a_data_fatt      [element::get_value $form_name f_a_data_fatt]
    set f_flag_pag         [element::get_value $form_name f_flag_pag]
    set error_num 0 

    if {![string equal $f_da_data_fatt ""]} {
	set f_da_data_fatt [iter_check_date $f_da_data_fatt]
	if {$f_da_data_fatt == 0} {
	    element::set_error $form_name f_da_data_fatt "Data non corretta"
	    incr error_num
	}
    }    

    if {![string equal $f_a_data_fatt ""]} {
	set f_a_data_fatt [iter_check_date $f_a_data_fatt]
	if {$f_a_data_fatt == 0} {
	    element::set_error $form_name f_a_data_fatt "Data non corretta"
	    incr error_num
	}
    }    

    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    set link_gest [export_url_vars f_num_fatt f_da_data_fatt f_cod_manu f_a_data_fatt f_flag_pag nome_funz nome_funz_caller]
    set return_url "coimfatt-list?$link_gest"    
    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
