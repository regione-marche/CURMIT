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


set titolo     "Aggiornamento tabelle dei database regionali"
set page_title $titolo
set main_directory [ad_conn package_url]
set context_bar [iter_context_bar [list ${main_directory}main "Home"] "$titolo"]
#set url_nome_funz [export_url_vars nome_funz]

if {$nome_funz_caller eq ""} {
    set nome_funz_caller $nome_funz
}


set form_name "sql"
set button_label "Vai"
set onsubmit_cmd ""
set readonly_fld \{\}

form create $form_name \
-html    $onsubmit_cmd

#Elementi della form di selezione

element create $form_name sql_istruction \
-label   "Istruzione SQL" \
-widget   text \
-datatype text \
-html    "size 100 class form_element" \
-optional

element create $form_name submit            -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name nome_funz         -widget hidden -datatype text -optional
element create $form_name nome_funz_caller  -widget hidden -datatype text -optional


if {[form is_request $form_name]} {
    element set_properties $form_name nome_funz_caller         -value $nome_funz_caller
    element set_properties $form_name nome_funz      -value $nome_funz
}

if {[form is_valid $form_name]} {

  # form valido dal punto di vista del templating system

    set sql_istruction     [element::get_value $form_name sql_istruction]
    
    set error_num 0

    if {$sql_istruction eq ""} {
	element::set_error $form_name sql_istruction "Inserire una istruzione sql valida"
	incr error_num
    }

    if {[string match "select*" $sql_istruction] == 1} {
	element::set_error $form_name sql_istruction "Non &egrave; possibile effettuare istruzioni di select in questa procedura"
	incr error_num
    }
    if {[string equal [string range $sql_istruction 0 1] "u "]} {

	set sql_istruction "update [string range $sql_istruction 2 end]"
	element set_properties $form_name sql_istruction  -value $sql_istruction
    }

    if {$error_num > 0} {
	ad_return_template
        return
    }

    set url_link [export_url_vars sql_istruction nome_funz_caller]
    set return_url "aggiornamento-db-list?$url_link"
    
    ad_returnredirect $return_url
    ad_script_abort

}


ad_return_template
