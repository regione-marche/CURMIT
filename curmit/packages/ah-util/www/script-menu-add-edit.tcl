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
    {condition:text,optional
        {label {Condizione}}
	{html {class input-xxlarge}}
	{help_text "Codice tcl che deve risultare vero o falso e determinerà l'inclusione o meno della voce di menu."}
        {mode $field_mode}
    }

} -new_request {

    set is_arrow_p t
    set is_admin_p t

} -select_query {

    select m.script_id,
           script_name, 
           package, 
           package_seq, 
           submenu,
           submenu_seq, 
           seq, 
           par,
           title,
           is_arrow_p,
           is_admin_p,
           condition
        from   mis_script_menu m
        where m.script_id   = :script_id

} -on_submit {

#    if {$par == ""} {
#	set par ""
#    }

} -new_data {


    if {[db_0or1row query "
        select 1 
        from mis_script_menu
        where script_name  = :script_name
          "]} {
	template::form::set_error addedit script_name "Esiste già un menu con lo stesso nome."
	break
    }

    db_transaction {
	
	if {![db_0or1row query "select script_id from  mis_script_menu where script_name = :script_name"]} {
	    set script_id [db_string query "select coalesce(max(script_id) + 1, 1) from mis_script_menu"]
	    db_dml query "
        insert into mis_script_menu (
	    script_id
           ,script_name
           ,package_seq
           ,submenu_seq
           ,seq
           ,par
           ,is_arrow_p
           ,is_admin_p
           ,condition
           ,package
           ,submenu
           ,title
        ) values (
	    :script_id
           ,:script_name
           ,:package_seq
           ,:submenu_seq
           ,:seq
           ,:par
           ,:is_arrow_p
           ,:is_admin_p
           ,:condition
           ,:package
           ,:submenu
           ,:title
        )"
	}
    } on_error {
        ah::transaction_error
    }

} -edit_data {


    db_transaction {
	
	db_dml query "
        update mis_script_menu set
            script_name = :script_name
           ,package_seq = :package_seq
           ,submenu_seq = :submenu_seq
           ,seq         = :seq
           ,par         = :par
           ,is_arrow_p  = :is_arrow_p
           ,is_admin_p  = :is_admin_p
           ,condition   = :condition
           ,package     = :package
           ,submenu     = :submenu
           ,title       = :title

        where script_id = :script_id
      "

    } on_error {
        ah::transaction_error
    }

} -after_submit {

    ad_returnredirect "scripts-menu-list?search_package=$package"
    ad_script_abort
}



