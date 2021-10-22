ad_page_contract {
    Divide il nome dal cognome

    @author        Adhoc
    @creation-date 13/11/2007

    @cvs-id dividi.tcl
}

db_transaction {
db_foreach  sel_cit "select cognome,cod_cittadino from coimcitt where nome is null" {
    set cognome_nome $cognome
    set ctr_blank [string first " " $cognome_nome]

    if {$ctr_blank < 0} {
	set cognome $cognome_nome
	set nome ""
	set natura_giuridica_prop "F"
    } else {
	set ctr_fin [expr $ctr_blank - 1]
	set cognome [string range $cognome_nome 0 $ctr_fin]
	set ctr_ini [expr $ctr_blank + 1]
	set nome [string range $cognome_nome $ctr_ini 999]
    }
if {![string equal $nome ""]} {
db_dml pd_cog "update coimcitt set cognome = :cognome, 
                                   nome    = :nome
                              where cod_cittadino = :cod_cittadino" }

}


}

ns_return 200 text/html " finito dividi nome_cognome"
return

