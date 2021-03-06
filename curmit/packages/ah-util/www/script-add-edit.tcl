ad_page_contract {

  @author Claudio Pasolini
  @cvs-id script-add-edit.tcl

} {
    item_id:integer,optional
    {parent_id ""}
    {mode "edit"}
    {return_url "permissions"}
}

if {![acs_user::site_wide_admin_p]} {
    ad_return_complaint 1 "<li>Spiacente, ma questa funzione è riservata agli amministratori del sistema."
    ad_script_abort
}

if {[ad_form_new_p -key item_id]} {
    set page_title "Crea nuovo script"
    set buttons [list [list "Crea script" new]]
    set field_mode edit
} else {
    if {[string equal $mode "edit"]} {
        set page_title "Modifica script"
        set buttons [list [list "Modifica script" edit]]
        set field_mode display
    } else {
        set page_title "Visualizza script"
        set buttons [list [list "OK" view]]
        set field_mode display
    }
}

set context [list [list $return_url {Programmi}] $page_title]
set context_bar [list [list $return_url {Programmi}] $page_title]

ad_form -name scriptaddedit \
        -mode $mode \
        -edit_buttons $buttons \
        -export {return_url parent_id} \
        -has_edit 1 \
        -form {

    item_id:key  

    {title:text 
        {label {Nome script}}
        {html {size 30}}
	{mode $field_mode}
    }

    {description:text(textarea),optional 
        {label Descrizione}
        {html {rows 5 cols 50 wrap soft}}
    }
    {parent_code:text,optional
        {label {Codice del parent script}}
        {mode $field_mode}
    }
    {original_author:text(select),optional
        {options { [db_list_of_lists get_aut {
            select email, party_id from parties where email is not null
            }] }}
        {label {Autore originale}}
    }
    {maintainer:text(select),optional
        {options { [db_list_of_lists get_maint {
            select email, party_id from parties where email is not null
            }] }}
        {label {Gestore attuale}}
    }
    {is_active_p:boolean(radio)
        {options {{SI t} {NO f}}}
        {label {Script attivo?}}
    }
    {is_executable_p:boolean(radio)
        {options {{SI t} {NO f}}}
        {label {Script eseguibile?}}
    }

} -new_request {

    if {$parent_id ne ""} {
        set parent_code [db_string query "
        select title from acs_objects where object_id = :parent_id"]
    }

    set is_active_p     t
    set is_executable_p t

} -select_query {

    select o1.object_id as item_id, 
           s.description, 
           o1.context_id as parent_id, 
           o2.title as parent_code, 
           o1.title, 
           s.original_author,
           s.maintainer, 
           s.is_active_p, 
           s.is_executable_p
    from   mis_scripts s, acs_objects o1, acs_objects o2
    where  o1.object_id    = :item_id and
           s.script_id     = o1.object_id and
           o2.object_id    = o1.context_id

} -on_submit {

    if {$parent_code ne "#acs-kernel.Main_Site#"} {
	if {![db_0or1row query "select object_id as parent_id from acs_objects where title = :parent_code and object_type = 'mis_script'"]} {
	    template::form::set_error scriptaddedit parent_code "Codice script non esistente."
	    break
	}
    }

} -new_data {

    db_transaction {

        mis::script::add                    \
          -title           $title                     \
          -description     $description         \
          -parent_id       $parent_id             \
          -original_author $original_author \
          -maintainer      $maintainer           \
          -is_active_p     $is_active_p         \
          -is_executable_p $is_executable_p

    } on_error {
        ah::transaction_error
    }

} -edit_data {

    db_transaction {

        mis::script::edit                   \
          -item_id         $item_id                 \
          -title           $title                     \
          -description     $description         \
          -parent_id       $parent_id           \
          -maintainer      $maintainer           \
          -is_active_p     $is_active_p         \
          -is_executable_p $is_executable_p

    } on_error {
        ah::transaction_error
    }

} -after_submit {

    ad_returnredirect $return_url
    ad_script_abort
}



