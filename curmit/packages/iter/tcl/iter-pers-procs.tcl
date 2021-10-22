ad_library {
    Provides various functions for the package.

    @author Nicola Mortoni
    @cvs-id iter-pers-procs.tcl

}

# definisco la proc che serve per calcolare la media
ad_proc iter_calc_media {
    num_decimali
    lista_valori
} {
    per ogni elemento, se e' null non lo considero,
    altrimenti lo considero per calcolare la media.
    arrotondo il risultato al num_decimali indicato
    do' per scontato che i numeri siano corretti.
} {
    set dividendo ""
    set divisore  0
    foreach valore $lista_valori {
	if {![string equal $valore ""]} {
	    append dividendo " + [iter_set_double $valore]"
	    incr divisore
	}
    }
    if {$divisore == 0} {
	set risultato ""
    } else {
	set risultato [expr ($dividendo) / $divisore]
	# ora arrotondo il risultato usando il db:
	set risultato [db_string sel_dual_round ""]
    }
    return $risultato
}

ad_proc iter_crea_pdf {
    comando_htmldoc
} {
    crea file PDF
} {
    with_catch error_msg {
        eval $comando_htmldoc
    } {
	ns_log Notice "iter_crea_pdf;error_msg:$error_msg"
#       ns_return 200 text/html "$error_msg-"; return
    }
}

ad_proc iter_separa_cog_nom {
    cognome
} {
    Accetta in input una stringa che puo' contenere sia cognome che nome.
    Restituisce in output una lista dove il primo elemento e' il cognome
    ed il secondo elemento e' il nome ed il terzo elemento e' un eventuale
    messaggio di errore.
} {
    set nome    ""
    set msg_err ""

  # pulisco i doppi o tripli ... spazi
    while {[regsub "  " $cognome " " cognome] > 0} {
	continue
    }

  # tolgo gli spazi a sinistra ed a destra
    set cognome [string trim $cognome]

  # mi accerto che il cognome sia sempre maiuscolo
    set cognome [string toupper $cognome]

  # aggiorno solo i cognomi con uno o due spazi
  # (gli altri sono complessi e per la maggior parte persone giuridiche)
    set ctr [regsub " " $cognome " " dummy]
    if {$ctr == 1
    ||  $ctr == 2
    } {
      # escludo i cognomi contenenti alcune parole che fanno capire
      # che non e' una persona fisica
	if {[string first "SNC"          $cognome] >= 0
	||  [string first "S.N.C."       $cognome] >= 0
	||  [string first "SPA"          $cognome] >= 0
	||  [string first "S.P.A."       $cognome] >= 0
	||  [string first "SRL"          $cognome] >= 0
	||  [string first "S.R.L."       $cognome] >= 0
	||  [string first "SAS"          $cognome] >= 0
	||  [string first "S.A.S."       $cognome] >= 0
	||  [string first "IMMOBILIARE"  $cognome] >= 0
	||  [string first "CONDOMINIO"   $cognome] == 0
	||  [string first "PARROCCHIA"   $cognome] >= 0
	||  [string first "SOLIDARIETA'" $cognome] >= 0
	||  [string first "COMUNE"       $cognome] >= 0
	||  [string first "CONSORZIO"    $cognome] >= 0
	||  [string first "CONVENTO"     $cognome] >= 0
	||  [string first "COOP"         $cognome] >= 0
	||  [string first "F.LLI"        $cognome] >= 0
	||  [string first "COOP"         $cognome] >= 0
	||  [string first "UNIVERSITA"   $cognome] >= 0
	||  [string first "SCUOLA"       $cognome] >= 0
	||  [string first "AGENZIA"      $cognome] >= 0
	} {
	  # non vanno modificati
	} else {
	    set pos_space  [string first " " $cognome]
	    set ws_cognome [string range $cognome 0 [expr $pos_space - 1]]
	    if {$ws_cognome == "DA"
	    ||  $ws_cognome == "DAL"
	    ||  $ws_cognome == "DALLA"
	    ||  $ws_cognome == "DE'"
	    ||  $ws_cognome == "DE"
	    ||  $ws_cognome == "DEL"
	    ||  $ws_cognome == "DELLA"
	    ||  $ws_cognome == "DI"
	    ||  $ws_cognome == "DEGLI"
	    ||  $ws_cognome == "LO"
	    ||  $ws_cognome == "LI"
	    ||  $ws_cognome == "LA"
	    } {
		set pos_space [string first " " $cognome [expr $pos_space + 1]]
	    }

	    if {$pos_space < 0} {
		set msg_err "Impossibile che non vi siano spazi nel cognome:$cognome"
	    } else {
		set cognome_old $cognome
		set cognome [string range $cognome_old 0 [expr $pos_space - 1]]
		set nome    [string range $cognome_old [expr $pos_space + 1] end]
	    }
	}
    }
    return [list $cognome $nome $msg_err]
}

