ad_page_contract {
    Filtro Modelli H da esportare
    @author          Nicola Mortoni Adhoc
    @creation-date   15/05/2006

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, serve per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimdimp-scar-filter.tcl
} {
    
   {funzione         "V"}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {receiving_element ""}

   {f_manu_cogn       ""}
   {f_manu_nome       ""}
   {f_cod_manu        ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
  # se il filtro viene chiamato da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

# Controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Controllo se l'utente è un manutentore
set cod_manutentore [iter_check_uten_manu $id_utente]

# Personalizzo la pagina
set button_label "Seleziona"
set page_title   "Esportazione Modelli H"

if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimdimp_scar"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

# la gestione del manutentore l'ho acquisita da coimaimp-filter.
# serve per avere il manutentore bloccato se l'utente collegato e' un manu.
# permette di scegliere il manutentore se l'utente collegato non e' un manu.
if {[string equal $cod_manutentore ""]} {
    set readonly_fld2 \{\}
    set cerca_manu    [iter_search $form_name coimmanu-list [list dummy f_cod_manu dummy f_manu_cogn dummy f_manu_nome]]
} else {
    set readonly_fld2 "readonly"
    set cerca_manu    ""
}

element create $form_name f_manu_cogn \
-label   "Cognome" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 200 $readonly_fld2 {} class form_element" \
-optional

element create $form_name f_manu_nome \
-label   "Nome" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 200 $readonly_fld2 {} class form_element"\
-optional

element create $form_name funzione          -widget hidden -datatype text -optional
element create $form_name caller            -widget hidden -datatype text -optional
element create $form_name nome_funz         -widget hidden -datatype text -optional
element create $form_name nome_funz_caller  -widget hidden -datatype text -optional
element create $form_name receiving_element -widget hidden -datatype text -optional
element create $form_name submit            -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name f_cod_manu        -widget hidden -datatype text -optional
element create $form_name dummy             -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    # solo se l'utente e' un manutentore valorizzo il relativo campo.
    if {![string equal $cod_manutentore ""]} {
	element set_properties $form_name f_cod_manu    -value $cod_manutentore
	if {[db_0or1row sel_manu_nome ""] == 0} {
	    set f_manu_cogn ""
	    set f_manu_nome ""
	}
    }

    element set_properties $form_name f_manu_cogn       -value $f_manu_cogn
    element set_properties $form_name f_manu_nome       -value $f_manu_nome
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name nome_funz_caller  -value $nome_funz_caller
    element set_properties $form_name receiving_element -value $receiving_element
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set f_cod_manu      [string trim [element::get_value $form_name f_cod_manu]]
    set f_manu_cogn     [string trim [element::get_value $form_name f_manu_cogn]]
    set f_manu_nome     [string trim [element::get_value $form_name f_manu_nome]]

  # controlli
    set error_num 0

    if {[string equal $f_manu_cogn ""]
    && ![string equal $f_manu_nome ""]
    } {
	element::set_error $form_name f_manu_cogn "Indicare anche il cognome"
	incr error_num
    }

  # routine generica per controllo codice manutentore
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
	db_foreach sel_manu "" {
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

    if {[string equal $f_manu_cogn ""]
    &&  [string equal $f_manu_nome ""]
    } {
	set cod_manutentore ""
    } else {
	set chk_inp_cod_manu $f_cod_manu
	set chk_inp_cognome  $f_manu_cogn
	set chk_inp_nome     $f_manu_nome
	eval $check_cod_manu
	set f_cod_manu  $chk_out_cod_manu
	if {$chk_out_rc == 0} {
	    element::set_error $form_name f_manu_cogn $chk_out_msg
	    incr error_num
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    set link_list [export_url_vars caller nome_funz nome_funz_caller receiving_element f_manu_cogn f_manu_nome f_cod_manu]

    set return_url "coimdocu-dist-dimp-list-cait?$link_list"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
