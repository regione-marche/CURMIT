ad_page_contract {

    Lista CAIT.
    Offre al manutentore la possibilità di aderire ad un CAIT.    

    @author Claudio Pasolini
    @cvs-id $Id: cait-list.tcl

} {
}

set maintainer_id [auth::require_login]

if {![db_0or1row check_maint "select 1 from iter_maintainers where maintainer_id = :maintainer_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai Manutentori registrati." /
    ad_script_abort
}

set page_title "Lista CAIT"
set context [list "$page_title"]

template::list::create \
    -name cait \
    -multirow cait \
    -key cait_id \
    -elements {
	name {
	    label "Ragione Sociale"
	    link_url_col link_url
	    link_html {title "Aderisci a questo CAIT" onClick "return(confirm('Sei sicuro?'));"}
	}
	city {
	    label "Comune"
	}
	province {
	    label "Provincia"
            html {align center}
	}
	phone {
	    label "Telefono"
	}
    }

    db_multirow -extend {link_url} cait query "
        select
            :maintainer_id as maintainer_id
           ,cait_id
           ,name
           ,city
           ,province
           ,phone
        from iter_cait
        order by name
    " {
	set link_url [export_vars -base "cait/link" {maintainer_id cait_id}]
    }
