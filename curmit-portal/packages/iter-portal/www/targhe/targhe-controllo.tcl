ad_page_contract {  
 
    Web Service controllo utilizzo della targa

    Il programma NON dispone di UI e deve essere chiamato via httpget dal 
    cliente del servizio. Restituisce una lista con diversi valori:
      1. return code può assumere il valore 'OK' oppure descrivere l'errore
      2. nome del db su cui è già stata utilizzata la targa
      3. codice impianto del caldo su cui è stata utilizzata la targa
      4. codice impianto del freddo su cui è stata utilizzata la targa

    @author Simone Pesci

    @cvs-id targhe-controllo.tcl 

    @param targa           Targa inserita sull'impianto in iter
    @param cod_manutentore Codice di iter del manutentore

    USER  DATA       MODIFICHE
    ===== ========== ===========================================================================
    rom01 14/09/2022 Aggiunto parametro ctrl_targa_manu, gli utenti admin system e admin dell'ente
    rom01            devono saltare il controllo sull'associazione delle targhe.

} {
    targa    
    cod_manutentore
    ctrl_targa_manu
}

wallet_check_login

if {$ctrl_targa_manu eq "t"} {#rom01 Aggiunte if, else e loro contenuto

    if {![db_0or1row q "select distinct t.nome_db_utilizzo
                         , t.cod_impianto_caldo
                         , t.cod_impianto_freddo
                         , iter_code
                      from coimtarg as t
                         , coimplic as p
                         ,iter_maintainers m
                     where upper(t.targa)  = upper(:targa)
                       and m.iter_code     = :cod_manutentore
                       and p.plico_id      = t.plico_id
                       and p.maintainer_id = m.maintainer_id"]} {

        ns_return 200 text/plain [list "KO" "" "" ""]
        ad_script_abort
    }
} else {

    if {![db_0or1row q "select distinct t.nome_db_utilizzo
                         , t.cod_impianto_caldo
                         , t.cod_impianto_freddo
                      from coimtarg as t
                         , coimplic as p
                     where upper(t.targa)  = upper(:targa)
                       and p.plico_id      = t.plico_id "]} {

        ns_return 200 text/plain [list "KO" "" "" ""]
        ad_script_abort
    }

}

ns_return 200 text/plain [list "OK" $nome_db_utilizzo $cod_impianto_caldo $cod_impianto_freddo]

