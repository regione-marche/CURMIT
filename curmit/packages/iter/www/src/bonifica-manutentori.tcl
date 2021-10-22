ad_page_contract {

    @author        Adhoc
    @creation-date 13/11/2007

    @cvs-id bonifica.tcl
}

set cognome_manu ""
db_transaction {
    db_foreach  sel_manu "select cod_manutentore , cognome from coimmanu_2 order by cognome" {

	if {![string equal $cognome_manu ""]} {
	    if {$cognome_manu == $cognome} {
		db_dml upd_manu "update coimmanu_2 set cod_manu_new = :cod_manu_new where cod_manutentore = :cod_manutentore"
		set cognome_manu $cognome
	    } else {
		db_1row sel_next "select nextval('coimmanu_2_seq') as cod_manu_new"
		db_dml upd_manu "update coimmanu_2 set cod_manu_new = :cod_manu_new where cod_manutentore = :cod_manutentore"
              set cognome_manu $cognome
	    }    
	} else {
	    db_1row sel_next "select nextval('coimmanu_2_seq') as cod_manu_new"
	    db_dml upd_manu "update coimmanu_2 set cod_manu_new = :cod_manu_new where cod_manutentore = :cod_manutentore"
	    set cognome_manu $cognome
	}
    }
}

ns_return 200 text/html " finito bonifica manutentori"
return

