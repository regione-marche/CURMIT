ad_page_contract {
    
    @author          Paolo Formizzi
    @creation-date   09/05/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimprvv-docu.tcl
} {
   {cod_prvv         ""}
   {funzione        "V"}
   {caller      "index"}
   {nome_funz        ""}
   {nome_funz_caller ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

 set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

if {[db_0or1row sel_prvv ""] == 0} {
    iter_return_complaint "Provvedimento non trovato"
}

# Controllo se il Database e' Oracle o Postgres
set id_db     [iter_get_parameter database]

set file_name [iter_set_spool_dir]/$id_utente-coimprvv-docu

# estraggo il tipo allegato
if {$id_db == "postgres"} {
    if {[db_0or1row sel_docu ""] == 0
        ||  [string is space $tipo_allegato]} {
	iter_return_complaint "Documento non trovato"
	return 
    }
} else {
    if {[db_0or1row sel_docu ""] == 0
	||  [string is space $tipo_allegato]} {
        iter_return_complaint "Documento non trovato"
        return 
    }

    db_blob_get_file sel_docu_2 "" -file $file_name

}

# scrivo su di un file l'allegato e poi lo spedisco al browser.
# se facessi la select, non va bene perche' per alcuni tipi mi da'
# un codice esadecimale, per altri (pdf) mi da' tutto il contenuto.
# Non andrebbe bene nemmeno per i pdf perche' non riuscirei a mandarli
# al browser

ns_returnfile 200 $tipo_allegato $file_name
ns_unlink $file_name
ad_script_abort
return
