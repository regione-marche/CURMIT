ad_page_contract {  
 
    Web Service Saldo Conto in stile REST. 

    Il programma NON dispone di UI e deve essere chiamato via httpget dal 
    cliente del servizio. Restituisce una lista con diversi valori:
      1. return code può assumere il valore 'OK' oppure descrivere l'errore
      2. saldo finale   o 0 in caso di errore
      3. codice portafoglio Lottomatica

    @author C. Pasolini

    @cvs-id ec.tcl 

    @param iter_code   Codice manutentore (o amministratore) in Iter

} {
    iter_code
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
          from wal_holders
         where 'MA'||lpad(cast(holder_id as varchar(10)),6,0) = :iter_code
        "
} else {
    set query_titolare "
        select substr(cod_manutentore,3,length(cod_manutentore)) as holder_id
             , wallet_id
          from coimmanu
         where cod_manutentore = :iter_code
        "
}

# iter_code può appartenere ad un manutentore o ad un amministratore di condominio
if {![db_0or1row query $query_titolare]} {
#    if {![db_0or1row query "
#        select trustee_id as holder_id, wallet_id
#         from iter_trustees
#        where iter_code = :iter_code"]} {
        ns_return 200 text/plain [list "Codice $iter_code errato o non autorizzato." 0 ""]
        ad_script_abort
#    }
}

# calcolo saldo 
set balance [db_string query "
    select coalesce(
             sum(
               case 
                 when t.sign = '+' then amount
                 else amount * -1
               end), 0.00)
    from wal_transactions m, wal_transaction_types t
    where m.holder_id    = :holder_id
      and m.tran_type_id = t.tran_type_id"] 

ns_log Notice "wallet/www/lotto/balance;returning [list "OK" $balance $wallet_id]"
ns_return 200 text/plain [list "OK" $balance $wallet_id]


