ad_page_contract {
    @author          Luca Romitti
    @creation-date   083/04/2018

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coiminco-filter.tcl

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    rom01  08/06/2018 Su richiesta di Sandro aggiungo il campo data_fattura che userò come data 
    rom01             di stampa della fattura.

} {
    {funzione         "V"}
    {caller       "index"}
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
if {[string equal $nome_funz_caller ""]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set titolo        "Selezione Ispezioni"
set button_label  "Seleziona" 
set button_label2 "Scarica"
set page_title    "Selezione Ispezioni"

set context_bar  [iter_context_bar -nome_funz $nome_funz] 


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimmov-fatt-filter"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

form create $form_name \
    -html    $onsubmit_cmd

set f_id_caus [db_string query "select id_caus from coimcaus where codice='VC'"]

set l_of_caus [db_list_of_lists q "
           select descrizione as caus_pag
                , id_caus as f_id_caus  
             from coimcaus 
            where codice='VC'"]



element create $form_name f_id_caus \
    -label   "Tipo movimento" \
    -widget   select \
    -datatype text \
    -html    "class form_element" \
    -options  $l_of_caus \
    -mode "display" \
    -optional

element create $form_name f_data_pag_da \
    -label   "Data pagamento da" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

element create $form_name f_data_pag_a \
    -label   "Data pagamento a" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

element create $form_name f_data_compet_da \
    -label   "Data competenza da" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

element create $form_name f_data_compet_a \
    -label   "Data pagamento a" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

#san01 aggiunto f_data_incasso_da e f_data_incasso_a
element create $form_name f_data_incasso_da \
    -label   "Data incasso da" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

element create $form_name f_data_incasso_a \
    -label   "Data incasso a" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional


element create $form_name f_data_scad_da \
    -label   "Data scadenza da" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

element create $form_name f_data_scad_a \
    -label   "Data scadenza a" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

element create $form_name f_importo_da \
    -label   "da importo" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

element create $form_name f_importo_a \
    -label   "a importo" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional
#rom01
element create $form_name data_fattura \
    -label "data fattura" \
    -widget text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional


set l_of_l [db_list_of_lists sel_lol "select descrizione, cod_tipo_pag from coimtp_pag order by ordinamento"]
set options_cod_tp_pag [linsert $l_of_l 0 [list "" ""]]
element create $form_name f_tipo_pag \
    -label   "Tipo pagamento" \
    -widget   select \
    -datatype text \
    -html    "class form_element" \
    -optional \
    -options $options_cod_tp_pag

element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name f_id_caus        -value $f_id_caus
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system

    set f_id_caus          [element::get_value $form_name f_id_caus]
    set f_tipo_pag         [element::get_value $form_name f_tipo_pag]
    set f_data_pag_da      [element::get_value $form_name f_data_pag_da]
    set f_data_pag_a       [element::get_value $form_name f_data_pag_a]
    set f_data_scad_da     [element::get_value $form_name f_data_scad_da]
    set f_data_scad_a      [element::get_value $form_name f_data_scad_a]
    set f_importo_da       [element::get_value $form_name f_importo_da]
    set f_importo_a        [element::get_value $form_name f_importo_a]
    set f_data_compet_da   [element::get_value $form_name f_data_compet_da]
    set f_data_compet_a    [element::get_value $form_name f_data_compet_a]
    set f_data_incasso_da  [element::get_value $form_name f_data_incasso_da];#san01
    set f_data_incasso_a   [element::get_value $form_name f_data_incasso_a];#san01
    set data_fattura       [element::get_value $form_name data_fattura];#rom01
    set error_num 0

    #controllo f_data incontro
    set flag_ok_dat_pag_da "f"
    if {![string equal $f_data_pag_da ""]} {
	set f_data_pag_da [iter_check_date $f_data_pag_da]
	if {$f_data_pag_da == 0} {
	    element::set_error $form_name f_data_pag_da "deve essere una data valida"
	    incr error_num
	} else {
	    set flag_ok_dat_pag_da "t"
	}
    }

    set flag_ok_dat_pag_a "f"
    if {![string equal $f_data_pag_a ""]} {
	set f_data_pag_a [iter_check_date $f_data_pag_a]
	if {$f_data_pag_da == 0} {
	    element::set_error $form_name f_data_pag_a "deve essere una data valida"
	    incr error_num
	} else {
	    set flag_ok_dat_pag_a "t"
	}
    }

    set flag_ok_dat_compet_da "f"
    if {![string equal $f_data_compet_da ""]} {
	set f_data_compet_da [iter_check_date $f_data_compet_da]
	if {$f_data_compet_da == 0} {
	    element::set_error $form_name f_data_compet_da "deve essere una data valida"
	    incr error_num
	} else {
	    set flag_ok_dat_compet_da "t"
	}
    }

    set flag_ok_dat_compet_a "f"
    if {![string equal $f_data_compet_a ""]} {
	set f_data_compet_a [iter_check_date $f_data_compet_a]
	if {$f_data_compet_da == 0} {
	    element::set_error $form_name f_data_compet_a "deve essere una data valida"
	    incr error_num
	} else {
	    set flag_ok_dat_compet_a "t"
	}
    }

    set flag_ok_dat_incasso_da "f";#san01
    if {![string equal $f_data_incasso_da ""]} {#san01 if e suo contenuto
	set f_data_incasso_da [iter_check_date $f_data_incasso_da]
	if {$f_data_incasso_da == 0} {
	    element::set_error $form_name f_data_incasso_da "deve essere una data valida"
	    incr error_num
	} else {
	    set flag_ok_dat_incasso_da "t"
	}
    }

    set flag_ok_dat_incasso_a "f";#san01
    if {![string equal $f_data_incasso_a ""]} {#san01 if e suo contenuto
	set f_data_incasso_a [iter_check_date $f_data_incasso_a]
	if {$f_data_compet_da == 0} {
	    element::set_error $form_name f_data_incasso_a "deve essere una data valida"
	    incr error_num
	} else {
	    set flag_ok_dat_incasso_a "t"
	}
    }


    if {![string equal $f_data_compet_da ""]
	&&  ![string equal $f_data_compet_a  ""]
	&&  $flag_ok_dat_compet_da == "t"
	&&  $flag_ok_dat_compet_a ==  "t"
	&&  $f_data_compet_a < $f_data_compet_da
    } {
	element::set_error $form_name f_data_compet_a "deve essere maggiore o uguale alla data pagamento iniziale"
	incr error_num
    } 

    if {![string equal $f_data_incasso_da ""]
	&&  ![string equal $f_data_incasso_a  ""]
	&&  $flag_ok_dat_incasso_da == "t"
	&&  $flag_ok_dat_incasso_a ==  "t"
	&&  $f_data_incasso_a < $f_data_incasso_da
    } {;#san01 if e suo contenuto
	element::set_error $form_name f_data_incasso_a "deve essere maggiore o uguale alla data incasso iniziale"
	incr error_num
    } 


    if {![string equal $f_data_pag_da ""]
	&&  ![string equal $f_data_pag_a  ""]
	&&  $flag_ok_dat_pag_da == "t"
	&&  $flag_ok_dat_pag_a ==  "t"
	&&  $f_data_pag_a < $f_data_pag_da
    } {
	element::set_error $form_name f_data_pag_a "deve essere maggiore o uguale alla data pagamento iniziale"
	incr error_num
    } 

    set flag_ok_dat_scad_da "f"
    if {![string equal $f_data_scad_da ""]} {
	set f_data_scad_da [iter_check_date $f_data_scad_da]
	if {$f_data_scad_da == 0} {
	    element::set_error $form_name f_data_scad_da "deve essere una data valida"
	    incr error_num
	} else {
	    set flag_ok_dat_scad_da "t"
	}
    }

    set flag_ok_dat_scad_a "f"
    if {![string equal $f_data_scad_a ""]} {
	set f_data_scad_a [iter_check_date $f_data_scad_a]
	if {$f_data_scad_da == 0} {
	    element::set_error $form_name f_data_scad_a "deve essere una data valida"
	    incr error_num
	} else {
	    set flag_ok_dat_scad_a "t"
	}
    }

    if {![string equal $f_data_scad_da ""]
	&&  ![string equal $f_data_scad_a  ""]
	&&  $flag_ok_dat_scad_da == "t"
	&&  $flag_ok_dat_scad_a ==  "t"
	&&  $f_data_scad_a < $f_data_scad_da
    } {
	element::set_error $form_name f_data_scad_a "deve essere maggiore o uguale alla data pagamento iniziale"
	incr error_num
    } 

    set flag_ok_importo_da "f"
    if {![string equal $f_importo_da ""]} {
	set f_importo_da [iter_check_num $f_importo_da 2]
	if {$f_importo_da == "Error"} {
	    element::set_error $form_name f_importo_da "deve essere un'importo  valido"
	    incr error_num
	} else {
	    set flag_ok_importo_da "t"
	}
    }

    set flag_ok_importo_a "f"
    if {![string equal $f_importo_a ""]} {
	set f_importo_a [iter_check_num $f_importo_a 2]
	if {$f_importo_da == "Error"} {
	    element::set_error $form_name f_importo_a "deve essere un'importo valido"
	    incr error_num
	} else {
	    set flag_ok_importo_a "t"
	}
    }

    if {![string equal $f_importo_da ""]
	&&  ![string equal $f_importo_a  ""]
	&&  $flag_ok_importo_da == "t"
	&&  $flag_ok_importo_a ==  "t"
	&&  $f_importo_a < $f_importo_da
    } {
	element::set_error $form_name f_importo_a "deve essere maggiore o uguale all'importo iniziale"
	incr error_num
    } 

    if {[string equal $data_fattura ""]} {#rom01 if e contenuto
	element::set_error $form_name data_fattura "Inserire data fattura"
	incr error_num
    };#rom01
    
    if {![string equal $data_fattura ""]} {#rom01 if e contenuto
        set data_fattura [iter_check_date $data_fattura]
        if {$data_fattura == 0} {
            element::set_error $form_name data_fattura "deve essere una data valida"
            incr error_num
        }
    };#rom01
    
    
    
    set link_list [export_url_vars  f_importo_da f_importo_a f_data_scad_da f_data_scad_a f_data_pag_da f_data_pag_a f_id_caus f_tipo_pag caller funzione nome_funz nome_funz_caller f_data_compet_da f_data_compet_a f_data_incasso_da f_data_incasso_a data_fattura]&flag_filter=t

    set return_url "coimmov-fatt-list?$link_list"

    if {$error_num > 0} {
	ad_return_template
	return
    }
    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
