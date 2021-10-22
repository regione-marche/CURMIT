ad_page_contract {
    Pagina di accesso agli enti della Regione Lombardia.
    
    @author Nicola Mortoni, Gianni Prosperi
    @date   26/10/2006

    @cvs_id aggiornamento-db-filter.tcl
} {
    {nome_funz ""}
    {nome_funz_caller ""}
}
set logo_url [iter_set_logo_dir_url]
#set id_utente [ad_get_cookie   iter_login_[ns_conn location]]
set id_utente [iter_get_id_utente]

if {$id_utente ne "sandro"} {
    ns_return 200 text/html "Funziona temporaneamente disabilitata";ad_script_abort
}

set titolo     "Aggiornamento tabelle dei database regionali"
set page_title $titolo
set main_directory [ad_conn package_url]
set context_bar [iter_context_bar [list ${main_directory}main "Home"] "$titolo"]
#set url_nome_funz [export_url_vars nome_funz]

if {$nome_funz_caller eq ""} {
    set nome_funz_caller $nome_funz
}


set form_name "aggiornamento_db_filter"
set button_label "Vai"
set onsubmit_cmd ""
set readonly_fld \{\}

form create $form_name \
-html    $onsubmit_cmd

#Elementi della form di selezione

element create $form_name sql_istruction \
-label   "Istruzione SQL" \
-widget   textarea \
-datatype text \
-html    "cols 120 rows 50  $readonly_fld {} class form_element" \
-optional

element create $form_name submit            -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name nome_funz         -widget hidden -datatype text -optional
element create $form_name nome_funz_caller  -widget hidden -datatype text -optional


if {[form is_request $form_name]} {
ns_log notice "\ndebug form is_request"
    element set_properties $form_name nome_funz_caller         -value $nome_funz_caller
    element set_properties $form_name nome_funz      -value $nome_funz
}

if {[form is_valid $form_name]} {

    # form valido dal punto di vista del templating system
    ns_log notice "\ndebug form is_valid"
    set sql_istruction     [element::get_value $form_name sql_istruction]
    
    set sql_istruction [string trimright $sql_istruction]
    
    set error_num 0
    
    if {$sql_istruction eq ""} {
	element::set_error $form_name sql_istruction "Inserire una istruzione sql valida"
	incr error_num
    }
    
    if {[string match "select*" $sql_istruction] == 1} {
	element::set_error $form_name sql_istruction "Non &egrave; possibile effettuare istruzioni di select in questa procedura"
	incr error_num
    }
    if {$error_num > 0} {
	ns_log notice "\ndebug errore!"
	ad_return_template
        return
    }

#    set sql_istruction [ad_urlencode $sql_istruction]
    set url_link [export_url_vars sql_istruction nome_funz_caller]
    set return_url "aggiornamento-db-list?$url_link"
    
    ad_returnredirect $return_url
    ad_script_abort

}


ad_return_template
