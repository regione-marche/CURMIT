ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimcimp"
    @author          Adhoc
    @creation-date   03/05/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimcimp-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom01 21/10/2020 Su segnalazione di Salerno modificato page_title per renderlo
    rom01            uguale al nome del menu', Sandro ha detto che va bene per tutti.

} {

    {cod_dimp         ""}
    {funzione        "M"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {extra_par        ""}
    {cod_impianto     ""}
    {url_aimp         ""}
    {url_list_aimp    ""}
    {gen_prog         ""}
    {flag_cimp        ""}
    {extra_par_inco   ""}
    {cod_inco         ""}
    {flag_inco        ""}
    {flag_tracciato   ""}
    {mode "edit"}

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

#set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]


iter_get_coimtgen
set flag_ente    $coimtgen(flag_ente)
set denom_comune $coimtgen(denom_comune)
set sigla_prov   $coimtgen(sigla_prov)
set link         [export_ns_set_vars "url"]

#rom01set page_title   "Sposta Dichiarazione su altro impianto"
set page_title   "Spostamento RCEE";#rom01
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

set buttons [list "Aggiorna"]

# NOTE form name must not contains '-' or JavaScript gets confused
ad_form -name addedit \
        -edit_buttons $buttons \
        -has_edit 1 \
    -form {

	{cod_dimp:text
	    {label {Codice Dichiarazione}}
	    {html {length 20} }
	}
	{cod_imp_dest:text
	    {label {Codice Impianto Destinazione}}
	    {html {length 20} }
	}
    } -on_submit {

	set errnum 0
	
 	if {![db_0or1row query "select 1 from coimdimp where cod_dimp = :cod_dimp"]} {
            template::form::set_error addedit cod_dimp "Dichiarazione inesistente."
            incr errnum
        }
 	if {![db_0or1row query "select cod_impianto from coimaimp where cod_impianto_est = :cod_imp_dest"]} {
            template::form::set_error addedit cod_imp_dest "Impianto inesistente."
            incr errnum
        }
	if {$errnum > 0} {
	    break
	}
	db_transaction {
	    db_dml query "update coimdimp set cod_impianto = :cod_impianto where cod_dimp = :cod_dimp"
	}

      } -after_submit {

	  ad_returnredirect "coimdimp-dest"
	  
	  ad_script_abort
      }
