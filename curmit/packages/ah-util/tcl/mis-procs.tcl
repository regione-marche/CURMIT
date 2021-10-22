ad_library {

    Various Procs.

    @author claudio.pasolini@comune.mantova.it
    @cvs-id $Id:

}

namespace eval mis {}


ad_proc -public mis::subsite_group_list  {
    -url:required 
} { 
    Returns the list of groups belonging to the given subsite

    @param url The url of the subsite e.g. /intranet
} {

    # trovo il subsite 
    array set arr [site_node::get_from_url -url ${url}/]
    set context_id $arr(package_id)

    # ottengo il gruppo a cui appartengono, con relazione di
    # composizione, tutti gli altri gruppi 
    set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]

    return [db_list query "
    select object_id_two
    from acs_rels
    where rel_type      = 'composition_rel' and
          object_id_one = :subsite_group_id"]
}

ad_proc -public mis::user_group {
    -user_id:required
} {
    Restituisce il gruppo di cui l'utente fa parte.
    N.B. Un utente DEVE appartenere ad uno ed un solo gruppo 
} {
    # get group_id of the user
    set group_list [mis::subsite_group_list -url ""]
    set group_list [join $group_list ,]

    return [db_string query "
           select object_id_one
           from acs_rels
           where object_id_two = :user_id and
                 object_id_one in($group_list)" -default ""]
}

ad_proc -public mis::user_group_name {
    -user_id:required
} {
    Restituisce il nome del gruppo di cui l'utente fa parte.
    N.B. Un utente DEVE appartenere ad uno ed un solo gruppo 
} {
    # get group_id of the user
    set group_list [mis::subsite_group_list -url ""]
    set group_list [join $group_list ,]

    return [db_string query "
           select g.group_name
           from acs_rels r, groups g
           where r.object_id_two = :user_id 
             and r.object_id_one in($group_list)
             and g.group_id      = r.object_id_one
           " -default ""]
}

ad_proc -public mis::group_explode {
    -parent_id:required 
    {-level "0"} 
    -multirow:required 

} {
    @param parent_id         The group to explode
    @param level             The depth level of this item in the structure
    @param multirow          The name of a multirow data structure to fill. 
                             Note that this param is passed by reference and
                             upvared in the caller scope.
} {
    upvar 1 $multirow groups
    incr level

    if {$level > [parameter::get -parameter max_bom_level]} {
	ad_return_complaint 1 "
        E' stato superato il massimo livello consentito = [parameter::get -parameter max_bom_level] nella struttura:
        probabilmente è stato creato un loop, che deve essere rimosso
        utilizzando l'esplosione a livello singolo."
	return 0
    }

    if {$level > 1} {
        set groups_list [db_list_of_lists query "
        select r.object_id_two,  
               repeat('.', $level * 4) || g.group_name,
               p.email
        from  acs_rels r, groups g, parties p
        where  r.object_id_one = :parent_id and
               r.rel_type      = 'composition_rel' and
               g.group_id      = r.object_id_two and
               p.party_id      = g.group_id
        order by g.group_name"]
    } else {
        set groups_list [db_list_of_lists query "
        select :parent_id,  
               g.group_name,
               p.email
        from  groups g, parties p
        where  g.group_id = :parent_id
          and  p.party_id = g.group_id
        order by g.group_name"]
    }

    db_release_unused_handles

    foreach group $groups_list {

	# decode the list
        util_unlist $group child_id child_name email

	set edit_url      [export_vars -base "group-add-edit" {{group_id $child_id}}]
	set explode_url   [export_vars -base "groups-hierarchy" {{parent_id $child_id}}]
	set members_url   [export_vars -base "group-members-list" {{group_id $child_id}}]
	set add_group_url [export_vars -base "group-add-edit" {{parent_id $child_id}}]
	
	template::multirow append groups $edit_url $explode_url $level $child_name $email $members_url $add_group_url $child_id

        # call recursively 
	group_explode \
            -parent_id         $child_id \
            -level             $level \
            -multirow          multirow
    }

}

ad_proc -private mis::create_scripts_one_package {
    -package_key:required
} { 

    Creates automatically the scripts for one package.

} {

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
		    if {[regexp {CVS$|lib$|sql$|tcl$|admin$|doc$|resources$|tmp$|outseq$|to-be-checked$} $newdir]} {
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
