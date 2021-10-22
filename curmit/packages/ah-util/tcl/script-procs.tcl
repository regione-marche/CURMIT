ad_library {

    Procs to add, edit, and remove mis_script

    @author claudio.pasolini@comune.mantova.it
    @cvs-id $Id:

}

namespace eval mis {}
namespace eval mis::script {}

ad_proc -public mis::script::get {
    -item_id:required
    -array:required
} { 
    This proc retrieves a script
} {
    upvar 1 $array row
    db_1row script_select {
	select o.object_id as item_id, o.title, o.context_id as parent_id,
	       s.*
	from   mis_scripts s, acs_objects o 
       where   s.script_id = :item_id
       and     s.script_id = o.object_id
    } -column_array row
}

ad_proc -public mis::script::add {
    -title:required
    {-description ""}
    {-parent_id ""}
    {-creation_user ""}
    {-creation_ip ""}
    {-original_author ""}
    {-maintainer ""}
    {-is_active_p "t"}
    {-is_executable_p "t"}
} { 
    This proc adds a script
} {

    if {$creation_user eq ""} {
	set creation_user [ad_conn user_id]
    }
    if {$creation_ip eq ""} {
	set creation_ip [ad_conn peeraddr]
    }

    if {$parent_id eq ""} {
	# considero come parent il main site
	array set arr [site_node::get_from_url -url /]
	set parent_id $arr(package_id)
    }

    set package_id [ad_conn package_id]

    if {![db_0or1row check_doubles "
        select 1 
        from acs_objects
        where object_type = 'mis_script' and
              title       = :title
        limit 1"]} {

	set object_id [db_exec_plsql object_add "
	select acs_object__new(
	       null,                 -- object_id
	       'mis_script',         -- object type
	       now(),                -- creation_date
	       :creation_user,       -- creation_user
	       :creation_ip,         -- creation_ip
	       :parent_id,           -- context_id
	       't',                  -- security_inherit_p
               :title,               -- title
               :package_id           -- package_id
	       )"]

	db_dml script_add "
 	    insert into mis_scripts (
	        script_id, 
                description,
                original_author,
                maintainer,
                is_active_p,
                is_executable_p
            ) values (
                :object_id, 
                :description,
                :original_author,
                :maintainer,
                :is_active_p,
                :is_executable_p
            )
	"
    } else {
	#script già esistente
	set object_id 0
    }
    
    return $object_id
}

ad_proc -public mis::script::edit {
    -item_id:required
    {-title "omit"}
    {-description "omit"}
    {-parent_id "omit"}
    {-original_author "omit"}
    {-maintainer "omit"}
    {-is_active_p "omit"}
    {-is_executable_p "omit"}
} { 
    This proc edits a script. 
} {
   
    set package_id     [ad_conn package_id]
    set modifying_user [ad_conn user_id]
    set modifying_ip   [ad_conn peeraddr]

    mis::script::get -item_id $item_id -array script

    if {$title eq "omit"} {
	set title $script(title)
    }
    if {$description  eq "omit"} {
	set description $script(description)
    }    
    if {$parent_id eq "omit"} {
	set parent_id $script(parent_id)
    }
    if {$original_author eq "omit"} {
	set original_author $script(original_author)
    }
    if {$maintainer eq "omit"} {
	set maintainer $script(maintainer)
    }
    if {$is_active_p eq "omit"} {
	set is_active_p $script(is_active_p)
    }
    if {$is_executable_p eq "omit"} {
	set is_executable_p $script(is_executable_p)
    }


    db_transaction {

	db_dml script_update {
 	    update mis_scripts set
	        description     = :description,
	        original_author = :original_author,
	        maintainer      = :maintainer,
	        is_active_p     = :is_active_p,
	        is_executable_p = :is_executable_p
            where script_id = :item_id
	}

	db_dml script_edit_2 { 
	    update acs_objects set
	        title          = :title,
                context_id     = :parent_id,
	        last_modified  = current_timestamp,
	        modifying_user = :modifying_user,
	        modifying_ip   = :modifying_ip
	    where object_id = :item_id
	}

    }
}

ad_proc -public mis::script::delete {
    -item_id:required
} { 
    This proc deletes a script.
} {
    db_exec_plsql script_delete {
	select acs_object__delete(:item_id)
    }
}

ad_proc -public mis::script::new {
    path
} { 
    Wrapper procedure to create a script
} {

    set user_id [ad_conn user_id]

    # get script name (last part of the path)
    regexp {(/[^/]*$)} $path match name
    # strip name getting parent part
    regsub $name $path {} parent
    # get parent_id
    db_0or1row query "select object_id as parent_id 
                      from acs_objects
                      where object_type = 'mis_script' and
                      title = :parent"

        mis::script::add                    \
	  -title           $path               \
          -parent_id       $parent_id             \
          -original_author $user_id         \
          -maintainer      $user_id              \
          -is_active_p     t                    \
          -is_executable_p t

    return
}

ad_proc -public mis::script::drop {
    path
} { 
    Wrapper procedure to delete a script
} {

    set user_id [ad_conn user_id]

    # get script id 
    set script_id [db_string query "
        select object_id 
        from acs_objects
        where object_type = 'mis_script' and
              title       = :path" -default ""]

    if {$script_id eq ""} {
	ad_return_complaint 1 "Nome script $path errato o inesistente."
        ad_script_abort
    }

    # drop
    db_exec_plsql script_delete {
	select acs_object__delete(:script_id)
    }

    return
}
