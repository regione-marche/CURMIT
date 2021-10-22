ad_page_contract {  
 
    Web Service in stile REST per caricare un movimento in wal_transactions.

    Il programma NON dispone di UI e deve essere chiamato via httpget dal 
    cliente del sevizio. Restituisce una lista con due valori:
    1. return code può assumere il valore 'OK' oppure descrivere l'errore
    2. id movimento o zero in caso di errore 

    @author C. Pasolini

    @cvs-id move.tcl 

    @param wallet_id      codice portafoglio
    @param body_id        codice Ente
    @param tran_type_id   tipo movimento
    @param payment_type   tipo pagamento char(1)
    @param payment_date   data movimento in formato ANSI
    @param reference      identificativo univoco del modello H di iter
    @param description    causale del movimento
    @param amount         importo (11,2)

} {
    wallet_id
    body_id
    tran_type_id
    pay_type_id
    payment_date
    reference
    filename
    description
    amount
    {creation_date ""}
}
wallet_check_login
if {$tran_type_id eq ""} {
    # ottengo tipo movimento
    set tran_type_id [parameter::get_from_package_key -package_key wallet -parameter tran_type_minus]
}

# ottengo titolare da codice portafoglio
if {![db_0or1row holder "select holder_id from wal_holders where wallet_id = :wallet_id"]} {
    ns_return 200 text/plain [list "Codice portafoglio $wallet_id errato." 0]
    ad_script_abort
}

# decodifico Ente se valorizzato
if {![string equal $body_id ""]} {
    if {![db_0or1row body "
    select substr(body_name,  1, 24) as body_header,
           substr(body_name, 25, 24) as body_header_2
    from wal_bodies
    where body_id = :body_id"]} {
	ns_return 200 text/plain [list "Codice Ente $body_id errato." 0]
	ad_script_abort
    }
} else {
    set body_header ""
    set body_header_2 ""
}
# decodifico titolare
if {![db_0or1row -dbn curit maintainer "
    select substr(name,  1, 24) as cust_header,
           substr(name, 25, 24) as cust_header_2,
           substr(name, 49, 24) as cust_header_3,
           substr(name, 73, 24) as cust_header_4,
           fiscal_code
     from iter_maintainers
     where maintainer_id = :holder_id"]} {
    ns_return 200 text/plain [list "Manutentore $holder_id inesistente." 0]
    ad_script_abort
}

if {[string equal $creation_date ""]} {
    set creation_date [db_string query "select to_char(current_date, 'YYYY-MM-DD')"]
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
               ,description   
               ,reference     
               ,amount        
               ,currency      
               ,currency_amount
               ,filename  
               ,currency_date
            ) values (
                nextval('wal_transactions_seq')
               ,:holder_id     
               ,:body_id
               ,:tran_type_id        
               ,:pay_type_id   
               ,to_date(:payment_date, 'YYYY-MM-DD')  
               ,to_date(:creation_date, 'YYYY-MM-DD')  
               ,:description
               ,:reference
               ,:amount
               ,null
               ,null
               ,:filename
               ,to_date(:payment_date, 'YYYY-MM-DD')  
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
               ,to_date(:creation_date, 'YYYY-MM-DD')  
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
               ,:pay_type_id  
               ,:reference
            )"
	    
} on_error {
    ns_return 200 text/plain [list "Errore imprevisto durante l'aggiornamento: $errmsg" 0] 
    ad_script_abort
}

ns_return 200 text/plain [list "OK" $transaction_id]


