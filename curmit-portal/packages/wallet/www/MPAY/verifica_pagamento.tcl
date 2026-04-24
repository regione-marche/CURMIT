ad_page_contract {  
 
    Web Service che riceve la risposta da MPAY. 

    Il programma NON dispone di UI e deve essere chiamato via httpget dal 
    cliente del servizio. 

    Il programma salverà l'esito restituito da MPay e crea il moviento su curmit. 
    Se la transazione è pendente lo crea in stato "In lavorazione"

    @author Simone Pesci

    @cvs-id verifica_pagamento.tcl 

    @param iter_code   Codice manutentore (o amministratore) in Iter

} {
    buffer
}

set return_url ""
db_dml q "insert into mpay_paymentdata 
              ( data_input
              , buffer_input
              , creation_program)
              values (
                current_timestamp
              , :buffer
              , 'verifica_pagamento')"


set service   "verifica_pagamento"
set caller "$buffer-${service}"
set error_num 0
set messaggio ""

ns_log Notice "MPAY/${service};step01;inizio programma"

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
               where buffer_input    = :xml_request"

    set path_file_response [MPAY_call_ws $buffer $end_point $caller $xml_request]
        
    set file_id      [open $path_file_response r]
    fconfigure       $file_id -encoding utf-8
    set xml_response [read $file_id]
    close            $file_id


    db_dml q "update mpay_paymentdata
                 set data_response   = current_timestamp
                   , buffer_response = :xml_response
               where buffer_input    = :xml_request"


    set root_id [ah_xml_get_root_id $xml_response]

    if {[string match "*<Buffer>*" $xml_response]} {
	ah_dom_explorer -node $root_id
	
	set orario_response $TagOrario
	
	set bufferdati_decript [::base64::decode $BufferDati]
	ns_log notice "simone bufferdati_decript verifica=$bufferdati_decript"

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
               where buffer_input            = :xml_request"


	set orario_inizio_validita [db_string q "select to_char((current_timestamp - interval '10 minute'),'yyyyMMddHH24mi')"]
	set ora_corrente [db_string q "select to_char((current_timestamp),'yyyyMMddHH24mi');"]
	
	
	if {$TagOrario < $orario_inizio_validita || $TagOrario > $ora_corrente} {
	    set CommitMsg "<?xml version=\"1.0\" encoding=\"UTF-8\"?><CommitMsg><PortaleID></PortaleID><NumeroOperazione></NumeroOperazione><IDOrdine></IDOrdine><Commit>NOK</Commit></CommitMsg>"
	    
	    db_dml q "update mpay_paymentdata
                    set motivo_scarto   = 'Range di date non corretto: TagOrario di input=:TagOrario, momento del controllo = $ora_corrente'
                  where buffer_input    = :xml_request"
	    
	    set scartato 1
	    
	} 
    } else {
	set scartato 1
    }	

    if {$scartato ==0} {
	
	set hashCalcolato [MPAY_crea_hash $bufferdati_decript $TagOrario]
	    
	if {$hashCalcolato ne $Hash} {
	    set CommitMsg "<?xml version=\"1.0\" encoding=\"UTF-8\"?><CommitMsg><PortaleID></PortaleID><NumeroOperazione></NumeroOperazione><IDOrdine></IDOrdine><Commit>NOK</Commit></CommitMsg>"
	    
	    db_dml q "update mpay_paymentdata
                     set motivo_scarto   = 'Hash non corretto: Hash di input=$Hash, Hash ricalcolato = $hashCalcolato'
                  where buffer_input    = :xml_request"
	    
	    set scartato 1
	    
	    }
    }
    
    if {$scartato == 0} {
	
	set root_pagamento_id [ah_xml_get_root_id $bufferdati_decript]
	ah_dom_explorer -node $root_pagamento_id
	
	set numerooperazione $NumeroOperazione
	
	set CommitMsg "<?xml version=\"1.0\" encoding=\"UTF-8\"?><CommitMsg><PortaleID>$portaleid</PortaleID><NumeroOperazione>$NumeroOperazione</NumeroOperazione><IDOrdine>$IDOrdine</IDOrdine><Commit>OK</Commit></CommitMsg>"
	
	#set commit_msg "<CommitMsg><PortaleID>$portaleid</PortaleID><NumeroOperazione>$NumeroOperazione</NumeroOperazione><IDOrdine>$IDOrdine</IDOrdine><Commit>OK</Commit></CommitMsg>"
	
	db_dml q "update mpay_paymentrequest 
                     set stato='VERIFICATO' 
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
                   where buffer_input   = :xml_request"

    set CommitMsg "<?xml version=\"1.0\" encoding=\"UTF-8\"?><CommitMsg><PortaleID></PortaleID><NumeroOperazione></NumeroOperazione><IDOrdine></IDOrdine><Commit>NOK</Commit></CommitMsg>"

}

