ad_page_contract {
    @author          Catte Valentina
    @creation-date   11/05/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimstso-filter.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom01 21/10/2020 Su segnalazione di Salerno modificato page_title per renderlo
    rom01            uguale al nome del menu', Sandro ha detto che va bene per tutti.
    
} {  
    {f_id_caus          ""}
    {f_contatore        ""}
    {f_importo          ""}
    {f_data_scadenza    ""}
    {f_cod_comune       ""}
    {id_stampa          ""}
    {caller        "index"}
    {funzione          "V"}
    {nome_funz          ""}
    {nome_funz_caller   ""}
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
#rom01set titolo "Impostazioni per stampa Attivit&agrave; sospese"
set titolo       "Stampa Solleciti di pagamento";#rom01
set button_label "Seleziona"
#rom01set page_title   "Impostazione per stampa Attivit&agrave; sospese"
set page_title "Stampa Solleciti di pagamento";#rom01
iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimstso"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)
set cod_comune  $coimtgen(cod_comu)

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
    -html    $onsubmit_cmd

if {$flag_ente == "P"} {
    element create $form_name comune \
	-label   "Comune" \
	-widget   text \
	-datatype text \
	-html    "size 30 maxlength 35 $readonly_fld {} class form_element" \
	-optional

    set link_comune [iter_search  coimstso [ad_conn package_url]/tabgen/coimcomu-list [list dummy_1 f_cod_comune search_word comune dummy_2 dummy dummy_3 dummy]]
}

set l_of_l_caus [db_list_of_lists query "select descrizione, id_caus from coimcaus where codice = 'SA' order by descrizione"]
set l_of_l_caus [linsert $l_of_l_caus 0 [list "" ""]]
element create $form_name f_id_caus \
    -label   "Causale pagamento" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options $l_of_l_caus

element create $form_name f_importo \
    -label   "Importo" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 20 $readonly_fld {} class form_element" \
    -optional

element create $form_name f_contatore \
    -label   "f_contatore" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 20 $readonly_fld {} class form_element" \
    -optional

element create $form_name f_data_scadenza \
    -label   "Data scadenza" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional 

element create $form_name id_stampa \
    -label   "Denominazione stampa" \
    -widget   select \
    -options  [iter_selbox_from_table coimstpm id_stampa descrizione] \
    -datatype text \
    -html    "class form_element" \
    -optional

element create $form_name f_cod_comune     -widget hidden -datatype text -optional
element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name dummy            -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {
    
    if {$flag_ente == "C"} {
	element set_properties $form_name f_cod_comune  -value $cod_comune
    }
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name nome_funz_caller  -value $nome_funz_caller
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system

    set f_cod_comune       [element::get_value $form_name f_cod_comune]
    set f_id_caus          [element::get_value $form_name f_id_caus]
    set f_importo          [element::get_value $form_name f_importo]
    set f_contatore        [element::get_value $form_name f_contatore]
    set f_data_scadenza    [element::get_value $form_name f_data_scadenza]
    set id_stampa          [element::get_value $form_name id_stampa]
    
    set error_num 0
    
    if {![string equal $f_data_scadenza ""]} {
	set f_data_scadenza [iter_check_date $f_data_scadenza]
	if {$f_data_scadenza == 0} {
	    element::set_error $form_name f_data_scadenza "Inserire correttamente la data"
	    incr error_num
	}
    }
    
    if {![string equal $f_importo ""]} {
	set f_importo [iter_check_num $f_importo 2]
	if {$f_importo == "Error"} {
	    element::set_error $form_name f_importo "Deve essere numerico"
	    incr error_num
	} else {
	    if {[iter_set_double $f_importo] >=  [expr pow(10,7)]
		||  [iter_set_double $f_importo] <= -[expr pow(10,7)]} {
		element::set_error $form_name f_importo "deve essere < di 10.000.000"
		incr error_num
	    }
	}
    }

    if {![string equal $f_contatore ""]} {
	set f_contatore [iter_check_num $f_contatore]
	if {$f_contatore == "Error"} {
	    element::set_error $form_name f_contatore "Deve essere numerico"
	    incr error_num
	} else {
	    if {[iter_set_double $f_contatore] >=  [expr pow(10,7)]
		||  [iter_set_double $f_contatore] <= -[expr pow(10,7)]} {
		element::set_error $form_name f_contatore "deve essere < di 10.000.000"
		incr error_num
	    }
	}
    }
    
    if {[string equal $id_stampa ""]} {
	element::set_error $form_name id_stampa "Inserire la stampa"
	incr error_num
    }

    if {[string equal $f_id_caus ""]} {
	element::set_error $form_name f_id_caus "Inserire causale pagamento"
	incr error_num
    }

    if {[string equal $f_cod_comune ""]} {
	element::set_error $form_name comune "Inserire comune"
	incr error_num
    }
    if {[string equal $f_importo ""]} {
	element::set_error $form_name f_importo "Inserire importo"
	incr error_num
    }
    if {[string equal $f_contatore ""]} {
	element::set_error $form_name f_contatore "Inserire ristampa"
	incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    set link [export_url_vars set f_cod_comune f_id_caus f_importo f_contatore f_data_scadenza id_stampa nome_funz nome_funz_caller]
    set return_url "coimstso-list?$link"    

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
