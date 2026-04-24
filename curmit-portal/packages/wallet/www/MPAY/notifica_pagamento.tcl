ad_page_contract {  
 
    Web Service che riceve la risposta da MPAY. 

    Il programma NON dispone di UI e deve essere chiamato via httpget dal 
    cliente del servizio. 

    Il programma salverà l'esito restituito da MPay e a sua volta darà esito positivo della ricezione 

    @author Simone Pesci

    @cvs-id notifica_pagamento.tcl 

    @param iter_code   Codice manutentore (o amministratore) in Iter

} {
    buffer
}

set buffer_input $buffer
set service   "notifica_pagamento"
set caller "$buffer-${service}"
set error_num 0
set messaggio ""

ns_log Notice "MPAY/${service};step01;inizio programma"


if {![db_0or1row q "select 1 
                      from mpay_paymentdata 
                     where buffer_input=:buffer_input
                       and creation_program='notifica_pagamento' limit 1"]} {

db_dml q "insert into mpay_paymentdata 
              ( data_input
              , buffer_input
              , creation_program)
              values (
                current_timestamp
              , :buffer_input
              , 'notifica_pagamento')"

} else {
    db_dml q "update mpay_paymentdata 
                 set data_input   = current_timestamp 
               where buffer_input = :buffer_input
                 and creation_program = 'notifica_pagamento'"
}

set current_timestamp             [db_string q "select to_char(current_timestamp,'yyyyMMddHH24mi')"]
set portaleid                     "PortaleMARBOL"

set end_point    "http://payertest.regione.marche.it/mpay/cart/extS2SPID.do" 
set xml_request $buffer
set buffer [MPAY_crea_buffer $buffer]

set scartato 0
with_catch msg_err_curl {

    db_dml q "update mpay_paymentdata
                 set data_notifica   = current_timestamp
                   , buffer_notifica = :buffer
               where buffer_input    = :buffer_input
                 and creation_program = 'notifica_pagamento'"

    set path_file_response [MPAY_call_ws $buffer $end_point $caller $xml_request]
        
    set file_id      [open $path_file_response r]
    fconfigure       $file_id -encoding utf-8
    set xml_response [read $file_id]
    close            $file_id

    db_dml q "update mpay_paymentdata
                 set data_response   = current_timestamp
                   , buffer_response = :xml_response
               where buffer_input    = :buffer_input
                 and creation_program = 'notifica_pagamento'"


    set root_id [ah_xml_get_root_id $xml_response]

    if {[string match "*<Buffer>*" $xml_response]} {
	ah_dom_explorer -node $root_id
	
	set orario_response $TagOrario
	
	set bufferdati_decript [::base64::decode $BufferDati]
	ns_log notice "simone bufferdati_decript notifica=$bufferdati_decript"

	set root_id_paymentdata [ah_xml_get_root_id $bufferdati_decript]
	ah_dom_explorer -node $root_id_paymentdata

	#qui salvo gli altri campi
	db_dml q "update mpay_paymentdata 
                 set portaleid               = :PortaleID
                   , numerooperazione        = :NumeroOperazione

                   , codiceutente            = :CodiceUtente
                   , codiceente              = :CodiceEnte
                   , tipoufficio             = :TipoUfficio
                   , codiceufficio           = :CodiceUfficio
                   , tipologiaservizio       = :TipologiaServizio
                   , numerodocumento         = :NumeroDocumento

                   , idordine                = :IDOrdine
                   , dataoraordine           = :DataOraOrdine
                   , idtransazione           = :IDTransazione
                   , dataoratransazione      = :DataOraTransazione
                   , sistemapagamento        = :SistemaPagamento
                   , sistemapagamentod       = :SistemaPagamentoD
                   , circuitoautorizzativo   = :CircuitoAutorizzativo
                   , circuitoautorizzativod  = :CircuitoAutorizzativoD
                   , importotransato         = :ImportoTransato
                   , importocommissioni      = :ImportoCommissioni
                   , importocommissioniente  = :ImportoCommissioniEnte
                   , esito                   = :Esito
                   , esitod                  = :EsitoD
                   , autorizzazione          = :Autorizzazione
               where buffer_input            = :buffer_input
                 and creation_program = 'notifica_pagamento'"


	set orario_inizio_validita [db_string q "select to_char((current_timestamp - interval '10 minute'),'yyyyMMddHH24mi')"]
	set ora_corrente [db_string q "select to_char((current_timestamp),'yyyyMMddHH24mi');"]
	
	
	if {$TagOrario < $orario_inizio_validita || $TagOrario > $ora_corrente} {
	    set CommitMsg "<CommitMsg><PortaleID></PortaleID><NumeroOperazione></NumeroOperazione><IDOrdine></IDOrdine><Commit>NOK</Commit></CommitMsg>"
	    
	    db_dml q "update mpay_paymentdata
                    set motivo_scarto   = 'Range di date non corretto: TagOrario di input=:TagOrario, momento del controllo = $ora_corrente'
                      , esito = 'KO'
                      , esitod = 'Non ha superto i controlli'
                  where buffer_input     = :buffer_input
                    and creation_program = 'notifica_pagamento'"
	    
	    set scartato 1
	    
	} 
    } else {
	set scartato 1
    }	

    if {$scartato ==0} {
	
	set hashCalcolato [MPAY_crea_hash $bufferdati_decript $TagOrario]
	    
	if {$hashCalcolato ne $Hash} {
	    set CommitMsg "<CommitMsg><PortaleID></PortaleID><NumeroOperazione></NumeroOperazione><IDOrdine></IDOrdine><Commit>NOK</Commit></CommitMsg>"
	    
	    db_dml q "update mpay_paymentdata
                     set motivo_scarto   = 'Hash non corretto: Hash di input=$Hash, Hash ricalcolato = $hashCalcolato'
                       , esito = 'KO'
                       , esitod = 'Non ha superto i controlli'
                  where buffer_input    = :buffer_input"
	    
	    set scartato 1
	    
	    }
    }
    
    if {$scartato == 0} {
	
	set root_pagamento_id [ah_xml_get_root_id $bufferdati_decript]
	ah_dom_explorer -node $root_pagamento_id
	
	set numerooperazione $NumeroOperazione
	
	set CommitMsg "<CommitMsg><PortaleID>$portaleid</PortaleID><NumeroOperazione>$NumeroOperazione</NumeroOperazione><IDOrdine>$IDOrdine</IDOrdine><Commit>OK</Commit></CommitMsg>"
	
	db_dml q "update mpay_paymentrequest 
                     set stato='NOTIFICATO' 
                   where numerooperazione = :NumeroOperazione"
	
    } else {
	
	db_dml q "update mpay_paymentrequest
                     set stato='SCARTATO'
                   where numerooperazione = :NumeroOperazione"
    }
    
    
} {

    set scartato 1
    db_dml q "update mpay_paymentdata
                     set motivo_scarto  = 'Errore nella lettura del buffer= $msg_err_curl'
                   where buffer_input   = :buffer_input
                     and creation_program = 'notifica_pagamento'"

    set CommitMsg "<CommitMsg><PortaleID></PortaleID><NumeroOperazione></NumeroOperazione><IDOrdine></IDOrdine><Commit>NOK</Commit>$msg_err_curl</CommitMsg>"

}

if {$scartato != 0} {
    set messaggio "ATTENZIONE transazione non avvenuta correttamente"
} else {

    db_1row q "select m.iter_code as cod_manutentore
                  , p.maintainer_id
                  , p.ente_portafoglio as f_ente_portafoglio
                  , p.tran_id  
               from mpay_paymentrequest p
         inner join iter_maintainers m
                 on m.maintainer_id  = p.maintainer_id
              where numerooperazione = :numerooperazione"
   
    if {$Esito eq "OK" || $Esito eq "OP"} {
	
	if {$tran_id ne ""} {
	    
	    db_1row q "select status as status_tran
                         from wal_transactions
                        where tran_id=:tran_id"
	    
	    if {$status_tran eq "L" && $Esito eq "OK"} {
	
		#faccio l'update solo se ho la notifica ok anche sull'altro ente. Altrimenti lascio pendente
		
		if {[db_0or1row q "select 1
                                     from mpay_paymentdata
                                    where numerooperazione = :NumeroOperazione
                                      and codiceente      != :CodiceEnte
                                      and esito = 'OK'"]} {

		    db_dml q "update wal_transactions 
                                 set status ='A'
                               where tran_id=:tran_id"

		    set messaggio "Transazione avvenuta correttamente"
		}
		
	    }

	}
	
    } else {

	if {$tran_id ne ""} {

	    db_dml q "update wal_transactions 
                         set status ='K'
                       where tran_id=:tran_id"
	    
	}
	
	db_dml q "update mpay_paymentrequest
                     set data_ricezione_pid = current_timestamp
                       , responce_pid       = :xml_response
                       , stato              = upper(:EsitoD)
                   where numerooperazione   = :numerooperazione"

	#ho ricevuto un esito diverso da OK o OP
	set messaggio "Attenzione: la transazione ha restituito il seguente esito: $Esito - $EsitoD."
	set scartato 1
    }
    
}

#pulisco i file delle chiamate
exec rm [acs_root_dir]/packages/wallet/www/MPAY/log/$caller-input.xml
exec rm [acs_root_dir]/packages/wallet/www/MPAY/log/$caller-paymentrequest.xml
exec rm [acs_root_dir]/packages/wallet/www/MPAY/log/$caller-trace.txt
exec rm [acs_root_dir]/packages/wallet/www/MPAY/log/$caller-response.xml

ns_return 200 text/xml $CommitMsg
