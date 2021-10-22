ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimmode"
    @author          Nicola Mortoni (clonato da coimopma-gest)
    @creation-date   19/03/2014

    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz_caller identifica l'entrata di menu, serve per la navigation bar

    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimmode-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    nic01 27/07/2015 Il Comune di Rimini ha chiesto che l'ordinamento non sia piu' per
    nic01            descrizione + codice ma per descrizione + flag_attivo + codice.
    nic01            Prima vuole gli attivi 'S', poi i non attivi 'N' e poi gli altri.
} {
   {cod_mode          ""}
   {last_key_order_by ""}
   {funzione          "V"}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {extra_par         ""}

   {cod_cost          ""}
   {url_cost          ""}

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

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set link_gest [export_url_vars cod_mode last_key_order_by nome_funz nome_funz_caller extra_par caller cod_cost url_cost]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars last_key_order_by caller nome_funz_caller nome_funz cod_cost url_cost]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]

if {![db_0or1row query "select descr_cost
                          from coimcost
                         where cod_cost = :cod_cost"]
} {
    iter_return_complaint "Costruttore non trovato"
}

set titolo              "Modello del costruttore $descr_cost"
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
set vieta_delete        "f"

#if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
#} else {
#    set context_bar  [iter_context_bar \
#                     [list "javascript:window.close()" "Torna alla Gestione"] \
#                     [list coimmode-list?$link_list "Lista Modelli"] \
#                     "$page_title"]
#}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimmode"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
    "I" {
	set readonly_key \{\}
	set readonly_fld \{\}
	set disabled_fld \{\}
    }
    "M" {
	set readonly_fld \{\}
        set disabled_fld \{\}
    }
}

form create $form_name \
-html    $onsubmit_cmd

element create $form_name descr_mode \
    -label   "Descrizione" \
    -widget   text \
    -datatype text \
    -html    "size 30 maxlength 30 $readonly_fld {} class form_element" \
    -optional

element create $form_name flag_attivo \
    -label   "Attivo" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{Sì S} {No N}}

element create $form_name note \
    -label   "Note" \
    -widget   textarea \
    -datatype text \
    -html    "cols 80 rows 3 $readonly_fld {} class form_element" \
    -optional

element create $form_name funzione          -widget hidden -datatype text -optional
element create $form_name caller            -widget hidden -datatype text -optional
element create $form_name nome_funz         -widget hidden -datatype text -optional
element create $form_name nome_funz_caller  -widget hidden -datatype text -optional
element create $form_name extra_par         -widget hidden -datatype text -optional
element create $form_name submit            -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_key_order_by -widget hidden -datatype text -optional

element create $form_name cod_mode          -widget hidden -datatype text -optional
element create $form_name cod_cost          -widget hidden -datatype text -optional
element create $form_name url_cost          -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name nome_funz_caller  -value $nome_funz_caller
    element set_properties $form_name extra_par         -value $extra_par
    element set_properties $form_name last_key_order_by -value $last_key_order_by
    element set_properties $form_name cod_cost          -value $cod_cost
    element set_properties $form_name url_cost          -value $url_cost

    if {$funzione == "I"} {
        
    } else {
      # leggo riga
        if {![db_0or1row query "
            select descr_mode
                 , flag_attivo
                 , note
              from coimmode
             where cod_mode = :cod_mode
            "]
	} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name cod_mode       -value $cod_mode
        element set_properties $form_name descr_mode     -value $descr_mode
        element set_properties $form_name flag_attivo    -value $flag_attivo
        element set_properties $form_name note           -value $note

	if {$funzione == "D"} {
	    if {[db_0or1row query "
                select 1
                  from coimgend
                 where cod_mode = :cod_mode
                 limit 1
                "]
	    } {
		set vieta_delete "t"
		element::set_error $form_name descr_mode "Impossibile cancellare: Modello collegato ad uno o più generatori"
	    }
	}
    }
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system

    set descr_mode  [string trim [element::get_value $form_name descr_mode]]
    set flag_attivo [string trim [element::get_value $form_name flag_attivo]]
    set note        [string trim [element::get_value $form_name note]]

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {[string equal $descr_mode ""]} {
            element::set_error $form_name descr_mode "Inserire Descrizione"
            incr error_num
        } else {

	    if {$funzione  == "I"} {
		set and_cod_mode ""
	    } else {
		set and_cod_mode " and cod_mode <> :cod_mode"
	    }

	    if {[db_0or1row query "
                select 1
                  from coimmode
                 where cod_cost          = :cod_cost
                   and upper(descr_mode) = upper(:descr_mode)
                  $and_cod_mode
                 limit 1"]
	    } {
		# controllo univocita'/protezione da double_click
		element::set_error $form_name descr_mode "La descrizione che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
		incr error_num
	    }
	}
    }


    if {$error_num > 0} {
        ad_return_template
        return
    }

    with_catch error_msg {
	db_transaction {
	    if {$funzione eq "I"} {
		db_1row query "select coalesce(max(cod_mode),0) + 1 as cod_mode
                                 from coimmode"
		set data_ins   [iter_set_sysdate]
		set utente_ins $id_utente
		set data_mod   ""
		set utente_mod ""

		db_dml query "
                insert
                  into coimmode
                     ( cod_mode
                     , descr_mode
                     , cod_cost
                     , flag_attivo
                     , note
                     , data_ins
                     , utente_ins
                     , data_mod
                     , utente_mod
                     )
              values (:cod_mode
                     ,:descr_mode
                     ,:cod_cost
                     ,:flag_attivo
                     ,:note
                     ,:data_ins
                     ,:utente_ins
                     ,:data_mod
                     ,:utente_mod
                     )"
	    }

	    if {$funzione eq "M"} {
		set data_mod   [iter_set_sysdate]
		set utente_mod $id_utente

		db_dml query "
                update coimmode
                   set descr_mode  = :descr_mode
                     , flag_attivo = :flag_attivo
                     , note        = :note
                     , data_mod    = :data_mod
                     , utente_mod  = :utente_mod
                 where cod_mode    = :cod_mode"

		# Visto che in alcuni programmi si usa coimgend.modello o modello_bruc,
		# Se cambia la descrizione, aggiorno anche tali campi
		db_dml query "
                update coimgend
                   set modello       = :descr_mode
                 where cod_mode      = :cod_mode"

		db_dml query "
                update coimgend
                   set modello_bruc  = :descr_mode
                 where cod_mode_bruc = :cod_mode"

	    }

	    if {$funzione eq "D"} {
		db_dml query "
                delete
                  from coimmode
                 where cod_mode    = :cod_mode"
	    }
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }

    # Dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione == "I"} {
	# Non devo fare nessuna forzatura sul flag_attivo perchè dopo l'inserimento può
	# valere solo 'S' o 'N'.
        #nic01 set last_key_order_by [list $descr_mode $cod_mode]
        set last_key_order_by        [list $flag_attivo $descr_mode $cod_mode];#nic01
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_mode last_key_order_by nome_funz nome_funz_caller extra_par caller cod_cost url_cost]
    switch $funzione {
        M {set return_url   "coimmode-gest?funzione=V&$link_gest"}
        D {set return_url   "coimmode-list?$link_list"}
        I {set return_url   "coimmode-gest?funzione=V&$link_gest"}
        V {set return_url   "coimmode-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
