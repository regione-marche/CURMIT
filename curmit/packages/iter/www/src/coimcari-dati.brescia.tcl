ad_page_contract {
    Lettura di 3 file sequenziali contenenti gli impianti, le autocertificazioni e i rapporti di verifica
    seguendo un tracciato record prefissato e validandone i dati al fine di ottenere un caricamento veloce e pulito
    delle tabelle *** di iter
    Il programma restituisce un report visivo con il riassunto adei dati validati, 
    tre file csv contenenti gli errori riscontrati
    ** file pronti per essere caricati mediante il comando copy
    
    @creation-date   18/10/2006
    
    @cvs-id          coimcari-dati.tcl
} {
    {funzione         "V"}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

ReturnHeaders

# Acquisisco i dati della coimtgen
iter_get_coimtgen

set valid_mod_h $coimtgen(valid_mod_h)
set valid_mod_h_b $coimtgen(valid_mod_h_b)

# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string equal $nome_funz_caller ""]} {
    set nome_funz_caller $nome_funz
}

set link_gest [export_url_vars nome_funz nome_funz_caller caller]

# Personalizzo la pagina
set page_title   "Caricamento dati"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
# Setto le directory per il salvataggio degli output temporanei
set dir           [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]

if {$coimtgen(flag_ente) eq "P"} {
    set input_dir "corretti_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(sigla_prov)]"
    set output_dir "dat_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(sigla_prov)]"
} else {
    regsub -all " " $coimtgen(denom_comune) "" coimtgen(denom_comune)
    set input_dir "corretti_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(denom_comune)]"
    set output_dir "dat_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(denom_comune)]"
}

#set copy_path "/$dir/$output_dir"

cd [iter_set_spool_dir]
#Creo le directory
file mkdir $output_dir

#Nome dei file da elaborare
set file_1 "corretti_impianti.csv"
set file_2 "corretti_rapporti.csv"
set file_3 "corretti_autocertificazioni.csv"

#nome file finali
set comb_outputt "coimcomb.dat"
set topo_outputt "coimtopo.dat"
set viae_outputt "coimviae.dat"
set citt_outputt "coimcitt.dat"
set manu_outputt "coimmanu.dat"
set aimp_outputt "coimaimp.dat"
set cost_outputt "coimcost.dat"
set gend_outputt "coimgend.dat"
set cimp_outputt "coimcimp.dat"
set anom_outputt "coimanom.dat"
set dimp_outputt "coimdimp.dat"
set opve_outputt "coimopve.dat"
set prog_outputt "coimprog.dat"

# Setto il file di log per tenere traccia delle operazioni compiute
if {$coimtgen(flag_ente) eq "P"} {
    set log "log_file_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(sigla_prov)]"
} else {
    regsub -all " " $coimtgen(denom_comune) "" coimtgen(denom_comune)
    set log "log_file_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(denom_comune)]"
}
# Setto la directory di log
set log_dir "log"

#Settaggio del file di log
set log_file [open $dir/$log_dir/$log w]
close $log_file



#settaggio fattore di visualizzazione avanzamento
set dividendo 500

#Settaggio dei file di input 
set impianti_file [open $dir/$input_dir/$file_1 r]
set rapporti_file [open $dir/$input_dir/$file_2 r]
set autocertificazioni_file [open $dir/$input_dir/$file_3 r]

#encoding dei dati caricati
fconfigure $impianti_file -encoding iso8859-15 -translation crlf
fconfigure $rapporti_file -encoding iso8859-15 -translation crlf
fconfigure $autocertificazioni_file -encoding iso8859-15 -translation crlf

#file di output corretti
set comb_output [open $dir/$output_dir/$comb_outputt w]
set topo_output [open $dir/$output_dir/$topo_outputt w]
set viae_output [open $dir/$output_dir/$viae_outputt w]
set citt_output [open $dir/$output_dir/$citt_outputt w]
set manu_output [open $dir/$output_dir/$manu_outputt w]
set aimp_output [open $dir/$output_dir/$aimp_outputt w]
set cost_output [open $dir/$output_dir/$cost_outputt w]
set gend_output [open $dir/$output_dir/$gend_outputt w]
set cimp_output [open $dir/$output_dir/$cimp_outputt w]
set anom_output [open $dir/$output_dir/$anom_outputt w]
set dimp_output [open $dir/$output_dir/$dimp_outputt w]
set opve_output [open $dir/$output_dir/$opve_outputt w]
set prog_output [open $dir/$output_dir/$prog_outputt w]

#encoding per i file di output che andranno a caricare il database
fconfigure $comb_output -encoding iso8859-15 -translation lf
fconfigure $topo_output -encoding iso8859-15 -translation lf
fconfigure $viae_output -encoding iso8859-15 -translation lf
fconfigure $citt_output -encoding iso8859-15 -translation lf
fconfigure $manu_output -encoding iso8859-15 -translation lf
fconfigure $aimp_output -encoding iso8859-15 -translation lf
fconfigure $cost_output -encoding iso8859-15 -translation lf
fconfigure $gend_output -encoding iso8859-15 -translation lf
fconfigure $cimp_output -encoding iso8859-15 -translation lf
fconfigure $anom_output -encoding iso8859-15 -translation lf
fconfigure $dimp_output -encoding iso8859-15 -translation lf
fconfigure $opve_output -encoding iso8859-15 -translation lf
fconfigure $prog_output -encoding iso8859-15 -translation lf

close $comb_output
close $topo_output
close $viae_output
close $citt_output
close $manu_output
close $aimp_output
close $cost_output
close $gend_output
close $cimp_output
close $anom_output
close $dimp_output
close $opve_output
close $prog_output


#contatori per valutare lo stato di avanzamento
set count_1 0
set count_2 0 
set count_3 0

#contatori di servizio
set service_counter_0 0
set service_counter_1 0
set service_counter_2 0

#@cod_topo contatore di toponimi
set cod_topo 0
#@cod_comb contatore di combustibili
set cod_comb 0
#@n_comuni_letti è il numero di comuni codificati correttamente rispetto al numero di righe lette
set n_comuni_cod 0
#@cod_via contatore per le vie
set codice_via 0
#@count_citt contatore per i cittadini
set count_citt 0
#@count_manu contatore per i manutentori
set count_manu 0
#@count_prog contatore per i progettisti
set count_prog 0
#@count_aimp contatore per gli impianti
set count_aimp 0
#@count_cost contatore per i costruttori
set count_cost 0
#@count_gend contatore per i costruttori
set count_gend 0
#@count_cimp contatore per i rapporti di verifica
set count_cimp 0
#@count_dimp contatore per le autocertificazioni
set count_dimp 0
#@count_anom contatore per le anomalie
set count_anom 0
#@count_opve contatore per gli operatori
set count_opve 0
#@aimp_corretti contatore degli impianti caricati
set aimp_corretti 0

#setto un array contenente tutti i comuni per velocizzare l'estrazione del loro codici
db_foreach comuni_italia "" {
    set comuni_italia($nome_comune_italia) $cod_comune_italia
}
#setto un array contenente tuttle province per velocizzare l'estrazione del loro codici
db_foreach provincie_italia "" {
    set provincie_italia($sigla_provincia_italia) $cod_provincia_italia
}


#ora di inizio flusso
set time_start [clock format [clock seconds]]


#Inizio dell'analisi dei file per la creazione dei file dat che andranno a popolare le tabelle del database

#ora di inizio flusso
set time_start [clock format [clock seconds]]
ns_write "Inizio analisi flusso dati: ora di inizio <b>$time_start</b> <br>"
set log_file [open $dir/$log_dir/$log a]
puts $log_file "Inizio analisi flusso dati: ora di inizio $time_start"
close $log_file
unset time_start

#Inizio della lettura degli impianti dal file csv dato in input
set csv_name "impianti"

#scrivo la lista delle variabili per il file degli impianti
set impianti_file_cols "" 

db_foreach sel_liste_csv "" {
    #Creo la lista
    lappend impianti_file_cols $nome_colonna

}

#Salto la prima riga di intestazione del file csv, andando a scrivere l'intestazione nei file in uscita 
iter_get_csv $impianti_file impianti_file_cols_list |

#Comincio la lettura dei records
iter_get_csv $impianti_file impianti_file_cols_list |

set aimp_singoli(0) 1

