ad_page_contract {
    @author          Giulio Laurenzi
    @creation-date   10/05/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coiminco-filter.tcl     
} {
   {f_cod_comune      ""}
   {f_data1           ""}
   {f_data2           ""}
   {f_campagna        ""}
   {caller       "index"}
   {funzione         "V"}
   {nome_funz         ""}
   {nome_funz_caller  ""}   
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
  # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

set link_filter [export_ns_set_vars url]

# imposto variabili usate nel programma:
set sysdate_edit  [iter_edit_date [iter_set_sysdate]]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {![string equal $f_campagna ""]} {
    set where_campagna "and a.cod_cinc = :f_campagna"
} else {
    set where_campagna ""
}

if {![string equal $f_cod_comune ""]} {
    set where_comune " where cod_comune = :f_cod_comune"
} else {
    set where_comune ""
}


if {[string equal $f_data1 ""]} {
    set f_data1 "18000101"
}
if {[string equal $f_data2 ""]} {
    set f_data2 "21001231"
}

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file        "Stampa riepilogo appuntamenti eff.-ris."
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set titolo       "Stampa riepilogo appuntamenti effettivi/in attesa"
set button_label "Stampa"
set page_title   "Stampa riepilogo appuntamenti effettivi/in attesa"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 
 
set root       [ns_info pageroot]
set stampa ""

iter_get_coimdesc
set ente              $coimdesc(nome_ente)
set ufficio           $coimdesc(tipo_ufficio)
set indirizzo_ufficio $coimdesc(indirizzo)
set telefono_ufficio  $coimdesc(telefono)
set assessorato       $coimdesc(assessorato)
# Titolo della stampa
set testata2 " <!-- FOOTER LEFT   \"$sysdate_edit\"-->
               <!-- FOOTER RIGHT  \"Pagina \$PAGE(1) di \$PAGES(1)\"-->
               <table width=100%>
               <tr><td width=100% align=center>
                    <table><tr>
                       <td align=center><b>$ente</b></td>
                    </tr><tr>
                       <td align=center>$ufficio</td>
                    </tr><tr>
                       <td align=center>$assessorato</td>
                    </tr><tr>
                       <td align=center><small>$indirizzo_ufficio</small></td>
                    </tr><tr><td align=center><small>$telefono_ufficio</small></td>
                    </tr></td></table></tr></table> 
"
set testata "<blockquote>"

append stampa "<p align=center><big>Riepilogo appuntamenti assegnati effettivi/in attesa</p></big>"

append stampa "</font>"
if {![string equal $f_cod_comune ""]
||  ![string equal $f_data1 ""]
||  ![string equal $f_data2 ""]
} {
    append stampa "<br>Selezione per"
    
    if {![string equal $f_campagna ""]} {
	db_1row get_campagna ""
	append stampa "<br>Campagna: $des_campagna"
    }
    if {![string equal $f_cod_comune ""]} {
        db_1row sel_comune ""
        append stampa "<br>Comune: $comune"
    }
    if {![string equal $f_data1 ""]
    ||  ![string equal $f_data2 ""]
    } {
	db_1row edit_date_dual ""
	
        append stampa "<br>Data appuntamento compresa tra $data1e e $data2e"
    }
    append stampa "<br><br>"
}
# Costruisco descrittivi tabella
append stampa "<table border=1 >"

set inizio "S"
set conta 0

append stampa "
	  <tr>
          <th align=left>Comune</th>
          <th align=left>Controlli previsti effettivi</th>
          <th align=left>Controlli previsti in attesa</th>
          </tr>
	  "

set data $f_data1
set yyyy [string range $data 0 3]
set mm [string range $data 4 5]
set gg [string range $data 6 7]
set data_pretty "$gg/$mm/$yyyy"

while {$data <= $f_data2} {
    set data_st "
	       <tr>
	       <td align=left colspan=3><b>Data: $data_pretty</b></td>
               </tr>"
    
    set conteggi_st ""
    
    db_foreach sel_comune "" {

	db_1row sel_effettivi ""
	db_1row sel_riserve ""
	if {$conta_effettivi == 0 && $conta_riserve == 0} {
	    append conteggi_st ""
	} else {
		append conteggi_st "
	       <tr>
	       <td align=left>$comune</td>
               <td align=left>$conta_effettivi</td>
               <td align=left>$conta_riserve</td>
               </tr>
	       "
	}
    }
    
    if {$conteggi_st != ""} {
	append stampa $data_st
	append stampa $conteggi_st
    }

    switch $mm {
	"01" {set giorni 31
	}
	"02" {set giorni 29
	    set data_check "$yyyy$mm$giorni"
	    if {[iter_check_date $data_check] == 0} {
		set giorni 28
	    }
	}
	"03" {set giorni 31
	}
	"04" {set giorni 30
	}
	"05" {set giorni 31
	}
	"06" {set giorni 30
	}
	"07" {set giorni 31
	}
	"08" {set giorni 31
	}
	"09" {set giorni 30
	}
	"10" {set giorni 31
	}
	"11" {set giorni 30
	}
	"12" {set giorni 31
	}  
    }

    if {$gg == $giorni} {
	if {$mm == "12"} {
	    set gg "01"
	    set mm "01"
	    set yyyy [expr $yyyy + 1]
	} else {
	    set gg "01"
	    if {[string range $mm 0 0] == "0"} {
		set mm [string range $mm 1 1]
	    }
	    set mm [expr $mm + 1]
	    if {[string length $mm] == 1} {
		set mm "0$mm"
	    }
	}
    } else {
	if {[string range $gg 0 0] == "0"} {
	    set gg [string range $gg 1 1]
	}
	set gg [expr $gg + 1]
	if {[string length $gg] == 1} {
	    set gg "0$gg"
	}
    }
    set data "$yyyy$mm$gg"
    set data_pretty "$gg/$mm/$yyyy"
}



append stampa "</table>"

set stampa1 $testata
append stampa1 $stampa

set stampa2 $testata2
append stampa2 "<small>"
append stampa2 $stampa
append stampa2 "</small>"

# creo file temporaneo html

set   file_id  [open $file_html w]
fconfigure $file_id -encoding iso8859-1
puts  $file_id $stampa2
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer D / --quiet --landscape --bodyfont arial --left 1cm --right 1cm --top 0cm --bottom  0cm -f $file_pdf $file_html]

ns_unlink $file_html
#ad_returnredirect $file_pdf_url
#ad_script_abort
ad_return_template
