ad_library {
    Provides various functions for the package.

    @author Giulio Laurenzi
    @cvs-id iter-edit-procs.tcl

    USER  DATA       MODIFICHE
    ===== ========== ======================================================================
    san01 06/09/2016 Modificata proc iter_calc_rend sostituendo 1983 con 1993

    nic01 10/03/2016 Aggiunta nuova proc iter_edit_crlf

}

ad_proc -private iter_check_date {{-formato ""} data_edit} {
    Accetta in ingresso una campo alfanumerico di 10 caratteri contenete una data in formato
    gg/mm/aaaa, oppure di 8 caratteri contenente una data in formato ggmmaaaa, ne controlla la
    validità e, se valido, restituisce la data in formato aaaammgg altrimenti restituisce 0.
    Se si valorizza lo switch -formato, verrà usato quello come formato della data di input
    e non verranno fatte le considerazioni descritte sopra per intuire il formato della data.
}  {
    if {[string is space $formato]} {;#17/12/2013
	switch [string length $data_edit] {
	     8 {set formato "ddmmyyyy"}
	    10 {set formato "dd/mm/yyyy"}
       default {return 0}
	}
    };#17/12/2013

    with_catch err_msg {
        db_1row sel_dual_data_int ""

        db_1row sel_dual_data_chk ""

        if {$data_edit != $data_chk} {
            error "Postgresql come al solito si inventa date inesistenti"
        }

        set yyyy [string range $data_int 0 3] 
        if {$yyyy < 1800
        ||  $yyyy > 2200
        } {
            error "anno fuori range (1800-2200)"
        }
    } {
        return 0
    }

    return $data_int
}

ad_proc -private iter_check_time {time_edit} {
    Accetta in ingresso una campo alfanumerico di 5 caratteri contenete 
    un'ora in formato hh24:mi, ne controlla la validita' e
    , se valido, restituisce l'ora in formato hh24:mi
    altrimenti restituisce 0.
}  {
    switch [string length $time_edit] {
         5 {set formato "hh24:mi"}
   default {return 0}
    }

    with_catch err_msg {
        db_1row sel_dual_time_chk ""

        if {$time_edit != $time_chk} {
            error "Postgresql come al solito si inventa time inesistenti"
        }

    } {
        return 0
    }

    return $time_chk
}

ad_proc -private iter_check_num {numero {max_decimali "0"}} {
    Accetta in ingresso una campo alfanumerico  contenente un numero editato.
    Controlla che abbia al massimo il numero di decimali indicato, 
    che la virgola sia una sola e nel posto corretto, i punti 
    delle migliaia sono nel posto corretto, dopo di che elimina tutti i punti
    e sostitusice la virgola con il punto.
}  {
    if {![string is integer -strict $max_decimali]} {
        return "Error"
    }

    set len [string length $numero]
    
  # controllo la presenza del segno 
    set segno ""
    if {[string index $numero [expr $len - 1]] == "-"} {
        set numero [string trimright $numero "-"]
        set segno "-"
    }

    if {[string range $numero 0 0] == "-"} {
        if {$segno == "-"} {
            return "Error"
        }
        set numero [string trimleft $numero "-"]
        set segno "-"
    }
    
  # elimino eventuali spazi dopo o prima il numero
    set numero [string trim $numero]

  # controllo esistenza di spazi all'interno del numero.
    set ctr_spazi   [regsub -all " " $numero "" numero]
    if {$ctr_spazi > 0} {
        return "Error"
    }

  # controllo la presenza di piu' virgole
    set ctr_virgole [regsub -all "," $numero "," campo_di_comodo1]
    if {$ctr_virgole > 1} {   
        return "Error"
    } 
    
  # controllo se i decimali sono 2 e se la virgola e' al posto corretto
    if {$ctr_virgole == 1} {
        set pos_virg [string first "," $numero]
        set decimali [string range $numero [expr $pos_virg + 1] end]
        set len_decimali [string length $decimali]
        if {$len_decimali > $max_decimali} {
            return "Error"
        }
    }

  # imposto la parte intera del numero
    if {$ctr_virgole == 1} {
        set intero [string range $numero 0 [expr $pos_virg - 1]]
    } else {
        set intero $numero
    }
    set len [string length $intero]
  # ovviamente se il numero e' vuoto non va bene.
    if {$len <= 0} {
        return "Error"
    }

  # controllo la presenza di punti separatori di migliaia
    set ctr_punti [regsub -all {\.} $intero {\.} campo_di_comodo2]
  
  # controllo che i punti separatori delle migliaia siano al posto corretto
    if {$ctr_punti > 0} {
        set puntatore [expr $len - 1]
        set pos       1
        while {$puntatore >= 0} {
            set carattere [string range $intero $puntatore $puntatore]
            
            if {$pos < 4} {
                if {$carattere == "."} {
                    return "Error"
                }
            } else {
                if {$carattere == "."} {
                    set pos 0     
                } else {
                    set pos 1
                } 
            }
            incr pos
            set puntatore [expr $puntatore - 1]
        }
    }

  # elimino tutti i punti
    regsub -all  {\.} $intero {} intero
    if {![string is digit $intero]} {
        return "Error"
    }

  # ricostruisco il numero
    if {$segno == "-"} {
	set numero "-$intero"
    } else {
        set numero $intero
    }

    if {$ctr_virgole == 1} {
	if {[string is digit $decimali]} {
            set numero "$numero.$decimali"
        } else {
            return "Error"
        }
    }
    
    return $numero
}

