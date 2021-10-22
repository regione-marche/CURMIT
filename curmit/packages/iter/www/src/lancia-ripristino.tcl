ad_page_contract {
    @cvs-id          lancia caricamento modelli
} {
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}


set id_utente "sandro"

set form_name "ripristino"
set page_title   "Lancio ripristino caricamenti interrotti"
#set context_bar  [iter_context_bar -nome_funz cari-modelli-f]
set context_bar ""
form create $form_name 

element create $form_name tipo_modello \
    -label   "Tipo modello" \
    -widget   select \
    -options  {{"Modello G" "modellog"} {"Modello F" "modellof"} } \
    -datatype text \
    -html    "size 1 class form_element" \
    -optional

element create $form_name cod_manutentore \
    -label   "Manutentore" \
    -widget   select \
    -datatype text \
    -html    "class form_element" \
    -optional \
    -options [iter_selbox_from_table coimmanu cod_manutentore cod_manutentore] 


element create $form_name submit       -widget submit -datatype text -label "Ripristina" -html "class form_submit"
element create $form_name current_date -widget hidden -datatype text -optional
element create $form_name current_time -widget hidden -datatype text -optional



if {[form is_request $form_name]} {
    
    set current_date [iter_set_sysdate]
    set current_time [iter_set_systime]
    
    element set_properties $form_name current_date  -value $current_date
    element set_properties $form_name current_time  -value $current_time

}


if {[form is_valid $form_name]} {

    set current_date       [element::get_value $form_name current_date]
    set current_time       [element::get_value $form_name current_time]
    set tipo_modello       [element::get_value $form_name tipo_modello]
    set cod_manutentore    [element::get_value $form_name cod_manutentore]

    
    lappend par        $id_utente
    
    set permanenti_dir [iter_set_permanenti_dir]
    set note           ""
    
    ad_returnredirect iter-ripristino?tipo_modello=$tipo_modello&cod_manutentore=$cod_manutentore
    ad_script_abort
}

ad_return_template
