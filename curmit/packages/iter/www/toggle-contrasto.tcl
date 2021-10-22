ad_page_contract {
    
    Aggiorna coimuten.flag_alto_contrasto

} {
}

set id_utente [iter_get_id_utente]

with_catch error_msg {
    db_transaction {
	db_dml query "
        update coimuten
           set flag_alto_contrasto = case
                                     when flag_alto_contrasto is true then 
                                          false
                                     else
                                          true
                                     end
         where id_utente = :id_utente"
    }
} {
    iter_return_complaint "Spiacente, ma il DBMS ha restituito il
    seguente messaggio di errore <br><b>$error_msg</b><br>
    Contattare amministratore di sistema e comunicare il messaggio
    d'errore. Grazie."
}

ad_returnredirect main
ad_script_abort
