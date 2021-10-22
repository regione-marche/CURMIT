ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimtpin"
    @author          Luca Romitti
    @creation-date   05/04/2019

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimtpin-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================

} {
    
   {funzione        "I"}
   {caller      "index"}
   {nome_funz        ""}
   {nome_funz_caller ""}
   {extra_par        ""}
   {cod_manutentore  ""}
   {url_manu         ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}


switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars nome_funz nome_funz_caller extra_par caller cod_manutentore url_manu]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set link_list_script {[export_url_vars caller nome_funz_caller nome_funz cod_manutentore url_manu]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Tipologia Impianto"
set button_label "Conferma Inserimento"
set page_title   "Inserimento $titolo"

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

iter_get_coimtgen
set flag_ente        $coimtgen(flag_ente)
set sigla_prov       $coimtgen(sigla_prov)

if {[db_0or1row sel_manu ""] == 0} {
    iter_return_complaint "Ditta manutentrice non trovato"
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimtpin"
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


set cod_coimtpin_list [db_list q "
    select a.cod_coimtpin
      from coimtpin_manu a
         , coimtpin b
     where a.cod_coimtpin    = b.cod_coimtpin
       and a.cod_manutentore = :cod_manutentore"]

if {$cod_coimtpin_list ne ""} {
    set where_gia_presenti "where cod_coimtpin not in ([join $cod_coimtpin_list ,])"
} else {
    set where_gia_presenti "where cod_coimtpin is not null"
}

element create $form_name tipologia_impianto \
    -label   "tipologia_impianto" \
    -widget   select \
    -datatype text \
    -html    "$readonly_fld {} class form_element" \
    -options [iter_selbox_from_table_wherec coimtpin cod_coimtpin descrizione cod_coimtpin "$where_gia_presenti"]  \
    -optional

element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name cod_manutentore  -widget hidden -datatype text -optional
element create $form_name url_manu  -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"


if {[form is_request $form_name]} {

    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name extra_par     -value $extra_par
    element set_properties $form_name cod_manutentore      -value $cod_manutentore
    element set_properties $form_name url_manu      -value $url_manu
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
#    element set_properties $form_name tipologia_impianto value $tipologia_impinato
}

if {[form is_valid $form_name]} {
    set tipologia_impianto [element::get_value $form_name tipologia_impianto]

    # form valido dal punto di vista del templating system
    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    #se provano a selezionare un'abilitazione che possiedono gia' li blocco.
    if {[db_0or1row q "select 1 
                         from coimtpin_manu
                        where cod_coimtpin = :tipologia_impianto
                          and cod_manutentore = :cod_manutentore"] ==1} {
	element::set_error $form_name tipologia_impianto "Errore: &egrave; gi&agrave: presente un'abilitazione per questa Tipologia."
	incr error_num
    }
    if {$tipologia_impianto eq ""} {
	element::set_error $form_name tipologia_impianto "Selezionare una Tipologia" 
	incr error_num
    }
    if {$error_num > 0} {
        ad_return_template
        return
    }

    #tiro fuori il piu alto valore di maintainer_installations_id
    db_1row q "
        select coalesce(max(cod_coimtpin_manu),0) +1 as cod_coimtpin_manu
          from coimtpin_manu"
   set dml_sql [db_map ins_tpin]
    
    # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
	with_catch error_msg {
	    db_transaction {
                db_dml dml_coimtpin_manu $dml_sql
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

    # dopo l'inserimento posiziono la lista sul record inserito
    set link_list  [subst $link_list_script]
    set link_gest  [export_url_vars nome_funz nome_funz_caller extra_par caller cod_manutentore url_manu]
    set return_url "coimtpin-list?$link_list"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
