ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimogge"
    @author          Adhoc
    @creation-date   17/05/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimogge-gest.tcl
} {
    
   {livello ""}
   {scelta_1 ""}
   {scelta_2 ""}
   {scelta_3 ""}
   {scelta_4 ""}
   {last_scelta ""}
   {funzione  "V"}
   {caller    "index"}
   {nome_funz ""}
   {nome_funz_caller ""}
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
set link_gest [export_url_vars livello scelta_1 scelta_2 scelta_3 scelta_4 last_scelta nome_funz nome_funz_caller extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


# Personalizzo la pagina
set link_list_script {[export_url_vars livello scelta_1 scelta_2 scelta_3 last_scelta caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Oggetto"
switch $funzione {
    M {set button_label "Conferma Modifica" 
       set page_title   "Modifica $titolo"}
    D {set button_label "Conferma Cancellazione"
       set page_title   "Cancellazione $titolo"}
    I {set button_label "Conferma Inserimento"
       set page_title   "Inserimento $titolo"}
    V {set button_label "Torna alla lista"
       set page_title   "Visualizzazione $titolo"}
}

 set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimogge"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set disabled_key "disabled"
set onsubmit_cmd ""
switch $funzione {
   "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
        set disabled_key \{\}
       }
   "M" {set readonly_fld \{\}
        set disabled_fld \{\}
       }
}

form create $form_name \
-html    $onsubmit_cmd

set lista_scelte [list [list 0 0]]
set conta 11
while {$conta < 100} {
    lappend lista_scelte [list $conta $conta]
    incr conta
}
if {$funzione == "I"} {
    element create $form_name livello \
    -label   "livello" \
    -widget   select \
    -datatype text \
    -html    "$disabled_key {} class form_element" \
    -optional \
    -options {{1 1} {2 2} {3 3} {4 4}}

    element create $form_name scelta_1 \
    -label   "scelta_1" \
    -widget   select \
    -datatype text \
    -html    "$disabled_key {} class form_element" \
    -optional \
    -options $lista_scelte

    element create $form_name scelta_2 \
    -label   "scelta_2" \
    -widget   select \
    -datatype text \
    -html    "$disabled_key {} class form_element" \
    -optional \
    -options $lista_scelte

    element create $form_name scelta_3 \
    -label   "scelta_3" \
    -widget   select \
    -datatype text \
    -html    "$disabled_key {} class form_element" \
    -optional \
    -options $lista_scelte

    element create $form_name scelta_4 \
    -label   "scelta_4" \
    -widget   select \
    -datatype text \
    -html    "$disabled_key {} class form_element" \
    -optional \
    -options $lista_scelte
} else {
    element create $form_name livello \
    -label   "livello" \
    -widget   text \
    -datatype text \
    -html    "size 2 readonly {} class form_element" \
    -optional \

    element create $form_name scelta_1 \
    -label   "scelta_1" \
    -widget   text \
    -datatype text \
    -html    "size 2 readonly {} class form_element" \
    -optional \

    element create $form_name scelta_2 \
    -label   "scelta_2" \
    -widget   text \
    -datatype text \
    -html    "size 2 readonly {} class form_element" \
    -optional \

    element create $form_name scelta_3 \
    -label   "scelta_3" \
    -widget   text \
    -datatype text \
    -html    "size 2 readonly {} class form_element" \
    -optional \

    element create $form_name scelta_4 \
    -label   "scelta_4" \
    -widget   text \
    -datatype text \
    -html    "size 2 readonly {} class form_element" \
    -optional \
}
element create $form_name tipo \
-label   "tipo" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Menu menu} {Funzione funzione} {Titolo titolo}}

element create $form_name descrizione \
-label   "descrizione" \
-widget   text \
-datatype text \
-html    "size 50 maxlength 100 $readonly_fld {} class form_element" \
-optional

set lista_nome_funz [db_list_of_lists sel_n_funz ""]
set lista_nome_funz [linsert $lista_nome_funz 0 [list "" ""]]

element create $form_name nome_funz_d \
-label   "nome_funz" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options $lista_nome_funz


element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_scelta -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name last_scelta -value $last_scelta

    if {$funzione == "I"} {
        
    } else {
      # leggo riga
        if {[db_0or1row sel_ogge {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name livello  -value $livello
        element set_properties $form_name scelta_1 -value $scelta_1
        element set_properties $form_name scelta_2 -value $scelta_2
        element set_properties $form_name scelta_3 -value $scelta_3
        element set_properties $form_name scelta_4 -value $scelta_4
        element set_properties $form_name tipo -value $tipo
        element set_properties $form_name descrizione -value $descrizione
        element set_properties $form_name nome_funz_d -value $nome_funz_d

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set livello     [element::get_value $form_name livello]
    set scelta_1    [element::get_value $form_name scelta_1]
    set scelta_2    [element::get_value $form_name scelta_2]
    set scelta_3    [element::get_value $form_name scelta_3]
    set scelta_4    [element::get_value $form_name scelta_4]
    set tipo        [element::get_value $form_name tipo]
    set descrizione [element::get_value $form_name descrizione]
    set nome_funz_d [element::get_value $form_name nome_funz_d]
   # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {



        if {[string equal $tipo ""]} {
            element::set_error $form_name tipo "Inserire tipo"
            incr error_num
        }

        if {[string equal $descrizione ""]} {
            element::set_error $form_name descrizione "Inserire descrizione"
            incr error_num
        }
    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_ogge_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name scelta_4 "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

    # TODO: inserire eventuali controlli CUSTOM, tra cui
    #       i controlli di integrita' referenziale per I/M e D.
    #       non contemplati dalle references.

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_ogge]}
        M {set dml_sql [db_map upd_ogge]}
        D {set dml_sql [db_map del_ogge]
           set dml_mnu [db_map del_menu]
	}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimogge $dml_sql
		if {[info exists dml_mnu]} {
		    db_dml dml_coimmenu $dml_mnu
		}
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

  # dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione == "I"} {
        set last_scelta [list $livello $scelta_1 $scelta_2 $scelta_3 $scelta_4]
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars livello scelta_1 scelta_2 scelta_3 scelta_4 last_scelta nome_funz nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coimogge-gest?funzione=V&$link_gest"}
        D {set return_url   "coimogge-list?$link_list"}
        I {set return_url   "coimogge-gest?funzione=V&$link_gest"}
        V {set return_url   "coimogge-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
