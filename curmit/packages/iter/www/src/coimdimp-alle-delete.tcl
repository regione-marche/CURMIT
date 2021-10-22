ad_page_contract {
    cancella allegato
} {
    tabella
    cod_dimp:integer
}


set dir      "[iter_set_spool_dir]/allegati"
set dir_canc "[iter_set_spool_dir]/allegaticancellati"

if {[db_0or1row sel_allv "select * from coimallegati where codice = :cod_dimp and tabella = :tabella"] == 0} {
    iter_return_complaint "Non risulta alcun documento scansionato allegato."
} else {
    set file_name $dir/$tabella$cod_dimp
    set file_name_canc $dir_canc/$tabella$cod_dimp

    db_dml query "delete from coimallegati where codice = :cod_dimp and tabella = :tabella"
#    file rename  $file_name $file_name_canc
    ns_rename  $file_name $file_name_canc
    ns_return 200 text/html "Allegato cancellato"
    ad_script_abort
}

return



