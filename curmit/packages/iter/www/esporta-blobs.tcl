ad_page_contract {
} {
}

set name_istanza [db_get_database]
ns_log notice "inizio esporta-blobs.tcl $name_istanza" 

set numalle 0
db_foreach q "select cod_documento
                   , contenuto
               from coimdocu
               where contenuto is not null
--                 and cod_documento = '11761'
" {

    set path_file_db "/var/lib/ns/allegati-$name_istanza/$cod_documento"

#    exec mkdir "/var/lib/ns/allegati-$name_istanza"
    
    set path_file "/var/lib/ns/$name_istanza/packages/iter/www/permanenti/allegati-$name_istanza/$cod_documento"
    
    set export_ok [db_string q "select lo_export($contenuto, '$path_file_db')"]
    
    if {$export_ok ==1} {
	db_dml q "update coimdocu set path_file=:path_file where cod_documento=:cod_documento"
	incr numalle
    }
    
}
ns_log notice "fine esporta-blobs.tcl $name_istanza"
ns_return 200 text/html "allegati esportati $numalle"
