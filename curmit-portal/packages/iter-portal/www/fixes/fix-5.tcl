ad_page_contract {

    One time fix.    
    Questo programma aggiorna il database di curit partendo da una istanza di iter
    da cui leggo un set di manutentori nuovi.    

    @author Claudio Pasolini
    @cvs-id $Id: fix5.tcl

} {
}

ns_logroll

# manutentori
db_foreach -dbn itercmbg getman "
    select m.cod_manutentore, m.cod_fiscale, m.cod_piva, o.cod_opma, o.codice_fiscale, u.password
    from coimmanu m, coimopma o, coimuten u
    where m.cod_manutentore = o.cod_manutentore
      and o.cod_opma        = u.id_utente
      and o.cod_manutentore between 'MA008303' and 'MA008308'
    order by o.cod_opma
" {

   ns_log notice "\n ... letto manutentore $cod_manutentore $cod_fiscale $cod_piva $cod_opma $codice_fiscale $password"

   db_1row id "select maintainer_id, cait_id from iter_maintainers where fiscal_code = :cod_fiscale and iva_code = :cod_piva"
   lappend maintainers_to_notify [list $maintainer_id $cait_id]

   ns_log notice "\n ... id $maintainer_id $cait_id"

    # aggiorno maintainers
    db_dml updman "
            update iter_maintainers set 
                validating_date = current_date - 1
              , iter_code       = :cod_manutentore 
              , validated_p     = 't'
            where maintainer_id = :maintainer_id"

    ns_log notice "\n ... aggiornato id $maintainer_id"

    # aggiorno operators
        db_dml updop "
            update iter_operators set 
                iter_no  = :cod_opma, 
                password = :password 
            where fiscal_code = :codice_fiscale"
        ns_log notice "\n ... aggiornato operatore con cod. fiscale $codice_fiscale"
}

# devo notificare i manutentori, diversificando la mail se sono
# associati ad un cait
# notifica manutentori 
foreach maintainer $maintainers_to_notify {
    util_unlist $maintainer maintainer_id cait_id

    if {$cait_id ne ""} {
	iter::notify_maintainer_with_cait -maintainer_id $maintainer_id -cait_id $cait_id
    } else {
	iter::notify_maintainer -maintainer_id $maintainer_id
    }
}

ns_return 200 text/html Fatto!
