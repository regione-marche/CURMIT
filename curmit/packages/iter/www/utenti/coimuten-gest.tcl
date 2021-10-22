ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimuten"
    @author          Giulio Laurenzi
    @creation-date   14/05/2004

    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz_caller identifica l'entrata di menu, serve per la 
    @                navigazione con navigation bar

    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimuten-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    nic01 21/05/2014 Aggiunto flush della cache in modo da rinfrescare il menù dinamico
    nic01            dopo aver inserito, modificato o cancellato un menù.
 
} {
    
   {cod_utente ""}
   {last_utente ""}
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
set link_gest [export_url_vars cod_utente last_utente nome_funz nome_funz_caller extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set link_list_script {[export_url_vars last_utente caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Utente"
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

# Richiamo la procedura iter_get_coimtgen per verificare se sono o meno in un ente regionale
# Se non ci si trova in un ente regionale l'utente non potrà creare profili appartenenti alla regione
iter_get_coimtgen
# Identifico settore e ruolo a cui appartiene l'utente
db_1row select_profilo_utente ""

set flag_regione ""
if {($coimtgen(flag_ente) ne "R") && ($id_settore ne "system")} {
    set flag_regione "where a.id_settore != 'regione' and a.id_settore != 'system'"
}
if {($coimtgen(flag_ente) eq "R") && ($id_settore ne "system")} {
    set flag_regione "where a.id_settore != 'system'"
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimuten"
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

element create $form_name cod_utente \
-label   "Id utente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_key {} class form_element" \
-optional

element create $form_name cognome \
-label   "Cognome" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name nome \
-label   "Nome" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

#element create $form_name password \
#-label   "Password" \
#-widget   text \
#-datatype text \
#-html    "size 15 maxlength 15 $readonly_fld {} class form_element" \
#-optional

element create $form_name id_settore \
-label   "Settore" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table_wherec coimsett id_settore descrizione "" $flag_regione]

element create $form_name id_ruolo \
-label   "Ruolo" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimruol id_ruolo descrizione]

element create $form_name e_mail \
-label   "E mail" \
-widget   text \
-datatype text \
-html    "size 50 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name rows_per_page \
-label   "Righe per pagina" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimrgh rgh_cde rgh_cde]

element create $form_name livello \
-label   "Livello" \
-widget   text \
-datatype text \
-html    "size 1 maxlength 1 $readonly_fld {} class form_element" \
-optional


element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name password  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_utente -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name last_utente -value $last_utente

    if {$funzione == "I"} {
        
    } else {
      # leggo riga
        if {[db_0or1row sel_uten {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name cod_utente     -value $cod_utente
        element set_properties $form_name cognome        -value $cognome
        element set_properties $form_name nome           -value $nome
        element set_properties $form_name password       -value $password
        element set_properties $form_name id_settore     -value $id_settore
        element set_properties $form_name id_ruolo       -value $id_ruolo
        element set_properties $form_name e_mail         -value $e_mail
        element set_properties $form_name rows_per_page  -value $rows_per_page
        element set_properties $form_name livello        -value $livello

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_utente    [element::get_value $form_name cod_utente]
    set cognome       [element::get_value $form_name cognome]
    set nome          [element::get_value $form_name nome]
 #   set password      [element::get_value $form_name password]
    set id_settore    [element::get_value $form_name id_settore]
    set id_ruolo      [element::get_value $form_name id_ruolo]
    set e_mail        [element::get_value $form_name e_mail]
    set rows_per_page [element::get_value $form_name rows_per_page]
    set livello       [element::get_value $form_name livello]

set password "cambiami"
  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {[string equal $cod_utente ""]} {
            element::set_error $form_name cod_utente "Inserire Id utente"
            incr error_num
       # } elseif {$funzione == "I"  && ([string range $cod_utente 0 1] eq "AM" || [string range $cod_utente 0 1] eq "MA")} {
       #    element::set_error $form_name cod_utente "Non si possono inserire utenti con prefisso 'MA' o 'AM', tali prefissi sono riservati."
       #    incr error_num
	}

        if {[string equal $cognome ""]} {
            element::set_error $form_name cognome "Inserire Cognome"
            incr error_num
        }

        if {[string equal $nome ""]} {
            element::set_error $form_name nome "Inserire Nome"
            incr error_num
        }

#        if {[string equal $password ""]} {
#            element::set_error $form_name password "Inserire Password"
#            incr error_num
#        }

        if {[string equal $id_settore ""]} {
            element::set_error $form_name id_settore "Inserire Settore"
            incr error_num
        }

        if {[string equal $id_ruolo ""]} {
            element::set_error $form_name id_ruolo "Inserire Ruolo"
            incr error_num
        }

        if {[string equal $e_mail ""]} {
            element::set_error $form_name e_mail "Inserire E mail"
            incr error_num
        }

        if {[string equal $rows_per_page ""]} {
            element::set_error $form_name rows_per_page "Inserire Righe per pagina"
            incr error_num
        } else {
            set rows_per_page [iter_check_num $rows_per_page 0]
            if {$rows_per_page == "Error"} {
                element::set_error $form_name rows_per_page "Righe per pagina deve essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $rows_per_page] >=  [expr pow(10,8)]
                ||  [iter_set_double $rows_per_page] <= -[expr pow(10,8)]} {
                    element::set_error $form_name rows_per_page "Righe per pagina deve essere inferiore di 100.000.000"
                    incr error_num
                }
            }
        }

        if {![string equal $livello ""]} {
            set livello [iter_check_num $livello 0]
            if {$livello == "Error"} {
                element::set_error $form_name livello "Livello deve essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $livello] >=  [expr pow(10,1)]
                ||  [iter_set_double $livello] <= -[expr pow(10,1)]} {
                    element::set_error $form_name livello "Livello deve essere inferiore di 10"
                    incr error_num
                }
            }
        }
    }

   # if {$funzione == "D" && ([string range $cod_utente 0 1] eq "AM" || [string range $cod_utente 0 1] eq "MA")} {
    #	element::set_error $form_name cod_utente "Non si possono cancellare utenti con prefisso 'MA' o 'AM', tali prefissi sono riservati, per disattivare mettere livello a zero"
    #	incr error_num
    #}

     if {$funzione == "D"} {
    	element::set_error $form_name cod_utente "Non si possono cancellare utenti, per disattivare mettere livello a zero"
    	incr error_num
    }
    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_uten_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name cod_utente "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_uten]}
        M {set dml_sql [db_map upd_uten]}
        D {set dml_sql [db_map del_uten]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimuten $dml_sql
            }

            ns_cache_flush dynamic_menu_cache $cod_utente;#nic01
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

  # dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione == "I"} {
        set last_utente [list $cognome $nome $cod_utente]
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_utente last_utente nome_funz nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coimuten-gest?funzione=V&$link_gest"}
        D {set return_url   "coimuten-list?$link_list"}
        I {set return_url   "coimuten-gest?funzione=V&$link_gest"}
        V {set return_url   "coimuten-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
