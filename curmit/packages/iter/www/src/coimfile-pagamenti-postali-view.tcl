ad_page_contract {
    Visualizzazione  file oid
    @author          Nicola Mortoni (copiando da allegati-cari-view)
    @creation-date   17/10/2014

    @cvs-id          coimfile-pagamenti-postali-view
} {
    {funzione  "V"}
    {nome_funz ""}
    oid
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    #"I" {set lvl 2}
    #"M" {set lvl 3}
    #"D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

set file_name [iter_set_spool_dir]/$id_utente-coimfile-pagamenti-postali-view

if {$oid ne ""} {
    db_1row query "select lo_export(:oid,:file_name) as flag_export"
} else {
    # Nessun allegato da visualizzare
    iter_return_complaint "File non non trovato"
    return
}

set tipo_contenuto "text/plain"

ns_returnfile 200 $tipo_contenuto $file_name
ns_unlink $file_name
ad_script_abort
return