ad_proc iter_separa_numciv_espciv {
    numero
} {
    Accetta in input una stringa che puo' contenere sia numero che esponente.
    Restituisce in output una lista dove il primo elemento e' il numero, 
    il secondo elemento e' l'esponente ed il terzo elemento e' un eventuale
    messaggio di errore.
} {
    set esponente ""
    set msg_err   ""

  # se numero non e' numerico, separo la parte numerica di sinistra mettendola
  # in numero e la restante parte mettendola nell'esponente.
    set numero [string trim     $numero]
    set numero [string trimleft $numero "0"]
    if {![string is digit $numero]} {
	set numero_old       $numero
	set numero           ""
	set esponente        ""
	set ind_num           0
	set lun_num          [string length $numero_old]
	set sw_iniz_num      "f"
	set sw_fine_num      "f"
	set sw_iniz_esp      "f"
	while {$ind_num < $lun_num} {
	    set ws_num [string range $numero_old $ind_num $ind_num]
	    if {$sw_iniz_num == "f"} {
		# salto tutti i caratteri strani all'inizio del numero
		if {[string is alnum $ws_num]} {
		    set sw_iniz_num "t"
		}
	    }
	    if {$sw_iniz_num == "t"} {
		if {$sw_fine_num == "f"} {
		    if {[string is digit $ws_num]} {
			append numero $ws_num
		    } else {
			set sw_fine_num "t"
		    }
		}
		if {$sw_fine_num == "t"} {
		    if {$sw_iniz_esp == "f"} {
			# salto tutti i caratteri strani all'inizio
			# dell'esponente
			if {[string is alnum $ws_num]} {
			    set sw_iniz_esp "t"
			}
		    }
		    if {$sw_iniz_esp == "t"} {
			append esponente $ws_num
		    }
		}
	    }

	    incr ind_num
	    set ws_num [string range $numero $ind_num $ind_num]
	}
	set esponente  [string trim $esponente]

	# nessun messaggio di errore contemplato
	set msg_err ""
    }

    return [list $numero $esponente $msg_err]
}

ad_proc iter_edit_flag_mh {
    flag_input
} {
    Decodifica il valore del flag del modello h:
    S = Si'; N = No; E = ES; C = N.C.
} {
    switch $flag_input {
	"S" {set flag_output "SI"}
	"N" {set flag_output "NO"}
	"E" {set flag_output "ES"}
	"C" {set flag_output "N.C."}
    default {set flag_output ""}
    }
    return $flag_output
}

ad_proc iter_edit_flag_mh6 {
    flag_input
} {
    Decodifica il valore del flag del modello h al punto 6:
    P = positivo; N = Negativo; A = non applicabile
} {
    switch $flag_input {
	"P" {set flag_output "Pos"}
	"N" {set flag_output "Neg"}
	"A" {set flag_output "N.A."}
    default {set flag_output ""}
    }
    return $flag_output
}

ad_proc iter_edit_flag_mh2 {
    flag_input
} {
    Decodifica il valore del flag del modello h :
    S = soddisfacente; N = Non soddisfacente
} {
    switch $flag_input {
	"S" {set flag_output "Soddisfacente"}
	"N" {set flag_output "Non soddisfacente"}
    default {set flag_output ""}
    }
    return $flag_output
}

ad_proc iter_edit_flag_mh3 {
    flag_input
} {
    Decodifica il valore del flag del modello h :
    S = Presente N = Assente
} {
    switch $flag_input {
	"S" {set flag_output "Presente"}
	"N" {set flag_output "Assente"}
    default {set flag_output ""}
    }
    return $flag_output
}

ad_proc iter_cpadova_head {
} {
    Restituisce la testata utilizzata nelle stampe, personalizzata
    per il comune di Padova
} {
    set logo_dir      [iter_set_logo_dir]

    set data_corrente [iter_edit_date [iter_set_sysdate]]
    set testata "
    <table width=100%>
      <tr>
        <td align=center width=20% rowspan=3>
          <img src=$logo_dir/cmpd-stp.gif width=\"10%\">
        </td>
        <td align=right  width=80% colspan=2>
          <big><b>RACCOMANDATA A.R.</b></big>
        </td>
      </tr>
      <tr>
        <td align=center width=60%>
          <big><big><big><b><i>Comune di Padova</i></b></big></big></big>
        </td>
        <td width=20%>&nbsp;</td>
      </tr>
      <tr>
        <td align=center><font size=\"-1\">Codice Fiscale 00644060287</font></td>
        <td>&nbsp;</td>
      </tr>
    </table>

    <table width=100%>
      <tr><td colspan=2>&nbsp;</td></tr>
      <tr>
        <td width=50% valign=top>&nbsp;</td>
        <td width=50% valign=top align=center>Padova, $data_corrente</td>
      </tr>
      <tr>
        <td colspan=2><b>SETTORE AMBIENTE</b>
      </tr>
    </table>"

    return $testata
}

