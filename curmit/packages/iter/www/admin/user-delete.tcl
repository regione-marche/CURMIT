ad_page_contract {
    Cancella un manutentore regisdtrato

    @author   Claudio Pasolini
    @cvs-id   user-delete.tcl

} {
    user_id:integer
}

#ns_return 200 text/html "Funzione temporaneamente disabilitata"
#return

set package_id [ad_conn package_id]

ns_log notice "\nuser_id=$user_id"
# la cancellazione dell'utente non è garantita
set a [acs_user::delete -user_id $user_id -permanent]
#[dotlrn::remove_user_completely -user_id $user_id]

ns_return 200 text/html "utente $user_id cancellato"

ad_script_abort
