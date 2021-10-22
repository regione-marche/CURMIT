ad_page_contract {
    Modifica i codici impianto secoondo i target della regione

    @author        Valentina catte
    @creation-date 28/03/2007

    @cvs-id recupero-portafoglio
}

set conta_upd 0
db_foreach sel_dich "select a.cod_dimp
                          , a.cod_manutentore
                          , a.gen_prog
                          , a.costo
                          , b.cod_potenza
                       from coimdimp a
                          , coimaimp b
                      where a.cod_impianto = b.cod_impianto
                        and a.data_controllo >= '2008-08-01'
                        and a.data_controllo < '2008-08-06'
                        and a.importo_tariffa is null
                        and a.tariffa is null" {


    if {[db_0or1row sel_tari_contributo "select a.importo as importo_tariffa
                                           from coimtari a
                                          where a.cod_potenza = :cod_potenza
                                            and a.tipo_costo  = '7' 
                                            and a.cod_listino = '0'"] == 0} {
	ns_log notice "Recupero portafoglio: tariffa non trovata ($cod_potenza)"
    } else {
	set oggi [db_string sel_date "select current_date"]
	set database [db_get_database]
	set reference "$cod_dimp $database"
	set url "lotto/itermove?iter_code=$cod_manutentore&body_id=3&tran_type_id=2&payment_type=1&payment_date=$oggi&reference=$reference&description=pagamento&amount=$importo_tariffa"
	set data [iter_httpget_wallet $url]
	array set result $data
	set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
	if {$risultato != "OK"} {
	    ns_log notice "Recupero portafoglio: transazione non avvenuta correttamente $result(page)"
	} else {
	    db_dml upd_dimp "update coimdimp set importo_tariffa = :importo_tariffa, tariffa = '7' where cod_dimp = :cod_dimp"
	    db_dml ins_trans "insert
                  into coimtrans_manu
                     ( id_transazione
                     , cod_dimp
                     , num_gen
                     , rimborso_reg
                     , costo_bollino
                     , azione
                     , data_ora
                     , utente)
                values
                     (nextval('coimtrans_manu_s')
                     ,:cod_dimp
                     ,:gen_prog
                     ,:importo_tariffa
                     ,:costo
                     ,'I'
                     ,current_timestamp
                     ,'rec_portaf')"
	    incr conta_upd
	}
    }
}
ns_log notice "Recupero portafoglio: Dichiarazioni corrette $conta_upd"
