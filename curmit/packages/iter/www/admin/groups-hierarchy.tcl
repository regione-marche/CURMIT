ad_page_contract {

    Esplosione scalare della struttura organizzativa.

    @author Claudio Pasolini

} {
    {parent_id ""}
}

set user_id    [ad_conn user_id]

set company_group_id [parameter::get -parameter company_group_id]
if {$parent_id eq ""} {
    set parent_id $company_group_id
}

set parent_name [db_string query "select group_name from groups where group_id = :parent_id"]
 
set page_title "Struttura organizzativa esplosa (<a href=\"groups-list\">semplice</a>)"
set context [list "Struttura organizzativa esplosa"]
set context    [iter_context_bar \
		    [list /tosap/ "Home"] \
		    [list index "Amministrazione Viae"] \
		    "$page_title"]

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
	level {
	    label "Lvl."
	}
	group_name {
	    label "Unità Organizzativa"
	    link_url_col explode_url 
            link_html {title "Esplodi questa Unità Organizzativa"}
	}
	email {
	    label "Email"
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
    }

# defines multirow
multirow create groups edit_url explode_url level group_name email members_url add_group_url child_id 

tosa_group_explode \
    -parent_id         $parent_id \
    -level             0 \
    -multirow          groups 