while {![eof $impianti_file]} {

    incr count_1
    set righe_contate [expr $count_1%$dividendo]
    if {$righe_contate eq 0} {
	set time [clock format [clock seconds]]
	set log_file [open $dir/$log_dir/$log a]
	puts $log_file "Analisi completata per $count_1 impianti $time"
	close $log_file
	ns_write "Analisi completata per $count_1 impianti $time <br>"
    }   
    
    #log degli errori
    set err_log ""
    set err_count 0   
    set ind 0

    foreach column_name $impianti_file_cols {
	set $column_name [lindex $impianti_file_cols_list $ind]
	incr ind
    }

    # impianti 

    # combustibile 
    # salvo i dati relativi ai combustibili in un array per poi compattare i doppioni e estrarre solo i dati singolari
    if {![info exists comb_generale($descr_comb)]} {
	set comb_generale($descr_comb) 1
    }
    
    #toponimo
    #per motivi di utilizzo i valori di toponimo verranno troncati oltre all'ottavo carattere
    if {[string length $toponimo] > 8} {
	set toponimo [string range $toponimo 0 7]
    }
    set topo_generale($toponimo) $toponimo
    

    #viae
    #controlli su congruenza nome comune o cap nella tabella coimcomu    
    if {[info exists comuni_italia([string toupper $comune])]} {
	set cod_comune $comuni_italia([string toupper $comune])
	incr n_comuni_cod
    } else {
	set cod_comune 00
    }
    set indirizzo [string toupper $indirizzo]
    set toponimo [string toupper $toponimo]
    set viae_generale($cod_impianto_est) [list $toponimo $indirizzo $cod_comune]

    #citt
    #i dati vendono presi in base al flag flag_resp, che può assumere il valore A = amministratore; I = intestatario; O = occupante; P = proprietario; T = terzista
    set $flag_resp [string toupper $flag_resp]
    switch $flag_resp {
	A {
	    #elaboro i dati degli amministratori
	    if {[info exists provincie_italia($provincia_amm)]} {
		set sigla_amm $provincia_amm
	    } else {
		set sigla_amm ""
	    }
	    
	    if {![info exists amm_generale([list $cognome_amm $nome_amm $cfisc_amm $indirizzo_amm $numero_amm $localita_intestatario $comune_amm $sigla_amm $cap_amm])]} {
		set amm_generale([list $cognome_amm $nome_amm $cfisc_amm $indirizzo_amm $numero_amm $localita_amm $comune_amm $sigla_amm $cap_amm]) [list $natura_amm $telefono_amm $cod_impianto_est]
	    }
	}
	I {
	    #elaboro i dati degli intestatario
	    if {[info exists provincie_italia($provincia_intestatario)]} {
		set sigla_intestatario $provincia_intestatario
	    } else {
		set sigla_intestatario ""
	    }
	    if {![info exists intestatario_generale([list $cognome_intestatario $nome_intestatario $cfisc_intestatario $indirizzo_intestatario $numero_intestatario $localita_intestatario $comune_intestatario $sigla_intestatario $cap_intestatario])]} {
		
		set intestatario_generale([list $cognome_intestatario $nome_intestatario $cfisc_intestatario $indirizzo_intestatario $numero_intestatario $localita_intestatario $comune_intestatario $sigla_intestatario $cap_intestatario]) [list $natura_intestatario $telefono_intestatario $cod_impianto_est]
	    }
	}
	P {
	    #elaboro i dati degli proprietari
	    if {[info exists provincie_italia($provincia_prop)]} {
		set sigla_prop $provincia_prop
	    } else {
		set sigla_prop ""
	    }
	    if {![info exists prop_generale([list $cognome_prop $nome_prop $cfisc_prop $indirizzo_prop $numero_prop $localita_prop $comune_prop $sigla_prop $cap_prop])]} {
		set prop_generale([list $cognome_prop $nome_prop $cfisc_prop $indirizzo_prop $numero_prop $localita_prop $comune_prop $sigla_prop $cap_prop]) [list $natura_prop $telefono_prop $cod_impianto_est]			
	    }
	}
	T {
	    #elaboro i dati degli terzi
	    if {[info exists provincie_italia($provincia_terzi)]} {
		set sigla_terzi $provincia_terzi
	    } else {
		set sigla_terzi ""
	    }
	    if {![info exists terzi_generale([list $cognome_terzi $nome_terzi $cfisc_terzi $indirizzo_terzi $numero_terzi $localita_terzi $comune_terzi $sigla_terzi $cap_terzi])]} {
		set terzi_generale([list $cognome_terzi $nome_terzi $cfisc_terzi $indirizzo_terzi $numero_terzi $localita_terzi $comune_terzi $sigla_terzi $cap_terzi]) [list $natura_terzi $telefono_terzi $cod_impianto_est]		
	    }
	}
	O {
	    #elaboro i dati dell'occupante
	    set indirizzo_occu "$toponimo $indirizzo"
	    set civico_occu "$numero $esponente"
	    if {[info exists provincie_italia($provincia)]} {
		set sigla_occu $provincia
	    } else {
		set sigla_occu ""
	    }
	    if {![info exists occu_generale([list $cognome_occu $nome_occu $cfisc_occu $indirizzo_occu $civico_occu $localita $comune $sigla_occu $cap $localita])]} {
		set occu_generale([list $cognome_occu $nome_occu $cfisc_occu $indirizzo_occu $civico_occu $localita $comune $sigla_occu $cap $localita]) [list $natura_occu $telefono_occu $cod_impianto_est]		
	    }
	}
 	default {
 	    #elaboro i dati dell'occupante
	    set indirizzo_occu "$toponimo $indirizzo"
	    set civico_occu "$numero $esponente"
	    if {[info exists provincie_italia($provincia)]} {
		set sigla_occu $provincia
	    } else {
		set sigla_occu ""
	    }
	    if {![info exists occu_generale([list $cognome_occu $nome_occu $cfisc_occu $indirizzo_occu $civico_occu $localita $comune $sigla_occu $cap])]} {
		set occu_generale([list $cognome_occu $nome_occu $cfisc_occu $indirizzo_occu $civico_occu $localita $comune $sigla_occu $cap]) [list $natura_occu $telefono_occu $cod_impianto_est]		
	    }    
	}
    }



    #carico massivo degli altri dati per la tabella coimcitt
    if {$flag_resp ne "A"} {
	if {[info exists provincie_italia($provincia_amm)]} {
	    set sigla_amm $provincia_amm
	} else {
	    set sigla_amm ""
	}
	if {![info exists all_generale([list $cognome_amm $nome_amm $cfisc_amm $indirizzo_amm $numero_amm $localita_amm $comune_amm $sigla_amm $cap_amm])]} {
	    set all_generale([list $cognome_amm $nome_amm $cfisc_amm $indirizzo_amm $numero_amm $localita_amm $comune_amm $sigla_amm $cap_amm]) [list $natura_amm $telefono_amm]
	}
    }
    if {$flag_resp ne "P"} {
	if {[info exists provincie_italia($provincia_prop)]} {
	    set sigla_prop $provincia_prop
	} else {
	    set sigla_prop ""
	}
	if {![info exists all_generale([list $cognome_prop $nome_prop $cfisc_prop $indirizzo_prop $numero_prop $localita_prop $comune_prop $sigla_prop $cap_prop])]} {
	    set all_generale([list $cognome_prop $nome_prop $cfisc_prop $indirizzo_prop $numero_prop $localita_prop $comune_prop $sigla_prop $cap_prop]) [list $natura_prop $telefono_prop]
	}	
    }
    if {$flag_resp ne "I"} {
	if {[info exists provincie_italia($provincia_intestatario)]} {
	    set sigla_intestatario $provincia_intestatario
	} else {
	    set sigla_intestatario ""
	}
	if {![info exists all_generale([list $cognome_intestatario $nome_intestatario $cfisc_intestatario $indirizzo_intestatario $numero_intestatario $localita_intestatario $comune_intestatario $sigla_intestatario $cap_intestatario])]} {
	    set all_generale([list $cognome_intestatario $nome_intestatario $cfisc_intestatario $indirizzo_intestatario $numero_intestatario $localita_intestatario $comune_intestatario $sigla_intestatario $cap_intestatario]) [list $natura_intestatario $telefono_intestatario]
	}
    }
    if {$flag_resp ne "T"} {
	if {[info exists provincie_italia($provincia_terzi)]} {
	    set sigla_terzi $provincia_terzi
	} else {
	    set sigla_terzi ""
	}
	if {![info exists all_generale([list $cognome_terzi $nome_terzi $cfisc_terzi $indirizzo_terzi $numero_terzi $localita_terzi $comune_terzi $sigla_terzi $cap_terzi])]} {
	    set all_generale([list $cognome_terzi $nome_terzi $cfisc_terzi $indirizzo_terzi $numero_terzi $localita_terzi $comune_terzi $sigla_terzi $cap_terzi]) [list $natura_terzi $telefono_terzi]
	}		
    }
    if {$flag_resp ne "O"} {
	set indirizzo_occu "$toponimo $indirizzo"
	set civico_occu "$numero $esponente"
	if {[info exists provincie_italia($provincia)]} {
	    set sigla_occu $provincia
	} else {
	    set sigla_occu ""
	}
	if {![info exists all_generale([list $cognome_occu $nome_occu $cfisc_occu $indirizzo_occu $civico_occu $localita $comune $sigla_occu $cap])]} {
	    set all_generale([list $cognome_occu $nome_occu $cfisc_occu $indirizzo_occu $civico_occu $localita $comune $sigla_occu $cap]) [list $natura_occu $telefono_occu]
	}			
    }

    #gestisco i manutentori
    if {$cognome_manu ne ""} {
	set indirizzo_manu [string trim $indirizzo_manu]
	if {![info exists manu_generale([list $cognome_manu $nome_manu $cfisc_manu])]} {
	    set manu_generale([list $cognome_manu $nome_manu $cfisc_manu]) [list $indirizzo_manu $localita_manu $comune_manu $provincia_manu $cap_manu $telefono_manu $cod_impianto_est $convenzionato]
	}
    } 

    #gestisco i progettisti
    if {$cognome_prog ne ""} {
	set indirizzo_prog [string trim $indirizzo_prog]
	if {![info exists prog_generale([list $cognome_prog $nome_prog $indirizzo_prog $comune_prog $cap_prog $cfisc_prog])]} {
	    set prog_generale([list $cognome_prog $nome_prog $indirizzo_prog $comune_prog $cap_prog $cfisc_prog]) [list $provincia_prog $telefono_prog $cod_impianto_est]	
	}
    } 

    #gestisco i costruttori dei generatori
    if {$costruttore_gen ne ""} {
	set cost_generale($costruttore_gen) 1	
    } 

    #gestisco i costruttori di bruciatori
    if {$costruttore_bruc ne ""} {
	set cost_generale($costruttore_bruc) 1	
    } 

    
    #creo l'array dell'impianto
    if {$potenza_utile eq ""} {
	set potenza_utile 0
    }
    if {[info exists comuni_italia([string toupper $comune])]} {
	set cod_comune $comuni_italia([string toupper $comune])
    } else {
	set cod_comune ""
    }
    if {[info exists provincie_italia($provincia)]} {
	set provincia $provincie_italia($provincia)
    } else {
	set provincia ""
    }
    if {![info exists n_gen_aimp($cod_impianto_est)]} {
	set n_gen_aimp($cod_impianto_est) $gen_prog
    } else {
	if {$gen_prog > $n_gen_aimp($cod_impianto_est)} {
	    set n_gen_aimp($cod_impianto_est) $gen_prog
	}
    }
    if {![info exists potenza_aimp($cod_impianto_est)]} {
	set potenza_aimp($cod_impianto_est) $pot_focolare_nom
    } else {
	if {$pot_focolare_nom ne ""} {
	    set pot_aimp [expr $potenza_aimp($cod_impianto_est) + $pot_focolare_nom]
	    set potenza_aimp($cod_impianto_est) $pot_aimp
	}
    }
    if {([string toupper $stato] eq "R") && ($data_rottamaz eq "") } {
	set data_rottamaz [clock format [clock seconds] -format "%Y-%m-%d"]
    }
    if {([string toupper $stato] ne "R") && ($data_rottamaz ne "")} {
	set data_rottamaz ""
    }

    if {![info exists aimp_singoli([list $cod_impianto_est $descr_comb $toponimo $indirizzo $comune $provincia])]} {

	set aimp_generale([list $cod_impianto_est $provenienza_dati $descr_comb $potenza $potenza_utile $cod_potenza $data_installaz $localita $toponimo $indirizzo $numero $esponente $cod_comune $provincia $cap $tipo_impianto $flag_dpr412 $flag_resp $cognome_amm $nome_amm $natura_amm $cfisc_amm $indirizzo_amm $numero_amm $comune_amm $sigla_amm $cap_amm $cognome_prop $nome_prop $natura_prop $cfisc_prop $indirizzo_prop $numero_prop $comune_prop $sigla_prop $cap_prop $cognome_occu $nome_occu $natura_occu $cfisc_occu $indirizzo_occu $civico_occu $comune $sigla_occu $cap $cognome_terzi $nome_terzi $natura_terzi $cfisc_terzi $indirizzo_terzi $numero_terzi $comune_terzi $sigla_terzi $cap_terzi $cognome_intestatario $nome_intestatario $natura_intestatario $cfisc_intestatario $indirizzo_intestatario $numero_intestatario $comune_intestatario $sigla_intestatario $cap_intestatario $cognome_manu $nome_manu $data_installaz $data_attivaz $data_rottamaz $stato $flag_dichiarato $data_prima_dich $data_ultim_dich $consumo_annuo $stato_conformita $cod_cted $tariffa $scala $piano $interno $cod_tpdu $cod_qua $cod_urb $data_ins $data_mod $utente $anno_costruzione $marc_effic_energ $volimetria_risc $gen_prog $n_generatori]) $note_impianto
	
	set aimp_singoli([list $cod_impianto_est $descr_comb $toponimo $indirizzo $comune $provincia]) 1
    }
    
    #creo l'array dei generatori
    if {($gen_prog ne "")} {
	if {![info exists gend_multiple([list $cod_impianto_est $gen_prog])]} {
	    
	    set gend_multiple([list $cod_impianto_est $gen_prog]) 1
	    
	    set gend_generale([list $cod_impianto_est $gen_prog $descrizione $flag_attivo $matricola $modello $costruttore_gen $matricola_bruc $modello_bruc $costruttore_bruc $tipo_foco $mod_funz $cod_utgi $tipo_bruciatore $tiraggio $locale $cod_emissione $comb_gen $data_installaz_gend $pot_focolare_lib $pot_utile_lib $pot_focolare_nom $pot_utile_nom $campo_funzion_min $campo_funzion_max $data_costruz_gen $data_rottamaz_gen]) $note
	}
    }


    incr aimp_corretti
	unset impianti_file_cols_list
    iter_get_csv $impianti_file impianti_file_cols_list |

}
close $impianti_file
unset impianti_file
array unset column_name
array unset comuni_italia
#array unset province_italia
array unset aimp_singoli
#Risetto al valore null tutte le variabili utilizazate per il precedente file
db_foreach sel_liste_csv "" {
	#Creo la lista
	unset $nome_colonna 
}
unset impianti_file_cols

