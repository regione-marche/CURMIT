ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: tools.tcl

} {
    type
}

set inspector_id [auth::require_login]

if {![db_0or1row check_inspector "select name as inspector_name, validated_p, approved_p from iter_inspectors where inspector_id = :inspector_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata agli Ispettori registrati." /
    ad_script_abort
}

if {[string equal $type "0"]} {
    set tool_type "Analizzatore di Combustione"
    set tools_type "Analizzatori di Combustione"
    set oth_type "1"
    set oth_tools_type "Deprimometri"
} elseif {[string equal $type "1"]} {
    set tool_type "Deprimometro"
    set tools_type "Deprimometri"
    set oth_type "0"
    set oth_tools_type "Analizzatori di Combustione"
} 

set page_title "Lista $tools_type di $inspector_name"
set context [list [list services "Servizi per gli Ispettori"] "Lista $tools_type"]

# prepare actions buttons
set actions [list \
     "Nuovo $tool_type" tool-add-edit?inspector_id=$inspector_id&type=$type "Crea un nuovo $tool_type" \
		 ]

template::list::create \
    -name tools \
    -multirow tools \
    -actions $actions \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" width="16" height="16" border="0">}
	    link_html {title "Modifica $tool_type"}
	    sub_class narrow
	}
	brand {
	    label "Marca"
	}
	model {
	    label "Modello"
	}
	no {
	    label "Matricola"
	}
	last_calibration_date_pretty {
	    label "Data ultima taratura"
	}
	delete {
	    link_url_col delete_url 
            link_html {title "Cancella" onClick "return(confirm('Confermi la cancellazione?'));"}
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	    sub_class narrow
	}
    }

    db_multirow -extend {edit_url delete_url} tools query "
                   select *, to_char(last_calibration_date, 'DD/MM/YYYY') as last_calibration_date_pretty
                   from iter_inspectors_tools
                   where inspector_id = :inspector_id
                     and type = :type
                   order by brand
    " {
	set edit_url   [export_vars -base "tool-add-edit" {inspector_id tool_id type}]
	set delete_url [export_vars -base "tool-delete"   {inspector_id tool_id type}]
	
    }

