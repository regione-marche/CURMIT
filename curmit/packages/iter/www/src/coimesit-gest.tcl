ad_page_contract {
    Delete           per tabella "coimesit"/"coimbatc"
    @author          Adhoc
    @creation-date   13/08/2004

    @param funzione  D=delete
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimesit-gest.tcl
} {
    cod_batc
    ctr
   {last_key  ""}
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
    "D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

set sw_esit "t"
if {[db_0or1row sel_esit {}] == 0} {
    # iter_return_complaint "Record non trovato"
    # in questo caso significa che c'e' solo il record di coimbatc
    # ma non di coimesit perche', ad esempio si e' interrotto!!!
    set sw_esit "f"
} else {
    if {$nom == "Esito provvisorio"} {
	iter_return_complaint "Non sono cancellabili Esiti provvisori."
    }
}

# Lancio la query di cancellazione
with_catch error_msg {
    db_transaction {
	if {$sw_esit == "t"} {
	    with_catch error_msg {
		ns_unlink $pat
	    } {
		##
	    }
	    db_dml del_esit {}
	}
	set ctr_esit [db_string sel_esit_count {}]
	if {$ctr_esit == 0} {
	    db_dml del_batc {}
	}
    }
} {
    iter_return_complaint "Spiacente, ma il DBMS ha restituito il
    seguente messaggio di errore <br><b>$error_msg</b><br>
    Contattare amministratore di sistema e comunicare il messaggio
    d'errore. Grazie."
}

set link_list [export_url_vars cod_batc last_key caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]
set return_url   "coimesit-list?$link_list"

ad_returnredirect $return_url
ad_script_abort