#stampo i file corretti
#riformatto l'array per preparare il file per il copy
#preparo l'output per il file dei combustibili
#foreach cod_combustibile [array names comb_generale] {
#    puts $comb_output "$cod_combustibile;$comb_generale($cod_combustibile)"
#}

set occu_all(0) 1
set amm_all(0) 1
set prop_all(0) 1
set int_all(0) 1
set terz_all(0) 1
set gen_all(0) 1

#set occu_all($idx_comb) 0
set idx_comb "NON NOTO"
set comb_all($idx_comb) 0
set comb_output [open $dir/$output_dir/$comb_outputt a]
puts $comb_output "0|NON NOTO"
close $comb_output
foreach {descr_combustibile cod_combustibile} [array get comb_generale] {
    if {$descr_combustibile ne "NON NOTO"} {
	incr cod_comb
	set comb_output [open $dir/$output_dir/$comb_outputt a]
	puts $comb_output "$cod_comb|$descr_combustibile"
	close $comb_output
	set comb_all($descr_combustibile) $cod_comb
    }
}
array unset comb_generale

#preparo l'output per il file dei toponimi
foreach {toponimo descr_toponimo} [array get topo_generale] {
    if {($descr_toponimo ne "") && ($toponimo ne "")} {
	incr cod_topo
	set topo_output [open $dir/$output_dir/$topo_outputt a]
	puts $topo_output "$toponimo|$descr_toponimo"
	close $topo_output
    }
}
array unset topo_generale

