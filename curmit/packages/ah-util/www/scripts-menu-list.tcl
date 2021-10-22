ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: scripts-menu-list.tcl
} {

    {search_script_name ""}
    {search_package ""}
    is_arrow_p:optional
    is_admin_p:optional

    page:optional
    {rows_per_page 100}
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
	{search_package:text,optional
	    {label {Cerca Package}}
	    {html {length 10} }
	    {value $search_package}
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

set page_title "Lista Menu "
set context [list "Lista Menu "]

# prepare actions buttons
set actions { 
    "Nuovo Menu"             script-menu-add-edit                                 "Aggiunge un nuovo Menu" 
    "Estrai tutto in CSV"    scripts-menu-list?format=csv&rows_per_page=99999999  "Estrazione totale in CSV"
    "Esporta Menu"           script-menu-export                                   "Esporta il Menu sul file system" 
    "Importa Menu"           script-menu-import                                   "Importa il Menu dal file system" 
    "Cancella Cache"         script-menu-flush                                    "Cancella la cache a seguito di modifiche" 
}

set formats {
      normal {
	label "Video"
	layout table
	row {
            edit {}  
            clone {}  
	    package {}
	    submenu {}
	    title {}
	    package_seq {}
	    submenu_seq {}
	    seq {}
            delete {}
	}
      }
      csv {
 	label "Excel"
	output csv
	row {
	    script_id {}
	    script_name {}
	    package {}
	    submenu {}
	    seq {}
	    par {}
	    title {}
	    is_arrow_p {}
	    package_seq {}
	    submenu_seq {}
	    is_admin_p {}
            condition {}
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
	clone {
	    link_url_col clone_url
	    link_html {title "Clona"}
	    display_template {<img src="/resources/acs-subsite/Copy16.gif" width="16" height="16" border="0">}
	    sub_class narrow
	}
	script_id {
	    label "Id"
	}
	script_name {
	    label "Nome script"
	}
	package {
	    label "Package"
	}
	submenu {
	    label "Submenu"
	}	
	seq {
	    label "Script<br>Seq."
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
	    label "Package<br>seq."
	}
	submenu_seq {
	    label "Submenu<br> seq."
	}
	is_admin_p {
	    label "Admin"
	}
	condition {
	    label "Condizione"
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
        default_value natural,asc
        script_name {
	    label "Nome"
	    orderby script_name
	}
        natural {
	    label "Naturale"
	    orderby package_seq,submenu_seq,seq
	}
    } \
    -filters {
        search_script_name {
            hide_p 1
	    where_clause {upper(script_name) like upper('%$search_script_name%')}
        }
        search_package {
            hide_p 1
	    where_clause {upper(package) like upper('%$search_package%')}
        }
        is_arrow_p {
	    label "A tendina?"
  	    values {{Sì t} {No f}}
	    where_clause {is_arrow_p = :is_arrow_p}
        }
        is_admin_p {
	    label "Amministratore?"
  	    values {{Sì t} {"No" f}}
	    where_clause {is_admin_p = :is_admin_p}
        }
        rows_per_page {
	    label "Righe per pagina"
  	    values {{10 10} {30 30} {100 100} {Tutte 9999}}
	    where_clause {1 = 1}
            default_value 100
        }
    } 

set sql "
	select m.script_id,
               m.script_name, 
               m.package, 
               m.submenu, 
               m.seq, 
               m.par, 
               m.title,
               case when m.is_arrow_p='t' then 'Sì' else 'No' end as is_arrow_p,
               m.package_seq,
               m.submenu_seq,
               case when m.is_admin_p='t' then 'Sì' else 'No' end as is_admin_p,
               m.condition
        from   mis_script_menu m
        where 1 = 1
        [template::list::page_where_clause -name scriptsmenu -key m.script_id -and]
        [template::list::filter_where_clauses -name scriptsmenu -and]
        [template::list::orderby_clause -name scriptsmenu -orderby] 
        offset $offset"
 
#ns_log notice "\n$sql"

# eseguo la query solo in assenza di errori nei filtri del form
if {![info exists errnum]} {
    db_multirow -extend {edit_url clone_url delete_url} scriptsmenu query  $sql {
	set edit_url   [export_vars -base "script-menu-add-edit" {script_id}]
	set clone_url  [export_vars -base "script-menu-clone" {script_id}]
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



