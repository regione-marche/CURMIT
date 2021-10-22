ad_library {
    Provides various functions for the package.

    @author Nicola Mortoni
    @cvs-id iter-utility-procs.tcl

}

namespace eval iter {}

ad_proc -public iter::verifyfc  {
     -xcodfis
    {-xcontrolla "0"}
} { 
    Verify last char of fiscal code
} {

    set exception_count 0
    set exception_text ""
    set xcodfis [string toupper $xcodfis]
    
    if {[string length $xcodfis] != 16} {
	incr exception_count
	append exception_text "<li> Lunghezza del Codice Fiscale Errata"
    } else {
	set x15cf [string range $xcodfis 0 14]
	set car_contr [iter::calc_char_cf -x15cf $x15cf]
	if {$car_contr != [string range $xcodfis 15 15]} {
	    incr exception_count
	    append exception_text "<li> Carattere di Controllo del Codice Fiscale Errato"
	}
    }
    
    if {$exception_count > 0 } {
	if {$xcontrolla == 1} {
	    #visualizzo il messaggio di errore
	    ad_return_complaint $exception_count $exception_text
	}
	return 0
    } else {
	return $xcodfis
    }
    
}

ad_proc -public iter::verifyvc  {
     -xcodfis
    {-xcontrolla "0"}
} { 
    Verify last char of VAT code
} {

    set exception_count 0
    set exception_text ""
    
    if {[string length $xcodfis] != 11 } {
	incr exception_count
	append exception_text "<li> Lunghezza della Partita IVA Errata"
    } else {
	if {[regexp {[^0-9]+} $xcodfis] > 0 } {
	    incr exception_count
	    append exception_text "<li> Partita IVA Errata. Ammessi solo numeri"
	} else {
	    set nl 1
	    set stringa ""
	    while {$nl < 11} {
		set char [string index $xcodfis $nl]
		set num [expr 2*$char]
		append stringa $num
		append stringa [string index $xcodfis [expr $nl - 1]]
		set nl [expr $nl + 2]
	    }
	    set num 0
	    set stringa [split $stringa {}]
	    foreach valore_lista $stringa {
		incr  num $valore_lista
	    }		
	    

	    set num [string index $num [expr [string length $num] - 1]]
	    if {$num == 0} {
		set char 0
	    } else {
		set char [expr 10 -$num]
	    }
	    set num [string range $xcodfis 7 9]
	    if {([string range $xcodfis 0 6] == 0000000) && ($num <= 95)} {
		set char 1
	    }
	    if {$char != [string index $xcodfis 10]} {
		incr exception_count
		append exception_text "<li> Partita IVA Errata"
	    }
	}
    }

    if {$exception_count > 0 } {
	if {$xcontrolla == 1} {
	    #visualizzo il messaggio di errore
	    ns_return 200 text/html "|$exception_count|$exception_text|";return
	    ad_return_complaint $exception_count $exception_text
	}
        return 0
    } else {
	return 1
    }
}
ad_proc -public iter::calc_char_cf  {
     -x15cf
} { 
    Calculate last charr of fiscal code
} {
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

