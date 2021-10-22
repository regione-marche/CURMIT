ad_page_contract {

    Lettura di 3 file sequenziali contenenti gli impianti, le autocertificazioni e i rapporti di verifica
    seguendo un tracciato record prefissato e validandone i dati al fine di ottenere un caricamento veloce e pulito
    delle tabelle *** di iter
    Il programma restituisce un report visivo con il riassunto adei dati validati, 
    tre file csv contenenti gli errori riscontrati

    @creation-date   18/10/2006

    @cvs-id          coimcari-files.tcl
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

# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# raccolgo i dati della coimtgen
iter_get_coimtgen

# controllo il parametro di "propagazione" per la navigation bar
if {[string equal $nome_funz_caller ""]} {
    set nome_funz_caller $nome_funz
}

set link_gest [export_url_vars nome_funz nome_funz_caller caller]

# Personalizzo la pagina
set page_title   "Bonifica dei dati da caricare"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# Setto le directory per il salvataggio degli output temporanei
set dir           [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]

# Setto la directory in cui sono salvati i file con i record pronti per il caricamento
if {$coimtgen(flag_ente) eq "P"} {
    set dat_dir "dat_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(sigla_prov)]"
} else {
    set dat_dir "dat_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(denom_comune)]"
}

# Setto i nomi dei file che andrò a modificare
set coimcomb "coimcomb.dat"
set coimaimp "coimaimp.dat"
set coimgend "coimgend.dat"
set coimtopo "coimtopo.dat" 
set coimviae "coimviae.dat"
set coimcitt "coimcitt.dat"

# Setto i nomi dei file di output bonificati
set coimcomb_bnf "coimcomb_bnf.dat"
set coimaimp_bnf "coimaimp_bnf.dat"
set coimgend_bnf "coimgend_bnf.dat"
set coimtopo_bnf "coimtopo_bnf.dat" 
set coimviae_bnf "coimviae_bnf.dat"
set coimcitt_bnf "coimcitt_bnf.dat"

# Dichiaro i file da andare a modificare
set coimaimp_file [open $dir/$dat_dir/$coimaimp r]
set coimgend_file [open $dir/$dat_dir/$coimgend r]
set coimcomb_file [open $dir/$dat_dir/$coimcomb r]
set coimtopo_file [open $dir/$dat_dir/$coimtopo r]
set coimviae_file [open $dir/$dat_dir/$coimviae r]
set coimcitt_file [open $dir/$dat_dir/$coimcitt r]

# Dichiaro i file di output bonificati
set coimaimp_output [open $dir/$dat_dir/$coimaimp_bnf w]
set coimgend_output [open $dir/$dat_dir/$coimgend_bnf w]
set coimcomb_output [open $dir/$dat_dir/$coimcomb_bnf w]
set coimtopo_output [open $dir/$dat_dir/$coimtopo_bnf w]
set coimviae_output [open $dir/$dat_dir/$coimviae_bnf w]
set coimcitt_output [open $dir/$dat_dir/$coimcitt_bnf w]

#Setto l'encoding per i file in lettura
fconfigure $coimaimp_file -encoding iso8859-15 -translation lf
fconfigure $coimgend_file -encoding iso8859-15 -translation lf
fconfigure $coimcomb_file -encoding iso8859-15 -translation lf
fconfigure $coimtopo_file -encoding iso8859-15 -translation lf
fconfigure $coimviae_file -encoding iso8859-15 -translation lf
fconfigure $coimcitt_file -encoding iso8859-15 -translation lf

#Setto l'encoding per i file in scrittura
fconfigure $coimaimp_output -encoding iso8859-15 -translation lf
fconfigure $coimgend_output -encoding iso8859-15 -translation lf
fconfigure $coimcomb_output -encoding iso8859-15 -translation lf
fconfigure $coimtopo_output -encoding iso8859-15 -translation lf
fconfigure $coimviae_output -encoding iso8859-15 -translation lf
fconfigure $coimcitt_output -encoding iso8859-15 -translation lf

#Settaggio della lista per la lettura del file coimcomb.dat
set coimcomb_file_cols ""

lappend coimcomb_file_cols cod_comb_old
lappend coimcomb_file_cols descr_comb_old
lappend coimcomb_file_cols cod_comb_new
lappend coimcomb_file_cols descr_comb_new

#Lettura del file dei combustibili e memorizzazione dei valori in un array, che servirà per la modifica
iter_get_csv $coimcomb_file coimcomb_file_cols_list |

while {![eof $coimcomb_file]} {

    set ind 0    
    foreach column_name $coimcomb_file_cols {
	set $column_name [lindex $coimcomb_file_cols_list $ind]
	incr ind
    }

    set comb_bonifica($cod_comb_old) $cod_comb_new

    set comb_new([list $cod_comb_new $descr_comb_new]) 1

    iter_get_csv $coimcomb_file coimcomb_file_cols_list | 
}

#Setto le variabili utilizzate a null
set cod_comb_old ""
set descr_comb_old ""
set cod_comb_new ""
set descr_comb_new ""

#Settaggio della lista per la lettura del file coimtopo.dat
set coimtopo_file_cols ""

lappend coimtopo_file_cols cod_topo_old
lappend coimtopo_file_cols descr_topo_old
lappend coimtopo_file_cols cod_topo_new
lappend coimtopo_file_cols descr_topo_new

#Lettura del file dei toponimi e memorizzazione dei valori in un array, che servirà per la modifica
iter_get_csv $coimtopo_file coimtopo_file_cols_list |

while {![eof $coimtopo_file]} {

    set ind 0    
    foreach column_name $coimtopo_file_cols {
	set $column_name [lindex $coimtopo_file_cols_list $ind]
	incr ind
    }

    set topo_bonifica($cod_topo_old) $cod_topo_new
    set topo_new([list $cod_topo_new $descr_topo_new]) 1

    iter_get_csv $coimtopo_file coimtopo_file_cols_list | 
}

#Setto le variabili utilizzate a null
set cod_topo_old ""
set descr_topo_old ""
set cod_topo_new ""
set descr_topo_new ""

#Setto le variabili per la lettura del file delle vie
set coimviae_file_cols ""

lappend coimviae_file_cols cod_via
lappend coimviae_file_cols cod_comune
lappend coimviae_file_cols descrizione
lappend coimviae_file_cols descr_topo
lappend coimviae_file_cols descr_estesa

#Setto la vbariabile descr_topo_index contenente la posizione occupata dal toponimo all'interno della lista
set descr_topo_index 3
set cod_via_new 0

#Lettura del file dei toponimi e memorizzazione dei valori in un array, che servirà per la modifica
iter_get_csv $coimviae_file coimviae_file_cols_list |

while {![eof $coimviae_file]} {

    set ind 0    
    foreach column_name $coimviae_file_cols {
	set $column_name [lindex $coimviae_file_cols_list $ind]
	incr ind
    }
    set indirizzo_citt_old "$descr_topo $descrizione"

    if {([info exists topo_bonifica($descr_topo)]) && ($descr_topo ne $topo_bonifica($descr_topo))} {
	set descr_topo $topo_bonifica($descr_topo)
	set coimviae_file_cols_list [lreplace $coimviae_file_cols_list $descr_topo_index $descr_topo_index $topo_bonifica($descr_topo)]
    }

    if {![info exists viae_compact([list $cod_comune $descrizione $descr_topo $descr_estesa])]} {
	incr cod_via_new

       	set viae_bonifica($cod_via) $cod_via_new 

	set coimviae_file_cols_list [lreplace $coimviae_file_cols_list 0 0 $cod_via_new]
	set viae_compact([list $cod_comune $descrizione $descr_topo $descr_estesa]) $cod_via_new

	set indirizzo_citt_new "$descr_topo $descrizione"
	set viae_citt($indirizzo_citt_old) $indirizzo_citt_new
	
	iter_put_csv $coimviae_output coimviae_file_cols_list |
    } else {
	set viae_bonifica($cod_via) $viae_compact([list $cod_comune $descrizione $descr_topo $descr_estesa])
    }

    iter_get_csv $coimviae_file coimviae_file_cols_list | 
}

#Setto le variabili utilizzate a null
set cod_via ""
set cod_comune ""
set descrizione ""
set descr_topo ""
set descr_estesa ""

# Setto la lista per la lettura del file degli impianti
set coimaimp_file_cols ""

lappend coimaimp_file_cols count_aimp
lappend coimaimp_file_cols cod_impianto_est
lappend coimaimp_file_cols cod_combustibile
lappend coimaimp_file_cols provenienza_dati
lappend coimaimp_file_cols tipo_impianto
lappend coimaimp_file_cols potenza
lappend coimaimp_file_cols potenza_utile
lappend coimaimp_file_cols cod_potenza
lappend coimaimp_file_cols data_installaz
lappend coimaimp_file_cols data_attivaz
lappend coimaimp_file_cols data_rottamaz
lappend coimaimp_file_cols note
lappend coimaimp_file_cols stato
lappend coimaimp_file_cols flag_dichiarato
lappend coimaimp_file_cols data_prima_dich
lappend coimaimp_file_cols data_ultim_dich
lappend coimaimp_file_cols consumo_annuo
lappend coimaimp_file_cols n_generatori
lappend coimaimp_file_cols stato_conformita
lappend coimaimp_file_cols cod_cted
lappend coimaimp_file_cols tariffa
lappend coimaimp_file_cols cod_responsabile
lappend coimaimp_file_cols flag_resp
lappend coimaimp_file_cols cod_intestatario
lappend coimaimp_file_cols cod_proprietario
lappend coimaimp_file_cols cod_occupante
lappend coimaimp_file_cols cod_amministratore
lappend coimaimp_file_cols cod_manutentore
lappend coimaimp_file_cols localita
lappend coimaimp_file_cols cod_via
lappend coimaimp_file_cols toponimo
lappend coimaimp_file_cols indirizzo
lappend coimaimp_file_cols numero
lappend coimaimp_file_cols esponente
lappend coimaimp_file_cols scala
lappend coimaimp_file_cols piano
lappend coimaimp_file_cols interno
lappend coimaimp_file_cols cod_comune
lappend coimaimp_file_cols provincia
lappend coimaimp_file_cols cap
lappend coimaimp_file_cols cod_tpdu
lappend coimaimp_file_cols cod_qua
lappend coimaimp_file_cols cod_urb
lappend coimaimp_file_cols data_ins
lappend coimaimp_file_cols data_mod
lappend coimaimp_file_cols utente
lappend coimaimp_file_cols flag_dpr412
lappend coimaimp_file_cols anno_costruzione
lappend coimaimp_file_cols marc_effic_energ
lappend coimaimp_file_cols volimetria_risc
lappend coimaimp_file_cols gb_x
lappend coimaimp_file_cols gb_y

#Setto la vbariabile comb_index contenente la posizione occupata dal codice combustibile all'interno della lista
set comb_index 2
set cod_via_index 29
set toponimo_index 30

#Inizio la lettura del file degli impianti
#Una volta apportate le modifiche necessarie, i dati corretti vengono scritti nel file di output

iter_get_csv $coimaimp_file coimaimp_file_cols_list |

while {![eof $coimaimp_file]} {

    set ind 0
    foreach column_name $coimaimp_file_cols {
	set $column_name [lindex $coimaimp_file_cols_list $ind]
	incr ind
    }

    if {[info exists comb_bonifica($cod_combustibile)]} {
	set coimaimp_file_cols_list [lreplace $coimaimp_file_cols_list $comb_index $comb_index $comb_bonifica($cod_combustibile)] 
    }
    if {[info exists topo_bonifica($toponimo)]} {
	set coimaimp_file_cols_list [lreplace $coimaimp_file_cols_list $toponimo_index $toponimo_index $topo_bonifica($toponimo)]
    }
    if {[info exists viae_bonifica($cod_via)]} {
	set coimaimp_file_cols_list [lreplace $coimaimp_file_cols_list $cod_via_index $cod_via_index $viae_bonifica($cod_via)]
    }

    iter_put_csv $coimaimp_output coimaimp_file_cols_list |

    iter_get_csv $coimaimp_file coimaimp_file_cols_list |
}

# Setto a null le variabili utilizzate
set count_aimp ""
set cod_impianto_est ""
set cod_combustibile ""
set provenienza_dati ""
set tipo_impianto ""
set potenza ""
set potenza_utile ""
set cod_potenza ""
set data_installaz ""
set data_attivaz ""
set data_rottamaz ""
set note ""
set stato ""
set flag_dichiarato ""
set data_prima_dich ""
set data_ultim_dich ""
set consumo_annuo ""
set n_generatori ""
set stato_conformita ""
set cod_cted ""
set tariffa ""
set cod_responsabile ""
set flag_resp ""
set cod_intestatario ""
set cod_proprietario ""
set cod_occupante ""
set cod_amministratore ""
set cod_manutentore ""
set localita ""
set cod_via ""
set toponimo ""
set indirizzo ""
set numero ""
set esponente ""
set scala ""
set piano ""
set interno ""
set cod_comune ""
set provincia ""
set cap ""
set cod_tpdu ""
set cod_qua ""
set cod_urb ""
set data_ins ""
set data_mod ""
set utente ""
set flag_dpr412 ""
set anno_costruzione ""
set marc_effic_energ ""
set volimetria_risc ""
set gb_x ""
set gb_y ""

#Setto la lista per la lettura del file dei generatori
set coimgend_file_cols ""

lappend coimgend_file_cols cod_aimp
lappend coimgend_file_cols gen_prog
lappend coimgend_file_cols gen_prog_est
lappend coimgend_file_cols descrizione
lappend coimgend_file_cols flag_attivo
lappend coimgend_file_cols matricola
lappend coimgend_file_cols modello
lappend coimgend_file_cols cod_costruttore
lappend coimgend_file_cols matricola_bruc
lappend coimgend_file_cols modello_bruc
lappend coimgend_file_cols cod_costruttore_bruc
lappend coimgend_file_cols tipo_foco
lappend coimgend_file_cols mod_funz
lappend coimgend_file_cols cod_utgi
lappend coimgend_file_cols tipo_bruciatore
lappend coimgend_file_cols tiraggio
lappend coimgend_file_cols locale
lappend coimgend_file_cols cod_emissione
lappend coimgend_file_cols cod_combustibile
lappend coimgend_file_cols data_installaz_gend
lappend coimgend_file_cols pot_focolare_lib
lappend coimgend_file_cols pot_utile_lib
lappend coimgend_file_cols pot_focolare_nom
lappend coimgend_file_cols pot_utile_nom
lappend coimgend_file_cols note

#Setto la vbariabile comb_index contenente la posizione occupata dal codice combustibile all'interno della lista
set comb_index 17


#Inizio la lettura del file degli impianti
#Una volta apportate le modifiche necessarie, i dati corretti vengono scritti nel file di output

iter_get_csv $coimgend_file coimgend_file_cols_list |

while {![eof $coimgend_file]} {

    set ind 0
    foreach column_name $coimgend_file_cols {
	set $column_name [lindex $coimgend_file_cols_list $ind]
	incr ind
    }
    if {[info exists comb_bonifica($cod_combustibile)]} {
	set coimgend_file_cols_list [lreplace $coimgend_file_cols_list $comb_index $comb_index $comb_bonifica($cod_combustibile)] 
    }

    iter_put_csv $coimgend_output coimgend_file_cols_list |

    iter_get_csv $coimgend_file coimgend_file_cols_list |
}

#Setto a null le variabili utilizzate
set cod_aimp ""
set gen_prog ""
set gen_prog ""
set descrizione ""
set flag_attivo ""
set matricola ""
set modello ""
set cod_costruttore ""
set matricola_bruc ""
set modello_bruc ""
set cod_costruttore_bruc ""
set tipo_foco ""
set mod_funz ""
set cod_utgi ""
set tipo_bruciatore ""
set tiraggio ""
set locale ""
set cod_emissione ""
set cod_combustibile ""
set data_installaz_gend ""
set pot_focolare_lib ""
set pot_utile_lib ""
set pot_focolare_nom ""
set pot_utile_nom ""
set note ""

#Setto le variabili per la lettura del file dei cittadini
set coimcitt_file_cols ""

lappend coimcitt_file_cols cod_cittadino
lappend coimcitt_file_cols natura_giuridica
lappend coimcitt_file_cols cognome
lappend coimcitt_file_cols nome
lappend coimcitt_file_cols indirizzo
lappend coimcitt_file_cols numero
lappend coimcitt_file_cols cap
lappend coimcitt_file_cols localita
lappend coimcitt_file_cols comune
lappend coimcitt_file_cols provincia
lappend coimcitt_file_cols cod_fiscale
lappend coimcitt_file_cols telefono

#Setto la variabile indirizzo_index contenente la posizione occupata dall'indirizzo all'interno della lista
set indirizzo_index 4

#Inizio la lettura del file degli impianti
#Una volta apportate le modifiche necessarie, i dati corretti vengono scritti nel file di output
iter_get_csv $coimcitt_file coimcitt_file_cols_list | 

while {![eof $coimcitt_file]} {

    set ind 0    
    foreach column_name $coimcitt_file_cols {
	set $column_name [lindex $coimcitt_file_cols_list $ind]
	incr ind
    }
    
    if {[info exist viae_citt($indirizzo)]} {
	set coimcitt_file_cols_list [lreplace $coimcitt_file_cols_list $indirizzo_index $indirizzo_index $viae_citt($indirizzo)]
    }
    iter_put_csv $coimcitt_output coimcitt_file_cols_list |

    iter_get_csv $coimcitt_file coimcitt_file_cols_list | 
}

#Setto le variabili utilizzate a null
set cod_cittadino ""
set natura_giuridica ""
set cognome ""
set nome ""
set indirizzo ""
set numero ""
set cap ""
set localita ""
set comune ""
set provincia ""
set cod_fiscale ""
set telefono ""

#Scrivo il nuovo file dei combustibili
foreach {coimcomb_file_cols_list coimcomb_value} [array get comb_new] {
    iter_put_csv $coimcomb_output coimcomb_file_cols_list |
}
#Scrivo il nuovo file dei toponimi
foreach {coimtopo_file_cols_list coimtopo_value} [array get topo_new] {
    iter_put_csv $coimtopo_output coimtopo_file_cols_list |
}

# chiudo i file aperti
close $coimaimp_file
close $coimcomb_file
close $coimgend_file
close $coimtopo_file
close $coimviae_file
close $coimcitt_file
close $coimaimp_output
close $coimcomb_output
close $coimgend_output
close $coimviae_output
close $coimcitt_output

#Rinomino i file *_bnf al nome standard dei file di output
exec cp $dir/$dat_dir/coimcomb_bnf.dat $dir/$dat_dir/coimcomb.dat
exec cp $dir/$dat_dir/coimaimp_bnf.dat $dir/$dat_dir/coimaimp.dat
exec cp $dir/$dat_dir/coimgend_bnf.dat $dir/$dat_dir/coimgend.dat
exec cp $dir/$dat_dir/coimtopo_bnf.dat $dir/$dat_dir/coimtopo.dat
exec cp $dir/$dat_dir/coimviae_bnf.dat $dir/$dat_dir/coimviae.dat
exec cp $dir/$dat_dir/coimcitt_bnf.dat $dir/$dat_dir/coimcitt.dat

#Cancello i file *_bnf
exec rm $dir/$dat_dir/coimcomb_bnf.dat 
exec rm $dir/$dat_dir/coimaimp_bnf.dat
exec rm $dir/$dat_dir/coimgend_bnf.dat
exec rm $dir/$dat_dir/coimtopo_bnf.dat
exec rm $dir/$dat_dir/coimviae_bnf.dat
exec rm $dir/$dat_dir/coimcitt_bnf.dat

#Fine delle operazioni
ns_return 200 text/html "FINE"; return

ad_return_template
