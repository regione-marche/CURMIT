ad_page_contract {

    Imposto la preferenza dell'utente fra menu grafico e menu html

    @author  Nicola Mortoni
} {
}

set id_utente [iter_get_id_utente]

with_catch error_msg {
    db_transaction {
        db_dml query "
        update coimuten
           set flag_menu_yui = case
                               when flag_menu_yui is true then
                                    false
                               else
                                    true
                               end
         where id_utente = :id_utente"
    }

    # azzero la cache del menù dinamico per l'utente corrente
    ns_cache flush dynamic_menu_cache $id_utente

} {
    iter_return_complaint "Spiacente, ma il DBMS ha restituito il
    seguente messaggio di errore <br><b>$error_msg</b><br>
    Contattare amministratore di sistema e comunicare il messaggio
    d'errore. Grazie."
}


ad_returnredirect main
ad_script_abort
