ad_page_contract {
    dob 2013

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    san01  22/08/2014 Gestito campo range_value
} {
    {nome_tabella ""}
    {nome_colonna ""}
    {funzione  "V"}
    {caller    "index"}
    {nome_funz ""}
    {extra_par ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

set link_gest [export_url_vars nome_tabella nome_colonna nome_funz extra_par]
iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars nome_tabella caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "COIMTABS"

switch $funzione {
    M {set button_label "Conferma Modifica" 
	set page_title   "Modifica $titolo"}
    D {set button_label "Conferma Cancellazione"
	set page_title   "Cancellazione da $titolo"}
    I {set button_label "Conferma Inserimento"
	set page_title   "Inserimento in $titolo"}
    V {set button_label "Torna alla lista"
	set page_title   "Visualizzazione $titolo"}
}

set context_bar  [iter_context_bar -nome_funz $nome_funz]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimtabs"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
    "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
    }
    "M" {set readonly_fld \{\}
        set disabled_fld \{\}
    }
}

form create $form_name \
    -html    $onsubmit_cmd

element create $form_name nome_tabella \
    -label   "Nome tabella" \
    -widget   text \
    -datatype text \
    -html    "size 35 maxlength 35 $readonly_key {} class form_element" \
    -optional


element create $form_name nome_colonna \
    -label   "Nome colonna" \
    -widget   text \
    -datatype text \
    -html    "size 40 maxlength 35 $readonly_key {} class form_element" \
    -optional

element create $form_name tipo_dato \
    -label   "Tipo dato" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 20 $readonly_fld {} class form_element" \
    -optional

element create $form_name dimensione \
    -label   "Dimensione" \
    -widget   text \
    -datatype text \
    -html    "size 35 maxlength 35 $readonly_fld {} class form_element" \
    -optional


element create $form_name obbligatorio \
    -label   "Obbligatorio" \
    -widget   text \
    -datatype text \
    -html    "size 1 maxlength 1 $readonly_fld {} class form_element" \
    -optional

element create $form_name ordinamento \
    -label   "Ordinamento" \
    -widget   text \
    -datatype text \
    -html    "size 6 maxlength 6 $readonly_fld {} class form_element" \
    -optional

element create $form_name range_value \
    -label   "Range di valori" \
    -widget   text \
    -datatype text \
    -html    "size 100 maxlength 4000 $readonly_fld {} class form_element" \
    -optional;#san01

element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {
    
    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name extra_par     -value $extra_par
    
    if {$funzione == "I"} {
        
    } else {
	# leggo riga
        if {[db_0or1row query "	select nome_tabella,
                         	nome_colonna,
                                tipo_dato,
                         	dimensione,
                        	obbligatorio,
                                range_value, -- san01
                        	ordinamento
                	    from coimtabs
                           where nome_tabella = :nome_tabella 
                             and nome_colonna = :nome_colonna"] == 0
        } {
            iter_return_complaint "Record non trovato"
	}
	
        element set_properties $form_name nome_tabella -value $nome_tabella
        element set_properties $form_name nome_colonna -value $nome_colonna
        element set_properties $form_name tipo_dato    -value $tipo_dato
        element set_properties $form_name dimensione   -value $dimensione
        element set_properties $form_name obbligatorio -value $obbligatorio
        element set_properties $form_name ordinamento  -value $ordinamento
        element set_properties $form_name range_value  -value $range_value;#san01
	
    }
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set nome_tabella [element::get_value $form_name nome_tabella]
    set nome_colonna [element::get_value $form_name nome_colonna]
    set tipo_dato    [element::get_value $form_name tipo_dato]
    set dimensione   [element::get_value $form_name dimensione]
    set obbligatorio [element::get_value $form_name obbligatorio]
    set ordinamento  [element::get_value $form_name ordinamento]
    set range_value  [element::get_value $form_name range_value];#san01
    
    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
	||  $funzione == "M"
    } {
	set error_num 0
    }
 

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql "insert into coimtabs
                          (  nome_tabella,
                             nome_colonna,
                             tipo_dato,
                             dimensione,
                             obbligatorio,
                             range_value,--san01
                             ordinamento)
                         values
                            (:nome_tabella,
                             :nome_colonna,
                             :tipo_dato,
                             :dimensione,
                             :obbligatorio,
                             :range_value,--san01
                             :ordinamento)"}

        M {set dml_sql "update coimtabs set
                             nome_tabella = :nome_tabella,
                             nome_colonna = :nome_colonna,
                             tipo_dato    = :tipo_dato,
                             dimensione   = :dimensione,
                             obbligatorio = :obbligatorio,
                             range_value  = :range_value,--san01
                             ordinamento  = :ordinamento 
    	    where nome_tabella = :nome_tabella and nome_colonna = :nome_colonna"}
    
	D {set dml_sql "delete from coimtabs where nome_tabella = :nome_tabella and nome_colonna = :nome_colonna"}
    }

    if {[info exists dml_sql]} {
	db_dml query $dml_sql
    }


#    set link_list      [subst $link_list_script]
    set link_list      $link_list_script

    set link_gest      [export_url_vars nome_tabella nome_colonna nome_funz extra_par caller]
    switch $funzione {
        M {set return_url   "coimtabs-gest?funzione=V&$link_gest"}
        D {set return_url   "coimtabs-list?$link_list"}
        I {set return_url   "coimtabs-gest?funzione=V&$link_gest"}
        V {set return_url   "coimtabs-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template

