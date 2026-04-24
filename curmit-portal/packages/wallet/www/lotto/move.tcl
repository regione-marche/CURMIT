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

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    gab01 09/04/2018 Aggiunto ente_portafoglio

} {
    wallet_id
    body_id
    tran_type_id
    payment_type
    payment_date
    reference
    description
    amount
    reason
    {status "A"}
    {tran_id ""}
    {ente_portafoglio ""}
}

wallet_check_login

set tran_id_storno $tran_id

set sw_usato_dal_portale [parameter::get_from_package_key -package_key wallet -parameter sw_usato_dal_portale]

set sw_multi_portafoglio [parameter::get_from_package_key -package_key wallet -parameter sw_multi_portafoglio -default 0];#gab01

if {!$sw_multi_portafoglio} {;#gab01
    set ente_portafoglio ""
}

if {$tran_type_id eq ""} {
    # ottengo tipo movimento
    set tran_type_id [parameter::get_from_package_key -package_key wallet -parameter tran_type_minus]
}

# ottengo tipo pagamento
set pay_type_id [parameter::get_from_package_key -package_key wallet -parameter cash_pay_type]

# ottengo titolare da codice portafoglio
if {![db_0or1row query "select holder_id
                          from wal_holders
                         where wallet_id = :wallet_id
                       "]
} {
    ns_return 200 text/plain [list "Codice portafoglio $wallet_id errato." 0]
    ad_script_abort
}

# decodifico Ente
if {![db_0or1row query "
    select substr(body_name,  1, 24) as body_header
         , substr(body_name, 25, 24) as body_header_2
      from wal_bodies
     where body_id = :body_id
    "]
} {
    #ns_return 200 text/plain [list "Codice Ente $body_id errato." 0]
    #ad_script_abort
    set body_header ""
    set body_header_2 ""
}

if {$sw_usato_dal_portale == 1} {

    
    if {$ente_portafoglio ne ""} {
	set and_nome_istanza "and instance_name = '$ente_portafoglio'"
    } else {
	set and_nome_istanza ""
    }

    set query_titolare "
    select substr(name,  1, 24) as cust_header
         , substr(name, 25, 24) as cust_header_2
         , substr(name, 49, 24) as cust_header_3
         , substr(name, 73, 24) as cust_header_4
         , fiscal_code
      from wal_holders
     where holder_id = :holder_id
       $and_nome_istanza
    "
} else {
    set query_titolare "
    select substr(cognome,  1, 24) as cust_header
         , substr(cognome, 25, 24) as cust_header_2
         , substr(cognome, 49, 24) as cust_header_3
         , substr(cognome, 73, 24) as cust_header_4
         , cod_fiscale as fiscal_code
      from coimmanu
     where cod_manutentore = 'MA$holder_id'
    "
}

# decodifico titolare
if {![db_0or1row query $query_titolare]} {
    ns_return 200 text/plain [list "Manutentore MA$holder_id inesistente." 0]
    ad_script_abort
}

db_transaction {

    set tran_id [db_string q "select nextval('wal_transactions_seq')"] 

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
               ,reason
               ,status
               ,instance_name --gab01
            ) values (
                :tran_id
               ,:holder_id     
               ,:body_id
               ,:tran_type_id        
               ,:pay_type_id   
               ,to_date(:payment_date, 'YYYY-MM-DD')  
               ,current_date
               ,:description
               ,:reference
               ,:amount
               ,null
               ,null
               ,:reference  
               ,to_date(:payment_date, 'YYYY-MM-DD')
               ,:reason
               ,:status
               ,:ente_portafoglio  
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
               ,reason
               ,instance_name --gab01
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
               ,:reason
               ,:ente_portafoglio
            )"
	
    #strono eventuali movimenti presenti sulla lista movimenti del cait e sulla ricarica del cait	
    if {$tran_id ne "" && 
        [db_0or1row q "select 1 from wal_recharge_cait     where wallet_tran_id = :tran_id_storno"] &&
	[db_0or1row q "select 1 from wal_transactions_cait where wallet_tran_id = :tran_id_storno"]} {

	#ricavo i dati del movimento del cait da stornare
	db_1row q "select tran_id  as tran_cait_id_stornato
                        , cait_id
                     from wal_transactions_cait
                    where wallet_tran_id = :tran_id_storno"
                       

	set tran_cait_id [db_string q "select nextval('wal_transactions_cait_seq')"] 

	# registro il movimento di storno nella lista movimenti cait
	set transaction_id [db_dml transaction_new "
            insert into wal_transactions_cait (
                tran_id       
               ,cait_id
               ,holder_id     
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
               ,reason
               ,status
               ,wallet_tran_id
            ) values (
                :tran_cait_id
               ,:cait_id
               ,:holder_id     
               ,:tran_type_id        
               ,:pay_type_id   
               ,to_date(:payment_date, 'YYYY-MM-DD')  
               ,current_date
               ,:description
               ,:reference
               ,:amount
               ,null
               ,null
               ,:reference  
               ,to_date(:payment_date, 'YYYY-MM-DD')
               ,:reason
               ,:status  
               ,:tran_id
            )"]

    # registro movimento cait su tabella di log
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
               ,reason
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
               ,:reason
               ,:tran_id
            )"

	db_dml q "update wal_transactions_cait
                     set ref_tran_id = :tran_cait_id
                   where tran_id = :tran_cait_id_stornato" 



	#ricavo i dati del movimento di ricarica cait da stornare
	db_1row q "select rec_id as rec_id_da_stornare
                     from wal_recharge_cait
                    where wallet_tran_id = :tran_id_storno"

	#il movimento di storno della ricarica deve essere inverso a quello del manutentore. 
	#Se tolgo 20 al manutentore devo ricaricare di 20 il cait
	set cait_tran_type_id [db_string q "select tran_type_id 
                                              from wal_transaction_types
                                             where tran_type_id != :tran_type_id"]


	set rec_id [db_string q "select nextval('wal_recharge_cait_seq')"]

	#carico l'importo dal portafoglio del cait
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
               ,reason   
               ,wallet_tran_id
               ,flag_storno
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
               ,:reason
               ,:tran_id
               ,'t'
            )"

	db_dml q "update wal_recharge_cait
                     set ref_rec_id = :rec_id
                   where rec_id     = :rec_id_da_stornare"

    }


} on_error {
    ns_return 200 text/plain [list "Errore imprevisto durante l'aggiornamento: $errmsg" 0] 
    ad_script_abort
}

ns_return 200 text/plain [list "OK" $tran_id]