ad_proc iter_cpadova_foot {
} {
    Restituisce il pie' di pagina utilizzata nelle stampe, personalizzata
    per il comune di Padova
} {
    set footer "
    <hr>
    <font face=\"times-roman\">
    <table cellspacing=0 cellpadding=0 width=100%>
      <tr>
        <td align=center>
          <b>Responsabile del Procedimento:</b> Dr. Ferro F. -
          <b>Sede</b> via F.Paolo Sarpi n. 2 - 35138 Padova
        </td>
      </tr>
      <tr>
        <td align=center>
          <b>Tel.</b> 8204712 - <b>Fax</b> 8204767
          <b>E-MAIL</b>: ferrof@comune.padova.it
        </td>
      </tr>
      <tr>
        <td align=center>
          <b>Per informazioni rivorgersi</b> all'Ufficio impianti termici
        </td>
      </tr>
      <tr>
        <td align=center>
          <b>Tel.</b> 8204812 - <b>Fax</b> 8204767 -
          <b>E-MAIL</b>: bovos@comune.padova.it
        </td>
      </tr>
      <tr>
        <td align=center>
           Orario di Ricevimento: Marted&igrave; e Gioved&igrave;
           dalle ore 10.00 alle ore 13.00.
        </td>
      </tr>
      <tr>
        <td align=center>
           Su appuntamento: Gioved&igrave; dalle 15.00 alle 17.00.
        </td>
      </tr>
    </table>
    </font>"

    return $footer
}

ad_proc iter_get_val_stringa {
    stringa
} {
    Data una stringa alfanumerica (esempio una matricola) restituisce una
    stringa dove sono stati eliminati gli zeri non significativi e le lettere
} {
    set lung_stringa [string length $stringa]
    set posiz 0
    set val_stringa ""
    set flag_zero "t"
    while {$posiz < $lung_stringa} {
	set carattere [string range $stringa $posiz $posiz]
	if {[string is integer $carattere]} {
	    if {$flag_zero == "t"} {
		if {$carattere != "0"} {
		    set flag_zero "f"
		    append val_stringa $carattere
		}
	    } else {
		append val_stringa $carattere
	    }
	}
	incr posiz
    }
    return $val_stringa
}

ad_proc iter_selbox_from_table_wherec {table_name table_key key_description {key_orderby ""} {where_condition ""}} {} {
    if {[string is space $key_orderby]} {
        set key_orderby   $key_description
    }

    set l_of_l [db_list_of_lists sel_lol_2 ""]
    set l_of_l [linsert $l_of_l 0 [list "" ""]]

    return $l_of_l
}

ad_proc iter_link_ins {
   -button:boolean
    form_name
    script_name
    what_list
    etichetta
   {lista_par ""}
} {
} {

# Da utilizzare nella pagina ADP del programma di gestione 

# Argomenti: 1. nome del form che contiene i campi di ricerca
#            2. nome dello script che propone la lista
#            3. lista parametri attesi da script_name alternata ai 
#               corrispondenti campi di form_name   

# genera un link al programma script_name, i cui url parameter vengono popolati
# dai campi del form in base alla lista what_list. Quest'ultima contiene una o
# piu' coppie di nomi, in cui il primo rappresenta il nome del parametro atteso
# da script_name e il secondo il nome del corrispondente campo di form. Il nome
# del campo di form puo' essere nullo ed in questo casi viene assunto uguale al
# nome del parametro.

    if {![string is space $lista_par]} {
        set extra_par "&[iter_set_url_vars $lista_par]"
    } else {
        set extra_par ""
    }

  # costruisco nomi campi di form riceventi
    foreach {p1 p2} $what_list {
	if {$p2 == ""} {
	    set p2 $p1
	}
	append receiving_element ${p2}|
    }
    set receiving_element [string trimright $receiving_element |]

    if {$button_p} {
        set tag_iniz {<input type=button value="$etichetta"}
        set tag_fine {</input>}
    } else {
        set tag_iniz {<a href="#"}
        set tag_fine "$etichetta</a>"
    }
    set link_to " $tag_iniz onclick=\"javascript:window.open('$script_name?caller=$form_name$extra_par&receiving_element=$receiving_element'" 

    foreach {p1 p2} $what_list {
	if {$p2 == ""} {
	    set p2 $p1
	}
	append link_to " + '&$p1=' + urlencode(document.$form_name.$p2.value)"
    }

    regsub -all -- {-} $script_name {} window_name
    regsub -all -- {/} $window_name {} window_name

    append link_to ", '$window_name', 'scrollbars=yes, resizable=yes, width=760, height=500').moveTo(12,1)\">$tag_fine"

    set urlencode "
    <script language=JavaScript>
    function urlencode(inString){
        inString=escape(inString);
        for(i=0;i<inString.length;i++){
             if(inString.charAt(i)=='+'){
                  inString=inString.substring(0,i) + \"%2B\" + inString.substring(i+1);
             }
        }
        return(inString);
    }
    </script>"

    append link_to $urlencode
    return $link_to
}

