ad_page_contract {
    @creation-date   17/05/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimstte-filter.tcl
} {
    
   {funzione         "V"}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}

   {f_cod_enve        ""}
   {f_cod_tecn        ""}

} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set cod_opve 	[iter_check_uten_opve $id_utente]

# controllo il parametro di "propagazione" per la navigation bar
if {[string equal $nome_funz_caller ""]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set button_label "Scarica parametri" 
set page_title   "Filtro per scarico parametri"

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 
set context_bar "<a href=\"/iter/main\">Home</a> : <a href=\"/iter/main?livello=2&scelta%5f1=23&scelta%5f2=0&scelta%5f3=0&scelta%5f4=0\">Funzioni di Utilit&agrave;</a>"

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimscar"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

form create $form_name \
-html    $onsubmit_cmd

element create $form_name f_cod_enve \
-label   "Codice ente" \
-widget   select \
-datatype text \
-html    "class form_element" \
-optional \
-options [iter_selbox_from_table coimenve cod_enve ragione_01]

element create $form_name f_cog_tecn \
-label   "Cognome tecnico" \
-widget   text \
-datatype text \
-html    "size 15 maxlength 40  class form_element" \
-optional 

element create $form_name f_nom_tecn \
-label   "Nome tecnico" \
-widget   text \
-datatype text \
-html    "size 15 maxlength 40  class form_element" \
-optional 

set cerca_opve [iter_search $form_name coimopve-list [list cod_enve f_cod_enve dummy f_cod_tecn dummy f_nom_tecn dummy f_cog_tecn]]

element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name f_cod_tecn       -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller

    element set_properties $form_name f_cod_enve       -value $f_cod_enve
    element set_properties $form_name f_cod_tecn       -value $f_cod_tecn
    if {[db_0or1row sel_tecn ""] == 0} {
	set f_cog_tecn ""
	set f_nom_tecn ""
    }
    element set_properties $form_name f_nom_tecn       -value $f_nom_tecn
    element set_properties $form_name f_cog_tecn       -value $f_cog_tecn
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set f_cod_enve       [element::get_value $form_name f_cod_enve]
    set f_cod_tecn       [element::get_value $form_name f_cod_tecn]
    set f_nom_tecn       [element::get_value $form_name f_nom_tecn]
    set f_cog_tecn       [element::get_value $form_name f_cog_tecn]


    set error_num 0
    
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

#    if {[string equal $f_cod_tecn ""]} {
#	element::set_error $form_name f_cog_tecn "Inserisci verificatore"
#	incr error_num
#    }

    if {[string equal $f_cog_tecn ""]
    &&  [string equal $f_nom_tecn    ""]
    } {
	set f_cod_tecn ""
    } else {
	set chk_inp_cod_tecn $f_cod_tecn
	set chk_inp_cognome  $f_cog_tecn
	set chk_inp_nome     $f_nom_tecn
	eval $check_cod_tecn
	set f_cod_tecn  $chk_out_cod_tecn
	if {$chk_out_rc == 0} {
	    element::set_error $form_name f_cog_tecn $chk_out_msg
	    incr error_num
	}
    }

    if {$error_num > 0} {
       ad_return_template
       return
    }

    set link_list [export_url_vars caller funzione nome_funz nome_funz_caller f_cod_tecn f_cod_enve]

    set return_url "coimscar-parm-gest?$link_list"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
