ad_page_contract {
    Login su I.Ter. del sito passato come parametro
    usando l'utente corrente (che ha fatto login su questo sito)

    @author Nicola Mortoni
    @date   26/10/2006

    @cvs_id accesso-enti-gest.tcl
} {
     sito
    {nome_funz ""}
}

if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
}

# leggo nome e cognome dell'utente
if {![db_0or1row sel_uten ""]
} {
    iter_return_complaint  "Codice utente non valido."
    return
}


set form:mode "edit"
set form:id   "login"
set utn_cde   $id_utente
set utn_psw   $password
set submit    ""
set url       [export_url_vars utn_cde utn_psw submit]

# ns_return 200 text/plain $sito/index?form:mode=edit&form:id=login&$url

ad_returnredirect $sito/index?form:mode=edit&form:id=login&$url
