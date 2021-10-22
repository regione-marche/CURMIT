ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimdmsg" (visualizza messaggio ed aggiorna flag_letto)

    @author          Nicola Mortoni
    @creation-date   27/03/2014 (clonato da coimdmsg-gest)

    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @param           serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @param           serve se lista e' uno zoom che permetti aggiungi.

    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimdmsg-gest.tcl
} {
    {cod_dmsg          ""}
    {last_key_order_by ""}
    {funzione          "V"}
    {caller            "index"}
    {nome_funz         ""}
    {extra_par         ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Questo programma può essere chiamato solo in visualizzazione
if {$funzione ne "V"} {
    iter_return_complaint "Funzione $funzione non ammessa"
}

# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_dmsg last_key_order_by nome_funz extra_par]

# Imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars last_key_order_by caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Messaggio Ricevuto"
set page_title       "Visualizzazione $titolo"

#if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz]
#} else {
#   set context_bar  [iter_context_bar \
#                         [list "javascript:window.close()" "Torna alla Gestione"] \
#                         [list coimdmsg-list?$link_list "Lista Messaggi inviati"] \
#                         "$page_title"]
#}


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimdmsg"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

form create $form_name \
-html    $onsubmit_cmd

element create $form_name ts_ins_edit \
    -label   "Data/Ora invio" \
    -widget   text \
    -datatype text \
    -html    "size 19 maxlength 19 readonly {} class form_element" \
    -optional

element create $form_name utente_ins \
    -label   "Mittente" \
    -widget   select \
    -datatype text \
    -html    "disabled {} class form_element" \
    -optional \
    -options [iter_selbox_from_table coimuten id_utente "coalesce(cognome)||' '||coalesce(nome)"]

element create $form_name oggetto \
    -label   "Oggetto" \
    -widget   text \
    -datatype text \
    -html    "size 100 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name messaggio \
    -label   "Messaggio" \
    -widget   textarea \
    -datatype text \
    -html    "cols 98 rows 14 $readonly_fld {} class form_element" \
    -optional

element create $form_name flag_letto \
    -label   "Letto" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{No N} {S&igrave; S}}

element create $form_name ts_lettura_edit \
    -label   "Data/Ora lettura" \
    -widget   text \
    -datatype text \
    -html    "size 19 maxlength 19 $readonly_fld {} class form_element" \
    -optional


element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name last_key_order_by -widget hidden -datatype text -optional
element create $form_name cod_dmsg      -widget hidden -datatype text -optional


if {[form is_request $form_name]} {
    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name extra_par     -value $extra_par
    element set_properties $form_name last_key_order_by -value $last_key_order_by
    element set_properties $form_name cod_dmsg      -value $cod_dmsg

    # leggo riga
    if {![db_0or1row query "
        select a.cod_dmsg
             , b.ts_ins 
             , to_char(b.ts_ins,'DD/MM/YYYY HH24:MI') as ts_ins_edit
             , b.utente_ins
             , b.oggetto
             , b.messaggio
             , a.flag_letto
             , to_char(a.ts_lettura,'DD/MM/YYYY HH24:MI') as ts_lettura_edit
             , a.ts_lettura
             , a.utente_dest
          from coimdmsg a
             , coimtmsg b
         where a.cod_dmsg =  :cod_dmsg
           and b.cod_tmsg = a.cod_tmsg
            "]
    } {
	iter_return_complaint "Record non trovato (cod_dmsg = $cod_dmsg)"
    }

    element set_properties $form_name ts_ins_edit     -value $ts_ins_edit
    element set_properties $form_name utente_ins      -value $utente_ins
    element set_properties $form_name oggetto         -value $oggetto
    element set_properties $form_name messaggio       -value $messaggio
    element set_properties $form_name flag_letto      -value $flag_letto
    element set_properties $form_name ts_lettura_edit -value $ts_lettura_edit

    # Quando si visualizza un messaggio dell'utente, devo aggiornare il relativo flag di lettura
    # In teoria questo programma viene chiamato solo per vedere i messaggi dell'utente corrente
    # ma per scrupolo faccio anche questa if:
    if {$utente_dest eq $id_utente
    &&  $flag_letto  eq "f"
    } {
	set flag_letto "t"

	db_1row query  "select current_timestamp as current_timestamp
                         from dual"

	set ts_lettura $current_timestamp

	with_catch error_msg {
	    db_transaction {

		db_dml query "
                update coimdmsg
                   set flag_letto = :flag_letto
                     , ts_lettura = :ts_lettura
                 where cod_dmsg   = :cod_dmsg"

	    }
	} {
	    iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
	}
    }
}


# Non gestisco il form is_valid perchè è abilitata solo la funzione di lettura
ad_return_template
