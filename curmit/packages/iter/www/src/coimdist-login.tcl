ad_page_contract {
    Login utente
    @author        Nicola Mortoni
    @creation_date 30/10/2002

    @cvs-id index.tcl
} {
    {cod_distr ""}

} -properties {
    page_title:onevalue
    context_bar:onevalue
}

set page_title   "Login"
set context_bar  "&nbsp;"
set form_name    "login"

if {![string equal $cod_distr ""]} {
    set msg "<tr><td><font color=red>Registrazione eseguita.
                                 <br>L'utente a lei assegnato &egrave;: <big><b>$cod_distr</b></big>
                                 <br>Password: <big><b>cambiami</b></big></font></td></tr>
             <tr><td>&nbsp;</td></tr>"
} else {
    set msg "N"
}

iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)

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
 
    ad_returnredirect "coimddts-isrt?$utn_cde"
    ad_script_abort
}

ad_return_template
