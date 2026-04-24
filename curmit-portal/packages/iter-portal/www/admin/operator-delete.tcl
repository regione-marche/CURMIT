ad_page_contract {
    Deletes an operator

    @author Claudio Pasolini
    @cvs-id operator-delete.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    sim01 19/02/2020 E' possibile eliminare solo gli operatori non ancora propagati. Tolto il vecchio
    sim01            controllo su approved_p.

} {
    operator_id:integer
    maintainer_id
}

db_1row query "select approved_p from iter_maintainers where maintainer_id = :maintainer_id"

set return_url "operators-list?maintainer_id=$maintainer_id";#sim01

#sim01 if {[string equal $approved_p "t"]} {
    #sim01 ad_returnredirect -message "Spiacente, operazione non consentita." /
    #sim01 ad_script_abort
#sim01}

db_1row query "select iter_no 
                 from iter_operators 
                where operator_id = :operator_id 
                  and maintainer_id = :maintainer_id";#sim01
if {![string equal $iter_no ""]} {#sim01 if e suo contenuto
    ad_returnredirect -message "Spiacente, non è possibile eliminare un operatore già propagato. E' possibile disattivarlo attraverso la modifica " $return_url
    ad_script_abort
}

db_transaction {

    db_dml query "delete from iter_operators where operator_id = :operator_id and maintainer_id = :maintainer_id"
    
} on_error {
    ah::transaction_error
}

ad_returnredirect "operators-list?maintainer_id=$maintainer_id"

ad_script_abort
