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
} {
    
    cod_dimp
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {last_cod_dimp ""}
   {cod_impianto ""}
   {url_aimp     ""}
   {url_list_aimp ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}

# Controlla lo user

#switch $funzione {
#    "V" {set lvl 1}
#    "I" {set lvl 2}
#    "M" {set lvl 3}
#    "D" {set lvl 4}
#}

#set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]



iter_get_coimtgen
set flag_ente    $coimtgen(flag_ente)
set denom_comune $coimtgen(denom_comune)
set sigla_prov   $coimtgen(sigla_prov)
set link         [export_ns_set_vars "url"]
#set link2    "\[export_url_vars cod_dimp cod_impianto url_list_aimp url_aimp last_cod_dimp nome_funz nome_funz_caller extra_par \]"

db_1row query "select gen_prog as gen_prog_old, cod_impianto from coimdimp where cod_dimp = :cod_dimp"
set page_title   "Cambia Generatore"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

set buttons [list "Aggiorna"]

# NOTE form name must not contains '-' or JavaScript gets confused
ad_form -name addedit \
        -edit_buttons $buttons \
        -export {cod_dimp cod_impianto url_list_aimp url_aimp last_cod_dimp nome_funz nome_funz_caller extra_par} \
        -has_edit 1 \
    -form {

	{gen_prog_new:text(select)
	    {options { [db_list_of_lists query "
            select gen_prog, gen_prog from coimgend where cod_impianto = :cod_impianto and gen_prog <> :gen_prog_old"] }}
	    {label {Nuovo Generatore}}
	}

    } -on_submit {

        set errnum 0

        if {$errnum > 0} {
            break
        }
        db_transaction {
            db_dml query "update coimdimp set gen_prog = :gen_prog_new where cod_dimp = :cod_dimp"
        }

    } -after_submit {

	#set link2    "\[export_url_vars cod_dimp cod_impianto url_list_aimp url_aimp last_cod_dimp nome_funz nome_funz_caller extra_par \]"
	ad_returnredirect "coimdimp-list?$link"
	
	ad_script_abort
    }



