ad_page_contract {
    Divide l'indirizzo dal numero

    @author        Adhoc
    @creation-date 13/11/2007

    @cvs-id dividi.tcl
}

set dir           [iter_set_permanenti_dir]
set file_log      $dir/coimaimp.log
set file_err      $dir/coimaimp.err


# apro il file in scrittura e metto in file_log_id l'identificativo
# del file per poterlo scrivere successivamente
if {[catch {set file_log_id [open $file_log w]}]} {
    ns_return 200 text/html "File di log    non aperto: $file_log"
    return
}
# dichiaro di scrivere in formato iso West European
fconfigure $file_log_id -encoding iso8859-1
puts $file_log_id "numero_old|numero|esponente|cod_impianto|cod_impianto_est"

# apro il file in scrittura e metto in file_err_id l'identificativo
# del file per poterlo scrivere successivamente
if {[catch {set file_err_id [open $file_err w]}]} {
    ns_return 200 text/html "File di err    non aperto: $file_err"
    return
}
# dichiaro di scrivere in formato iso West European
fconfigure $file_err_id -encoding iso8859-1

# routine di scrittura log
set scrivi_log {
    puts $file_log_id $msg_err
}


set ctr_inp 0
set ctr_err 0
set ctr_esp 0

db_foreach sel_ind "
    select cod_impianto
         , cod_impianto_est
         , numero
         , esponente
      from coimaimp
     where numero is not null
" {
    incr ctr_inp

    set numero [string trim     $numero]
    set numero [string trimleft $numero "0"]

  # inizio elaborazione
  # se numero non e' numerico, separo la parte numerica di sinistra mettendola
  # in numero e la restante parte mettendola nell'esponente.
    set numciv_espciv_list [iter_separa_numciv_espciv $numero]
    set numero_old    $numero
    set esponente_old $esponente
    set numero       [lindex $numciv_espciv_list 0]
    set esponente    [lindex $numciv_espciv_list 1]
    set msg_err      [lindex $numciv_espciv_list 2]

    set esponente    "${esponente_old}${esponente}"
    if {[string length $esponente] > 3} {
	set esponente [string range $esponente 0 2]
	set msg_err  "Esponente piu' lungo di 3 caratteri: troncato"
    }

    if {![string is space $msg_err]} {
	incr ctr_err
	puts $file_err_id "$msg_err|$numero_old|$esponente_old|$numero|$esponente|$cod_impianto|$cod_impianto_est"
    } else {
	if {$esponente != $esponente_old} {
	    incr ctr_esp
	    puts $file_log_id "$numero_old|$esponente_old|$numero|$esponente|$cod_impianto|$cod_impianto_est"
	    db_dml query "
            update coimaimp
               set numero       = :numero
                 , esponente    = :esponente
             where cod_impianto = :cod_impianto
            "
	}
    }
}


close $file_log_id
close $file_err_id

ns_return 200 text/html "
Elaborazione terminata<br>
ctr_inp:$ctr_inp<br>
ctr_esp:$ctr_esp<br>
ctr_err:$ctr_err<br>
"

return
