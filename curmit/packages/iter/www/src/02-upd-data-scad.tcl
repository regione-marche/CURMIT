ad_page_contract {
    Modifica i codici impianto secoondo i target della regione

    @author        Valentina catte
    @creation-date 28/03/2007

    @cvs-id upd-codici-regione
}

db_dml save_cod_impianto_est "update coimaimp set cod_impianto_old = cod_impianto_est"

db_foreach sel_data_dich "select"
{

    if {![string equal $cod_comune ""]} {
 	incr manca_comu
	set cod_impianto_est ""
    } else {
	if {![string equal $cod_istat ""]} {
	    incr manca_istat
	    set cod_impianto_est ""
	} else {
	    if {![string equal $potenza "0.00"]} {
		if {$potenza < 35} {
		    set tipologia "IN"
		} else {
		    set tipologia "CT"
		}
		set cod_impianto_est "$cod_istat$tipologia$progressivo"
	    } else {
		if {![string equal $cod_potenza "0"]
		    && ![string equal $cod_potenza ""]} { 
		    switch $cod_potenza {
			"B"  {set tipologia "IN"}
			"A"  {set tipologia "CT"}
			"MA" {set tipologia "CT"}
			"MB" {set tipologia "CT"}
		    }
		    
		    set cod_impianto_est "$cod_istat$tipologia$progressivo"
		} else {
		    set cod_impianto_est ""
		    incr manca_pote
		}
	    }
	}
    }

    if {![string equal $cod_impianto_est ""]} {    
	db_dml upd_aimp "update coimaimp set cod_impianto_est = :cod_impianto_est"   

	db_dml upd_comu "update coimcomu
                            set progressivo = :progressivo
                          where cod_comune  = :cod_comune"
    } else {
	db_dml upd_aimp "update coimaimp set cod_impianto_est = null"   
    }
}
