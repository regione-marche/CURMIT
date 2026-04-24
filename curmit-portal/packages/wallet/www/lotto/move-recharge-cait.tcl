ad_page_contract {  
 
    Web Service in stile REST per caricare un movimento in wal_recharge_cait.

    Il programma NON dispone di UI e deve essere chiamato via httpget dal 
    cliente del sevizio. Restituisce una lista con due valori:
    1. return code può assumere il valore 'OK' oppure descrivere l'errore
    2. id movimento o zero in caso di errore 

    @author Gabriele Lo Vaglio

    @cvs-id move-recharge-cait.tcl 

    @param tran_type_id   tipo movimento
    @param payment_type   tipo pagamento char(1)
    @param payment_date   data movimento in formato ANSI
    @param description    causale del movimento
    @param amount         importo (11,2)

} {
    cait_id
    tran_type_id
    payment_type
    payment_date
    description
    amount
    reason
    {status "A"}
}

wallet_check_login

set sw_usato_dal_portale [parameter::get_from_package_key -package_key wallet -parameter sw_usato_dal_portale]

if {$tran_type_id eq ""} {
    # ottengo tipo movimento
    set tran_type_id [parameter::get_from_package_key -package_key wallet -parameter tran_type_minus]
}

# ottengo tipo pagamento
set pay_type_id [parameter::get_from_package_key -package_key wallet -parameter cash_pay_type]

db_transaction {

    set rec_id [db_string q "select nextval('wal_recharge_cait_seq')"] 

    #aggiungo l'importo al portafoglio del cait
    db_dml transaction_new "
            insert into wal_recharge_cait (
                rec_id
               ,cait_id
               ,tran_type_id
               ,pay_type_id
               ,payment_date
               ,creation_date
               ,description
               ,amount
               ,reason
               ,currency_date
               ,flag_storno
            ) values (
                :rec_id
               ,:cait_id
               ,:tran_type_id
               ,:pay_type_id
               ,to_date(:payment_date, 'YYYY-MM-DD')
               ,current_date
               ,:description
               ,:amount
               ,:reason
               ,to_date(:payment_date, 'YYYY-MM-DD')
               ,'t'
            )"
    
	    
} on_error {
    ns_return 200 text/plain [list "Errore imprevisto durante l'aggiornamento: $errmsg" 0] 
    ad_script_abort
}

ns_return 200 text/plain [list "OK" $rec_id]


