ad_page_contract {
    @author          Giulio Laurenzi
    @creation-date   26/04/2005

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimaces-filter.tcl
} {
    
   {caller        "index"}
   {nome_funz          ""}
   {nome_funz_caller   ""} 
   {da_data            ""}
   {a_data             ""}
   {f_manu_cogn          ""}
   {f_manu_nome          ""}
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

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# controllo se l'utente � un manutentore
set cod_manutentore [iter_check_uten_manu $id_utente]

# Personalizzo la pagina
set titolo       "Numero modelli H"
set button_label "Seleziona" 
set page_title   "Numero modelli H"


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimstco"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

element create $form_name da_data \
-label   "da_data" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name a_data \
-label   "a_data" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

if {[string equal $cod_manutentore ""]} {
    set sw_manu "f"
    set readonly_fld2 \{\}
    set cerca_manu [iter_search $form_name coimmanu-list [list dummy f_cod_manu dummy f_manu_cogn dummy f_manu_nome]]
} else {
    set sw_manu "t"
    set readonly_fld2 "readonly"
    set cerca_manu ""
}
element create $form_name f_manu_cogn \
-label   "Cognome" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld2 {} class form_element tabindex 7" \
-optional

element create $form_name f_manu_nome \
-label   "Nome" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld2 {} class form_element tabindex 8"\
-optional

element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name dummy       -widget hidden -datatype text -optional
element create $form_name f_cod_manu  -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"


if {[form is_request $form_name]} {

    if {![string equal $cod_manutentore ""]} {
	element set_properties $form_name f_cod_manu    -value $cod_manutentore
	if {[db_0or1row get_nome_manu "select cognome as f_manu_cogn
            , nome    as f_manu_nome
         from coimmanu
        where cod_manutentore = :cod_manutentore"] == 0} {
	    set f_manu_cogn ""
	    set f_manu_nome ""
	}
    }
    
    element set_properties $form_name f_manu_cogn        -value $f_manu_cogn
    element set_properties $form_name f_manu_nome        -value $f_manu_nome
    element set_properties $form_name caller         -value $caller
    element set_properties $form_name nome_funz      -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set da_data            [element::get_value $form_name da_data]
    set a_data             [element::get_value $form_name a_data]
    set f_cod_manu         [string trim [element::get_value $form_name f_cod_manu]]
    set f_manu_cogn        [string trim [element::get_value $form_name f_manu_cogn]]
    set f_manu_nome        [string trim [element::get_value $form_name f_manu_nome]]
    set error_num 0 

    if {[string equal $da_data ""]} {
	element::set_error $form_name da_data "Inserire"
	incr error_num
    } else {
	set da_data [iter_check_date $da_data]
	if {$da_data == 0} {
	    element::set_error $form_name da_data "Data non corretta"
	    incr error_num
	}
    }    

    if {[string equal $a_data ""]} {
	element::set_error $form_name a_data "Inserire"
	incr error_num
    } else {
	set a_data [iter_check_date $a_data]
	if {$a_data == 0} {
	    element::set_error $form_name a_data "Data non corretta"
	    incr error_num
	}
    }    

    if {[string equal $f_manu_cogn ""]
	&& ![string equal $f_manu_nome ""]
    } {
	element::set_error $form_name f_manu_cogn "Indicare anche il cognome"
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
              where upper(cognome)   $eq_cognome
                and upper(nome)      $eq_nome" {
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
	element::set_error $form_name f_manu_cogn "inserire"
	incr error_num
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
    
    set link_gest [export_url_vars da_data a_data f_manu_cogn f_manu_nome f_cod_manu  nome_funz nome_funz_caller]

    set return_url "coimstat-manu-list?$link_gest"
    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
