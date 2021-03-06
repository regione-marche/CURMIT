ad_page_contract {

    @author Serena Saccani
    @cvs-id $Id: tran-types.tcl

} {

    {rows_per_page 30}
    {offset 0}
    {search_word ""}
    orderby:optional
}

ah::script_init -script_name wallet/tran-types-list

# Creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{search_word:text,optional
	    {label {Cerca Tipo Movimento}}
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
	ah::set_list_filters wallet tran-types-list
    }

set page_title "Lista Tipi Movimento"
set context [list "Lista Tipi Movimento"]

# prepare actions buttons
set actions {
     "Nuovo Tipo Movimento" tran-type-add-edit "Crea un nuovo Tipo Movimento"
}

source [ah::package_root -package_key ah-util]/paging-buttons.tcl

template::list::create \
    -name tran_types \
    -multirow tran_types \
    -actions $actions \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" width="16" height="16" border="0">}
	    link_html {title "Modifica Tipo Movimento"}
	    sub_class narrow
	}
	tran_type_name {
	    label "Tipo Movimento"
	}
	sign {
	    label "Segno del Movimento"
	}
	delete {
	    link_url_col delete_url 
            link_html {title "Cancella Tipo Movimento" onClick "return(confirm('Confermi la cancellazione?'));"}
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	    sub_class narrow
	}
    } \
    -orderby {
        default_value tran_type_name
        tran_type_name {
	    label "Tipo Movimento"
	    orderby_desc "tran_type_name desc"
	    orderby_asc  "tran_type_name"
	}
        sign {
	    label "Segno del Movimento"
	    orderby_desc "sign desc"
	    orderby_asc  "sign"
	}

    } \
    -filters {
	search_word {
	    hide_p 1
	    where_clause {upper(tran_type_name) like upper('%$search_word%')}	    
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
    db_multirow -extend {edit_url delete_url} tran_types query "
                   select tran_type_id,
                          tran_type_name,
                          sign
                   from wal_transaction_types 
                   where 1 = 1
                   [template::list::filter_where_clauses -name tran_types -and]
                   [template::list::orderby_clause       -name tran_types -orderby]
                   limit $rows_per_page
                   offset $offset
    " {
	set edit_url   [export_vars -base "tran-type-add-edit" {tran_type_id}]
	set delete_url [export_vars -base "tran-type-delete"   {tran_type_id}]
    }

} else {
    # creo una multirow fittizia 
    template::multirow create pos dummy
}

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property wallet tran-types-list [export_vars -entire_form -no_empty]
}

