ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimprof"

    @author          Giulio Laurenzi
    @creation-date   17/05/2004

    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar

    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimprof-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    nic01 21/05/2014 Aggiunto flush della cache in modo da rinfrescare il menù dinamico
    nic01            dopo aver inserito, modificato o cancellato un profilo.
} {
    
   {nome_menu ""}
   {last_nome_menu ""}
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
set link_gest [export_url_vars nome_menu last_nome_menu nome_funz nome_funz_caller extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Richiamo la procedura iter_get_coimtgen per verificare se sono o meno in un ente regionale
# Se non sono nell'ente regione non sarà possibile creare profili della regione
iter_get_coimtgen

db_1row select_profilo_utente ""

set flag_regione ""
if {($coimtgen(flag_ente) ne "R") && ($id_settore ne "system")} {
    set flag_regione "where a.id_settore != 'regione' and a.id_settore != 'system'"
}
if {($coimtgen(flag_ente) eq "R") && ($id_settore ne "system")} {
    set flag_regione "where a.id_settore != 'system'"
}

# Personalizzo la pagina
set link_list_script {[export_url_vars last_nome_menu caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Profilo"
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
set form_name    "coimprof"
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

element create $form_name nome_menu \
-label   "nome_menu" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 20 $readonly_key {} class form_element" \
-optional

element create $form_name settore \
-label   "settore" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options  [iter_selbox_from_table_wherec coimsett id_settore descrizione "" $flag_regione] 

element create $form_name ruolo \
-label   "ruolo" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options  [iter_selbox_from_table coimruol id_ruolo descrizione] 

element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_nome_menu -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name last_nome_menu -value $last_nome_menu

    if {$funzione == "I"} {
        
    } else {
      # leggo riga
        if {[db_0or1row sel_prof {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name nome_menu -value $nome_menu
        element set_properties $form_name settore -value $settore
        element set_properties $form_name ruolo -value $ruolo

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set nome_menu [element::get_value $form_name nome_menu]
    set settore   [element::get_value $form_name settore]
    set ruolo     [element::get_value $form_name ruolo]


  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {[string equal $nome_menu ""]} {
            element::set_error $form_name nome_menu "Inserire nome_menu"
            incr error_num
        }

        if {[string equal $settore ""]} {
            element::set_error $form_name settore "Inserire settore"
            incr error_num
        }

        if {[string equal $ruolo ""]} {
            element::set_error $form_name ruolo "Inserire ruolo"
            incr error_num
        }
	if {$funzione == "M"} {
	    set where_cod "and nome_menu <> :nome_menu"
	} else {
	    set where_cod ""
	}
	if {[db_0or1row check_profilo ""] == 1} {
	    element::set_error $form_name ruolo "Profilo gi&agrave; presente"
            incr error_num
	}

    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_prof_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name nome_menu "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_prof]}
        M {set dml_sql [db_map upd_prof]}
        D {set dml_sql [db_map del_prof]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimprof $dml_sql
            }

            ns_cache_flush dynamic_menu_cache;#nic01

        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

  # dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione == "I"} {
        set last_nome_menu $nome_menu
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars nome_menu last_nome_menu nome_funz nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coimprof-gest?funzione=V&$link_gest"}
        D {set return_url   "coimprof-list?$link_list"}
        I {set return_url   "coimprof-gest?funzione=V&$link_gest"}
        V {set return_url   "coimprof-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
