ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimaces"
    @author          Katia Coazzoli Adhoc
    @creation-date   20/05/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimaces-gest.tcl
} {
    
   {cod_aces          ""}
   {stato_01          ""}
   {url_coimaces_list ""}
   {last_cod_aces     ""}
   {funzione         "M"}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {extra_par         ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
# Se il programma e' 'delicato', mettere livello 5 (amministratore).

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_aces last_cod_aces nome_funz nome_funz_caller extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


# Personalizzo la pagina
set link_list_script {[export_url_vars stato_01]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Impianto proveniente dall'esterno"
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


#if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
#} else {
#    set context_bar  [iter_context_bar \
#                     [list "javascript:window.close()" "Torna alla Gestione"] \
#                     [list coimaces-list?$link_list "Lista Impianti provenienti dall'esterno"] \
#                     "$page_title"]
#}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimaces"
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

element create $form_name cod_aces \
-label   "cod_aces" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

element create $form_name cod_aces_est \
-label   "cod_aces_est" \
-widget   text \
-datatype text \
-html    "size 15 maxlength 15 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_acts \
-label   "cod_acts" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_combustibile \
-label   "cod_combustibile" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name url_coimaces_list  -widget hidden -datatype text -optional
element create $form_name stato_01  -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_aces -widget hidden -datatype text -optional

#recupero dati statistici nella testata
db_0or1row sel_acts ""

switch $stato_01 {
    "N" { }
    "E" {set ctr_invariati [expr $ctr_invariati - 1] 
	 set ctr_chiusi    [expr $ctr_chiusi + 1]}
    "I" {set ctr_invariati [expr $ctr_invariati - 1] 
	 set ctr_chiusi    [expr $ctr_chiusi + 1]}
    "D" {set ctr_da_analizzare [expr $ctr_da_analizzare - 1] 
	 set ctr_chiusi        [expr $ctr_chiusi + 1] }
    "S" { }
    "P" {set ctr_importati [expr $ctr_importati - 1] 
	 set ctr_chiusi    [expr $ctr_chiusi + 1] }
    default { }
}

set invariati      $ctr_invariati
set da_analizzare  $ctr_da_analizzare
set importati_aimp $ctr_importati
set chiusi_forzat  $ctr_chiusi
if {$da_analizzare == 0} {
    set stato_acts "C"
} else {
    set stato_acts "E"
}
set dml_upd_acts [db_map upd_acts]

    
set new_stato "S"
set dml_sql [db_map upd_aces]

# Lancio la query di manipolazione dati contenute in dml_sql
if {[info exists dml_sql]
 && [info exists dml_upd_acts]} {
    with_catch error_msg {
        db_transaction {
            db_dml dml_coimaces $dml_sql 
            db_dml dml_coimaces $dml_upd_acts
        }
    } {
        iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }
}

set link_list      [subst $link_list_script]
set link_gest      [export_url_vars cod_aces last_cod_aces nome_funz nome_funz_caller extra_par caller]

set return_url "$url_coimaces_list&$link_list"

ad_returnredirect $return_url
ad_script_abort

ad_return_template
