ad_page_contract {
    @author          Katia Coazzoli Adhoc
    @creation-date   09/06/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimboll-filter.tcl

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    nic01  09/01/2014 Sistemato per segnalazione di Chiara Paravan di Ucit: nella context_bar
                      compariva Gestione Amministrativa che andava in errore.
                      Lo rendo coerente con la lista fatture e manutentori.
} {
    {is_admin_p         ""}
    {funzione          "V"}
    {caller        "index"}
    {nome_funz          ""}
    {nome_funz_caller   ""}
    {f_manutentore      ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
set user_id [auth::require_login]

# Personalizzo la pagina
set titolo       "Selezione bollini"
set button_label "Seleziona" 
set page_title   "Selezione bollini"

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

#nic01 set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
set context_bar [iter_context_bar \
		     [list / "Home"] \
		     [list /iter-portal "Portale dei Manutentori verso ITER"] \
		     "$page_title"];#nic01

#iter_get_coimtgen
#set flag_ente  $coimtgen(flag_ente)
#set sigla_prov $coimtgen(sigla_prov)

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimboll"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
    -html    $onsubmit_cmd

set l_of_l_manu  [db_list_of_lists query "select name, iter_code from iter_maintainers order by name"]
set l_of_l_manu [linsert $l_of_l_manu 0 [list "" ""]]

element create $form_name f_cod_manu \
    -label   "Cognome" \
    -widget   select \
    -datatype text \
    -options  $l_of_l_manu \
    -optional

element create $form_name f_data_ril_da \
    -label   "Da data rilascio" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name f_data_ril_a \
    -label   "A data rilascio" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name dummy            -widget hidden -datatype text -optional
element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name nome_funz_caller -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set f_cod_manu        [string trim [element::get_value $form_name f_cod_manu]]
    set f_data_ril_da     [element::get_value $form_name f_data_ril_da]
    set f_data_ril_a      [element::get_value $form_name f_data_ril_a]

    set error_num 0 

    set check_data_da "f"
    if {![string equal $f_data_ril_da ""]} {
        set f_data_ril_da [iter_check_date $f_data_ril_da]
        if {$f_data_ril_da == 0} {
            element::set_error $form_name f_data_ril_da "Data rilascio non corretta"
            incr error_num
        } else {
	    set check_data_da "t"
	}
    }

    set check_data_a "f"
    if {![string equal $f_data_ril_a ""]} {
        set f_data_ril_a [iter_check_date $f_data_ril_a]
        if {$f_data_ril_a == 0} {
            element::set_error $form_name f_data_ril_a "Data rilascio non corretta"
            incr error_num
        } else {
	    set check_data_a "t"
	}
    }
    
    if {![string equal $f_data_ril_da ""] && ![string equal $f_data_ril_a ""]
	&&  $check_data_da eq "t" && $check_data_a  eq "t" &&  $f_data_ril_da > $f_data_ril_a} {
	element::set_error $form_name f_data_ril_da "La data iniziale deve essere minore della data finale"
	incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    set link_list [export_url_vars f_cod_manu f_data_ril_da f_data_ril_a caller funzione nome_funz nome_funz_caller is_admin_p]
    set return_url "coimboll-list?$link_list"    
    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
