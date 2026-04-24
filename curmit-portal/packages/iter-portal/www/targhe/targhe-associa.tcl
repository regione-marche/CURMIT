ad_page_contract {  
 
    Web Service salvo utilizzo della targa

    Il programma NON dispone di UI e deve essere chiamato via httpget dal 
    cliente del servizio. Restituisce una lista con diversi valori:
      1. return code può assumere il valore 'OK' oppure descrivere l'errore

    @author Simone Pesci

    @cvs-id targhe-associa

    @param targa              Targa inserita sull'impianto in iter
    @param nome_db_utilizzo   Db dell'istanza in cui viene usata la targa
    @param cod_impianto_targa Codice impianto su cui è salvata la targa
    @param flag_tipo_impianto Indica se l'impianto in cui viene associata è delcaldo o del freddo

} {
    targa    
    nome_db_utilizzo
    cod_impianto_targa
    flag_tipo_impianto
}

wallet_check_login

db_transaction {

    if {$flag_tipo_impianto eq "R"} {
	db_dml upd "update coimtarg
                       set nome_db_utilizzo    = :nome_db_utilizzo
                         , cod_impianto_caldo  = :cod_impianto_targa
                     where upper(targa)      = upper(:targa)"

    } else {
	db_dml upd "update coimtarg
                       set nome_db_utilizzo     = :nome_db_utilizzo
                         , cod_impianto_freddo  = :cod_impianto_targa
                     where upper(targa)       = upper(:targa)"
    }

} on_error {
    ns_return 200 text/plain [list "Errore imprevisto durante l'aggiornamento: $errmsg" ]
    ad_script_abort
}

ns_return 200 text/plain [list "OK"]

