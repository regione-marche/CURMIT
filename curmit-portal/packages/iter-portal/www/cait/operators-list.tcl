ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: operators.tcl

} {
    maintainer_id
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

set page_title "Lista Operatori di $maintainer_name"
set context [list [list services "Servizi per i manutentori"] "Lista Operatori"]

# prepare actions buttons
set actions [list \
     "Nuovo Operatore" operator-add-edit?maintainer_id=$maintainer_id "Crea un nuovo operatore" \
		 ]

template::list::create \
    -name operators \
    -multirow operators \
    -actions $actions \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" width="16" height="16" border="0">}
	    link_html {title "Modifica operatore"}
	    sub_class narrow
	}
	name {
	    label "Cognome"
	}
	first_name {
	    label "Nome"
	}
	no {
	    label "Matricola"
	}
	iter_no {
	    label "Codice Iter"
	}
	password {
	    label "Password"
	}
	fiscal_code {
	    label "Cod. fiscale"
	}
	phone {
	    label "Telefono"
	}
	mobile {
	    label "Cellulare"
	}
	attivo {
	    label "Attivo ?"
	}
	delete {
	    link_url_col delete_url 
            link_html {title "Cancella l' operatore" onClick "return(confirm('Confermi la cancellazione?'));"}
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	    sub_class narrow
	}
    }

    db_multirow -extend {edit_url delete_url attivo} operators query "
                   select *
                   from iter_operators
                   where maintainer_id = :maintainer_id
                   order by name
    " {
	if {[string equal $is_active_p "t"]} {
	    set attivo "Si"
	} else {
	    set attivo "No"
	}
	set edit_url   [export_vars -base "operator-add-edit" {maintainer_id operator_id}]
	set delete_url [export_vars -base "operator-delete"   {maintainer_id operator_id}]
	
    }

