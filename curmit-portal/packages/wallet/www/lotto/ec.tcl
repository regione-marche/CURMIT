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

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    gab01 10/04/2018 Modifiche per gestione del multiportafoglio            

    sim01 12/10/2016 Aggiunto filtro su campo status e description

} {
    wallet_id
    from_date
    to_date
    f_status
}

wallet_check_login

# ottengo titolare da codice portafoglio
#gab01 estraggo anche instance_name
if {![db_0or1row holder "select holder_id, instance_name from wal_holders where wallet_id = :wallet_id"]} {
    ns_return 200 text/plain [list "Codice portafoglio $wallet_id errato." 0 0 [list]]
    ad_script_abort
}

set sw_multi_portafoglio [parameter::get_from_package_key -package_key wallet -parameter sw_multi_portafoglio -default 0];#gab01

if {$sw_multi_portafoglio} {;#gab01 aggiunta if, else e contenuto
    if {$instance_name ne ""} {
	set where_multi_portafoglio "and m.instance_name = :instance_name"
    } else {
	set where_multi_portafoglio ""
    }
} else {
    set where_multi_portafoglio ""
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
      and m.payment_date < :from_date
      and coalesce(m.status,'') = 'A' --sim01
          $where_multi_portafoglio    --gab01"]

set final_balance $initial_balance 
set movements [list]

if {$f_status ne ""} {;#sim01 if else e suo stato
    set where_status "and m.status = :f_status"
} else {
    set where_status ""
}

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
       ,case when m.status = 'L' then 'In lavorazione'
             when m.status = 'A' then 'Accreditato'
             when m.status = 'K' then 'Annullato'
              end as status_desc --sim01
       ,m.cro --sim01
    from wal_transactions m, wal_transaction_types t
    where m.holder_id    = :holder_id
      and m.tran_type_id = t.tran_type_id
      and m.payment_date between :from_date and :to_date
      and m.amount <> 0
      $where_status --sim01
      $where_multi_portafoglio --gab01
    order by m.payment_date
" {
    if {$status_desc eq "Accreditato"} {;#sim01
    set final_balance [expr $final_balance $sign $amount] 
    };#sim01

#sim01    lappend movements [list $tran_type_id $body_id $payment_date $reference $pay_type_id $description $amount $sign $currency_date $tran_id]
    lappend movements [list $tran_type_id $body_id $payment_date $reference $pay_type_id $description $amount $sign $currency_date $tran_id $status_desc $cro];#sim01
}

ns_return 200 text/plain [list "OK" $initial_balance $final_balance $movements]


