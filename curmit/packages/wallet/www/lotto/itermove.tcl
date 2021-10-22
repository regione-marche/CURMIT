ad_page_contract {  
 
    Web Service in stile REST per caricare un movimento in wal_transactions.

    Il programma NON dispone di UI e deve essere chiamato via httpget dal 
    cliente del sevizio. Restituisce una lista con due valori:
    1. return code può assumere il valore 'OK' oppure descrivere l'errore
    2. id movimento o zero in caso di errore 

    @author C. Pasolini

    @cvs-id itermove.tcl 

    @param iter_code      codice manutentore (o amministratore)
    @param body_id        codice Ente
    @param tran_type_id   tipo movimento
    @param payment_type   tipo pagamento char(1)
    @param payment_date   data movimento in formato ANSI
    @param reference      identificativo univoco del modello H di iter
    @param description    causale del movimento
    @param amount         importo (11,2)

} {
    iter_code
    body_id
    tran_type_id
    payment_type
    payment_date
    reference
    description
    amount
}

    # imposto dbn
#    if {[db_get_database] eq "wallet-dev"} {
#	set curit_dbn "curit-dev"
#    } elseif {[db_get_database] eq "wallet-sta"} {
#	set curit_dbn "curit-sta"
#    } else {
#	set curit_dbn "curit"
#    }

wallet_check_login

set sw_usato_dal_portale [parameter::get_from_package_key -package_key wallet -parameter sw_usato_dal_portale]

if {$sw_usato_dal_portale == 1} {
    set query_titolare "
    select holder_id
         , wallet_id
         , substr(name,  1, 24) as cust_header
         , substr(name, 25, 24) as cust_header_2
         , substr(name, 49, 24) as cust_header_3
         , substr(name, 73, 24) as cust_header_4
         , fiscal_code
      from wal_holders
     where 'MA' || lpad(cast(holder_id as varchar(10)),6,0) = :iter_code
    "
} else {
    set query_titolare "
    select substr(cod_manutentore,3,length(cod_manutentore)) as holder_id
         , wallet_id
         , substr(cognome,  1, 24) as cust_header
         , substr(cognome, 25, 24) as cust_header_2
         , substr(cognome, 49, 24) as cust_header_3
         , substr(cognome, 73, 24) as cust_header_4
         , cod_fiscale as fiscal_code
      from coimmanu
     where cod_manutentore = :iter_code
    "
}

# iter_code può appartenere ad un manutentore o ad un amministratore di condominio
if {![db_0or1row query $query_titolare]} {
#    if {![db_0or1row trustee "
#        select trustee_id as holder_id, 
#           wallet_id,
#           substr(name,  1, 24) as cust_header,
#           substr(name, 25, 24) as cust_header_2,
#           substr(name, 49, 24) as cust_header_3,
#           substr(name, 73, 24) as cust_header_4,
#           fiscal_code
#        from iter_trustees
#        where iter_code = :iter_code"]} {
        ns_return 200 text/plain [list "Codice $iter_code errato o non autorizzato." 0]
        ad_script_abort
#    }
}


if {$tran_type_id eq ""} {
    # ottengo tipo movimento
    set tran_type_id [parameter::get_from_package_key -package_key wallet -parameter tran_type_minus]
}

# ottengo tipo pagamento
set pay_type_id [parameter::get_from_package_key -package_key wallet -parameter cash_pay_type]

# decodifico Ente
if {![db_0or1row body "
    select substr(body_name,  1, 24) as body_header,
           substr(body_name, 25, 24) as body_header_2
    from wal_bodies
    where body_id = :body_id"]} {
    #ns_return 200 text/plain [list "Codice Ente $body_id errato." 0]
    #ad_script_abort
    set body_header ""
    set body_header_2 ""
}

db_transaction {

    # registro pagamento su tabella movimenti
    set transaction_id [db_dml transaction_new "
            insert into wal_transactions (
                tran_id       
               ,holder_id     
               ,body_id       
               ,tran_type_id  
               ,pay_type_id   
               ,payment_date  
               ,creation_date 
               ,currency_date
               ,description   
               ,reference     
               ,amount        
               ,currency      
               ,currency_amount
               ,filename  
            ) values (
                nextval('wal_transactions_seq')
               ,:holder_id     
               ,:body_id
               ,:tran_type_id        
               ,:pay_type_id   
               ,to_date(:payment_date, 'YYYY-MM-DD')  
               ,current_date
               ,to_date(:payment_date, 'YYYY-MM-DD')  
               ,:description
               ,:reference
               ,:amount
               ,null
               ,null
               ,:reference  
            )"]

    # registro movimento su tabella di log
    db_dml log_new "
            insert into wal_log_payments (
                log_id
               ,filename      
               ,creation_date 
               ,body_header   
               ,body_header_2 
               ,amount        
               ,wallet_id     
               ,cust_header   
               ,cust_header_2 
               ,cust_header_3 
               ,cust_header_4 
               ,fiscal_code   
               ,payment_date  
               ,pos           
               ,payment_type  
               ,reference
            ) values (
                nextval('wal_log_payments_seq')
               ,:reference     
               ,current_date 
               ,:body_header   
               ,:body_header_2 
               ,:amount 
               ,:wallet_id     
               ,:cust_header   
               ,:cust_header_2 
               ,:cust_header_3 
               ,:cust_header_4 
               ,:fiscal_code   
               ,to_date(:payment_date, 'YYYY-MM-DD')  
               ,null
               ,:payment_type  
               ,:reference
            )"
	    
} on_error {
    ns_return 200 text/plain [list "Errore imprevisto durante l'aggiornamento: $errmsg" 0] 
    ad_script_abort
}

ns_return 200 text/plain [list "OK" $transaction_id]


