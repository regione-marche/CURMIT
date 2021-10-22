ad_page_contract {  
 
    Web Service Estratto Conto in stile REST. 

    Il programma NON dispone di UI e deve essere chiamato via httpget dal 
    cliente del servizio. Restituisce una lista con diversi valori:
      1. return code può assumere il valore 'OK' oppure descrivere l'errore
      2. saldo iniziale o 0 in caso di errore
      3. saldo finale   o 0 in caso di errore
      4. lista dei movimenti o una lista vuota in caso di errore
    Ogni elemento della lista di movimenti è a sua volta costituito da:
      1. id_tipo_movimento, 
      2. id_ente, 
      3. data pagamento, 
      4. riferimento, 
      5. id_tipo_pagamento, 
      6. descrizione, 
      7. importo,
      8. segno
      9. data valuta
      10. id del movimento (tran_id)

      I movimenti con importo uguale a zero vengono scartati.

    @author C. Pasolini

    @cvs-id ec.tcl 

    @param wallet_id      codice portafoglio
    @param from_date      data inizio formato ANSI
    @param to_date        data fine   formato ANSI

} {
    wallet_id
    from_date
    to_date
}

wallet_check_login

# ottengo titolare da codice portafoglio
if {![db_0or1row holder "select holder_id from wal_holders where wallet_id = :wallet_id"]} {
    ns_return 200 text/plain [list "Codice portafoglio $wallet_id errato." 0 0 [list]]
    ad_script_abort
}

# calcolo saldo iniziale
set initial_balance [db_string initial "
    select coalesce(
             sum(
               case 
                 when t.sign = '+' then amount
                 else amount * -1
               end), 0.00)
    from wal_transactions m, wal_transaction_types t
    where m.holder_id    = :holder_id
      and m.tran_type_id = t.tran_type_id
      and m.payment_date < :from_date"]

set final_balance $initial_balance 
set movements [list]

# estraggo i movimenti compresi fra le date indicate e calcolo il saldo finale
db_foreach movement "
    select 
        m.tran_id
       ,m.tran_type_id  
       ,m.body_id       
       ,m.payment_date  
       ,m.reference     
       ,m.pay_type_id   
       ,m.description   
       ,m.amount        
       ,t.sign
       ,m.currency_date
    from wal_transactions m, wal_transaction_types t
    where m.holder_id    = :holder_id
      and m.tran_type_id = t.tran_type_id
      and m.payment_date between :from_date and :to_date
      and m.amount <> 0
    order by m.payment_date
" {
    set final_balance [expr $final_balance $sign $amount]
    lappend movements [list $tran_type_id $body_id $payment_date $reference $pay_type_id $description $amount $sign $currency_date $tran_id]
}

ns_return 200 text/plain [list "OK" $initial_balance $final_balance $movements]


