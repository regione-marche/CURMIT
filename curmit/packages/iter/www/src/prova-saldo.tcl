ad_page_contract {@author dob}      
set oggi [db_string sel_date "select current_date"]

set ctr 0

set ritorno "Elenco manutentori con saldo negativo <br>"
set ctr_parziale 0
set ctr_tot 0
db_foreach query "select cod_manutentore, cognome from coimmanu" {
    set url "lotto/balance?iter_code=$cod_manutentore"
    set data [iter_httpget_wallet $url]
    array set result $data
    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
    set parte_2 [string range $result(page) [expr [string first " " $result(page)] + 1] end]
    set saldo [string range $parte_2 0 [expr [string first " " $parte_2] - 1]]
    set conto_manu [string range $parte_2 [expr [string first " " $parte_2] + 1] end]
    incr ctr_parziale
    incr ctr_tot
    if {$ctr_parziale > 100} {
	ns_log notice "scanditi $ctr_tot manutentori trovati $ctr manutentori con saldo negativo" 
	set ctr_parziale 0
    }

    if {$saldo < 0} {
	incr ctr	
	append ritorno  "$cod_manutentore $cognome saldo $saldo insufficiente <br>"
    }
}

append ritorno "<br>Sono stati trovati $ctr manutentori con saldo negativo."
ns_return 200 text/html "$ritorno"
return
