ad_page_contract {
    Modifica i codici impianto secoondo i target della regione

    @author        Valentina catte
    @creation-date 28/03/2007

    @cvs-id upd-codici-regione
}

db_dml save_cod_impianto_est "update coimaimp set cod_impianto_old = cod_impianto_est"

set manca_comu  0
set manca_istat 0
set manca_pote  0
set modificati  0
db_foreach sel_dati_comu "select coalesce(a.cod_istat, '') as cod_istat
                               , coalesce(a.cod_comune, '') as cod_comune
                               , b.potenza
                               , b.cod_potenza
                               , b.cod_impianto
                               , b.cod_impianto_est as cod_impianto_est_old
                            from coimaimp b
                 left outer join coimcomu a on a.cod_comune = b.cod_comune" {

    if {[string equal $cod_comune ""]} {
 	incr manca_comu
	set cod_impianto_est ""
    } else {
	
	set progressivo [db_string sel_prog "select coalesce(lpad((progressivo + 1), 7, '0'), '0000001') as progressivo from coimcomu where cod_comune = :cod_comune"]
	if {[string equal $cod_istat ""]} {
	    incr manca_istat
	    set cod_impianto_est ""
	} else {
	    if {[string equal $potenza "0.00"]
	     || [string equal $potenza ""]} {
		if {[string equal $cod_potenza "0"]
		 || [string equal $cod_potenza ""]} { 
		    set cod_impianto_est ""
		    incr manca_pote
		} else {
		    switch $cod_potenza {
			"B"  {set tipologia "IN"}
			"A"  {set tipologia "CT"}
			"MA" {set tipologia "CT"}
			"MB" {set tipologia "CT"}
		    }	    
		    set cod_impianto_est "$cod_istat$tipologia$progressivo"
		}
	    } else {
		if {$potenza < 35} {
		    set tipologia "IN"
		} else {
		    set tipologia "CT"
		}
		set cod_impianto_est "$cod_istat$tipologia$progressivo"
	    }
	}
    }
    db_dml upd_aimp "update coimaimp set cod_impianto_old = :cod_impianto_est_old where cod_impianto = :cod_impianto"   
    if {![string equal $cod_impianto_est ""]} {    
	db_dml upd_aimp "update coimaimp set cod_impianto_est = :cod_impianto_est where cod_impianto = :cod_impianto"   

	db_dml upd_comu "update coimcomu
                            set progressivo = :progressivo
                          where cod_comune  = :cod_comune"
 	incr modificati
    } else {
	db_dml upd_aimp "update coimaimp set cod_impianto_est = null where cod_impianto = :cod_impianto"   
    }
}

set totale [expr $manca_comu + $manca_istat + $manca_pote + $modificati]
ns_return 200 text/html "manca_comu : $manca_comu
                         manca_istat: $manca_istat
                         manca_pote : $manca_pote
                         modificati : $modificati
                         totale     : $totale
"; return
