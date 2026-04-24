ad_page_contract {

  @author Claudio Pasolini

} {
    {maintainer_id:multiple ""}
}

if {$maintainer_id eq ""} {
    ad_returnredirect -message "Non hai selezionato alcun manutentore!" maintainers-list
    ad_script_abort
}

db_transaction {

    db_dml validate "update iter_maintainers set
                         validated_p     = 't'
                       , validating_date = current_date
                     where maintainer_id in ([join $maintainer_id ,])"

} on_error {
    ah::transaction_error
}

ad_returnredirect -message "I manutentori selezionati sono stati validati e saranno propagati appena possibile." maintainers-list
ad_script_abort