if {$scartato != 0} {
    set messaggio "ATTENZIONE transazione non avvenuta correttamente"
} else {

    db_1row q "select m.iter_code as cod_manutentore
                  , p.maintainer_id
                  , p.ente_portafoglio as f_ente_portafoglio
                  , p.tran_id
                  , p.importo + p.importo_reg as importo_comlessivo_transazione  
               from mpay_paymentrequest p
         inner join iter_maintainers m
                 on m.maintainer_id  = p.maintainer_id
              where numerooperazione = :numerooperazione"
	
    
    set return_url "/iter-portal/ec?maintainer_id=$maintainer_id&f_ente_portafoglio=$f_ente_portafoglio"    

    if {$Esito eq "OK" || $Esito eq "OP"} {

	if {$Esito eq "OK"} {
	    set status "A"
	} 
	
	if {$Esito eq "OP"} {
	    set status "L"
	}
	
	if {$tran_id ne ""} {
	    
	    #non dovrebbe mai entrare ma per sicurezza lo lascio
		
	    set messaggio "ATTENZIONE: Ricarica già effettuata."
		
	} elseif {![db_0or1row q "select 1
                                     from mpay_paymentdata
                                    where numerooperazione = :NumeroOperazione
                                      and codiceente      != :CodiceEnte
                                      and esito = 'OK'"]} {
	    #rom01 Aggiunta elseif e contenuto
	    #ROMXX mettere controllo che guarda se esiste un altro payment_data a esito OK con CodiceEnte diverso
	    #eichiamo l'itermove solo se ho la notifica ok anche sull'altro ente. Altrimenti lascio pendente
	    set messaggio "ATTENZIONE: Ricarica non possibile."
	} else {
	    
	    set DataOraTransazione [string range $DataOraTransazione 0 7]
	    set payment_date [db_string q "select :DataOraTransazione::date"]
	    
	    set reference ""
	    set oggi [db_string sel_date "select current_date"]
	    
	    set link_description "Ricarica effettuata mediante ordine N. $IDOrdine"
	    
	    #io faccio un unico movimento per entrambi gli importi richiesti
	    set amount [expr $importo_comlessivo_transazione/100.00]
	    
	    set url "lotto/itermove?iter_code=$cod_manutentore&body_id=&tran_type_id=1&payment_type=1&payment_date=$payment_date&reference=$reference&description=$link_description&amount=$amount&ente_portafoglio=$f_ente_portafoglio&status=$status&mpay_numerooperazione=$numerooperazione"
	    
	    set data [iter_httpget_wallet $url]
	    
	    array set result $data
	    
	    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
	    if {$risultato == "OK"} {
		set transaz_eff "T"
		
		set transactions_id [lindex $result(page) 1]
		
		db_dml q "update mpay_paymentrequest
                     set data_ricezione_pid = current_timestamp
                       , responce_pid       = :xml_response
                       , stato              = upper(:EsitoD)
                   where numerooperazione   = :numerooperazione"
		
		if {$Esito eq "OK"} {
		    set messaggio "Transazione avvenuta correttamente"
		}
		
		if {$Esito eq "OP"} {
		    set messaggio "Transazione pendente. La ricarica verrà effettuata alla conferma del pagamento"
		}
		
	    } else {
		set scartato 1
		set messaggio "Transazione non avvenuta correttamente" 
	    }
   
	}
	
    } else {

	db_dml q "update mpay_paymentrequest
                     set data_ricezione_pid = current_timestamp
                       , responce_pid       = :xml_response
                       , stato              = upper(:EsitoD)
                   where numerooperazione   = :numerooperazione"

	#ho ricevuto un esito diverso da OK o OP
	set messaggio "Attenzione: la transazione ha restituito il segunete esito: $Esito - $EsitoD."
	set scartato 1
    }
    
}

#if {$scartato !=0 && $return_url eq ""} {
#    set return_url "/iter-portal/" 
#    exec rm $path_file_response
#}

exec rm [acs_root_dir]/packages/wallet/www/MPAY/log/$caller-input.xml
exec rm [acs_root_dir]/packages/wallet/www/MPAY/log/$caller-paymentrequest.xml
exec rm [acs_root_dir]/packages/wallet/www/MPAY/log/$caller-trace.txt
exec rm [acs_root_dir]/packages/wallet/www/MPAY/log/$caller-response.xml

ad_returnredirect -html -message $messaggio $return_url
ad_returnredirect $return_url
ad_script_abort

