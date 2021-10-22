ad_page_contract {
    @author          Katia Coazzoli Adhoc
    @creation-date   23/03/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimstav-filter.tcl

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    rom01 13/07/2018  Ricevo e passo il filtro f_invio_comune.

    gab01 29/06/2018  Ricevo e passo i filtri flag_racc e flag_pres.

} {
    
   {funzione         "V"}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {id_stampa         ""}
   {flag_racc         ""}
   {flag_pres         ""}
   {f_invio_comune    ""}

   ls_cod_inco
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string equal $nome_funz_caller ""]} {
    set nome_funz_caller $nome_funz
}
iter_get_coimtgen
#set flag_viario $coimtgen(flag_viario)
#set flag_ente   $coimtgen(flag_ente)
#set sigla_prov  $coimtgen(sigla_prov)
set flag_avvisi $coimtgen(flag_avvisi)
#if {$flag_ente == "C"} {
#    set f_cod_comune $coimtgen(cod_comu)
#}



# Personalizzo la pagina
set button_label "Visualizza elenco avvisi" 
set page_title   "Selezione appuntamenti estratti per richiesta documentazione"
set context_bar  [iter_context_bar -nome_funz $nome_funz] 

set conta [db_string sel_cinc_count ""]
if {$conta == 0} {
    iter_return_complaint "Non ci sono campagne aperte"
}
if {$conta > 1} {
    iter_return_complaint "C'&egrave; pi&ugrave; di una campagna aperta"
}
if {$conta == 1} {
    if {[db_0or1row sel_cinc ""] == 0} {
	iter_return_complaint "Campagna non trovata"
    }
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimstav"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

form create $form_name \
-html    $onsubmit_cmd

element create $form_name id_stampa \
    -label   "Denominazione stampa" \
    -widget   select \
    -options  [iter_selbox_from_table coimstpm id_stampa descrizione] \
    -datatype text \
    -html    "class form_element" \
    -optional

element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name dummy       -widget hidden -datatype text -optional
element create $form_name ls_cod_inco -widget hidden -datatype text -optional
element create $form_name flag_racc   -widget hidden -datatype text -optional;#gab01
element create $form_name flag_pres   -widget hidden -datatype text -optional;#gab01
element create $form_name f_invio_comune -widget hidden -datatype text -optional;#rom01

if {[form is_request $form_name]} {
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name id_stampa        -value $id_stampa
    element set_properties $form_name ls_cod_inco      -value $ls_cod_inco
    element set_properties $form_name flag_racc        -value $flag_racc;#gab01
    element set_properties $form_name flag_pres        -value $flag_pres;#gab01
    element set_properties $form_name f_invio_comune   -value $f_invio_comune;#rom01
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set id_stampa         [element::get_value $form_name id_stampa]
    set ls_cod_inco       [element::get_value $form_name ls_cod_inco]
    set error_num 0
    
    if {[string is space $id_stampa]} {
	element::set_error $form_name id_stampa "Inserire la stampa desiderata"
	incr error_num
    }
    
    
    
    if {$error_num > 0} {
	ad_return_template
	return
    }
    #dpr74
    set nome_funz "stpm-da-app"
    #rom01 aggiunto nell'export_url_vars f_invio_comune
    #gab01 aggiunti nell'export_url_vars flag_racc e flag_pres
    set link_list [export_url_vars caller funzione nome_funz nome_funz_caller ls_cod_inco id_stampa flag_racc flag_pres f_invio_comune]
    
    set return_url "coimstpm-prnt-da-app?$link_list&flag_richiesta=S"
    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
