ad_page_contract {

    @author Serena Saccani
    @cvs-id $Id: bodies.tcl

} {

    {rows_per_page 30}
    {offset 0}
    {search_word ""}
    orderby:optional
}

ah::script_init -script_name wallet/bodies-list

# Creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{search_word:text,optional
	    {label {Cerca Ente}}
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
	ah::set_list_filters wallet bodies-list
    }

set page_title "Lista Enti"
set context [list "Lista Enti"]

# prepare actions buttons
set actions {
     "Nuovo Ente" body-add-edit "Crea un nuovo Ente"
}

source [ah::package_root -package_key ah-util]/paging-buttons.tcl

template::list::create \
    -name bodies \
    -multirow bodies \
    -actions $actions \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" width="16" height="16" border="0">}
	    link_html {title "Modifica l'Ente"}
	    sub_class narrow
	}
	body_name {
	    label "Nome Ente"
	}
	delete {
	    link_url_col delete_url 
            link_html {title "Cancella l'Ente" onClick "return(confirm('Confermi la cancellazione?'));"}
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	    sub_class narrow
	}
    } \
    -orderby {
        default_value body_name
        body_name {
	    label "Nome Ente"
	    orderby_desc "body_name desc"
	    orderby_asc  "body_name"
	}

    } \
    -filters {
	search_word {
	    hide_p 1
	    where_clause {upper(body_name) like upper('%$search_word%')}	    
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
    db_multirow -extend {edit_url delete_url} bodies query "
                   select body_id,
                          body_name
                   from wal_bodies 
                   where 1 = 1
                   [template::list::filter_where_clauses -name bodies -and]
                   [template::list::orderby_clause       -name bodies -orderby]
                   limit $rows_per_page
                   offset $offset
    " {
	set edit_url   [export_vars -base "body-add-edit" {body_id}]
	set delete_url [export_vars -base "body-delete"   {body_id}]
    }

} else {
    # creo una multirow fittizia 
    template::multirow create pos dummy
}

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property wallet bodies-list [export_vars -entire_form -no_empty]
}