#preparo l'output per il file delle viae
foreach {cod_impianto_est_viae indx_viae} [array get viae_generale] {
    util_unlist $indx_viae toponimo_esp descrizione_esp cod_comune_esp
    #leggo i valori dell'array assegnandoli alle variabili sotto elencate
    if {($indx_viae ne "") && ($descrizione_esp ne "") && ($toponimo_esp ne "")} {
	if {![info exists viae_singole([list $toponimo_esp $descrizione_esp $cod_comune_esp])]} {
	    incr codice_via
		set viae_output [open $dir/$output_dir/$viae_outputt a]
	    puts $viae_output "$codice_via|$cod_comune_esp|$descrizione_esp|$toponimo_esp|$descrizione_esp"
		close $viae_output
		set viae_singole([list $toponimo_esp $descrizione_esp $cod_comune_esp]) $codice_via
	}
	set via_all([string trim $cod_impianto_est_viae]) $viae_singole([list $toponimo_esp $descrizione_esp $cod_comune_esp])
    }
}
array unset viae_generale

#preparo l'output per il file di coimcitt elaborando i dati degli occupanti
foreach {indx_occu valore_occu} [array get occu_generale] {
    util_unlist $indx_occu cognome_occu nome_occu cfisc_occu indirizzo_occu civico_occu localita comune sigla_occu cap
    util_unlist $valore_occu natura_occu telefono_occu cod_impianto
    #trongco i valori troppo lunghi
    set indirizzo_occu [string range $indirizzo_occu 0 39]
    #leggo i valori dell'array assegnandoli alle variabili sotto elencate
    if {![info exists citt_all([list $cognome_occu $nome_occu $natura_occu $indirizzo_occu $comune $cfisc_occu])]} {
	incr count_citt
	set citt_all([list $cognome_occu $nome_occu $natura_occu $indirizzo_occu $comune $cfisc_occu]) $count_citt
	set citt_output [open $dir/$output_dir/$citt_outputt a]
	puts $citt_output "$count_citt|$natura_occu|$cognome_occu|$nome_occu|$indirizzo_occu|$civico_occu|$cap|$localita|$comune|$sigla_occu|$cfisc_occu|$telefono_occu"
	close $citt_output

    }
}
array unset occu_generale

#preparo l'output per il file di coimcitt elaborando i dati degli amministratori
foreach {indx_amm valore_amm} [array get amm_generale] {
    util_unlist $indx_amm cognome_amm nome_amm cfisc_amm indirizzo_amm civico_amm localita_amm comune sigla_amm cap
    util_unlist $valore_amm natura_amm telefono_amm cod_impianto
    #trongco i valori troppo lunghi
    set indirizzo_amm [string range $indirizzo_amm 0 39]
    #leggo i valori dell'array assegnandoli alle variabili sotto elencate
    if {![info exists citt_all([list $cognome_amm $nome_amm $natura_amm $indirizzo_amm $comune $cfisc_amm])]} {
	incr count_citt
	set citt_all([list $cognome_amm $nome_amm $natura_amm $indirizzo_amm $comune $cfisc_amm]) $count_citt
	set citt_output [open $dir/$output_dir/$citt_outputt a]
	puts $citt_output "$count_citt|$natura_amm|$cognome_amm|$nome_amm|$indirizzo_amm|$civico_amm|$cap|$localita_amm|$comune|$sigla_amm|$cfisc_amm|$telefono_amm"	
	close $citt_output
    }
}
array unset amm_generale

#preparo l'output per il file di coimcitt elaborando i dati dei proprietari
foreach {indx_prop valore_prop} [array get prop_generale] {
    util_unlist $indx_prop cognome_prop nome_prop cfisc_prop indirizzo_prop civico_prop localita_prop comune sigla_prop cap
    util_unlist $valore_prop natura_prop telefono_prop cod_impianto
    #trongco i valori troppo lunghi
    set indirizzo_prop [string range $indirizzo_prop 0 39]
    #leggo i valori dell'array assegnandoli alle variabili sotto elencate
    if {![info exists citt_all([list $cognome_prop $nome_prop $natura_prop $indirizzo_prop $comune $cfisc_prop])]} {
	incr count_citt
	set citt_all([list $cognome_prop $nome_prop $natura_prop $indirizzo_prop $comune $cfisc_prop]) $count_citt
	set citt_output [open $dir/$output_dir/$citt_outputt a]
	puts $citt_output "$count_citt|$natura_prop|$cognome_prop|$nome_prop|$indirizzo_prop|$civico_prop|$cap|$localita_prop|$comune|$sigla_prop|$cfisc_prop|$telefono_prop"
	close $citt_output
    }
}
array unset prop_generale

#preparo l'output per il file di coimcitt elaborando i dati degli intestatari
foreach {indx_intestatario valore_intestatario} [array get intestatario_generale] {
    util_unlist $indx_intestatario cognome_intestatario nome_intestatario cfisc_intestatario indirizzo_intestatario civico_intestatario localita_intestatario comune sigla_intestatario cap
    util_unlist $valore_intestatario natura_intestatario telefono_intestatario cod_impianto
    #trongco i valori troppo lunghi
    set indirizzo_intestatario [string range $indirizzo_intestatario 0 39]
    #leggo i valori dell'array assegnandoli alle variabili sotto elencate
    if {![info exists citt_all([list $cognome_intestatario $nome_intestatario $natura_intestatario $indirizzo_intestatario $comune $cfisc_intestatario])]} {
	incr count_citt
	set citt_all([list $cognome_intestatario $nome_intestatario $natura_intestatario $indirizzo_intestatario $comune $cfisc_intestatario]) $count_citt
	set citt_output [open $dir/$output_dir/$citt_outputt a]
	puts $citt_output "$count_citt|$natura_intestatario|$cognome_intestatario|$nome_intestatario|$indirizzo_intestatario|$civico_intestatario|$cap|$localita_intestatario|$comune|$sigla_intestatario|$cfisc_intestatario|$telefono_intestatario"
	close $citt_output
    }
}
array unset intestatario_generale

#preparo l'output per il file di coimcitt elaborando i dati dei terzi
foreach {indx_terzi valore_terzi} [array get terzi_generale] {
    util_unlist $indx_terzi cognome_terzi nome_terzi cfisc_terzi indirizzo_terzi civico_terzi localita_terzi comune sigla_terzi cap
    util_unlist $valore_terzi natura_terzi telefono_terzi cod_impianto
    #trongco i valori troppo lunghi
    set indirizzo_terzi [string range $indirizzo_terzi 0 39]
    #leggo i valori dell'array assegnandoli alle variabili sotto elencate
    if {![info exists citt_all([list $cognome_terzi $nome_terzi $natura_terzi $indirizzo_terzi $comune $cfisc_terzi])]} {
	incr count_citt
	set citt_all([list $cognome_terzi $nome_terzi $natura_terzi $indirizzo_terzi $comune $cfisc_terzi]) $count_citt 
	set citt_output [open $dir/$output_dir/$citt_outputt a]
	puts $citt_output "$count_citt|$natura_terzi|$cognome_terzi|$nome_terzi|$indirizzo_terzi|$civico_terzi|$cap|$localita_terzi|$comune|$sigla_terzi|$cfisc_terzi|$telefono_terzi"
	close $citt_output
    }
}
array unset terzi_generale

#preparo l'output per il file di coimcitt elaborando i dati degli altri soggetti aventi diritto di essere caricati in coimcitt
foreach {indx_all valore_all} [array get all_generale] {
    util_unlist $indx_all cognome_all nome_all cfisc_all indirizzo_all civico_all localita_all comune sigla_all cap
    util_unlist $valore_all natura_all telefono_all cod_impianto
    if {$cognome_all ne ""} {
	#trongco i valori troppo lunghi
	set indirizzo_all [string range $indirizzo_all 0 39]
	#leggo i valori dell'array assegnandoli alle variabili sotto elencate
	if {![info exists citt_all([list $cognome_all $nome_all $natura_all $indirizzo_all $comune $cfisc_all])]} {
	    incr count_citt
	    set citt_all([list $cognome_all $nome_all $natura_all $indirizzo_all $comune $cfisc_all]) $count_citt
		set citt_output [open $dir/$output_dir/$citt_outputt a]
	    puts $citt_output "$count_citt|$natura_all|$cognome_all|$nome_all|$indirizzo_all|$civico_all|$cap|$localita_all|$comune|$sigla_all|$cfisc_all|$telefono_all"
		close $citt_output
	}
    }
}
array unset all_generale

