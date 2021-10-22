ad_page_contract {	
    visualizza allegato	
} { 
	alle_id:integer	
}			
	
db_1row query "select * from coimallegati
                              where alle_id = :alle_id"
			      
    set dir "/var/lib/aolserver/iter-demo/packages/iter/www/spool/allegati"
    set file_name $dir/$tabella$codice
    
    ns_returnfile 200 image/jpeg $file_name
    ad_script_abort
}

return

