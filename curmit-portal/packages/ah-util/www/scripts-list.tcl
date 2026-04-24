ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: script-list.tcl
} {

    {search_script_name ""}
    {search_package ""}
    is_active_p:optional
    is_executable_p:optional
    {rows_per_page 30}
    {offset 0}
    orderby:optional
}

# considero come parent il main site
array set arr [site_node::get_from_url -url /]
set parent_id $arr(package_id)

# creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{search_script_name:text,optional
	    {label {Cerca nome script}}
	    {html {length 20} }
	    {value $search_script_name}
	}
	{search_package:text(select),optional
	    {label {Scegli Package}}
  	    {options {{Scegli ""} [db_list_of_lists query {
               select title, object_id
               from   acs_objects o, mis_scripts s
               where  o.object_id  = s.script_id and
		      o.context_id = :parent_id}]}}         
	    {value $search_package}
	}
    } -on_request {
	set search_package_clause ""
    } -on_submit { 
	set errnum 0
        
        if {$search_package ne ""} {
	    set search_package_clause "and o1.tree_sortkey between acs_objects_get_tree_sortkey(:search_package) and tree_right(acs_objects_get_tree_sortkey(:search_package))"
	} else {
	    set search_package_clause ""
	}

	if {$errnum > 0} {
	    break
	} else {

	    # per evitare errori nell'esecuzione della query la eseguirò solo se 'errnum' non esiste
	    unset errnum	 
	    
	    # imposto flag per sapere se il form è stato inviato
	    set submit_p 1
	}

	# recupero l'impostazione dei filtri non compresi nel form
	ah::set_list_filters ah-util scripts-list

    }

set page_title "Lista scripts"
set context [list "Lista scripts"]

# prepare actions buttons
set actions { "Nuovo script" script-add-edit "Aggiunge un nuovo script" }
source [ah::package_root -package_key ah-util]/paging-buttons.tcl

template::list::create \
    -name scripts \
    -multirow scripts \
    -actions $actions \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" width="16" height="16" border="0">}
	    link_html {title "Modifica script"}
	    sub_class narrow
	}
	item_id {
	    label "Id"
	}
	title {
	    label "Nome"
	}
	description {
	    label "Descrizione"
	}
	parent_script {
	    label "Parent script"
	}
	permission {
	    link_url_col permission_url 
            link_html {title "Gestisci i permessi di questo script"}
	    display_template {Permessi}
	}
	add_script {
	    display_template {<if @scripts.is_executable_p@ false><a href="@scripts.add_url@" title="Aggiungi un nuovo script a questa cartella" >Nuovo Script</a></if><else> </else>}
	}
	delete {
	    link_url_col delete_url 
            link_html {title "Cancella questo script" onClick "return(confirm('Confermi la cancellazione?'));"}
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	    sub_class narrow
	}
    } \
    -orderby {
        default_value title,asc
        title {
	    label "Nome"
	    orderby title
	}
        item_id {
	    label "Id"
	    orderby item_id
	}

    } \
    -filters {
        search_script_name {
            hide_p 1
	    where_clause {upper(o1.title) like upper('%$search_script_name%')}
        }
        search_package {
            hide_p 1
        }
        is_active_p {
	    label "Attivo?"
  	    values {{Attivo t} {Inattivo f}}
	    where_clause {is_active_p = :is_active_p}
        }
        is_executable_p {
	    label "Eseguibile?"
  	    values {{Eseguibile t} {"Non eseguibile" f}}
	    where_clause {is_executable_p = :is_executable_p}
        }
        rows_per_page {
	    label "Righe per pagina"
  	    values {{10 10} {30 30} {100 100} {Tutte 9999}}
	    where_clause {1 = 1}
            default_value 30
        }
    } 

set sql "
	select o1.object_id,
               o1.object_id as item_id, 
               s.description, 
               o2.title as parent_script, 
               o1.title, 
               s.is_active_p, 
               s.is_executable_p, 
               s.original_author, 
               s.maintainer
        from   mis_scripts s, acs_objects o1, acs_objects o2
        where  s.script_id   = o1.object_id and
               o1.context_id = o2.object_id
        [template::list::filter_where_clauses -name scripts -and]
        $search_package_clause
        [template::list::orderby_clause -name scripts -orderby]
        limit $rows_per_page
        offset $offset"

#ns_log notice "\n$sql"

# eseguo la query solo in assenza di errori nei filtri del form
if {![info exists errnum]} {
    db_multirow -extend {edit_url add_url delete_url permission_url} scripts scripts_select $sql {
	set edit_url [export_vars -base "script-add-edit" {item_id}]
	set add_url [export_vars -base "script-add-edit" {{parent_id $item_id}}]
	set delete_url [export_vars -base "script-delete" {item_id}]
	set permission_url [export_vars -base "permissions/one" {object_id}]
    }
} else {
    # creo una multirow fittizia 
    template::multirow create scripts dummy
}
if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property ah-util scripts-list [export_vars -entire_form -no_empty]
}



