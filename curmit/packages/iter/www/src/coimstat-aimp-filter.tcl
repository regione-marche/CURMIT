ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimaimp"
    @author          Giulio Laurenzi
    @creation-date   02/09/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @cvs-id          coimstat-aimp-gest.tcl
} {
    {funzione        "I"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
}

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_batc nome_funz nome_funz_caller caller]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# imposto variabili usate nel programma:
set sysdate_edit [iter_edit_date [iter_set_sysdate]]

# imposto la directory degli permanenti ed il loro nome.
set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]

# imposto il nome dei file
set page_title  "Scarica statistiche impianti per applicazioni locali"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

set link_scar [export_url_vars nome_funz nome_funz_caller]

ad_return_template




