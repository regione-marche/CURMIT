ad_page_contract {
    visualizza allegato
} {
    tabella
    cod_dimp
}

set codice $cod_dimp

if {[db_0or1row query "select *
                         from coimallegati
                        where tabella = :tabella and codice = :codice"] ==  0} {
    ns_return 200 text/html "Nessun allegato alla tabella $tabella con codice interno $codice"
} else {
    #set pack_key  [iter_package_key]
    #append pack_dir "src/spool/allegati"

    #set dir $pack_dir
    set dir "[iter_set_spool_dir_url]/allegati"
    set file_name $dir/$tabella$codice

    ad_returnredirect $file_name
    ad_script_abort
}

return
