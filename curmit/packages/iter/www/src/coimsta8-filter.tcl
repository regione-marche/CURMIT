ad_page_contract {

    @creation-date   10/05/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coiminco-filter.tcl
} {
    {da_data_cons      ""}
    {a_data_cons       ""}
    {da_data_scad      ""}
    {a_data_scad       ""}
    {nome_manu         ""}
    {cognome_manu      ""}
    {cod_manutentore   ""}
    {caller       "index"}
    {funzione         "V"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
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


# Personalizzo la pagina
set titolo       "Parametri per stampa riepilogo bollini"
set button_label "Seleziona"
set page_title   "Parametri per stampa riepilogo bollini"

iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimsta8"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

element create $form_name da_data_cons \
-label   "data inizio" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional \

element create $form_name a_data_cons \
-label   "data fine" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional \

element create $form_name da_data_scad \
-label   "data inizio" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional \

element create $form_name a_data_scad \
-label   "data fine" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional \

element create $form_name cognome_manu \
-label   "Cognome manutentore" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_manu \
-label   "Nome manutentore" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 40 $readonly_fld {} class form_element" \
-optional

set cerca_manu [iter_search $form_name coimmanu-list [list dummy cod_manutentore dummy cognome_manu dummy nome_manu] [list f_ruolo "M"]]


element create $form_name cod_manutentore -widget hidden -datatype text -optional
element create $form_name funzione        -widget hidden -datatype text -optional
element create $form_name caller          -widget hidden -datatype text -optional
element create $form_name nome_funz       -widget hidden -datatype text -optional
element create $form_name submit          -widget submit -datatype text -label "$button_label" -html "class form_submit"


if {[form is_request $form_name]} {
    
    element set_properties $form_name da_data_cons  -value [iter_edit_date $da_data_cons]
    element set_properties $form_name a_data_cons   -value [iter_edit_date $a_data_cons]
    element set_properties $form_name da_data_scad  -value [iter_edit_date $da_data_scad]
    element set_properties $form_name a_data_scad   -value [iter_edit_date $a_data_scad]
    element set_properties $form_name cognome_manu    -value [iter_edit_date $cognome_manu]
    element set_properties $form_name nome_manu       -value [iter_edit_date $nome_manu]
    element set_properties $form_name cod_manutentore -value [iter_edit_date $cod_manutentore]

    element set_properties $form_name funzione       -value $funzione
    element set_properties $form_name caller         -value $caller
    element set_properties $form_name nome_funz      -value $nome_funz

}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set da_data_cons   [element::get_value $form_name da_data_cons]
    set a_data_cons    [element::get_value $form_name a_data_cons]
    set da_data_scad   [element::get_value $form_name da_data_scad]
    set a_data_scad    [element::get_value $form_name a_data_scad]
    set cognome_manu     [element::get_value $form_name cognome_manu]
    set nome_manu        [element::get_value $form_name nome_manu]
    set cod_manutentore  [element::get_value $form_name cod_manutentore]
   
    set error_num 0

    
    set flag_da_data_cons_ok "f"
    if {![string equal $da_data_cons ""]} {
	set da_data_cons [iter_check_date $da_data_cons]
	if {$da_data_cons == 0} {
	    element::set_error $form_name da_data_cons "Inserire correttamente la data"
	    incr error_num
	} else {
	    set flag_da_data_cons_ok "t"
	}
    }
    
    set flag_a_data_cons_ok "f"
    if {![string equal $a_data_cons ""]} {
	set a_data_cons [iter_check_date $a_data_cons]
	if {$a_data_cons == 0} {
	    element::set_error $form_name a_data_cons "Inserire correttamente la data"
	    incr error_num
	} else {
	    set flag_a_data_cons_ok "t"
	}
    }

    if {$flag_da_data_cons_ok
    &&  $flag_a_data_cons_ok
    &&  $da_data_cons > $a_data_cons
    } {
	element::set_error $form_name da_data_cons "La data iniziale dell'intervallo deve essere inferiore a quella finale"
	incr error_num
	
    }

    set flag_da_data_scad_ok "f"
    if {![string equal $da_data_scad ""]} {
	set da_data_scad [iter_check_date $da_data_scad]
	if {$da_data_scad == 0} {
	    element::set_error $form_name da_data_scad "Inserire correttamente la data"
	    incr error_num
	} else {
	    set flag_da_data_scad_ok "t"
	}
    }
    
    set flag_a_data_scad_ok "f"
    if {![string equal $a_data_scad ""]} {
	set a_data_scad [iter_check_date $a_data_scad]
	if {$a_data_scad == 0} {
	    element::set_error $form_name a_data_scad "Inserire correttamente la data"
	    incr error_num
	} else {
	    set flag_a_data_scad_ok "t"
	}
    }

    if {$flag_da_data_scad_ok
    &&  $flag_a_data_scad_ok
    &&  $da_data_scad > $a_data_scad
    } {
	element::set_error $form_name da_data_scad "La data iniziale dell'intervallo deve essere inferiore a quella finale"
	incr error_num
	
    }

    #routine generica per controllo codice manutentore
    set check_cod_manu {
	set chk_out_rc       0
	set chk_out_msg      ""
	set chk_out_cod_manu ""
	set ctr_manu         0
	if {[string equal $chk_inp_cognome ""]} {
	    set eq_cognome "is null"
	} else {
	    set eq_cognome "= upper(:chk_inp_cognome)"
	}
	if {[string equal $chk_inp_nome ""]} {
	    set eq_nome    "is null"
	} else {
	    set eq_nome    "= upper(:chk_inp_nome)"
	}
	db_foreach sel_manu "select cod_manutentore as cod_manu_db
                               from coimmanu
                              where cognome $eq_cognome
                                and nome    $eq_nome" {
	    incr ctr_manu
	    if {$cod_manu_db == $chk_inp_cod_manu} {
		set chk_out_cod_manu $cod_manu_db
		set chk_out_rc       1
	    }
	}
	switch $ctr_manu {
	    0 { set chk_out_msg "Soggetto non trovato"}
	    1 { set chk_out_cod_manu $cod_manu_db
		set chk_out_rc       1 }
	    default {
		if {$chk_out_rc == 0} {
		    set chk_out_msg "Trovati pi&ugrave; soggetti: usa il link cerca"
		}
	    }
	}
    }
    
    if {[string equal $cognome_manu ""]
	&&  [string equal $nome_manu    ""]
    } {
	set cod_manutentore ""
    } else {
	set chk_inp_cod_manu $cod_manutentore
	set chk_inp_cognome  $cognome_manu
	set chk_inp_nome     $nome_manu
	eval $check_cod_manu
	set cod_manutentore  $chk_out_cod_manu
	if {$chk_out_rc == 0} {
	    element::set_error $form_name cognome_manu $chk_out_msg
	    incr error_num
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    set link [export_url_vars da_data_cons a_data_cons da_data_scad a_data_scad cod_manutentore nome_manu cognome_manu caller funzione nome_funz nome_funz_caller]

   
    set return_url "coimsta8-layout?$link"    

    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
