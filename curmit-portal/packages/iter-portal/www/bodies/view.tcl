ad_page_contract {

  @author Claudio Pasolini

} {
    {group_id ""}
    {mode "edit"}
}

set user_id    [ad_conn user_id]

set select_clause "and object_id_two != :group_id"
set page_title "Visualizza Ente"
set buttons [list [list "Ritorna" new]]
set field_mode display

set context [list [list services {Servizi}] $page_title]

# trovo il subsite 
array set arr [site_node::get_from_url -url /]
set context_id $arr(package_id)

# ottengo il gruppo a cui appartengono, con relazione di
# composizione, tutti gli altri gruppi 
set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -export group_id \
    -has_edit 1 \
    -form {

	{group_name:text
	    {label {Nome Ente}}
	    {mode $field_mode}
	}
	{email:email
	    {label {Email}}
	    {help_text "Indirizzo al quale verranno inviate le notifiche ed i file dei distributori."}
	}
	{url:text
	    {label {URL}}
	    {help_text "Indirizzo per l'accesso ad ITER da parte dell'Ente."}
	}
} -on_request {

    if {[exists_and_not_null group_id]} {
        db_1row query "
            select group_name, object_id_one as parent_id, email, url
            from groups g, acs_rels r, parties p 
            where g.group_id       = :group_id and 
                  r.object_id_two  = :group_id and
                  group_id         = party_id
            order by object_id_one desc
            limit 1"
    }


} -after_submit { 

    ad_returnredirect "services"
    ad_script_abort
}




