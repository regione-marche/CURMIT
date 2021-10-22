ad_proc iter_creacf {
    xcognome
    xnome
    xsesso
    xdnas
    xcodfis
    {xcontrolla 0}
} {
    procedura per il calcolo del Codice Fiscale; se xcontrolla= 1 visualizza errori
} {

    set var_temp  [iter_convoc $xcognome]

    set xcfisc [string range [lindex $var_temp 0] 0 2]
    append xcfisc [string range [lindex $var_temp 1] 0 2]
    append xcfisc XXX
    set xcfisc [string range $xcfisc 0 2]

    set var_temp  [iter_convoc $xnome]

    set xcon [lindex $var_temp 0]
    set xvoc [lindex $var_temp 1]
    
    if {[string length $xcon] > 3} {
	append xcfisc [string index $xcon 0]
	append xcfisc [string range $xcon 2 3]
    } else {
	append xcfisc [string range $xcon 0 2]
	append xcfisc [string range $xvoc 0 2]
	append xcfisc XXX
    }
    
    # considero solo i primi sei caratteri
    set xcfisc [string range $xcfisc 0 5]

    #aggiungo ultime due cifre anno di nascita
    append xcfisc [string range $xdnas 2 3]

    #aggiungola lettera in tabella corrispondente al mese
    set mm [string range $xdnas 4 5]

    switch $mm {
       "01" {set mese "A"}
       "02" {set mese "B"}
       "03" {set mese "C"}
       "04" {set mese "D"}
       "05" {set mese "E"}
       "06" {set mese "H"}
       "07" {set mese "L"}
       "08" {set mese "M"}
       "09" {set mese "P"}
       "10" {set mese "R"}
       "11" {set mese "S"}
       "12" {set mese "T"}
	default {set mese "A"}
    }
    
   append xcfisc $mese 

    #aggiungo il giorno di nascita
    set dd [string range $xdnas 6 7]

    if {$xsesso == "M"} {
	append xcfisc $dd
    } else {
	set dd [expr [iter_set_double $dd] + 40]
	set dd [iter_edit_num $dd 0]
	append xcfisc $dd
    }

    # aggiungo codice belfiore
    append xcfisc $xcodfis

    #aggiungo il carattere di controllo
    append xcfisc [iter_calcolo_car_cf $xcfisc]

    return $xcfisc

}

proc_doc iter_convoc {dirty_string} {restituisce un lista contenente nel primo elemento tutte le consonanti e nel secondo le vocali; converte tutti i caratteri in maiuscolo, elimina i caratteri non alfabetici e converte gli accentati nella rispettiva lettera base.} {
    # converto tutto in maiuscolo e tolgo gli spazi in testa e in coda
    set dirty_string [string toupper [string trim $dirty_string]]
    
    set xcon ""
    set xvoc ""

    # conversione dei caratteri accentati o particolari (set caratteri esteso)
    regsub -all à $dirty_string A dirty_string
    regsub -all è|É $dirty_string E dirty_string
    regsub -all ì $dirty_string I dirty_string
    regsub -all ò $dirty_string O dirty_string
    regsub -all ù $dirty_string U dirty_string
    regsub -all Ç $dirty_string C dirty_string

    #rimozione di tutti i caratteri non alfabetici
    set i 0
    while {$i < [string length $dirty_string]} {
	if {[regexp {[A-Z]} [string index $dirty_string $i] car_extr] == 1} {
	    if {[regexp {[AEIOU]} $car_extr] == 1} {
		append xvoc $car_extr
	    } else {
		append xcon $car_extr
	    }
	    
	} 
        incr i
    } 
    set xchiav [list $xcon $xvoc]
    return $xchiav
}

proc_doc iter_calcolo_car_cf {x15cf} {procedura calcolo carattere di controllo} {
    set pari(A) 0
    set pari(B) 1
    set pari(C) 2
    set pari(D) 3
    set pari(E) 4
    set pari(F) 5
    set pari(G) 6
    set pari(H) 7
    set pari(I) 8
    set pari(J) 9
    set pari(0) 0
    set pari(1) 1
    set pari(2) 2
    set pari(3) 3
    set pari(4) 4
    set pari(5) 5
    set pari(6) 6
    set pari(7) 7
    set pari(8) 8
    set pari(9) 9
    set pari(K) 10
    set pari(L) 11
    set pari(M) 12
    set pari(N) 13
    set pari(O) 14
    set pari(P) 15
    set pari(Q) 16
    set pari(R) 17
    set pari(S) 18
    set pari(T) 19
    set pari(U) 20
    set pari(V) 21
    set pari(W) 22
    set pari(X) 23
    set pari(Y) 24
    set pari(Z) 25

    set dispari(A) 1
    set dispari(B) 0
    set dispari(C) 5
    set dispari(D) 7
    set dispari(E) 9
    set dispari(F) 13
    set dispari(G) 15
    set dispari(H) 17
    set dispari(I) 19
    set dispari(J) 21
    set dispari(0) 1
    set dispari(1) 0
    set dispari(2) 5
    set dispari(3) 7
    set dispari(4) 9
    set dispari(5) 13
    set dispari(6) 15
    set dispari(7) 17
    set dispari(8) 19
    set dispari(9) 21
    set dispari(K) 2
    set dispari(L) 4
    set dispari(M) 18
    set dispari(N) 20
    set dispari(O) 11
    set dispari(P) 3
    set dispari(Q) 6
    set dispari(R) 8
    set dispari(S) 12
    set dispari(T) 14
    set dispari(U) 16
    set dispari(V) 10
    set dispari(W) 22
    set dispari(X) 25
    set dispari(Y) 24
    set dispari(Z) 23


    set control(0) A
    set control(1) B
    set control(2) C
    set control(3) D
    set control(4) E
    set control(5) F
    set control(6) G
    set control(7) H
    set control(8) I
    set control(9) J
    set control(10) K
    set control(11) L
    set control(12) M
    set control(13) N
    set control(14) O
    set control(15) P
    set control(16) Q
    set control(17) R
    set control(18) S
    set control(19) T
    set control(20) U
    set control(21) V
    set control(22) W
    set control(23) X
    set control(24) Y
    set control(25) Z

    set xsum 0
    set i 0
    #pari = 0 -> dispari    
    set flag_pari 0   

    while {$i < 15} {

	set xc [string index $x15cf $i]

	if {$flag_pari == 0} {
	    set xsum [expr $dispari($xc) + $xsum ]
	    set flag_pari 1
	} else {
	    set xsum [expr $pari($xc) + $xsum ]
	    set flag_pari 0
	}
	incr i

    }

    #scorro la lista di controllo per assegnare il carattere di controllo
    set cc [expr int(fmod($xsum,26))]
    set ccontrol $control($cc)

    return $ccontrol
}

ad_proc iter_set_double {number} {
    Tcl non fa bene i calcoli se un numero non contiene il . dei decimali.
    (si fuma tutti i decimali).
    Tcl non fa bene i confronti (if) se un numero non contiene il . dei 
    decimali e supera il valore dell'integer: supera le 9 cifre intere.
    Superata questa soglia considera la variabile come stringa.
} {
    set number [string trimleft $number 0]
    set ctr [string first {.} $number]
    if {$ctr < 0} {
        append number .0
        set ctr [expr [string length $number] - 2]
    }
    if {$ctr == 0} {
        set    out_number 0
        append out_number $number
    } else {
        set out_number $number
    }
    return $out_number
}


