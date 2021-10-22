ad_page_contract {
} {
    object_id:integer,notnull
    return_url
    page:integer,optional
}

# check they have read permission on this file

ad_require_permission $object_id admin

# TODO:
# parties, select privilges, css, clean up

#set templating datasources

set user_id [ad_conn user_id]

set perm_url "/ah-util/permissions/"

list::create \
    -name users \
    -multirow users \
    -key user_id \
    -page_size 20 \
    -page_query_name users_who_dont_have_any_permissions_paginator \
    -no_data "[_ acs-subsite.lt_There_are_no_users_wh]" \
    -bulk_action_export_vars { return_url object_id } \
    -bulk_actions [list \
                       "Aggiungi permesso 'Read'" "${perm_url}perm-user-add-2" "Aggiungi permesso 'Read' agli utenti selezionati" \
                       "Aggiungi permesso 'Exec'" "${perm_url}perm-user-add-3" "Aggiungi permesso 'Exec' agli utenti selezionati" \
                      ]  \
    -elements {
        name {
            label "[_ acs-subsite.Name]"
        }
        email {
            label "[_ acs-subsite.Email]"
            link_url_eval {mailto:$email}
        }
        addread {
            label "Read"
            link_url_col add_url
            link_html { title "Aggiungi il permesso 'Read' a questo utente" }
            display_template "Read"
        }
        addexec {
            label "Exec"
            link_url_col exec_url
            link_html { title "Aggiungi il permesso 'Exec' a questo utente" }
            display_template "Exec"
        }
    } -filters {
	object_id {}
	return_url {}
    }

set page_where_clause [list::page_where_clause -name users -and]

db_multirow -extend { add_url exec_url } users users_who_dont_have_any_permissions {} {
    set add_url  [export_vars -base "${perm_url}perm-user-add-2" { return_url object_id user_id }]
    set exec_url [export_vars -base "${perm_url}perm-user-add-3" { return_url object_id user_id }]
}

set form_export_vars [export_vars -form {object_id return_url }]