#preparo l'output per il file di coimmanu 
foreach {indx_manu valore_manu} [array get manu_generale] {
    util_unlist $indx_manu cognome_manu nome_manu cfisc_manu
    util_unlist $valore_manu indirizzo_manu localita_manu comune_manu provincia_manu cap_manu telefono_manu cod_impianto convenzionato
    if {$cognome_manu ne ""} {
	if {![info exists manu_singoli([list $cognome_manu $nome_manu])]} {
	    incr count_manu
	    set cod_manu "MA$count_manu"
	    #leggo i valori dell'array assegnandoli alle variabili sotto elencate
		set manu_output [open $dir/$output_dir/$manu_outputt a]
	    puts $manu_output "$cod_manu|$cognome_manu|$nome_manu|$indirizzo_manu|$cap_manu|$localita_manu|$comune_manu|$provincia_manu|$cfisc_manu|$telefono_manu|$convenzionato"
		close $manu_output
	    set manu_singoli([list $cognome_manu $nome_manu]) 1
	}
	set manu_all([list $cognome_manu $nome_manu]) $cod_manu
    }
}
array unset manu_generale

#preparo l'output per il file di coimprog 
foreach {indx_prog valore_prog} [array get prog_generale] {
    util_unlist $indx_prog cognome_prog nome_prog indirizzo_prog comune_prog cap_prog cfisc_prog
    util_unlist $valore_prog provincia_prog telefono_prog cod_impianto
    if {$cognome_prog ne ""} {
	incr count_prog
	#leggo i valori dell'array assegnandoli alle variabili sotto elencate
	set prog_output [open $dir/$output_dir/$prog_outputt a]
	puts $prog_output "$count_prog|$cognome_prog|$nome_prog|$indirizzo_prog|$cap_prog|$comune_prog|$provincia_prog|$cfisc_prog|$telefono_prog"
	close $prog_output
	set prog_all([list $cod_impianto $cognome_prog $nome_prog]) $count_prog
    }
}
array unset prog_generale

#preparo l'output per il file di coimcost 
foreach {indx_cost valore_cost} [array get cost_generale] {
    util_unlist $indx_cost costruttore_gen
    if {$costruttore_gen ne ""} {
	if {[info exists cost_generale($costruttore_gen)]} {
	    incr count_cost
	    #leggo i valori dell'array assegnandoli alle variabili sotto elencate
		set cost_output [open $dir/$output_dir/$cost_outputt a]
	    puts $cost_output "$count_cost|$costruttore_gen"
		close $cost_output
	    set cost_all($costruttore_gen) $count_cost
	}
    }
}
array unset cost_generale

#preparo l'output per il file di coimaimp 
foreach {indx_aimp note_impianto} [array get aimp_generale] {
    util_unlist $indx_aimp cod_impianto_est provenienza_dati descr_comb potenza potenza_utile cod_potenza data_installaz localita toponimo indirizzo numero esponente cod_comune provincia cap tipo_impianto flag_dpr412 flag_resp cognome_amm nome_amm natura_amm cfisc_amm indirizzo_amm numero_amm comune_amm sigla_amm cap_amm cognome_prop nome_prop natura_prop cfisc_prop indirizzo_prop numero_prop comune_prop sigla_prop cap_prop cognome_occu nome_occu natura_occu cfisc_occu indirizzo_occu civico_occu comune sigla_occu cap cognome_terzi nome_terzi natura_terzi cfisc_terzi indirizzo_terzi numero_terzi comune_terzi sigla_terzi cap_terzi cognome_intestatario nome_intestatario natura_intestatario cfisc_intestatario indirizzo_intestatario numero_intestatario comune_intestatario sigla_intestatario cap_intestatario cognome_manu nome_manu data_installaz data_attivaz data_rottamaz stato flag_dichiarato data_prima_dich data_ultim_dich consumo_annuo stato_conformita cod_cted tariffa scala piano interno cod_tpdu cod_qua cod_urb data_ins data_mod utente anno_costruzione marc_effic_energ volimetria_risc gen_prog n_generatori


    #estraggo i codici di reference con le tabelle citt, manu, viae
     if {[info exists citt_all([list $cognome_occu $nome_occu $natura_occu $indirizzo_occu $comune $cfisc_occu])]} {
 	set cod_occupante $citt_all([list $cognome_occu $nome_occu $natura_occu $indirizzo_occu $comune $cfisc_occu])
     } else {
 	    set cod_occupante ""
     }

    if {[info exists citt_all([list $cognome_amm $nome_amm $natura_amm $indirizzo_amm $comune_amm $cfisc_amm])]} {
	set cod_amministratore $citt_all([list $cognome_amm $nome_amm $natura_amm $indirizzo_amm $comune_amm $cfisc_amm])
    } else {
	    set cod_amministratore ""
    }

    if {[info exists citt_all([list $cognome_prop $nome_prop $natura_prop $indirizzo_prop $comune_prop $cfisc_prop])]} {
	set cod_proprietario $citt_all([list $cognome_prop $nome_prop $natura_prop $indirizzo_prop $comune_prop $cfisc_prop])
    } else {
	    set cod_proprietario ""
    }

    if {[info exists manu_all([list $cognome_manu $nome_manu])]} {
	set cod_manutentore $manu_all([list $cognome_manu $nome_manu])
    } else {
	set cod_manutentore ""
    }

    if {[info exists citt_all([list $cognome_intestatario $nome_intestatario $natura_intestatario $indirizzo_intestatario $comune_intestatario $cfisc_intestatario])]} {
	set cod_intestatario $citt_all([list $cognome_intestatario $nome_intestatario $natura_intestatario $indirizzo_intestatario $comune_intestatario $cfisc_intestatario])
    } else {
	    set cod_intestatario ""
    }

    if {[info exists citt_all([list $cognome_terzi $nome_terzi $natura_terzi $indirizzo_terzi $comune_terzi $cfisc_terzi])]} {
	set cod_terzi $citt_all([list $cognome_terzi $nome_terzi $natura_terzi $indirizzo_terzi $comune_terzi $cfisc_terzi])
    } else {
	    set cod_terzi ""
    }

    if {[info exists via_all([string trim $cod_impianto_est])]} {
	set cod_via $via_all([string trim $cod_impianto_est])
    } else {
	set cod_via ""
    }

    if {[info exists comb_all($descr_comb)]} {
	set cod_combustibile $comb_all($descr_comb)
    } else {
	set cod_combustibile "0"
    }

    switch $flag_resp {
	A {
	    set cod_responsabile $cod_amministratore
	}
	P {
	    set cod_responsabile $cod_proprietario
	}
	O {
	    set cod_responsabile $cod_occupante
	}
	I {
	    set cod_responsabile $cod_intestatario
	}
	T {
	    set cod_responsabile $cod_terzi
	}
	default {
	    set cod_responsabile $cod_occupante	    
	}
    }
    if {[string trim $n_generatori] eq ""} {
	if {[info exists n_gen_aimp($cod_impianto_est)]} {
	    set n_generatori $n_gen_aimp($cod_impianto_est)
	}
     }
    if {$potenza eq ""} {
	if {[info exists potenza_aimp($cod_impianto_est)]} {
	    set potenza $potenza_aimp($cod_impianto_est);
	}
    }


    incr count_aimp    

    #leggo i valori dell'array assegnandoli alle variabili sotto elencate
	#da modificare dopo
    #set array_out_aimp($cod_impianto_est) [list $count_aimp $cod_combustibile $provenienza_dati $tipo_impianto $potenza $potenza_utile $cod_potenza $data_installaz $data_attivaz $data_rottamaz $stato $flag_dichiarato $data_prima_dich $data_ultim_dich $consumo_annuo $n_generatori $stato_conformita $cod_cted $tariffa $cod_responsabile $flag_resp $cod_intestatario $cod_proprietario $cod_occupante $cod_amministratore $cod_manutentore $localita $cod_via $toponimo $indirizzo $numero $esponente $scala $piano $interno $cod_comune $provincia $cap $cod_tpdu $cod_qua $cod_urb $data_ins $data_mod $utente $flag_dpr412 $anno_costruzione $marc_effic_energ $volimetria_risc $note_impianto]
	set aimp_output [open $dir/$output_dir/$aimp_outputt a]
    puts $aimp_output "$count_aimp|$cod_impianto_est|$cod_combustibile|$provenienza_dati|$tipo_impianto|$potenza|$potenza_utile|$cod_potenza|$data_installaz|$data_attivaz|$data_rottamaz|$stato|$flag_dichiarato|$data_prima_dich|$data_ultim_dich|$consumo_annuo|$n_generatori|$stato_conformita|$cod_cted|$tariffa|$cod_responsabile|$flag_resp|$cod_intestatario|$cod_proprietario|$cod_occupante|$cod_amministratore|$cod_manutentore|$localita|$cod_via|$toponimo|$indirizzo|$numero|$esponente|$scala|$piano|$interno|$cod_comune|$provincia|$cap|$cod_tpdu|$cod_qua|$cod_urb|$data_ins|$data_mod|$utente|$flag_dpr412|$anno_costruzione|$marc_effic_energ|$volimetria_risc|$note_impianto"
	close $aimp_output
	set aimp_all($cod_impianto_est) $count_aimp
    
}
array unset aimp_generale
array unset citt_all
array unset manu_all
array unset viae_all

