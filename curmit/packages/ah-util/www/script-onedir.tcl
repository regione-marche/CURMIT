ad_page_contract {

    Crea gli script partendo da una cartella (il cui script deve già esistere).

    @author Claudio Pasolini
    @cvs-id $Id: script-onedir.tcl
} {

}

#######
set package mis-acct
set path    [ah::service_root]/packages/mis-acct/www/vendors
######

set user_id [ad_conn user_id]

regsub .*$package/www $path {} folder
set folder_id [db_string query "select object_id from acs_objects where object_type = 'mis_script' and title = '$package$folder'"]

db_transaction {

    # inserisco immediatamente i file tcl della cartella
    foreach file [glob -nocomplain "$path/*tcl"] { 

	# elimino tutto fino a www
	regsub .*$package/www $file {} tail
	# elimino .tcl
	regsub {\.tcl} $tail {} tail
	# costruisco il nome dello script prefissandolo con il
	# nome del package
	set title $package$tail

	mis::script::add                      \
	    -title           $title           \
	    -parent_id       $folder_id       \
	    -original_author $user_id         \
	    -maintainer      $user_id         \
	    -is_active_p     t                \
	    -is_executable_p t
	ns_log notice "\n ... creato script $title con parent_id=$folder_id"	
    }

} on_error {
    ah::transaction_error
}

ns_return 200 text/html "Scripts creati correttamente"
return
