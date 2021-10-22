ad_page_contract {
    @cvs-id          lancia controllo contributo regionale
} {
    file_name:trim,optional
    file_name.tmpfile:tmpfile,optional
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}


set id_utente "sandro"

set flag_portafoglio [db_string query "select flag_portafoglio from coimtgen"]

if {$flag_portafoglio != "T"} {
    iter_return_complaint "
    L'ente non gestisce il portafoglio"  
    ad_script_abort 
}

set form_name "lanciatestcontr"
set page_title   "Lancio test contributo regionale"
set context_bar  "Lancio test controllo regionale"


form create $form_name \

element create $form_name cod_manutentore \
    -label   "Manutentore" \
    -widget   select \
    -datatype text \
    -html    "class form_element" \
    -optional \
    -options [iter_selbox_from_table coimmanu cod_manutentore cod_manutentore] 

element create $form_name da_data \
    -label   "Da data" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

element create $form_name a_data \
    -label   "A data" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

element create $form_name submit       -widget submit -datatype text -label "carica" -html "class form_submit"
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
    set cod_manutentore    [element::get_value $form_name cod_manutentore]
    set da_data            [element::get_value $form_name da_data]
    set a_data             [element::get_value $form_name a_data]

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

    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    ad_returnredirect iter-test-contributo?cod_manutentore=$cod_manutentore&da_data=$da_data&a_data=$a_data 
    ad_script_abort
}

ad_return_template