#preparo l'output per il file di coimgend 
foreach {indx_gend note} [array get gend_generale] {

    util_unlist $indx_gend cod_impianto_est gen_prog descrizione flag_attivo matricola modello costruttore_gen matricola_bruc modello_bruc costruttore_bruc tipo_foco mod_funz cod_utgi tipo_bruciatore tiraggio locale cod_emissione comb_gen data_installaz_gend pot_focolare_lib pot_utile_lib pot_focolare_nom pot_utile_nom campo_funzion_min campo_funzion_max data_costruz_gen data_rottamaz_gen

    if {[info exists cost_all($costruttore_gen)]} {
	set cod_costruttore $cost_all($costruttore_gen)
    } else {
	set cod_costruttore ""
    }
    if {[info exists cost_all($costruttore_bruc)]} {
	set cod_costruttore_bruc $cost_all($costruttore_bruc)
    } else {
	set cod_costruttore_bruc ""
    }
    if {[info exists comb_all($comb_gen)]} {
	set cod_combustibile $comb_all($comb_gen)
    } else {
	set cod_combustibile "0"
    }
    incr count_gend
    set cod_aimp $aimp_all($cod_impianto_est)
    #leggo i valori dell'array assegnandoli alle variabili sotto elencate
	set gend_output [open $dir/$output_dir/$gend_outputt a]
    puts $gend_output "$cod_aimp|$gen_prog|$gen_prog|$descrizione|$flag_attivo|$matricola|$modello|$cod_costruttore|$matricola_bruc|$modello_bruc|$cod_costruttore_bruc|$tipo_foco|$mod_funz|$cod_utgi|$tipo_bruciatore|$tiraggio|$locale|$cod_emissione|$cod_combustibile|$data_installaz_gend|$pot_focolare_lib|$pot_utile_lib|$pot_focolare_nom|$pot_utile_nom|$note|$campo_funzion_min|$campo_funzion_max|$data_costruz_gen|$data_rottamaz_gen"
	close $gend_output
	
	set gend_all([list $cod_aimp $gen_prog]) 1
}
array unset gend_generale


#chiudo i file aperti
#close $impianti_file
#close $comb_output
#close $topo_output
#close $viae_output
#close $cost_output
#close $gend_output


#Unset degli array creati durante l'elaborazione
#array unset comb_generale
#array unset topo_generale
#array unset viae_generale
#array unset amm_generale
#array unset intestatario_generale
#array unset prop_generale
#array unset terzi_generale
#array unset occu_generale

#array unset manu_generale
#array unset prog_generale
#array unset cost_generale
#array unset aimp_generale
#array unset gend_generale


ns_log Notice "Fine Impianti - arrivato"

set cod_impianto ""
set gen_prog ""

# Inizio della lettura del file dei rapporti di verifica
set csv_name "rapporti"

#scrivo la lista delle variabili per il file degli impianti
set rapporti_file_cols "" 

db_foreach sel_liste_csv "" {
    #Creo la lista
    lappend rapporti_file_cols $nome_colonna
}
lappend rapporti_file_cols cod_tanom

#Salto la prima riga di intestazione del file csv 
iter_get_csv $rapporti_file rapporti_file_cols_list |

#Comincio la lettura dei records
iter_get_csv $rapporti_file rapporti_file_cols_list |

set count_opve 0

db_1row sel_ente_ver ""
set count_opve [template::util::leadingPad $count_opve 3]
set cod_opve "$cod_enve$count_opve"
set opve_output [open $dir/$output_dir/$opve_outputt a]
puts $opve_output "$cod_opve|$cod_enve|Generico|Operatore"
close $opve_output

ns_log Notice "Inizio rapporti - arrivato"

