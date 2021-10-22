# Sorgente scritto da Nicola Mortoni il 19/05/2014

#
### frammento richiamato via source da dynamic-menu.tcl
#

# id_utente è già stato valorizzato da dynamic-menu.tcl

append menu "
<center>
<table cellpadding=\"3\" cellspacing=\"3\" border=\"1\" style=\"border-collapse: collapse;\">
<tbody class=\"head1\">
<tr>"

if {![db_0or1row query "select b.nome_menu
                          from coimuten a
                             , coimprof b
                         where a.id_utente = :id_utente
                           and b.settore   = a.id_settore
                           and b.ruolo     = a.id_ruolo"]
} {
   set nome_menu ""
}
set livello        1
set where_scelte_a ""

# non faccio la db_foreach al primo livello per evitare di creare un quarto pool di connessioni
set lista_righe_di_menu_di_primo_livello [db_list_of_lists sel_menu_join_ogge ""]

foreach riga $lista_righe_di_menu_di_primo_livello {
    util_unlist $riga scelta_1 scelta_2 scelta_3 a.scelta_4 livello descrizione tipo nome_funz id_riga_di_menu

    # Il primo livello può prevedere solo righe di tipo "menu"
    if {$tipo eq "menu"}  {
	append menu "
        <td class=\"radius1\" width=\"10%\" valign=top>
            <table width=\"100%\" cellpadding=3 cellspacing=3><!-- tbody class=\"head1\" -->
               <tr class=titoli_menu_html><td align=left class=\"c5\"><b>$descrizione</b></td></tr>"

        # Ora leggo le righe del secondo livello di menù relative alla riga del primo livello di menù
        incr livello
        set  where_scelte_a "and a.scelta_1 = :scelta_1"

	set sw_prima_riga_del_menu_di_primo_livello "t"
        db_foreach sel_menu_join_ogge "" {
            if {$tipo eq "funzione"
	    &&  [db_0or1row sel_funz ""] == 1
            } {
                set link "$azione$dett_funz?nome_funz=$nome_funz"
                if {![string equal $parametri ""]} {
                    set list_par [split $parametri "\&"]
                    foreach coppia $list_par {
                        set list_elem [split $coppia "="]
                        set key [lindex $list_elem 0]
                        set val [lindex $list_elem 1]
                        append link "&$key=[ns_urlencode $val]"
                    }
                }

		append menu "
                <tr><td align=left><a href=\"$link\" class=main>$descrizione</a></td></tr>"

		if {$sw_prima_riga_del_menu_di_primo_livello eq "t"} {
		    set sw_prima_riga_del_menu_di_primo_livello "f"
		}
	    }


	    if {$tipo eq "menu"} {
		if {$sw_prima_riga_del_menu_di_primo_livello eq "t"} {
		    set sw_prima_riga_del_menu_di_primo_livello "f"
		} else {
		    set descrizione "<br>$descrizione"
		}

		append menu "
                <tr><td align=left class=\"c7\"><b>$descrizione</b></td></tr>"

		# Ora leggo le righe del terzo livello di menù relative alla riga del secondo livello di menù
		incr livello
		set  where_scelte_a "and a.scelta_1 = :scelta_1
                                     and a.scelta_2 = :scelta_2"
		db_foreach sel_menu_join_ogge "" {
		    if {$tipo eq "funzione"
		    &&  [db_0or1row sel_funz ""] == 1
		    } {
                        set link "$azione$dett_funz?nome_funz=$nome_funz"
			if {![string equal $parametri ""]} {
			    set list_par [split $parametri "\&"]
			    foreach coppia $list_par {
				set list_elem [split $coppia "="]
				set key [lindex $list_elem 0]
				set val [lindex $list_elem 1]
				append link "&$key=[ns_urlencode $val]"
			    }
			}

			append menu "
                        <tr><td align=left><a class=main href=\"$link\">$descrizione</a></td></tr>"
		    }

                    if {$tipo eq "menu"} {
                        append menu "
                        <tr><td align=left class=\"c7\"><br>$descrizione</b></td></tr>"

                        # Le tabelle coimogge e coimmenu prevedono 4 livelli.
                        # Per ora ne ho gestiti solo 3 perchè non è mai capitato di usare
                        # anche il quarto livello.

                        #fine del menù di livello 3
                    }
                }

                #fine tag del menù di livello 2

	    }
	}
	append menu "
        </table>
        </td>";#fine tag del menù di livello 1
    }
}


append menu "
</tr>
</table>
</center>"