ad_proc -private iter_edit_date {data} {
    Accetta in ingresso una campo alfanumerico di otto caratteri in formato
    aaaammgg e lo converte ina gg/mm/aaaa.
}  {
    if {[string equal $data ""]} {
	set data_edit ""
    } else {
	set anno   [string range $data 0 3]
	set mese   [string range $data 4 5]
	set giorno [string range $data 6 8]
	set data_edit "$giorno/$mese/$anno"
    }

    return $data_edit
}


ad_proc -private iter_edit_num {numero {max_decimali "0"}} {
    Accetta in ingresso una campo numerico e lo edita inserendo i punti
    separatori delle migliaia e converte il separatore dei decimali da punto
    a virgola.
} {
    with_catch err_msg {
        db_1row sel_dual_edit_num ""
    } {
        return "Error"
    }

    return $num_edit
}

ad_proc -private iter_calc_date {data_1 operatore argomento} {
    Accetta in ingresso una data di cui ne controlla la validita'.
    Accetta un secondo parametro che puo' essere un operatore matematico
    (+ o -) oppure dif.
    Se e' un operatore matematico somma o sottrae argomento
    (che deve essere numerico)
    Se e' 'dif', calcola la differenza tra le due date
    (argomento deve essere una data).
}  {
    if {$operatore != "+"
    &&  $operatore != "-"
    &&  $operatore != "dif"
    } {
        error "iter_calc_date: operatore non permesso"
    }

    if {$operatore != "dif"} {
        set numero $argomento
        if {![string is digit -strict $numero]} {
            error "iter_calc_date: argomento non numerico"
        }
    } else {
        set data_2 $argomento
    }

    if {$operatore == "dif"} {
	set risultato [db_string sel_dual_dif_between_date ""]
    } else {
	set risultato [db_string sel_dual_add_number_to_date ""]
    }

    if {[string is space $risultato]} {
        error "iter_calc_date: risultato non ottenuto"
    }
    return $risultato
}