while {![eof $rapporti_file]} {
    incr count_2
    set righe_contate [expr $count_2%$dividendo]
    if {$righe_contate eq 0} {
	set time [clock format [clock seconds]]
	set log_file [open $dir/$log_dir/$log a]
	puts $log_file "Analisi completata per $count_2 rapporti $time"
	close $log_file
	ns_write "Analisi completata per $count_2 rapporti $time <br>"
    }   
	unset righe_contate
	
    set err_log ""
    set err_count_rapporti 0
    set ind 0
    foreach column_name $rapporti_file_cols {
	set $column_name [lindex $rapporti_file_cols_list $ind]
	incr ind
    }

	ns_log Notice "rapporto $count_2"
	
    #Registro il verificatore
    
    set opve_elaborati(0) 1
    if {![info exists opve_elaborati([list $cognome_veri $nome_veri])]} {
	set opve_elaborati([list $cognome_veri $nome_veri]) 1
	incr count_opve
	set lpad_count_opve [template::util::leadingPad $count_opve 3]
	set cod_opve "$cod_enve$lpad_count_opve"
	set opve_output [open $dir/$output_dir/$opve_outputt a]
	puts $opve_output "$cod_opve|$cod_enve|$cognome_veri|$nome_veri"
	close $opve_output
	set opve_generale([list $cognome_veri $nome_veri]) $cod_opve	
    }
    set cod_impianto ""
    # rapporti 
    if {[info exists aimp_all($cod_impianto_est)]} {
	set cod_impianto $aimp_all($cod_impianto_est)
    }
    if {$gen_prog eq "" || $gen_prog eq "0"} {
	set gen_prog 1
    }

    if {$data_controllo eq ""} {
	set data_controllo "19000101"
    }

    # verifico che il rapporto che si sta per elaborare sia singolo
    if {[info exists gend_all([list $cod_impianto $gen_prog])]} {    
	if {![info exists rapporti_elaborati([list $cod_impianto $gen_prog $data_controllo])]} {
	    set rapporti_elaborati([list $cod_impianto $gen_prog $data_controllo]) 1
	} else {	    
		unset rapporti_file_cols_list
	    iter_get_csv $rapporti_file rapporti_file_cols_list |
	    continue
	}
	
	#Cerco se il responsabile dell'impianto è stato caricato nella lettura degli impianti
	#
	set cod_resp ""
#	if {[info exists citt_all([list $cognome_resp $nome_resp $natura_giuridica_resp $indirizzo_resp $comune_resp $cod_fiscale_resp])]} {
#	    set cod_resp $citt_all([list $cognome_resp $nome_resp $natura_giuridica_resp $indirizzo_resp $comune_resp $cod_fiscale_resp])
#	} else {
	    if {[info exists provincie_italia($provincia_resp)]} {
		set sigla_resp $provincia_resp
	    } else {
		set sigla_resp ""
	    }
	    incr count_citt
	    set citt_output [open $dir/$output_dir/$citt_outputt a]
	    puts $citt_output "$count_citt|$natura_giuridica_resp|$cognome_resp|$nome_resp|||$cap_resp||$comune_resp|$sigla_resp|$cod_fiscale_resp|$telefono_resp"
	    close $citt_output
	    #set citt_all([list $cognome_resp $nome_resp $natura_giuridica_resp $indirizzo_resp $comune_resp $cod_fiscale_resp]) $count_citt
	    set cod_resp $count_citt
#	}

	if {[info exists opve_generale([list $cognome_veri $nome_veri])]} {
	    set cod_opve $opve_generale([list $cognome_veri $nome_veri])
	} else {
	    set cod_opve ""
	}	
	array unset opve_generale

	if {[info exists comb_all($cod_combustibile)]} {
	    set cod_combustibile $comb_all($cod_combustibile)
	} else {
	    set cod_combustibile "0"
	}	

	incr count_cimp
	#Creo il file csv di output per i rapporti di verifica	
	set cimp_output [open $dir/$output_dir/$cimp_outputt a]
	puts $cimp_output "$count_cimp|$cod_impianto|$gen_prog|$data_controllo|$presenza_libretto|$libretto_manutenz|$stato_coiben|$verifica_areaz|$rend_comb_conv|$rend_comb_min|$indic_fumosita_1a|$indic_fumosita_2a|$indic_fumosita_3a|$indic_fumosita_md|$temp_h2o_out_1a|$temp_h2o_out_2a|$temp_h2o_out_3a|$temp_h2o_out_md|$t_aria_comb_1a|$t_aria_comb_2a|$t_aria_comb_3a|$t_aria_comb_md|$temp_fumi_1a|$temp_fumi_2a|$temp_fumi_3a|$temp_fumi_md|$co_1a|$co_2a|$co_3a|$co_md|$co2_1a|$co2_2a|$co2_3a|$co2_md|$o2_1a|$o2_2a|$o2_3a|$o2_md|$temp_mant_1a|$temp_mant_2a|$temp_mant_3a|$temp_mant_md|$cod_combustibile|$libretto_corretto|$mis_pot_focolare|$eccesso_aria_perc|$eccesso_aria_perc_2a|$eccesso_aria_perc_3a|$eccesso_aria_perc_md|$manutenzione_8a|$co_fumi_secchi_8b|$indic_fumosita_8c|$rend_comb_8d|$esito_verifica|$note_conf|$note_verificatore|$note_resp|$pot_utile_nom|$pot_focolare_nom|$cod_resp|$new1_data_dimp|$new1_data_paga_dimp|$new1_conf_locale|$new1_disp_regolaz|$new1_foro_presente|$new1_foro_corretto|$new1_foro_accessibile|$new1_data_ultima_manu|$new1_data_ultima_anal|$new1_co_rilevato|$costo|$nominativo_pres|$dich_conformita|$mis_port_combust|$strumento|$marca_strum|$modello_strum|$matr_strum|$dt_tar_strum|$tipologia_costo|$riferimento_pag|$utente|$data_ins|$flag_tracciato|$new1_note_manu|$new1_dimp_pres|$new1_dimp_prescriz|$new1_manu_prec_8a|$new1_flag_peri_8p|$pendenza|$ventilaz_lib_ostruz|$disp_reg_cont_pre|$disp_reg_cont_funz|$disp_reg_clim_funz|$volumetria|$comsumi_ultima_stag|$data_prot|$n_prot|$cod_opve|$new1_conf_accesso|$new1_pres_mezzi|$new1_pres_intercet|$new1_pres_cartell|$new1_pres_interrut|$new1_asse_mate_estr|$ora_inizio|$ora_fine"
	close $cimp_output
		
	#Creo il file relativo alle anomalie dell'impianto che andrà a caricare la tabella coimanom    
        set anomalie_impianto [split $cod_tanom \,]
        set num_anom [llength $anomalie_impianto]
	set anom_prog 1
	set tipo_anom 2
	set flag_origine "RV"
	for {set i 0} {$i < $num_anom-1} {incr i} {
	    set anom [lindex $anomalie_impianto $i]
	    set anom [string trim $anom]
	    if {$anom ne ""} {
		set anom_output [open $dir/$output_dir/$anom_outputt a]
		puts $anom_output "$count_cimp|$anom_prog|$tipo_anom|$anom|$flag_origine"
		close $anom_output
		incr anom_prog
		incr count_anom
	    }
	}
    } 
    
	unset rapporti_file_cols_list
    iter_get_csv $rapporti_file rapporti_file_cols_list |
}

	ns_log Notice "Rapporti fine"
	
#Operazioni di chiusura per i rapporti di verifica
#Chiudo i file aperti durante l'elaborazione
close $rapporti_file
unset rapporti_file

#puts $log_file "Inizio Analisi per le autocertificazioni $time"
#ns_write "Inizio Analisi per le autocertificazioni $time <br>"

#Unset degli array creati durante l'elaborazione
array unset anom
array unset column_name
array unset anomalie_impianto

#Risetto a "" le variabili utilizzate	    
db_foreach sel_liste_csv "" {
    #Creo la lista
    unset $nome_colonna
}
unset rapporti_file_cols
unset cod_tanom
unset cod_impianto


ns_log Notice "Autocertificazioni inizio"
# Inizio l'analisi del file delle autocertificazioni
set csv_name "autocert"

#scrivo la lista delle variabili per il file degli impianti
set autocertificazioni_file_cols "" 

db_foreach sel_liste_csv "" {
    #Creo la lista
    lappend autocertificazioni_file_cols $nome_colonna
}
lappend autocertificazioni_file_cols cod_tanom
unset csv_name

#Salto la prima riga di intestazione del file csv 
iter_get_csv $autocertificazioni_file autocertificazioni_file_cols_list |

#Comincio la lettura dei records
iter_get_csv $autocertificazioni_file autocertificazioni_file_cols_list |

