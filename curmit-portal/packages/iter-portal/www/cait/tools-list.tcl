ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: tools.tcl

} {
    maintainer_id
    type
}

set cait_id [auth::require_login]

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :cait_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}
if {![db_0or1row check_maint "select approved_p, validated_p, name as maintainer_name from iter_maintainers where cait_id = :cait_id and maintainer_id = :maintainer_id"]} {
    ad_returnredirect -message "Spiacente, ma il manutentore non è tra quelli registrati dal CAIT." /
    ad_script_abort
}
if {[string equal $approved_p "t"] && [string equal $validated_p "f"]} {
    ad_returnredirect -message "Funzione non disponibile per questo manutentore." /
    ad_script_abort
}

set num_msg [iter::check_reg -maintainer_id $maintainer_id]
if {[string equal $num_msg ""] && ![string equal $validated_p "t"] && ![string equal $approved_p "t"]} {
    set to_approve_p "t"
} else {
    set to_approve_p "f"
}

set reg_msg [iter::get_reg_msg -validated_p $validated_p -approved_p $approved_p -num_msg $num_msg]

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

set page_title "Lista $tools_type di $maintainer_name"
set context [list [list services "Servizi per i manutentori"] "Lista $tools_type"]

# prepare actions buttons
set actions [list \
     "Nuovo $tool_type" tool-add-edit?maintainer_id=$maintainer_id&type=$type "Crea un nuovo $tool_type" \
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
                   from iter_tools
                   where maintainer_id = :maintainer_id
                     and type = :type
                   order by brand
    " {
	set edit_url   [export_vars -base "tool-add-edit" {maintainer_id tool_id type}]
	set delete_url [export_vars -base "tool-delete"   {maintainer_id tool_id type}]
	
    }

