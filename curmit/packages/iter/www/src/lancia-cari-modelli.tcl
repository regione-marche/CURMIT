ad_page_contract {
    @cvs-id          lancia caricamento modelli
} {
    file_name:trim,optional
    file_name.tmpfile:tmpfile,optional
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}


set id_utente "sandro"

set form_name "lanciacari"
set page_title   "Lancio caricamento modelli"
set onsubmit_cmd "enctype {multipart/form-data}"
set context_bar  [iter_context_bar -nome_funz cari-modelli-f]

ns_log notice "caricamento modelli prova dob 1 $form_name"

form create $form_name \
-html    $onsubmit_cmd

element create $form_name file_name \
    -label   "File da importare" \
    -widget   file \
    -datatype text \
    -html    "size 40 class form_element" \
    -optional

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


element create $form_name submit       -widget submit -datatype text -label "carica" -html "class form_submit"
element create $form_name current_date -widget hidden -datatype text -optional
element create $form_name current_time -widget hidden -datatype text -optional

ns_log notice "caricamento modelli prova dob 2 $form_name"



if {[form is_request $form_name]} {
    
    set current_date [iter_set_sysdate]
    set current_time [iter_set_systime]
    
    element set_properties $form_name current_date  -value $current_date
    element set_properties $form_name current_time  -value $current_time

}


ns_log notice "caricamento modelli prova dob 3 $form_name"



if {[form is_valid $form_name]} {
ns_log notice "caricamento modelli prova dob 4"

    set current_date       [element::get_value $form_name current_date]
    set current_time       [element::get_value $form_name current_time]
    set file_name          [element::get_value $form_name file_name]
    set tipo_modello       [element::get_value $form_name tipo_modello]
    set cod_manutentore    [element::get_value $form_name cod_manutentore]

    set error_num 0
    if {[string equal $file_name ""]} {
	element::set_error $form_name file_name "Inserire Nome File"
	incr error_num
    } else {
	set extension [file extension $file_name]
ns_log notice "caricamento modelli prova dob 5 $extension"
	if {$extension != ".csv" && $extension != ".txt"} {
	    element::set_error $form_name file_name "Il file non ha estensione csv o txt"
	    incr error_num
	}
    }
    
    if {$error_num > 0} {
ns_log notice "caricamento modelli prova dob 6 $error_num"
        ad_return_template
        return
    }
    
    lappend par        $id_utente
    
    set permanenti_dir [iter_set_permanenti_dir]
    set file_name_orig $file_name
    set file_name      [string range $file_name [string last \\ $file_name] end]
    set file_name      [string trimleft $file_name \\]
    set file_name      "${permanenti_dir}/$file_name"
    # salvo il file temporaneo in modo permanente
ns_log notice "caricamento modelli prova dob 7 $file_name"

    exec mv ${file_name.tmpfile} $file_name
    
    lappend par         file_name
    lappend par        $file_name
    
    set note           ""
    

ns_log notice "caricamento modelli prova dob 8 $tipo_modello $cod_manutentore $file_name"

    ad_returnredirect iter-cari-modelli?tipo_modello=$tipo_modello&cod_manutentore=$cod_manutentore&file_name=$file_name
    ad_script_abort
}

ad_return_template
