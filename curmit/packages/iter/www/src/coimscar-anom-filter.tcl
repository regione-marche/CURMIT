ad_page_contract {
    @autore dob gennaio 2013
} {
    {funzione        "I"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
}

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_batc nome_funz nome_funz_caller caller]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# imposto variabili usate nel programma:
set sysdate_edit [iter_edit_date [iter_set_sysdate]]

# imposto la directory degli permanenti ed il loro nome.
set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]

# Personalizzo la pagina
set button_label "Scarica"
set page_title   "Selezione per scarico anomalie da dichiarazione"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

set link_scar [export_url_vars nome_funz nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "scaranom"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set cerca_manu    [iter_search $form_name coimmanu-list [list dummy f_cod_manu dummy f_manu_cogn dummy f_manu_nome]]


form create $form_name \
-html    $onsubmit_cmd


element create $form_name f_manu_cogn \
-label   "Cognome" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 class form_element" \
-optional

element create $form_name f_manu_nome \
-label   "Nome" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 class form_element"\
-optional



element create $form_name f_data_inizio \
-label   "Data inizio " \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 class form_element" \
-optional

element create $form_name f_data_fine \
-label   "Data fine " \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 class form_element" \
-optional

element create $form_name f_clas_funz \
-label   "Classe anomalia " \
-widget   select \
-datatype text \
-options { {} {"Classe min 100" 10 } {"Classe min 200" 20 } {"Classe min 300" 30 } {"Classe min 400" 40 } {"Classe min 500" 50 }  } \
-optional

element create $form_name f_tipo_a_c \
    -label   "Tipo " \
    -widget   select \
    -datatype text \
    -options { {} {"Aperto" A } {"Chiuso" C } } \
    -optional

element create $form_name f_tiraggio \
    -label   "Tiraggio" \
    -widget   select \
    -datatype text \
    -options { {} {"Forzato" F} {"Naturale" N } } \
    -optional




element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name f_cod_manu        -widget hidden -datatype text -optional
element create $form_name dummy             -widget hidden -datatype text -optional


if {[form is_request $form_name]} {
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set f_data_inizio     [element::get_value $form_name f_data_inizio]
    set f_data_fine       [element::get_value $form_name f_data_fine]
    set f_cod_manu        [element::get_value $form_name f_cod_manu]
    set f_manu_cogn       [element::get_value $form_name f_manu_cogn]
    set f_manu_nome       [element::get_value $form_name f_manu_nome]
    set f_clas_funz       [element::get_value $form_name f_clas_funz]
    set f_tiraggio        [element::get_value $form_name f_tiraggio]
    set f_tipo_a_c        [element::get_value $form_name f_tipo_a_c]
			   
    set error_num 0

    set flag_data_inizio "f"
    set f_data_inizio [iter_check_date $f_data_inizio]
    if {$f_data_inizio == 0} {
	element::set_error $form_name f_data_inizio "Data mancante o errata"
	incr error_num
    } else {
	set flag_data_inizio "t"
    }
    
    set flag_data_fine "f"
    set f_data_fine [iter_check_date $f_data_fine]
    if {$f_data_fine == 0} {
	element::set_error $form_name f_data_fine "Data mancante o errata"
	incr error_num
    } else {
	set flag_data_fine "t"
    }
    
    if {$flag_data_inizio  == "t"
    &&  $flag_data_fine    == "t"
    &&  $f_data_inizio > $f_data_fine
    } {
	element::set_error $form_name f_data_fine "La data finale<br> dell'intervallo deve essere<br> minore di quella iniziale"
	incr error_num
    }

    if {$error_num > 0} {
       ad_return_template
       return
    }

    set link_scar [export_url_vars f_data_inizio f_data_fine  f_cod_manu f_clas_funz f_tiraggio f_tipo_a_c caller funzione nome_funz nome_funz_caller]

    set return_url "coimscar-anom-gest?$link_scar"
    ad_returnredirect $return_url
    ad_script_abort

}


ad_return_template




