ad_page_contract {

    One time fix.    
    Questo programma aggiorna il database di curit partendo da una istanza di iter
    da cui leggo un set di manutentori e amministratori.    

    @author Claudio Pasolini
    @cvs-id $Id: fix2.tcl

} {
}


# amministratori
db_foreach -dbn itercmbg getman "
    select c.cod_cittadino, c.cod_fiscale, u.password
    from coimcitt c, coimuten u
    where c.cod_cittadino = u.id_utente
      and c.cod_cittadino between 'AM001263' and 'AM001282'
    order by c.cod_cittadino
" {

    ns_log notice "\n ... letto amministratore $cod_cittadino $cod_fiscale $password"

    db_1row tid "select trustee_id, office_id from iter_trustees where fiscal_code = :cod_fiscale"
    lappend trustees_to_notify [list $trustee_id $office_id]

    ns_log notice "\n ... id $trustee_id $office_id"

    # aggiorno trustees
    db_dml updtr "
            update iter_trustees set 
                validating_date = current_date - 1
              , iter_code       = :cod_cittadino 
              , password        = :password
              , validated_p     = 't'
            where trustee_id = :trustee_id"

    ns_log notice "\n ... aggiornato id $trustee_id"
}


# notifica gli amministratori di condominio
foreach trustee $trustees_to_notify {
    util_unlist $trustee trustee_id office_id

    if {$office_id ne ""} {
	iter::notify_trustee_with_office -trustee_id $trustee_id -office_id $office_id
    } else {
	iter::notify_trustee -trustee_id $trustee_id
    }
}

ns_return 200 text/html Fatto!
