ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: inspectors-list.tcl

} {
}

set company_id [auth::require_login]

if {![db_0or1row check_company "select 1 from iter_inspecting_companies where company_id = :company_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata alle Aziende di Ispezione registrate." /
    ad_script_abort
}


set page_title "Ispettori incaricati"
set context [list "$page_title"]

template::list::create \
    -name inspectors \
    -multirow inspectors \
    -key maintainer_id \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" width="16" height="16" border="0">}
	    link_html {title "Gestisci i dati dell'ispettore"}
	    sub_class narrow
	}
	unlink {
	    link_url_col unlink_url
	    display_template {<img src="/resources/acs-subsite/Cut.gif" width="16" height="16" border="0">}
	    link_html {title "Scollega questo ispettore"}
	    sub_class narrow
	}
	name {
	    label "Nominativo"
            display_template {<if @inspectors.status@ eq 1><font color="green">@inspectors.name@</font></if><if @inspectors.status@ eq 3><font color="blue">@inspectors.name@</font></if><if @inspectors.status@ eq 2><font color="yellow">@inspectors.name@</font></if>}
	}
	city {
	    label "Comune"
	}
	province {
	    label "Provincia"
            html {align center}
	}
        iva_code {
	    label "Partita IVA"
	}
        fiscal_code {
	    label "Codice Fiscale"
	}
	phone {
	    label "Telefono"
	}
	delete {
	    link_url_col delete_url 
            link_html {title "Cancella l'ispettore" onClick "return(confirm('Confermi la cancellazione?'));"}
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	    sub_class narrow
	}
    }

db_multirow -extend {edit_url unlink_url delete_url status} inspectors query "
        select
            inspector_id
           ,name || ' ' || first_name as name
           ,city
           ,province
           ,iva_code
           ,fiscal_code
           ,phone
           ,validated_p 
           ,approved_p
        from iter_inspectors
        where company_id = :company_id
        order by name, first_name
    " {
	set edit_url   [export_vars -base "inspector-services" {inspector_id}]
	set unlink_url [export_vars -base "unlink" {inspector_id}]
	set delete_url [export_vars -base "inspector-delete" {inspector_id}]

	if {$validated_p} {
	    set status "1"
	} elseif {$approved_p} {
	    set status "2"
	} else {
	    set status "3"
	}
	
    }
