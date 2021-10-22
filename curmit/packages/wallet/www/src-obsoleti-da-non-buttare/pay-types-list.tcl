ad_page_contract {

    @author Serena Saccani
    @cvs-id $Id: pay-types.tcl

} {

    {rows_per_page 30}
    {offset 0}
    {search_word ""}
    orderby:optional
}

ah::script_init -script_name wallet/pay-types-list

# Creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{search_word:text,optional
	    {label {Cerca Tipo Pagamento}}
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
	ah::set_list_filters wallet pay-types-list
    }

set page_title "Lista Tipi Pagamento"
set context [list "Lista Tipi Pagamento"]

# prepare actions buttons
set actions {
     "Nuovo Tipo Pagamento" pay-type-add-edit "Crea un nuovo Tipo Pagamento"
}

source [ah::package_root -package_key ah-util]/paging-buttons.tcl

template::list::create \
    -name pay_types \
    -multirow pay_types \
    -actions $actions \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" width="16" height="16" border="0">}
	    link_html {title "Modifica Tipo Pagamento"}
	    sub_class narrow
	}
	pay_type_name {
	    label "Tipo Pagamento"
	}
	delete {
	    link_url_col delete_url 
            link_html {title "Cancella Tipo Pagamento" onClick "return(confirm('Confermi la cancellazione?'));"}
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	    sub_class narrow
	}
    } \
    -orderby {
        default_value pay_type_name
        pay_type_name {
	    label "Tipo Pagamento"
	    orderby_desc "pay_type_name desc"
	    orderby_asc  "pay_type_name"
	}

    } \
    -filters {
	search_word {
	    hide_p 1
	    where_clause {upper(pay_type_name) like upper('%$search_word%')}	    
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
    db_multirow -extend {edit_url delete_url} pay_types query "
                   select pay_type_id,
                          pay_type_name
                   from wal_payment_types 
                   where 1 = 1
                   [template::list::filter_where_clauses -name pay_types -and]
                   [template::list::orderby_clause       -name pay_types -orderby]
                   limit $rows_per_page
                   offset $offset
    " {
	set edit_url   [export_vars -base "pay-type-add-edit" {pay_type_id}]
	set delete_url [export_vars -base "pay-type-delete"   {pay_type_id}]
    }

} else {
    # creo una multirow fittizia 
    template::multirow create pos dummy
}

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property wallet pay-types-list [export_vars -entire_form -no_empty]
}
