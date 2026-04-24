ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: iter-login.tcl

} {
    url
    dbname
    iter_code
}

set user_id [auth::require_login]

# N.B.
# Occorre risolvere il problema di quale operatore usare per il login, infatti iter_code
# deve essere suffissato con il numero dell'operatore.
# Per questa prova uso sempre il '01'

append iter_code "01"
set password [db_string -dbn $dbname user "select password from coimuten where id_utente = :iter_code"]
