ad_page_contract {

  @author Claudio Pasolini
  @cvs-id welcome.tcl

} {
    {maintainer_id ""}
    {trustee_id ""}
}

set page_title "Benvenuto"

if {[db_get_database] eq "curit-dev"} {
    set base_url "http://wallet.sviluppo.curit.it"
} elseif {[db_get_database] eq "curit-sta"} {
    set base_url "http://wallet.staging.curit.it"
} else {
    set base_url "http://wallet.curit.it"
}

set base_url ""

if {$maintainer_id ne ""} {
    db_1row maint "
        select name, wallet_id, iter_code, validated_p, approved_p, cait_id 
        from iter_maintainers 
        where maintainer_id = :maintainer_id"
    if {$cait_id eq ""} {
        # set context [list [list services "Servizi per i manutentori"] $page_title ]
       set context [list [list /iter-portal/services "Servizi per i manutentori"] $page_title ]
	set party_type maintainer
    } else {
        # set context [list [list cait/services "Servizi per i manutentori"] $page_title ]
       set context [list [list /iter-portal/cait/servcait "Servizi per i manutentori"] $page_title ]
	set party_type cait
    }
} elseif {$trustee_id ne ""} {
    db_1row trustee "
        select name, wallet_id, iter_code, validated_p, approved_p, office_id
        from iter_trustees 
        where trustee_id = :trustee_id"
    if {$office_id eq ""} {
        # set context [list [list jbuild/servtrust "Servizi per gli amministratori"] $page_title ]
        set context [list [list /iter-portal/jbuild/servtrust "Servizi per gli amministratori"] $page_title ]
	set party_type trustee
    } else {
        # set context [list [list offices/trustees-services "Servizi per gli amministratori"] $page_title ]
        set context [list [list /iter-portal/jbuild/servtrust "Servizi per gli amministratori"] $page_title ]
	set party_type office
    }
} else {
    ad_returnredirect -message "Spiacente, ma questa funzione è accessibile solo a soggetti autorizzati." /
    ad_script_abort
}

# invoco il web service balance sull'istanza wallet
set url "/lotto/balance?iter_code=$iter_code"
#sim set data [ad_httpget -url $url -timeout 50]
set data [iter_httpget_wallet $url];#sim
array set result $data

util_unlist $result(page) retcode balance wallet_id

set wallet_credit_pretty [ah::edit_num $balance 2]




