ad_page_contract {
    Login utente
    @author        Nicola Mortoni
    @creation_date 30/10/2002

    @cvs-id index.tcl

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    nic01 04/06/2014 Aggiunto utilizzo dei parametri password_gg_durata e password_gg_preavviso
    nic01            per evitare di modificare questo sorgente sulle varie istanze

} -properties {
    page_title:onevalue
    context_bar:onevalue
}

set page_title   "Login"
set context_bar  "&nbsp;"
set form_name    "login"

set current_date [db_string query "select to_char(current_date,'YYYY-MM-DD')"]
iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)

form create $form_name

element create $form_name utn_cde \
    -label "Codice Utente" \
    -widget text \
    -datatype text \
    -html {size 30 maxlength 10}

element create $form_name utn_psw \
    -label "Password" \
    -widget password \
    -datatype text \
    -html {size 30 maxlength 10}

element create $form_name submit \
    -label "Invia" \
    -widget submit \
    -datatype text


if {[form is_valid $form_name]} {

  # form valido dal punto di vista del templating system

    set utn_cde      [element::get_value $form_name utn_cde]
    set form_utn_psw [element::get_value $form_name utn_psw]

    set error_num 0
    set data "2050-01-01"
    if {[db_0or1row sel_user_login ""] == 0} {
        incr error_num
        element::set_error $form_name utn_cde "Codice utente non valido"
    } else {
        if {$password != $form_utn_psw} {
            incr error_num
            element::set_error $form_name utn_psw "Password errata"
        }
    }

    set password_gg_durata    [parameter::get_from_package_key -package_key iter -parameter password_gg_durata    -default 91];#nic01
    set password_gg_preavviso [parameter::get_from_package_key -package_key iter -parameter password_gg_preavviso -default 81];#nic01
    
    set datascadpsw [db_string query "select to_char(to_date(:data,'YYYY-MM-DD') + $password_gg_durata   ,'YYYY-MM-DD')"]
    set dataprescad [db_string query "select to_char(to_date(:data,'YYYY-MM-DD') + $password_gg_preavviso,'YYYY-MM-DD')"]

    if {$current_date > $dataprescad} {
	set messaggioscad "Password in scadenza il $datascadpsw" 
    } else {
	set messaggioscad ""
    }

    if {$current_date > $datascadpsw} {
	incr error_num
	element::set_error $form_name utn_psw "<a href=/iter/utenti/coimcpwd-gest?funzione=M&nome-funz=main&id_utente=$id_utente> Cambia Password </a>"
    }
    

    if {$error_num > 0} {
        ad_return_template
        return
    }
 
    # ad_set_client_property -persistent t iter rows_per_page $utn_rgh
    # questo sopra non funziona per tutta la durata della sessione!!!

    # occorerebbe mettere in una sorta di var di sessione lo user che effettua la login
    # per confrontarlo con quello messo nel cookie
    ad_set_client_property iter logged_user_id $id_utente
    set id_utente_loggato_vero [ad_get_client_property iter logged_user_id]
    set clientip [lindex [ns_set iget [ns_conn headers] x-forwarded-for] end]
    set session_id [ad_conn session_id]
    set adsession [ad_get_cookie "ad_session_id"]
    
    # crea cookie utenti e permessi
    ad_set_cookie -replace t -path / iter_login_[ns_conn location] $id_utente
    ad_set_cookie -replace t -path / iter_rows_[ns_conn location] $rows_per_page
    
    # Creo un log degli utenti che si sono loggati
    ns_log Notice "********-AUTH-CHECK-LOGIN-ENTER        ;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;loggato nel sistema;$adsession;"
    
    ad_returnredirect -message $messaggioscad main   
    #    ad_script_abort
}

ad_return_template
