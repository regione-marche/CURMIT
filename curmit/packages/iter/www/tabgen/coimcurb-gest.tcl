ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimcurb"
    @author          Adhoc
    @creation-date   19/02/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimcurb-gest.tcl
} {
    
   {cod_urb         ""}
   {cod_comune      ""}
   {last_cod_urb    ""}
   {last_cod_comune ""}
   {descrizione     ""}
   {funzione       "V"}
   {caller     "index"}
   {nome_funz       ""}
   {extra_par       ""}
   cerca_com:optional
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}
  #  
# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_urb cod_comune last_cod_urb last_cod_comune nome_funz extra_par]

iter_set_func_class $funzione


# Personalizzo la pagina
set link_list_script {[export_url_vars cod_urb cod_comune last_cod_urb last_cod_comune caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Unita urbana"
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

set context_bar  [iter_context_bar -nome_funz $nome_funz]

iter_get_coimtgen
set flag_ente  $coimtgen(flag_ente)
set cod_comu $coimtgen(cod_comu)
set desc_comune  $coimtgen(denom_comune)

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimcurb"
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
       }
}

form create $form_name \
-html    $onsubmit_cmd

element create $form_name cod_urb \
-label   "Codice" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

if {$funzione == "I"} {
    if {$flag_ente == "P"} {
       element create $form_name cod_comune \
       -label   "Comune" \
       -widget   select \
       -datatype text \
       -html    "$disabled_fld {} class form_element" \
       -optional \
       -options [iter_selbox_from_comu]
    } else {
	element create $form_name cod_comune -widget hidden -datatype text -optional
	element create $form_name comune \
        -label   "Comune" \
        -widget   text \
        -datatype text \
        -html    "size 30 maxlength 50 $readonly_key {} class form_element" \
        -optional
    }
} else {
   element create $form_name comune \
   -label   "Comune" \
   -widget   text \
   -datatype text \
   -html    "size 30 maxlength 50 $readonly_key {} class form_element" \
   -optional
    
   element create $form_name cod_comune -widget hidden -datatype text -optional
}


element create $form_name descrizione \
-label   "Descrizione" \
-widget   text \
-datatype text \
-html    "size 50 maxlength 50 $readonly_fld {} class form_element" \
-optional

element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional

element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_urb  -widget hidden -datatype text -optional
element create $form_name last_cod_comune -widget hidden -datatype text -optional


if {[form is_request $form_name]} {
#ns_return 200 text/html "$cod_urb - $cod_comune - $funzione"; return
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name extra_par         -value $extra_par
    element set_properties $form_name last_cod_urb      -value $last_cod_urb
    element set_properties $form_name last_cod_comune   -value $last_cod_comune
    if {$funzione != "I"
    &&  $flag_ente == "C"
    } {
       element set_properties $form_name cod_comune     -value $cod_comu
    }


    if {$funzione == "I"} {

        if { $flag_ente == "C"} {
	     element set_properties $form_name cod_comune  -value $cod_comu
	     element set_properties $form_name comune      -value $desc_comune
	}

    } else {
      # leggo riga
        if {[db_0or1row sel_curb ""] == 0
        } {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name cod_urb       -value $cod_urb
        element set_properties $form_name cod_comune    -value $cod_comune
        element set_properties $form_name descrizione   -value $descrizione
	if {$funzione != "I"} {
           element set_properties $form_name comune     -value $comune
	}
    }

}


if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_urb     [element::get_value $form_name cod_urb]
    set cod_comune  [element::get_value $form_name cod_comune]
    set descrizione [element::get_value $form_name descrizione]
    if {$funzione != "I"} {
       set comune   [element::get_value $form_name comune]
    }


  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
        
        
        if {[string equal $cod_urb ""]} {
            element::set_error $form_name cod_urb "Inserire Codice"
            incr error_num
        }

        if {[string is space $cod_comune]} {
            element::set_error $form_name cod_comune "Inserire Comune"
            incr error_num
        }

        if {$funzione == "I"} {
            set where_cod ""
        } else {
            set where_cod " and cod_urb    <> :cod_urb
                            and cod_comune <> :cod_comune"
        }


	if {[string is space $descrizione]} {
            element::set_error $form_name descrizione "Inserire Descrizione"
            incr error_num
	} else {
	    # controllo univocita' descrizione
	    set descrizione [string toupper $descrizione]
	    if {[db_0or1row sel_curb_check_2 ""] == 1} {
                element::set_error $form_name descrizione "Descrizione gi&agrave; esistente"
                incr error_num
	    }
	} 
    }

    db_0or1row sel_aimp ""
    if {$funzione == "D"
     && $conta_aimp > 0} {
	element::set_error $form_name cod_urb "Il record che stai cercando di cancellare &egrave; collegato a degli impianti"
	incr error_num
    }
    
    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_curb_check ""] == 1} { 
       
      # controllo univocita'/protezione da double_click
        element::set_error $form_name cod_urb "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }
    
    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_curb]}
        M {set dml_sql [db_map upd_curb]}
        D {set dml_sql [db_map del_curb]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimcurb $dml_sql
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
        set last_cod_urb    $cod_urb
        set last_cod_comune $cod_comune
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_urb cod_comune last_cod_urb last_cod_comune nome_funz extra_par caller]

    switch $funzione {
        M {set return_url   "coimcurb-gest?funzione=V&$link_gest"}
        D {set return_url   "coimcurb-list?$link_list"}
        I {set return_url   "coimcurb-gest?funzione=V&$link_gest"}
        V {set return_url   "coimcurb-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
