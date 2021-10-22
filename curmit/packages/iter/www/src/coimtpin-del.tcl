ad_page_contract {
    Lista tabella "coimtpin"

    @author                  Romitti Luca
    @creation-date           08/04/2019
    @cvs-id coimtpin-del.tcl 
} { 
    cod_coimtpin
    cod_manutentore
    {nome_funz ""}
    {nome_funz_caller ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
}

with_catch error_msg {
    db_transaction {
	db_dml dml_coimtpin_manu  "delete from coimtpin_manu
                 where cod_coimtpin = :cod_coimtpin"
    }
} {
    iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
}

set link_list [export_url_vars nome_funz nome_funz_caller caller cod_manutentore]
set return_url "coimtpin-list?$link_list"

ad_returnredirect $return_url
ad_script_abort
