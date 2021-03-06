ad_page_contract {

    @author Serena Saccani
    @cvs-id $Id: sources.tcl

} {

    {rows_per_page 30}
    {offset 0}
    {search_word ""}
    orderby:optional
}

ah::script_init -script_name wallet/sources-list

# Creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{search_word:text,optional
	    {label {Cerca Provenienza}}
	    {html  {length 20} }
	    {value $search_word}
	}
    } -on_request {

    } -on_submit { 
	
	set errnum 0
	if {$errnum > 0} {
	    break
	} else {

	    # per evitare errori nell'esecuzione della query la eseguirò solo se 'errnum' non esiste
	    unset errnum	 
	    
	    # imposto flag per sapere se il form è stato inviato
	    set submit_p 1
	}

	# recupero l'impostazione dei filtri non compresi nel form
	ah::set_list_filters wallet sources-list
    }

set page_title "Lista Provenienze"
set context [list "Lista Provenienze"]

# prepare actions buttons
set actions {
    "Nuova Provenienza" source-add-edit "Crea una nuova Provenienza"
}

source [ah::package_root -package_key ah-util]/paging-buttons.tcl

template::list::create \
    -name sources \
    -multirow sources \
    -actions $actions \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" width="16" height="16" border="0">}
	    link_html {title "Modifica Provenienza"}
	    sub_class narrow
	}
	source_name {
	    label "Provenienza"
	}
	delete {
	    link_url_col delete_url 
            link_html {title "Cancella Provenienza" onClick "return(confirm('Confermi la cancellazione?'));"}
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	    sub_class narrow
	}
    } \
    -orderby {
        default_value source_name
        source_name {
	    label "Provenienza"
	    orderby_desc "source_name desc"
	    orderby_asc  "source_name"
	}

    } \
    -filters {
	search_word {
	    hide_p 1
	    where_clause {upper(source_name) like upper('%$search_word%')}	    
	}

        rows_per_page {
	    label "Righe per pagina"
  	    values {{10 10} {30 30} {100 100}}
	    where_clause {1 = 1}
            default_value 30
        }
    } 


# Eseguo la query solo in assenza di errori nei filtri del form
if {![info exists errnum]} {
    db_multirow -extend {edit_url delete_url} sources query "
                   select source_id,
                          source_name
                   from wal_sources 
                   where 1 = 1
                   [template::list::filter_where_clauses -name sources -and]
                   [template::list::orderby_clause       -name sources -orderby]
                   limit $rows_per_page
                   offset $offset
    " {
	set edit_url   [export_vars -base "source-add-edit" {source_id}]
	set delete_url [export_vars -base "source-delete"   {source_id}]
    }

} else {
    # creo una multirow fittizia 
    template::multirow create pos dummy
}

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property wallet sources-list [export_vars -entire_form -no_empty]
}
