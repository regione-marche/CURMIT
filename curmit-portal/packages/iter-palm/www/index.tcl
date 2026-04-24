ad_page_contract {
    Login utente
    @author        Nicola Mortoni
    @creation_date 30/10/2002

    @cvs-id index.tcl
} -properties {
    page_title:onevalue
    context_bar:onevalue
}

set page_title   "Login"
set context_bar  "&nbsp;"
set form_name    "login"

form create $form_name

element create $form_name utn_cde \
        -label "Codice Utente" \
	-widget text \
	-datatype text \
	-html {size 20 maxlength 10}

element create $form_name utn_psw \
        -label "Password" \
	-widget password \
	-datatype text \
	-html {size 20 maxlength 10}

element create $form_name submit \
        -label "Invia" \
        -widget submit \
        -datatype text


if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set utn_cde      [element::get_value $form_name utn_cde]
    set form_utn_psw [element::get_value $form_name utn_psw]

    set error_num 0
    if {[db_0or1row sel_user_login ""] == 0
    } {
        incr error_num
        element::set_error $form_name utn_cde "Codice utente non valido"
    } else {
        if {$password != $form_utn_psw} {
            incr error_num
            element::set_error $form_name utn_psw "Password errata"
        }
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }
 
  # ad_set_client_property -persistent t iter rows_per_page $utn_rgh
  # questo sopra non funziona per tutta la durata della sessione!!!

  # crea cookie utenti e permessi
    ad_set_cookie -replace t -path / iter_login_[ns_conn location] $id_utente
    ad_set_cookie -replace t -path / iter_rows_[ns_conn location] $rows_per_page

    ad_returnredirect main
    ad_script_abort
}

ad_return_template
