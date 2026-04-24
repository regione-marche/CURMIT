ad_page_contract {

    Crea automaticamente gli scripts del package 'iter'

    @author Claudio Pasolini
    @cvs-id $Id: script-auto.tcl
} {
}


proc create_iter_scripts {package_key} { 

    # considero come parent dei packages il main site
    array set arr [site_node::get_from_url -url /]
    set site_id $arr(package_id)

    set user_id [ad_conn user_id]

    set path    [ah::service_root]/packages/${package_key}/www
    set package $package_key

    db_transaction {

	# A list of directories that we still need to examine and the
	# corresponding parents.
	set dirs_to_examine [list $path]
        set parents         [list $site_id]

	# Perform a first search of the file tree. For each level,
	# examine dirs in $dirs_to_examine; if we encounter any directories,
	# add contained dirs to $new_dirs_to_examine (which will become
	# $dirs_to_examine in the next iteration).

        #ns_log notice "\n ... processing path $path"
	while { [llength $dirs_to_examine] > 0 } {

	    set new_dirs_to_examine [list]
	    set new_parents         [list]

	    foreach dir $dirs_to_examine parent_id $parents {

                #ns_log notice "\n ... processing dir $dir with parent=$parent_id"

		# Insert the directory as a folder object and
		# add its subdir to our list of dirs to examine next time.
		# elimino tutto fino a www
		regsub .*$package/www $dir {} tail
		# costruisco il nome dello script prefissandolo con il
		# nome del package
		set title $package$tail

		# Inserisco nuova cartella 
		set folder_id [mis::script::add                      \
				   -title           $title           \
				   -parent_id       $parent_id       \
				   -original_author $user_id         \
				   -maintainer      $user_id         \
				   -is_active_p     t                \
				   -is_executable_p f]

                #ns_log notice "\n ... creata cartella $title con id=$folder_id e parent=$parent_id"		
		# inserisco immediatamente i file tcl della cartella
		foreach file [glob -nocomplain "$dir/*tcl"] { 

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

                    #ns_log notice "\n ... creato script $title con parent_id=$folder_id"	
		}

                # check for subdir
		foreach newdir [glob -types d -nocomplain "$dir/*"] {
		    if {[regexp {CVS$|lib$|sql$|tcl$|logo$|permanenti$|resources$|tmp$|docu_dump$|javascript$|spool$|src-old$|PAV$|PVA$|una-tantum$} $newdir]} {
		        # discard these directories
		        continue
		    } else {
                        #ns_log notice "\n ... aggiunta cartella $newdir con parent $parent_id alla lista da elaborare"
		        lappend new_dirs_to_examine $newdir
			lappend new_parents         $folder_id
		    }
		}
	    }

	    set dirs_to_examine $new_dirs_to_examine
            set parents         $new_parents

            #ns_log notice "\n ... Restano da elaborare le cartelle $dirs_to_examine"
	}


    } on_error {
	ah::transaction_error
    }

}

create_iter_scripts iter

ns_return 200 text/html "Scripts creati correttamente"
return
