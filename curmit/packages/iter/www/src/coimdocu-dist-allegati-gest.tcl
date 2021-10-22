ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimdocu"
    @author          daniele zanotto
    @creation-date   15/12/08

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimdocu-gest.tcl
} {
    {cod_documento      ""}
    {last_cod_documento ""}
    {funzione          "V"}
    {caller        "index"}
    {nome_funz          ""}
    {nome_funz_caller   ""}
    {extra_par          ""}
    {cod_impianto       ""}
    {url_aimp           ""}
    {url_list_aimp      ""}
    {cod_acts           ""}
    {last_cod_acts      ""}
    contenuto:trim,optional
    contenuto.tmpfile:tmpfile,optional
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

if {$funzione == "C"} {
    set func_c func-sel
} else {
    set func_c func-menu
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
    "A" {set lvl 1}
    "C" {set lvl 4}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set current_date      [iter_set_sysdate]

# Controllo se il Database e' Oracle o Postgres
set id_db     [iter_get_parameter database]

set file_name [iter_set_spool_dir]/$id_utente-coimdocu-dist-allegati-gest

# estraggo il tipo allegato
if {[db_0or1row sel_docu_tipo_contenuto ""] == 0
||  [string is space $tipo_contenuto]
} {
	return_complaint "Documento non trovato"
	return 
}

#se presente il path vado a visualizzare il file sul file system
if {[db_0or1row q "select path_file 
                            , tipo_contenuto
                         from coimdocu 
                        where cod_documento = :cod_documento
                          and path_file is not null"]} {#sim01
    

    set file_name $path_file
    set cancella_file "f"
} else {#sim01

if {$id_db == "postgres"} {
	db_0or1row       sel_docu_alle ""
} else {
	db_blob_get_file sel_docu_alle "" -file $file_name
}

};#sim01

    # scrivo su di un file l'allegato e poi lo spedisco al browser.
# se facessi la select, non va bene perche' per alcuni tipi mi da'
# un codice esadecimale, per altri (pdf) mi da' tutto il contenuto.
# Non andrebbe bene nemmeno per i pdf perche' non riuscirei a mandarli
# al browser

ns_returnfile 200 $tipo_contenuto $file_name
ns_unlink $file_name
ad_script_abort
return

