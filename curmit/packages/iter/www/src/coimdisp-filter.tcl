ad_page_contract {
    @author          Giulio Laurenzi
    @creation-date   27/09/2005

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimcitt-filter.tcl
} {
    
   {funzione         "V"}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {cod_opve          ""}
   {mese              ""}
   {anno              ""}
   {cod_enve          ""} 
   {cod_opve          ""}
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
  # se il filtro viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie   iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {$caller == "index"} {
    set cod_tecn   [iter_check_uten_opve $id_utente]
    set cod_enve   [iter_check_uten_enve $id_utente]
} else {
    set cod_tecn $cod_opve
}

if {![string equal $cod_tecn ""]} {
    set cod_opve $cod_tecn
    if {[db_0or1row sel_cod_enve ""] == 0} {
	set cod_enve ""
    }
    set flag_cod_tecn "t"
} else {
    set flag_cod_tecn "f"
}

if {![string equal $cod_enve ""]} {
    set flag_cod_enve "t"
} else {
    set flag_cod_enve "f"
}
# Seleziono il livello dell'utente in base all'id_utente inserito
db_1row sel_livello_utente "" 
    set livello $livello

# Personalizzo la pagina
set titolo       "Agenda disponibilit&agrave; ispettori"
set button_label "Seleziona" 
set page_title   "Agenda disponibilit&agrave; ispettori"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimdisp"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
if {$flag_cod_tecn == "t"} {
    set readonly_tecn "readonly"
} else {
    set readonly_tecn  \{\}
}


set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

element create $form_name mese \
-label   "Mese" \
-widget   select \
-datatype text \
-html    "class form_element" \
-optional \
-options {{Gennaio 01} {Febbraio 02} {Marzo 03} {Aprile 04} {Maggio 05} {Giugno 06} {Luglio 07} {Agosto 08} {Settembre 09} {Ottobre 10} {Novembre 11} {Dicembre 12}} 

element create $form_name anno \
-label   "Anno" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
-optional \

if {$flag_cod_tecn == "f"
&&  $flag_cod_enve == "f"
} {    
    element create $form_name cod_enve \
    -label   "Codice ente" \
    -widget   select \
    -datatype text \
    -html    "class form_element" \
    -optional \
    -options [iter_selbox_from_table coimenve cod_enve ragione_01]
} else {
    element create $form_name cod_enve -widget hidden -datatype text -optional
    element set_properties $form_name cod_enve   -value $cod_enve

    element create $form_name desc_enve \
    -label   "Desc_enve" \
    -widget   text \
    -datatype text \
    -html    "size 30 readonly {} class form_element" \
    -optional 

    if {[db_0or1row sel_ragione_enve ""] == 0} {
        set ragione_01 ""
    }

    element set_properties $form_name desc_enve   -value $ragione_01
}

element create $form_name f_cog_tecn \
-label   "Cognome tecnico" \
-widget   text \
-datatype text \
-html    "size 15 maxlength 40 $readonly_tecn {} class form_element" \
-optional 

element create $form_name f_nom_tecn \
-label   "Nome tecnico" \
-widget   text \
-datatype text \
-html    "size 15 maxlength 40 $readonly_tecn {} class form_element" \
-optional 

set cerca_opve [iter_search $form_name coimopve-list [list cod_enve cod_enve dummy cod_opve dummy f_nom_tecn dummy f_cog_tecn]]


element create $form_name cod_opve    -widget hidden -datatype text -optional
element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name flag_cod_enve -widget hidden -datatype text -optional
element create $form_name flag_cod_tecn -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    if {[string equal $anno ""]} {
	set anno [string range [iter_set_sysdate] 0 3]
    }
    if {[string equal $mese ""]} {
	set mese [string range [iter_set_sysdate] 4 5]
    }
    element set_properties $form_name anno              -value $anno    
    element set_properties $form_name mese              -value $mese    
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name nome_funz_caller  -value $nome_funz_caller
    element set_properties $form_name cod_enve       -value $cod_enve
    element set_properties $form_name cod_opve       -value $cod_opve
    if {[db_0or1row sel_tecn ""] == 0} {
	set f_cog_tecn ""
	set f_nom_tecn ""
    }
    element set_properties $form_name f_cog_tecn       -value $f_cog_tecn
    element set_properties $form_name f_nom_tecn       -value $f_nom_tecn

}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set cod_enve        [element::get_value $form_name cod_enve]
    set cod_opve        [element::get_value $form_name cod_opve]
    set f_cog_tecn      [element::get_value $form_name f_cog_tecn]
    set f_nom_tecn      [element::get_value $form_name f_nom_tecn]
    set anno            [element::get_value $form_name anno]
    set mese            [element::get_value $form_name mese]
    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    set ctr_filter     0
    set first_element ""
    
    if {$flag_cod_enve == "t"} {
	set cod_enve [iter_check_uten_enve $id_utente]
    }
    if {$flag_cod_tecn == "t"} {
	set cod_tecn   [iter_check_uten_opve $id_utente]
	if {[db_0or1row sel_cod_enve ""] == 1} {
	    set cod_enve $cod_enve
	}
    }

    if {[string equal $cod_opve ""]
    && [string equal $f_cog_tecn  ""]
    && [string equal $f_nom_tecn  ""]
    } {
	element::set_error $form_name f_cog_tecn "Inserire il tecnico"
	incr error_num	
    }
    #routine generica per controllo codice tecnico
    set check_cod_tecn {
	set chk_out_rc       0
	set chk_out_msg      ""
	set chk_out_cod_tecn ""
	set ctr_tecn         0
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
	db_foreach sel_tecn_nom "" {
	    incr ctr_tecn
	    if {$cod_tecn_db == $chk_inp_cod_tecn} {
		set chk_out_cod_tecn $cod_tecn_db
		set chk_out_rc       1
	    }
	}
	switch $ctr_tecn {
	    0 { set chk_out_msg "Tecnico non trovato"}
	    1 { set chk_out_cod_tecn $cod_tecn_db
		set chk_out_rc       1 }
	    default {
		if {$chk_out_rc == 0} {
		    set chk_out_msg "Trovati pi&ugrave; tecnici: usa il link cerca"
		}
	    }
	}
    }

    if {[string equal $f_cog_tecn ""]
    &&  [string equal $f_nom_tecn    ""]
    } {
	set cod_opve ""
    } else {
	set chk_inp_cod_tecn $cod_opve
	set chk_inp_cognome  $f_cog_tecn
	set chk_inp_nome     $f_nom_tecn
	eval $check_cod_tecn
	set cod_opve  $chk_out_cod_tecn
	if {$chk_out_rc == 0} {
	    element::set_error $form_name f_cog_tecn $chk_out_msg
	    incr error_num
	}
    }

    if {[string equal $anno ""]} {
	element::set_error $form_name anno "Inserire l'anno"
	incr error_num
    } else {
	if {![string is integer $anno]} {
	    element::set_error $form_name anno "Deve essere un numero intero"
	    incr error_num
	} else {
	    if {[string length $anno] == 2} {
		element::set_error $form_name anno "Deve essere nel formato di quattro numeri"
		incr error_num
	    }
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }
       
    set link_list [export_url_vars caller nome_funz nome_funz_caller cod_enve cod_opve anno mese]

    set return_url "coimdisp-list?$link_list"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
