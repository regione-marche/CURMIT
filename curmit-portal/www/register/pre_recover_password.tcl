ad_page_contract {

    Menu servizi dei distributori.

    @cvs-id $Id: services.tcl,v 1.2 2021/07/27 15:06:33 nsadmin Exp $

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================

} {
    operator_id:integer,optional
    {mode "edit"}
    {return_url ""}
}

set page_title "Verifica utente"
set context [list [list [ad_pvt_home] [ad_pvt_home_name]] $page_title]
set buttons [list [list "verifica" edit]]
set system_name [ad_system_name]
set site_link [ad_site_home_link]

ad_form -name verif \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {

	operator_id:key
	
    {iter_no:text
        {label {Codice utente}}
        {html {size 20}}
    }
    {email_operator:text
        {label {Email}}
        {html {size 20}}
    }
} -on_request {

} -on_submit {

    if {![db_0or1row q "select o.email_operator                                         as email_operator_db
                             , coalesce(o.name,'') || ' ' || coalesce(o.first_name, '') as operator
                             , u.user_id
                          from iter_operators o
                             , users          u
                         where o.iter_no = :iter_no
                           and o.iter_no = u.username"]} {
	form set_error verif iter_no "Attenzione non è stato trovato un utente associato al codice operatore inserito."
	break
    } else {
	if {$email_operator_db ne $email_operator} {
            form set_error verif email_operator "Attenzione email non esiste nel profilo dell'operatore: $operator ."
            break
        }
    }

} -after_submit {

    set return_url [export_vars -base "recover-password-op?email=$email_operator&user_id=$user_id&username=$iter_no"]
    ad_returnredirect $return_url
    ad_script_abort
}

