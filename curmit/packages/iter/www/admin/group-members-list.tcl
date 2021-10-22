ad_page_contract {

    @author Claudio Pasolini

} {
    group_id
}

set user_id    [ad_conn user_id]

set group_name [db_string query "select group_name from groups where group_id=:group_id"]
set page_title "Membri di $group_name"
set context    [iter_context_bar \
		    [list /tosap/ "Home"] \
		    [list index "Amministrazione Viae"] \
		    [list groups-list "Unità organizzative"] \
		    "$page_title"]

# prepare actions buttons
set actions " {Aggiungi membro} member-add?group_id=$group_id {Aggiungi un membro a questo gruppo} "

template::list::create \
    -name members \
    -multirow members \
    -actions $actions \
    -elements {
	first_names {
	    label "Nome"
	}
	last_name {
	    label "Cognome"
	}
	email {
	    label "Email"
	}
	delete {
	    link_url_col delete_url 
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	    link_html {title "Rimuovi questo membro" onClick "return(confirm('Confermi la rimozione?'));"}
	    sub_class narrow
	}
    }

db_multirow -extend {delete_url} members query "
    select first_names, last_name, email, party_id 
    from acs_rels r, persons pe, parties pa  
    where rel_type      = 'membership_rel' and 
          object_id_one = :group_id and 
          object_id_two = person_id and
          party_id      = person_id
    " {
	set delete_url   [export_vars -base "member-delete"  {group_id party_id}]
    }