ad_proc iter_selected_2 {
    -insert:boolean
    form_name
    what_list
} {

} {

# genera una funzione JavaScript che popola i campi del form form_name
# in base alla lista what_list. Quest'ultima contiene una o
# piu' coppie di nomi, in cui il secondo rappresenta il nome della colonna 
# restituita dalla query e il primo il nome del corrispondente campo di form.
# Il nome della colonna della query puo' essere nullo ed in questo caso
# viene assunto uguale al nome del form.

    foreach {p1 p2} $what_list {
	if {$p2 == ""} {
	    set p2 $p1
	}
	# isolo le colonne della query in parms
	lappend parms $p2
	if {!$insert_p} {
	    append to_do "window.opener.document.$form_name.$p1.value = [iter_DoubleApos $p2] \n"
	} else {
	    append to_do "InsertText(window.opener.document.$form_name.$p1,$p2); \n"
	}
    }

    if {$insert_p} {
	set function "<!-- java script per inserire un valore all'interno di un campo --> \n
<script language=JavaScript> \n
  function InsertText(input, insTexte) {
    startTag = '';
    endTag   = '';
    if (input.createTextRange) {
      var text;
      input.focus(input.caretPos);
      input.caretPos = window.opener.document.selection.createRange().duplicate();
      input.caretPos.text = startTag + \" \" + insTexte + \" \" + endTag;
    } else {
      input.value += startTag + insTexte + endTag;
    }
  }
</script>"
    } else {
	set function ""
    }
    set parms [join $parms ,]
    append function "<!-- java script per selezione --> \n
<script language=JavaScript> \n"
    append function "$to_do window.opener.document.$form_name.submit();</script>
                     <script language=JavaScript> \n window.close(); \n</script>"

    return $function
}

ad_proc iter_get_coimuten {
   -utente_corrente:boolean
   {id_utente ""}
} {
   Valorizza nel programma chiamante l'array coimuten con tutte le colonne
   della tabella coimuten relative all'utente passato da parametro.
   Se viene richiamata con lo switch -utente_corrente, usa l'utente connesso.
} {
   if {$utente_corrente_p} {

       # reperisco l'utente dai Cookie
       # set id_utente [ad_get_cookie iter_login_[ns_conn location]]
       set id_utente [iter_get_id_utente]

#       set cookies [ns_set get [ns_conn headers] Cookie]
#       regexp {iter_login_([^=]+)=([^;]+)} $cookies match url id_utente


#       ||  ![info exists url]
#       ||  $url != [ns_conn location]

       if {[string equal $id_utente ""] } {
           return "Error"
       }
   }

   if {[db_0or1row sel_uten ""] == 0} {
       iter_return_complaint "
       Spiacente, utente non trovato su tabella utenti:$id_utente<br>
       proc iter_get_coimuten"
       return "Error"
   }

   uplevel [list set coimuten(id_utente)     $id_utente]
   uplevel [list set coimuten(cognome)       $cognome]
   uplevel [list set coimuten(nome)          $nome]
   uplevel [list set coimuten(password)      $password]
   uplevel [list set coimuten(id_settore)    $id_settore]
   uplevel [list set coimuten(id_ruolo)      $id_ruolo]
   uplevel [list set coimuten(lingua)        $lingua]
   uplevel [list set coimuten(e_mail)        $e_mail]
   uplevel [list set coimuten(rows_per_page) $rows_per_page]
   uplevel [list set coimuten(data)          $data]
   uplevel [list set coimuten(livello)       $livello]

   return "ok"
}
