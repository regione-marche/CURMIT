ad_page_contract {

    @author Claudio Pasolini

} {
}

set user_id    [ad_conn user_id]

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
		 -no_login \
		 -object_id [ad_conn package_id] \
		 -privilege admin]

if {!$admin_p} {
    ad_return_complaint 1 "Spiacente, ma questa funzione è riservata all'amministratore di ALTER"
    ad_script_abort
}

set page_title "Struttura organizzativa (<a href=\"groups-hierarchy\">esplosa</a>)"
set context [list "Struttura organizzativa"]

# prepare actions buttons
set actions { "Aggiungi Unità Organizzativa" group-add-edit "Aggiungi una nuova Unità Organizzativa" }

template::list::create \
    -name groups \
    -multirow groups \
    -actions $actions \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" width="16" height="16" border="0">}
	    link_html {title "Modifica Unità Organizzativa"}
	    sub_class narrow
	}
	group_name {
	    label "Nome Unità Organizzativa"
	}
	email {
	    label "Email"
	}
	parent_name {
	    label "Nome Unità Superiore"
	}
	members {
	    link_url_col members_url 
            link_html {title "Visualizza i membri di questa Unità Organizzativa"}
	    display_template {Membri}
	}
	add_group {
	    link_url_col add_group_url 
            link_html {title "Aggiungi una nuova Unità Organizzativa sotto quella selezionata"}
	    display_template {Nuova Unità}
	}
	delete {
	    link_url_col delete_url 
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	    link_html {title "Rimuovi questa Unità Organizzativa" onClick "return(confirm('Confermi la rimozione?'));"}
	    sub_class narrow
	}
    }

# ottengo il gruppo a cui appartengono, con relazione di composizione, tutti gli altri gruppi 
set subsite_group_id [application_group::group_id_from_package_id -package_id [ad_conn subsite_id]]

db_multirow -extend {edit_url members_url add_group_url delete_url} groups query "
    select g.group_id, 
           g.group_name, 
           p.email,
           (
            select g2.group_name
            from acs_rels r2, groups g2
            where r2.rel_type    = 'composition_rel' and 
                  r2.object_id_one != :subsite_group_id and 
                  g2.group_id    = r2.object_id_one and
                   r2.object_id_two = g.group_id
           ) as parent_name
    from acs_rels r, groups g, parties p
    where r.rel_type='composition_rel' and 
          r.object_id_one = :subsite_group_id and 
          r.object_id_two = g.group_id and
          g.group_id      = p.party_id
    order by group_name
    " {
	set edit_url      [export_vars -base "group-add-edit" {group_id}]
	set members_url   [export_vars -base "group-members-list"  {group_id}]
	set add_group_url [export_vars -base "group-add-edit"  {{parent_id $group_id}}]
	set delete_url    [export_vars -base "group-delete" {group_id}]
    }


