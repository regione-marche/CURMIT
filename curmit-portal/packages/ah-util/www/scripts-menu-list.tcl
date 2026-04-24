ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: scripts-menu-list.tcl
} {

    {search_script_name ""}
    {search_menu_type ""}
    f_is_arrow_p:optional
    f_is_admin_p:optional

    page:optional
    {rows_per_page 30}
    {offset 0}
    orderby:optional

    {format "normal"}
}

ah::script_init -script_name ah-util/scripts-menu-list

# creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{search_script_name:text,optional
	    {label {Cerca nome menu}}
	    {html {length 30} }
	    {value $search_script_name}
	}
	{search_menu_type:text,optional
	    {label {Cerca tipo menu}}
	    {html {length 10} }
	    {value $search_menu_type}
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
	ah::set_list_filters ah-util scripts-menu-list

    }

set page_title "Lista Menu"
set context [list "Lista Menu"]

# prepare actions buttons
set actions { 
    "Nuovo Menu" script-menu-add-edit "Aggiunge un nuovo Menu" 
    "Estrai tutto in CSV"    scripts-menu-list?format=csv&rows_per_page=99999999  "Estrazione totale in CSV"
}
#source [ah::package_root -package_key ah-util]/paging-buttons.tcl

set formats {
      normal {
	label "Video"
	layout table
	row {
            edit {}  
	    script_id {}
	    script_name {}
	    menu_type {}
	    package {}
	    submenu {}
	    seq {}
	    par {}
	    title {}
	    is_arrow_p {}
	    package_seq {}
	    submenu_seq {}
	    is_admin_p {}
            delete {}
	}
      }
      csv {
 	label "Excel"
	output csv
	row {
	    script_id {}
	    script_name {}
	    menu_type {}
	    package {}
	    submenu {}
	    seq {}
	    par {}
	    title {}
	    is_arrow_p {}
	    package_seq {}
	    submenu_seq {}
	    is_admin_p {}
	}
      }
}

if {![info exists errnum]} {
    set page_query_name paginator
} else {
    set page_query_name dummy_paginator
    template::multirow create scriptsmenu dummy
}

template::list::create \
    -name scriptsmenu \
    -multirow scriptsmenu \
    -actions $actions \
    -key script_id \
    -selected_format $format \
    -page_flush_p t \
    -page_size $rows_per_page \
    -page_groupsize 10 \
    -page_query_name $page_query_name \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" width="16" height="16" border="0">}
	    link_html {title "Modifica menu"}
	    sub_class narrow
	}
	script_id {
	    label "Id"
	}
	script_name {
	    label "Nome"
	}
	menu_type {
	    label "Tipo"
	}
	package {
	    label "Package"
	}
	submenu {
	    label "submenu"
	}	
	seq {
	    label "Seq."
	}
	par {
	    label "Par."
	}
	title {
	    label "Descrizione"
	}
	is_arrow_p {
	    label "Tendina"
	}
	package_seq {
	    label "package seq."
	}
	submenu_seq {
	    label "submenu seq."
	}
	is_admin_p {
	    label "Amministratore"
	}
	delete {
	    link_url_col delete_url 
            link_html {title "Cancella questo script" onClick "return(confirm('Confermi la cancellazione?'));"}
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	    sub_class narrow
	}
    } \
    -formats $formats \
    -orderby {
        default_value script_name,asc
        script_name {
	    label "Nome"
	    orderby script_name
	}
        script_id {
	    label "Id"
	    orderby script_id
	}

    } \
    -filters {
        search_script_name {
            hide_p 1
	    where_clause {upper(script_name) like upper('%$search_script_name%')}
        }
        search_menu_type {
            hide_p 1
	    where_clause {upper(menu_type) like upper('%$search_menu_type%')}
        }
        f_is_arrow_p {
	    label "A tendina?"
  	    values {{"Sì" t} {"No" f}}
	    where_clause {is_arrow_p = :f_is_arrow_p}
        }
        is_admin_p {
	    label "Amministratore?"
  	    values {{"Sì" t} {"No" f}}
	    where_clause {is_admin_p = :is_admin_p}
        }
        rows_per_page {
	    label "Righe per pagina"
  	    values {{10 10} {30 30} {100 100} {Tutte 9999}}
	    where_clause {1 = 1}
            default_value 30
        }
    } 

set sql "
	select script_id,
               script_name, 
               menu_type, 
               package, 
               submenu, 
               seq, 
               par, 
               title,
               case when is_arrow_p='t' then 'Sì' else 'No' end as is_arrow_p,
               package_seq,
               submenu_seq,
               case when is_admin_p='t' then 'Sì' else 'No' end as is_admin_p
        from   mis_script_menu
        where 1 = 1
        [template::list::page_where_clause -name scriptsmenu -key script_id -and]
        [template::list::filter_where_clauses -name scriptsmenu -and]
        [template::list::orderby_clause -name scriptsmenu -orderby] 
        offset $offset"
 
#ns_log notice "\n$sql"

# eseguo la query solo in assenza di errori nei filtri del form
if {![info exists errnum]} {
    db_multirow -extend {edit_url delete_url} scriptsmenu query  $sql {
	set edit_url [export_vars -base "script-menu-add-edit" {script_id}]
	set delete_url [export_vars -base "script-menu-delete" {script_id}]
    }
} else {
    # creo una multirow fittizia 
    template::multirow create scriptsmenu dummy
}

if {[string equal $format "csv"]} {
    template::list::write_csv -name scriptsmenu
    ad_script_abort
}

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property ah-util scripts-menu-list [export_vars -entire_form -no_empty]
}



