ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimmail"
    @author          Luca Romitti
    @creation-date   30/03/2018

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimmail-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================

} {
    {id_mail            ""}
    {mittente           ""}
    {destinatario       ""}
    {cc                 ""}
    {oggetto            ""}
    {testo              ""}
    {allegato           ""}
    {last_id_mail       ""}
    {funzione          "V"}
    {caller             ""}
    {nome_funz          ""}
    {nome_funz_caller   ""}
    {extra_par          ""}
    {path_allegato      ""}
    {nome_file          ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars id_mail last_id_mail last_destinatario last_mittente nome_funz extra_par]

iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars id_mail last_id_mail last_destinatario last_mittente caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Mail"
set nodelete "F"
switch $funzione {
    V {set button_label "Torna alla Lista"
	set page_title   "Visualizzazione $titolo"}
}


if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz]
} else {
    set context_bar  [iter_context_bar \
			  [list "javascript:window.close()" "Home"] \
			  [list coimmail-list?$link_list "Lista Mail"] \
			  "$page_title"]
}

db_1row sel_aimp_count ""

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimmail"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
#switch $funzione {
#    "I" {set readonly_key \{\}
#        set readonly_fld \{\}
#        set disabled_fld \{\}
#    }
#    "M" {set readonly_fld \{\}
#        set disabled_fld \{\}
#    }
#}

form create $form_name \
-html    $onsubmit_cmd

element create $form_name mittente \
    -label   "Mittente" \
    -widget   inform \
    -datatype text \
    -html    "size 70 readonly {} class form_element" \
    -optional

element create $form_name destinatario \
    -label   "Destinatario" \
    -widget   inform \
    -datatype text \
    -html    "size 70 $disabled_fld {} class form_element" \
    -optional

element create $form_name copia_conoscenza \
    -label   "CC" \
    -widget   inform \
    -datatype text \
    -html    "size 70 $disabled_fld {} class form_element" \
    -optional

element create $form_name oggetto \
    -label   "Oggetto" \
    -widget   inform \
    -datatype text \
    -html    "size 70 $disabled_fld {} class form_element" \
    -optional

element create $form_name testo \
    -label   "Testo" \
    -widget   textarea \
    -datatype text \
    -html    "cols 70 rows 3 $disabled_fld {} class form_element" \
    -optional

element create $form_name link_allegato \
    -label   "Allegato" \
    -widget   inform \
    -datatype text \
    -html    "readonly {} class form_element" \
    -optional


element create $form_name funzione          -widget hidden -datatype text -optional
element create $form_name caller            -widget hidden -datatype text -optional
element create $form_name nome_funz         -widget hidden -datatype text -optional
element create $form_name extra_par         -widget hidden -datatype text -optional
element create $form_name submit            -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_id_mail      -widget hidden -datatype text -optional
element create $form_name last_destinatario -widget hidden -datatype text -optional
element create $form_name last_mittente     -widget hidden -datatype text -optional
element create $form_name id_mail           -widget hidden -datatype text -optional
element create $form_name nome_file_email -widget hidden -datatype text -optional
element create $form_name path_allegato     -widget hidden -datatype text -optional
if {[form is_request $form_name]} {

    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name extra_par         -value $extra_par
    element set_properties $form_name last_id_mail      -value $last_id_mail
    element set_properties $form_name last_destinatario -value $destinatario
    element set_properties $form_name id_mail           -value $id_mail
#    element set_properties $form_name path_allegato     -value $path_allegato

      # leggo riga
        if {[db_0or1row sel_mail ""] == 0
        } {
            iter_return_complaint "Record non trovato"
	}
    element set_properties $form_name mittente         -value $mittente
    element set_properties $form_name destinatario     -value $destinatario
    element set_properties $form_name copia_conoscenza -value $cc
    element set_properties $form_name oggetto          -value $oggetto
    element set_properties $form_name testo            -value $testo
    

    set path_allegato [db_string q "select allegato from coimmail where id_mail = :id_mail"]
    set link_allegato "<a href=\"$path_allegato\">$nome_file</a>"
    element set_properties $form_name link_allegato         -value $link_allegato
  
}
if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    set mittente           [element::get_value $form_name mittente]
    set destinatario       [element::get_value $form_name destinatario]
    set copia_conoscenza   [element::get_value $form_name copia_conoscenza]
    set oggetto            [element::get_value $form_name oggetto]
    set testo              [element::get_value $form_name testo]
    set link_allegato      [element::get_value $form_name link_allegato]
    # data corrente
    db_1row sel_dual_date ""

  # controlli standard su numeri e date, per Ins ed Upd
    
  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
               
                db_dml dml_coimmail $dml_sql
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
	}
    }

  # dopo l'inserimento posiziono la lista sul record inserito
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars id_mail last_id_mail last_destinatario last_mittente nome_funz extra_par caller]
    switch $funzione {
        V {set return_url   "coimmail-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