while {![eof $autocertificazioni_file]} {
    
    incr count_3
    set righe_contate [expr $count_3%$dividendo]
    if {$righe_contate eq 0} {
	set time [clock format [clock seconds]]
	set log_file [open $dir/$log_dir/$log a]
	puts $log_file "Analisi completata per $count_3 autocertificazioni $time"
	close $log_file
	ns_write "Analisi completata per $count_3 autocertificazioni $time <br>"
    }   

    set err_log ""
    set ind 0
    foreach column_name $autocertificazioni_file_cols {
	set $column_name [lindex $autocertificazioni_file_cols_list $ind]
	incr ind
    }
    
    ns_log Notice "Autocertificazione $count_3"
    
    # autocertificazioni
    if {[info exists aimp_all($cod_impianto_est)]} {
	set cod_impianto $aimp_all($cod_impianto_est)
    }

    if {$data_controllo eq ""} {
	set data_controllo "1900-01-01"
    }

    # Settaggio di un array che conterrà la data dell'ultima dichiarazione effettuata e 
    # la data di scadenza dell'ultima dichiarazione.
    # Questi valori verranno confrontati con quelli derivati dall'analisi degli impianti e, se necessario
    # sostituiti nel file degli impianti
    # I dati nel file delle autocertificazioni non vengono mai modificati
    if {$data_scadenza eq "" && [iter_check_date $data_controllo] != 0} {
	if {$pot_focolare_mis < 35} {
	    set data_dich $data_controllo
	    set months $month_modh
	    db_1row add_date_month ""
	}
	if {$pot_focolare_mis > 35} {
	    set data_dich $data_controllo
	    set months $month_modh_b
	    db_1row add_date_month ""
	}
	set data_scadenza $date
    }

    if {[info exists datas_dich($cod_impianto_est)]} {
	set datas $datas_dich($cod_impianto_est)
	util_unlist $datas data_dimp data_scad
	if {$data_controllo > $data_dimp} {
	    set data_dimp $data_controllo
	}
	if {$data_scadenza > $data_scad} {
	    set data_scad $data_scadenza
	}

	set datas_dich($cod_impianto_est) [list $data_dimp $data_scad]
	
    } else {
	set datas_dich($cod_impianto_est) [list $data_controllo $data_scadenza]
    }

    # verifico che l'autocertificazione che si sta per elaborare sia singola
    
    #Se il campo del progressivo del generatore è null, lo setto al valore di default 1
    if {$gen_prog eq "" || $gen_prog eq "0"} {
	set gen_prog 1
    }
    
    if {[info exists gend_all([list $cod_impianto $gen_prog])]} {
	if {![info exists autocertificazioni_elaborati([list $cod_impianto $gen_prog $data_controllo])]} {
	    set autocertificazioni_elaborati([list $cod_impianto $gen_prog $data_controllo]) 1
	} else {
	    iter_get_csv $autocertificazioni_file autocertificazioni_file_cols_list |
	    continue
	}
	
	# Qui le autocertificazioni sono corrette
	
	#Cerco se il responsabile dell'impianto è stato caricato durante la lettura degli impianti
	#	
#	set cod_resp ""
#	if {[info exists citt_all([list $cognome_resp $nome_resp $natura_giuridica_resp $indirizzo_resp $comune_resp $cod_fiscale_resp])]} {
#	    set cod_resp $citt_all([list $cognome_resp $nome_resp $natura_giuridica_resp $indirizzo_resp $comune_resp $cod_fiscale_resp])
#	} else {
	    if {[info exists provincie_italia($provincia_resp)]} {
		set sigla_resp $provincia_resp
	    } else {
		set sigla_resp ""
	    }
	    incr count_citt
		set citt_output [open $dir/$output_dir/$citt_outputt a]
	    puts $citt_output "$count_citt|$natura_giuridica_resp|$cognome_resp|$nome_resp|$indirizzo_resp||$cap_resp||$comune_resp|$sigla_resp|$cod_fiscale_resp|$telefono_resp"
		close $citt_output
		#set citt_all([list $cognome_resp $nome_resp $natura_giuridica_resp $indirizzo_resp $comune_resp $cod_fiscale_resp]) $count_citt

	    set cod_resp $count_citt
#	}
	#Cerco se l'occupante dell'impianto è stato caricato durante la lettura degli impianti
#	set cod_occu ""
#    if {[info exists citt_all([list $cognome_occu $nome_occu $natura_giuridica_occu $indirizzo_occu $comune_occu $cod_fiscale_occu])]} {
#	    set cod_occu $citt_all([list $cognome_occu $nome_occu $natura_giuridica_occu $indirizzo_occu $comune_occu $cod_fiscale_occu])
#	} else {
	    if {[info exists provincie_italia($provincia_occu)]} {
		set sigla_occu $provincia_occu
	    } else {
		set sigla_occu ""
	    }
	    incr count_citt
		set citt_output [open $dir/$output_dir/$citt_outputt a]
	    puts $citt_output "$count_citt|$natura_giuridica_occu|$cognome_occu|$nome_occu|$indirizzo_occu||$cap_occu||$comune_occu|$sigla_occu|$cod_fiscale_occu|$telefono_occu"
		close $citt_output
		#set citt_all([list $cognome_occu $nome_occu $natura_giuridica_occu $indirizzo_occu $comune_occu $cod_fiscale_occu]) $count_citt
	    set cod_occu $count_citt
#	}
	#Cerco se il manutentore dell'impianto è stato caricato durante la lettura degli impianti
#	set cod_manu ""
#	if {[info exists manu_all([list $cognome_manu $nome_manu])]} {
#	    set cod_manu $manu_all([list $cognome_manu $nome_manu])
#	} else {
	    incr count_manu
	    set cod_manu "MA$count_manu"
	    #set manu_all([list $cognome_manu $nome_manu]) $cod_manu
	    set manu_output [open $dir/$output_dir/$manu_outputt a]
	    puts $manu_output "$cod_manu|$cognome_manu|$nome_manu||$cap_manu||$comune_manu||$cod_fiscale_manu|$telefono_manu|"
	    close $manu_output
#	}
	#Cerco se il proprietario dell'impianto è stato caricato durante la lettura degli impianti
	set cod_prop ""	    

	incr count_dimp
	#Creo il file csv di output per le autocertificazioni
	set dimp_output [open $dir/$output_dir/$dimp_outputt a]
	puts $dimp_output "$count_dimp|$cod_impianto|$data_controllo|$flag_status|$gen_prog|$cod_manu|$cod_resp|$cod_prop|$cod_occu|$conformita|$lib_impianto|$lib_uso_man|$inst_in_out|$rapp_contr|$certificaz|$libretto_bruc|$ispesl|$prev_incendi|$esame_vis_l_elet|$funz_corr_bruc|$idoneita_locale|$ap_ventilaz|$ap_vent_ostruz|$pendenza|$sezioni|$curve|$lunghezza|$conservazione|$scar_ca_si|$scar_parete|$riflussi_locale|$assenza_perdite|$pulizia_ugelli|$antivento|$scambiatore|$accens_reg|$disp_comando|$ass_perdite|$valvola_sicur|$vaso_esp|$disp_sic_manom|$organi_integri|$circ_aria|$guarn_accop|$assenza_fughe|$coibentazione|$eff_evac_fum|$cont_rend|$pot_focolare_mis|$temp_fumi|$temp_ambi|$o2|$co2|$bacharach|$flag_co_perc|$co|$rend_combust|$osservazioni|$raccomandazioni|$prescrizioni|$data_utile_inter|$n_prot|$data_prot|$delega_resp|$delega_manut|$num_bollo|$costo|$tipologia_costo|$riferimento_pag|$utente|$data_ins|$data_mod|$potenza|$flag_tracciato|$tiraggio|$ora_inizio|$ora_fine|$data_scadenza|$num_autocert|$volimetria_risc|$consumo_annuo"
	close $dimp_output
		
	#Creo il file relativo alle anomalie dell'impianto che andrà a caricare la tabella coimanom 
	set anomalie_impianto [split $cod_tanom \,]
	set num_anom [llength $anomalie_impianto] 
	set anom_prog 1
	set tipo_anom 2
	set flag_origine "MH"
	for {set i 0} {$i < $num_anom-1} {incr i} {
	    set anom [lindex $anomalie_impianto $i]
	    set anom [string trim $anom]
	    if {$anom ne ""} {
		set anom_output [open $dir/$output_dir/$anom_outputt a]
		puts $anom_output "$count_dimp|$anom_prog|$tipo_anom|$anom|$flag_origine"
		close $anom_output
		incr anom_prog
		incr count_anom
	    }
	}
	
    }	
	
    unset autocertificazioni_file_cols_list
    iter_get_csv $autocertificazioni_file autocertificazioni_file_cols_list |
}

#Operazioni di chiusura per i rapporti di verifica
#Chiudo i file aperti durante l'elaborazione
close $autocertificazioni_file
unset autocertificazioni_file

#close $dimp_output
#close $citt_output
#close $manu_output
ns_log Notice "Autocertificazioni fine"
#Unset degli array creati durante l'elaborazione
array unset anom
array unset column_name
array unset anomalie_impianto

#Risetto a "" tutte le variabili utilizzate
db_foreach sel_liste_csv "" {
    #Creo la lista
    unset $nome_colonna 
}
unset autocertificazioni_file_cols
unset cod_tanom
unset cod_impianto



#ora di fine flusso
set time_end [clock format [clock seconds]]

set dati_report_url "coimcari-report-dat?nome_funz=report-dat&cod_topo=$cod_topo&cod_comb=$cod_comb&n_comuni_cod=$n_comuni_cod&codice_via=$codice_via&count_citt=$count_citt&count_manu=$count_manu&count_prog=$count_prog&count_cost=$count_cost&count_gend=$count_gend&aimp_corretti=$aimp_corretti&count_cimp=$count_cimp&count_dimp=$count_dimp&count_anom=$count_anom&count_opve=$count_opve"

ns_write "Analisi completata: ora di fine <b>$time_end</b> <br>"
set log_file [open $dir/$log_dir/$log a]
puts $log_file "Analisi completata: ora di fine $time_end"
puts $log_file "Fine"
close $log_file
ns_write "Fine<br><br>"
unset time_ent

set log_file [open $dir/$log_dir/$log a]
puts $log_file "Toponimi caricati: $cod_topo;\nCombustibili caricati: $cod_comb;\nComuni caricati correttamente: $n_comuni_cod;\nVie caricate: $codice_via;\nCittadini caricati: $count_citt;\nManutentori caricati: $count_manu;\nProgettisti caricati: $count_prog;\nCostruttori caricati: $count_cost;\nGeneratori caricati: $count_gend;\nImpianti caricati: $aimp_corretti;\nRapporti di verifica caricati: $count_cimp;\nAutocertificazioni caricate: $count_dimp;\nAnomalie caricate: $count_anom;\nOperatori caricati: $count_opve;\n"
close $log_file
#exec tar czf "coimdat.tar.gz" $output_dir

ns_write "<a href=\"$dati_report_url\">Visualizza il report del caricamento</a>"



#ad_return_template