ad_proc -private iter_calc_rend {cod_impianto gen_prog} {
    Accetta in ingresso un codice impianto, progressivo generatore e il valore di rendimento misurato.
    Tramite una query vengono recuperati da coimgend i valori di data_installazione, potenza nominale a libretto,
    fluido termovettore e classificazione DPR.
    Con questi dati viene calcolato il rendimento minimo valido per il generatore in esame, 
    che verrà successivamente paragonato a quello effettivamente misurato per stabilire la regolarità
    di quest'ultimo.

    Verranno presi in esame, per quanto riguarda il fluido termovettore, solo i valori 1 e 2 (acqua ed aria calda)
}  {
    # Controllo che i parametri richiesti siano tutti presenti
    if {($cod_impianto eq "") || ($gen_prog eq "")} {
	error "Impossibile calcolare: valori obbligatori non presenti"
    }

    db_1row sel_gend_parm ""

    # Controllo che le variabili siano state tutte assegnate; in caso contrario ritorno errore
    if {($data_installazione eq "") || ($potenza_nominale eq "") || ($fluido_termovettore eq "")} {
	error "Impossibile calcolare: valori del generatori non validi"
    }

    set rend_min ""
    switch $fluido_termovettore {
	1 {
	    if {[iter_check_date $data_installazione] <= "19931029"} {#san01
		set rend_min [expr 82 + 2*[expr log10($potenza_nominale)]]
		set rend_min [iter_edit_num $rend_min 2]
	    }
	    if {[iter_check_date $data_installazione] >= "19931030" && [iter_check_date $data_installazione] <= "19971231"} {#san01
		set rend_min [expr 84 + 2*[expr log10($potenza_nominale)]]
		set rend_min [iter_edit_num $rend_min 2]
	    }
	    if {[iter_check_date $data_installazione] >= "19980101" && [iter_check_date $data_installazione] <= "20051007"} {
		switch $class_dpr {
		    S { set rend_min [expr 84 + 2*[expr log10($potenza_nominale)]] 
			set rend_min [iter_edit_num $rend_min 2]
		    }
		    B { set rend_min [expr 87.5 + 1.5*[expr log10($potenza_nominale)]] 
			set rend_min [iter_edit_num $rend_min 2]
		    }
		    G { set rend_min [expr 91 + [expr log10($potenza_nominale)]] 
			set rend_min [iter_edit_num $rend_min 2]
		    }
		    default { set rend_min [expr 84 + 2*[expr log10($potenza_nominale)]] 
			set rend_min [iter_edit_num $rend_min 2]
		    }
		}
	    }
	    if {[iter_check_date $data_installazione] >= "20051008"} {
		switch $class_dpr {
		    G { set rend_min [expr 89 + 2*[expr log10($potenza_nominale)]] 
			set rend_min [iter_edit_num $rend_min 2]
		    }
		    default { set rend_min [expr 87 + 2*[expr log10($potenza_nominale)]] 
			set rend_min [iter_edit_num $rend_min 2]
		    }
		}
	    }
	}

	2 {
	    if {[iter_check_date $data_installazione] <= "19931029"} {#san01
		set rend_min [expr 77 + 2*[expr log10($potenza_nominale)]]
		set rend_min [iter_edit_num $rend_min 2]
	    }
	    if {[iter_check_date $data_installazione] >= "19931030"} {#san01
		set rend_min [expr 80 + 2*[expr log10($potenza_nominale)]]
		set rend_min [iter_edit_num $rend_min 2]
	    }

	}
    }
#    ns_return 200 text/html "[iter_check_date $data_installazione] | $potenza_nominale | $fluido_termovettore | $class_dpr"; return    
    if {$rend_min eq ""} {
	error  "Impossibile eseguire il calcolo con il fluido termovettore inserito"
    } 


    return $rend_min

}


ad_proc -private iter_edit_crlf {stringa_inp} {#nic01: aggiunta proc
    Accetta in ingresso una stringa e trasforma i crlf, i cr ed i lf in <br> perche' vengano
    esposti correttamente in html.
} {
    set stringa_out [regsub -all \r\n $stringa_inp <br>]
    set stringa_out [regsub -all \r   $stringa_out <br>]
    set stringa_out [regsub -all   \n $stringa_out <br>]

    return $stringa_out
}
