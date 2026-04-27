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

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim01 12/10/2016 Aggiunto gestione della ricarica da parte del manutentore

} {
    iter_code
    cait_id
    body_id
    tran_type_id
    payment_type
    payment_date
    reference
    description
    amount
    {status "A"}
    {cro    ""}
}

#wallet_check_login

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
        ns_return 200 text/plain [list "Codice $iter_code errato o non autorizzato." 0]
        ad_script_abort
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

    set tran_id [db_string q "select nextval('wal_transactions_seq')"];#sim01
    set tran_id_cait [db_string q "select nextval('wal_transactions_cait_seq')"]
    set rec_id [db_string q "select nextval('wal_recharge_cait_seq')"]

    if {$status eq "L"} {
	set anno_pag [db_string q "select to_char(:payment_date::date, 'YYYY')"]
	set description "$iter_code-$tran_id/$anno_pag"
    }

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
               ,status --sim01
               ,cro    --sim01
            ) values (
                --sim01 nextval('wal_transactions_seq')
                :tran_id --sim05
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
               ,:status --sim01
               ,:cro    --sim01
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

    #registro il movimento sulla listamovimenti del cait
    set transaction_id_cait [db_dml transaction_new "
            insert into wal_transactions_cait (
                tran_id
               ,cait_id       
               ,holder_id     
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
               ,status --sim01
               ,cro    --sim01
               ,wallet_tran_id
            ) values (
                :tran_id_cait
               ,:cait_id
               ,:holder_id     
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
               ,:status --sim01
               ,:cro    --sim01
               ,:tran_id
            )"]

    # registro movimento su tabella di log
    db_dml log_new "
            insert into wal_log_payments_cait (
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
               ,wallet_tran_id
            ) values (
                nextval('wal_log_payments_cait_seq')
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
               ,:tran_id
            )"


    #per il potafoglio cait è un operazione inersa rispetto a quanto fatto per il manutentore
    #se per esempio è +100 al saldo del manutenore, è -100 al saldo del cait
    set cait_tran_type_id [db_string q "select tran_type_id from wal_transaction_types where tran_type_id != :tran_type_id"]

    #scalo l'importo dal portafoglio del cait
    db_dml transaction_new "
            insert into wal_recharge_cait (
                rec_id       
               ,cait_id       
               ,tran_type_id  
               ,pay_type_id   
               ,payment_date  
               ,currency_date
               ,creation_date 
               ,description   
               ,amount  
               ,wallet_tran_id      
            ) values (
                :rec_id
               ,:cait_id
               ,:cait_tran_type_id        
               ,:pay_type_id   
               ,to_date(:payment_date, 'YYYY-MM-DD')  
               ,to_date(:payment_date, 'YYYY-MM-DD')  
               ,current_date
               ,:description
               ,:amount
               ,:tran_id
            )"

	    
} on_error {
    ns_return 200 text/plain [list "Errore imprevisto durante l'aggiornamento: $errmsg" 0] 
    ad_script_abort
}

ns_return 200 text/plain [list "OK" $transaction_id_cait]


