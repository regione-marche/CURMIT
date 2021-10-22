ad_page_contract {
    Divide l'indirizzo dal numero

    @author        Adhoc
    @creation-date 13/11/2007

    @cvs-id dividi.tcl
}

db_transaction {
    db_foreach  sel_ind "select cod_impianto, indirizzo from coimaimp where indirizzo is not null and numero is null and cod_comune = '1033'" {
	set ind_civ $indirizzo
	set ctr_blank [string first " " $ind_civ]

	if {$ctr_blank < 0} {
	    set indirizzo $ind_civ
	    set civico ""
	} else {
	    set ctr_fin [expr $ctr_blank - 1]
	    set indirizzo [string trim [string range $ind_civ 0 $ctr_fin]]
	    set ctr_ini [expr $ctr_blank + 1]
	    set resto [string trim [string range $ind_civ  $ctr_ini 999]]

	    set ctr_blank_1 [string first " " $resto]
	    set ctr_fin_2 [expr $ctr_blank_1 + $ctr_blank]
	    set indirizzo [string trim [string range $ind_civ 0 $ctr_fin_2 ]]

	    set ctr_ini [expr $ctr_blank_1 + 1]
	    set civico [string trim [string range $resto  $ctr_ini 999]] 
	}
	if {![string equal $civico ""]
	  && [string is integer $civico]} {
	    db_dml upd_cog "update coimaimp set indirizzo    = :indirizzo
                                              , numero       = :civico
                                          where cod_impianto = :cod_impianto"
	}
    }
}

ns_return 200 text/html " finito dividi via numero"
return

