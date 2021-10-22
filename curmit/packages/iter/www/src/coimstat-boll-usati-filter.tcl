ad_page_contract {

    @creation-date   14.06.2012

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimstat-boll-usati-filter.tcl
} {  
    {f_data1           ""}
    {f_data2           ""}
    {f_manu_cogn       ""}
    {f_manu_nome       ""}
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
set titolo       "Parametri per stampa riepilogo bollini utilizzati"
set button_label "Seleziona"
set page_title   "Parametri per stampa riepilogo bollini utilizzati"

iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

# Controllo se l'utente è un manutentore
set cod_manutentore [iter_check_uten_manu $id_utente]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimstat"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

# imposto variabili per il cerca del manutentore
set sw_manu "f"
if {[string equal $cod_manutentore ""]} {
    set readonly_fld2 \{\}
    set cerca_manu    [iter_search $form_name coimmanu-list [list dummy cod_manutentore dummy f_manu_cogn dummy f_manu_nome]]
} else {
    set readonly_fld2 "readonly"
    set cerca_manu    ""
}
set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
    -html    $onsubmit_cmd

element create $form_name f_data1 \
    -label   "data inizio" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional
    
element create $form_name f_data2 \
    -label   "data fine" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name f_manu_cogn \
    -label   "Cognome" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 100 $readonly_fld2 {} class form_element " \
    -optional

element create $form_name f_manu_nome \
    -label   "Nome" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 100 $readonly_fld2 {} class form_element "\
    -optional

element create $form_name funzione        -widget hidden -datatype text -optional
element create $form_name caller          -widget hidden -datatype text -optional
element create $form_name nome_funz       -widget hidden -datatype text -optional
element create $form_name submit          -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name cod_manutentore -widget hidden -datatype text -optional


if {[form is_request $form_name]} {

  if {![string equal $cod_manutentore ""]} {
	if {![db_0or1row query "
            select cognome as f_manu_cogn
                 , nome    as f_manu_nome
              from coimmanu
             where cod_manutentore = :cod_manutentore"]
	} {
	    set f_manu_cogn ""
	    set f_manu_nome ""
	}
    }

    element set_properties $form_name f_data1         -value [iter_edit_date $f_data1]
    element set_properties $form_name f_data2         -value [iter_edit_date $f_data2]
    element set_properties $form_name f_manu_cogn     -value $f_manu_cogn
    element set_properties $form_name f_manu_nome     -value $f_manu_nome
    element set_properties $form_name cod_manutentore -value $cod_manutentore
    
    element set_properties $form_name funzione        -value $funzione
    element set_properties $form_name caller          -value $caller
    element set_properties $form_name nome_funz       -value $nome_funz
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set f_data1         [element::get_value $form_name f_data1]
    set f_data2         [element::get_value $form_name f_data2]
    set cod_manutentore [string trim [element::get_value $form_name cod_manutentore]]
    set f_manu_cogn     [string trim [element::get_value $form_name f_manu_cogn]]
    set f_manu_nome     [string trim [element::get_value $form_name f_manu_nome]]
    

    set error_num 0
    
    set flag_data1_ok "f"
    if {[string equal $f_data1 ""]} {
	element::set_error $form_name f_data1 "inserire"
	incr error_num
    } else {
	set f_data1 [iter_check_date $f_data1]
	if {$f_data1 == 0} {
	    element::set_error $form_name f_data1 "Inserire correttamente la data"
	    incr error_num
	} else {
	    set flag_data1_ok "t"
	}
    }
    
    set flag_data2_ok "f"
    if {[string equal $f_data2 ""]} {
	element::set_error $form_name f_data2 "inserire"
	incr error_num
    } else {
	set f_data2 [iter_check_date $f_data2]
	if {$f_data2 == 0} {
	    element::set_error $form_name f_data2 "Inserire correttamente la data"
	    incr error_num
	} else {
	    set flag_data2_ok "t"
	}
    }

    if {$flag_data1_ok &&  $flag_data2_ok && $f_data1 > $f_data2} {
	element::set_error $form_name f_data2 "La data iniziale dell'intervallo deve essere inferiore a quella finale"
	incr error_num
    }

    if {[string equal $f_manu_cogn ""] && ![string equal $f_manu_nome ""]} {
	element::set_error $form_name f_manu_cogn "Indicare anche il cognome"
	incr error_num
    }
    # routine generica per controllo codice manutentore ???
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
                              where upper(cognome)   $eq_cognome
                                and upper(nome)      $eq_nome
        " {
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

    if {[string equal $f_manu_cogn ""] &&  [string equal $f_manu_nome ""]} {
	set cod_manutentore ""
    } else {
	set chk_inp_cod_manu $cod_manutentore
	set chk_inp_cognome  $f_manu_cogn
	set chk_inp_nome     $f_manu_nome
	eval $check_cod_manu
	set cod_manutentore  $chk_out_cod_manu
	if {$chk_out_rc == 0} {
	    element::set_error $form_name f_manu_cogn $chk_out_msg
	    incr error_num
	}
    }
    
    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    set link [export_url_vars f_data1 f_data2 f_manu_cogn f_manu_nome cod_manutentore caller funzione nome_funz nome_funz_caller]
    set return_url "coimstat-boll-usati-layout?$link"
    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
