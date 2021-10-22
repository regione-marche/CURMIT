ad_page_contract {

    Creates automatically the scripts for all packages belonging to 'ALTER',
    i.e. mis-acct, mis-base, mis-bom, mis-purc, mis-sales, and mis-wh.

    @author Claudio Pasolini
    @cvs-id $Id: script-auto.tcl
} {
}

# recupero come parent dei packages il subsite gerarchicamente superiore
set site_id [site_node::closest_ancestor_package -node_id [ad_conn node_id] -package_key acs-subsite]

set user_id [ad_conn user_id]

set paths_list [list [ah::service_root]/packages/mis-acct/www [ah::service_root]/packages/mis-base/www [ah::service_root]/packages/mis-assets/www [ah::service_root]/packages/mis-purc/www [ah::service_root]/packages/mis-sales/www [ah::service_root]/packages/mis-wh/www]

set packages_list [list mis-acct mis-base mis-assets mis-purc mis-sales mis-wh]

db_transaction {

    foreach path $paths_list package $packages_list {

	# A list of directories that we still need to examine and the
	# corresponding parents.
	set dirs_to_examine [list $path]
        set parents         [list $site_id]

	# Perform a breadth-first search of the file tree. For each level,
	# examine dirs in $dirs_to_examine; if we encounter any directories,
	# add contained dirs to $new_dirs_to_examine (which will become
	# $dirs_to_examine in the next iteration).
        ns_log notice "\n ... processing path $path"
	while { [llength $dirs_to_examine] > 0 } {

	    set new_dirs_to_examine [list]
	    set new_parents         [list]

	    foreach dir $dirs_to_examine parent_id $parents {

                ns_log notice "\n ... processing dir $dir with parent=$parent_id"
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

                ns_log notice "\n ... creata cartella $title con id=$folder_id e parent=$parent_id"		
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
                    ns_log notice "\n ... creato script $title con parent_id=$folder_id"	
		}

                # check for subdir
		foreach newdir [glob -types d -nocomplain "$dir/*"] {
		    if {[regexp {CVS$|lib$|sql$|tcl$|admin$|doc$|resources$|tmp$|outseq$|to-be-checked$} $newdir]} {
		        # discard these directories
		        continue
		    } else {
                        ns_log notice "\n ... aggiunta cartella $newdir con parent $parent_id alla lista da elaborare"
		        lappend new_dirs_to_examine $newdir
			lappend new_parents         $folder_id
		    }
		}
	    }

	    set dirs_to_examine $new_dirs_to_examine
            set parents         $new_parents
            ns_log notice "\n ... Restano da elaborare le cartelle $dirs_to_examine"
	}
    }

} on_error {
    ah::transaction_error
}

ns_return 200 text/html "Scripts creati correttamente"
return
