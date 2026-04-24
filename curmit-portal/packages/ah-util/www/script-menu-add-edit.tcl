ad_page_contract {

  @author Claudio Pasolini
  @cvs-id script-menu-add-edit.tcl

} {
    script_id:integer,optional
    {mode "edit"}
}

if {![acs_user::site_wide_admin_p]} {
    ad_return_complaint 1 "<li>Spiacente, ma questa funzione è riservata agli amministratori del sistema."
    ad_script_abort
}

if {[ad_form_new_p -key script_id]} {
    set page_title "Crea nuovo menu"
    set buttons [list [list "Crea menu" new]]
    set field_mode edit
} else {
    if {[string equal $mode "edit"]} {
        set page_title "Modifica menu"
        set buttons [list [list "Modifica menu" edit]]
        set field_mode edit
    } else {
        set page_title "Visualizza menu"
        set buttons [list [list "OK" view]]
        set field_mode display
    }
}

set context [list [list scripts-menu-list {Lista Menu}] $page_title]

ad_form -name scriptmenuaddedit \
        -mode $mode \
        -edit_buttons $buttons \
        -has_edit 1 \
        -form {

    script_id:key  

    {script_name:text 
        {label {Nome Menu}}
        {html {size 70}}
	{mode $field_mode}
    }

    {menu_type:text 
        {label {Tipo Menu}}
        {html {size 10}}
    }
    {package:text
        {label {Package}}
        {mode $field_mode}
    }
    {package_seq:integer
        {label {Seq. Package}}
        {mode $field_mode}
    }
    {submenu:text
        {label {Submenu}}
        {mode $field_mode}
    }
    {submenu_seq:integer
        {label {Seq. Submenu}}
        {mode $field_mode}
    }
    {seq:integer
        {label {Sequenza}}
        {mode $field_mode}
    }
    {par:text,optional
        {label {Par.}}
        {mode $field_mode}
    }
    {title:text
        {label {Descrizione}}
        {mode $field_mode}
    }
    {is_arrow_p:boolean(radio)
        {options {{SI t} {NO f}}}
        {label {A Tendina?}}
    }
    {is_admin_p:boolean(radio)
        {options {{SI t} {NO f}}}
        {label {Amministratore?}}
    }

} -new_request {

    set is_arrow_p t
    set is_admin_p t

} -select_query {

    select script_id,
           script_name, 
           menu_type, 
           package, 
           package_seq, 
           submenu,
           submenu_seq, 
           seq, 
           par,
           title,
           is_arrow_p,
           is_admin_p
    from   mis_script_menu
    where  script_id    = :script_id

} -on_submit {

#    if {$par == ""} {
#	set par ""
#    }

} -new_data {

    ah::script_write -script_name ah-util/www/script-menu-add-edit

    db_transaction {
	
	set script_id [db_string query "select coalesce(max(script_id) + 1, 1) from mis_script_menu"]
	db_dml query "
        insert into mis_script_menu (
	    script_id
           ,script_name
           ,menu_type
           ,package
           ,package_seq
           ,submenu
           ,submenu_seq
           ,seq
           ,par
           ,title
           ,is_arrow_p
           ,is_admin_p
        ) values (
	    :script_id
           ,:script_name
           ,:menu_type
           ,:package
           ,:package_seq
           ,:submenu
           ,:submenu_seq
           ,:seq
           ,:par
           ,:title
           ,:is_arrow_p
           ,:is_admin_p
        )"

    } on_error {
        ah::transaction_error
    }

} -edit_data {


    ah::script_write -script_name mis-base/tab/bank-add-edit

    db_transaction {
	
	db_dml query "
        update mis_script_menu set
            script_name = :script_name
           ,menu_type   = :menu_type
           ,package     = :package
           ,package_seq = :package_seq
           ,submenu     = :submenu
           ,submenu_seq = :submenu_seq
           ,seq         = :seq
           ,par         = :par
           ,title       = :title
           ,is_arrow_p  = :is_arrow_p
           ,is_admin_p  = :is_admin_p
        where script_id = :script_id
      "

    } on_error {
        ah::transaction_error
    }

} -after_submit {

    ad_returnredirect "scripts-menu-list?search_script_name=$script_name"
    ad_script_abort
}



