ad_page_contract {@author dob}      
set range_value ""
set potenza_utile_nom "10,10"
set colonna [set "potenza_utile_nom"]
set dimension "9,2"
set int_dec [split $dimension \,]
util_unlist $int_dec intero decimale

#set pippo [iter_edit_num $colonna $decimale]
#ns_return 200 text/html "$colonna $intero $decimale $pippo"
#return

if {[iter_edit_num $colonna $decimale] != "Error"} {
    
    set element_int_dec [split $colonna \.]
    util_unlist $element_int_dec parte_intera parte_decimale
    set max_value [expr pow(10,[expr $intero - $decimale]) - 1]
    
    if {($parte_intera > [expr $max_value - 1]) || ($parte_intera < [expr (-1 * $max_value) +1])} {
	set desc_errore "Il campo deve essere numerico di [expr $intero-$decimale] cifre"
	ns_return 200 text/html "$desc_errore"
	return
    } else {
	
	if {![string equal $range_value ""]} {
	    set range_list [split $range_value \,]
	    set num_range [llength $range_list]
	    
	    set x 0
	    set ok_range 0
	    while {$x < $num_range} {
		if {$colonna == [lindex $range_list $x]} {
		    incr ok_range
		}
		incr x
	    }
	    if {$ok_range == 0} {
		set desc_errore "Il campo deve assumere uno dei seguenti valori: '$range_value'"
		ns_return 200 text/html "$desc_errore"
		return
	    }			
	}
    }			    		     
    set max_value [expr pow(10,$decimale)]
    if {($parte_decimale > [expr $max_value - 1])} {
	set desc_errore "Il campo deve avere $decimale cifre decimali"
	ns_return 200 text/html "$desc_errore"
	return
    } else {			
	if {![string equal $range_value ""]} {
	    set range_list [split $range_value \,]
	    set num_range [llength $range_list]
	    
	    set x 0
	    set ok_range 0
	    while {$x < $num_range} {
		if {$colonna == [lindex $range_list $x]} {
		    incr ok_range
		}
		incr x
	    }
	    if {$ok_range == 0} {
		set desc_errore "Il campo deve assumere uno dei seguenti valori: '$range_value'"
		ns_return 200 text/html "$desc_errore"
		return
	    }   
	}	
    }
    
} else {
    set desc_errore "Il campo deve essere un numero (per i decimali usare il separatore . )"
    ns_return 200 text/html "$desc_errore *"
    return
}

ns_return 200 text/html "$potenza_utile_nom corretta"
return

