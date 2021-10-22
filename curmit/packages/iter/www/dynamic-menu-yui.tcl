# Sorgente scritto da Nicola Mortoni il 19/05/2014

#
### frammento richiamato via source da dynamic-menu.tcl
#

# id_utente è già stato valorizzato da dynamic-menu.tcl

append menu "
<div id=\"productsandservices\" class=\"yuimenubar yuimenubarnav\">
<div class=\"bd\">
<ul class=\"first-of-type\">"

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
        <li class=\"yuimenubaritem\">
            <a class=\"yuimenubaritemlabel\" href=\"#$id_riga_di_menu\">$descrizione</a>
            <div id=\"$id_riga_di_menu\" class=\"yuimenu\"><div class=\"bd\">
	    <h6>$descrizione</h6>
            <ul>"

	# Ora leggo le righe del secondo livello di menù relative alla riga del primo livello di menù
	incr livello
	set  where_scelte_a "and a.scelta_1 = :scelta_1"
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
                <li class=\"yuimenuitem\">
                    <a class=\"yuimenuitemlabel\" href=\"$link\" title=\"$descrizione\">$descrizione</a>
                </li>"

	    }

	    if {$tipo eq "menu"} {
		append menu "
                <li class=\"yuimenuitem\">
                    <a class=\"yuimenuitemlabel\" href=\"#$id_riga_di_menu\">$descrizione</a>
                    <div id=\"$id_riga_di_menu\" class=\"yuimenu\"><div class=\"bd\">
	            <h6>$descrizione</h6>
                    <ul>"

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
                        <li class=\"yuimenuitem\">
                           <a class=\"yuimenuitemlabel\" href=\"$link\" title=\"$descrizione\">$descrizione</a>
                        </li>"
		    }

		    if {$tipo eq "menu"} {
			append menu "
                        <li class=\"yuimenuitem\">
                            <a class=\"yuimenuitemlabel\" href=\"#$id_riga_di_menu\">$descrizione</a>
                            <div id=\"$id_riga_di_menu\" class=\"yuimenu\"><div class=\"bd\">
	                    <h6>$descrizione</h6>
                            <ul>"

			# Le tabelle coimogge e coimmenu prevedono 4 livelli.
			# Per ora ne ho gestiti solo 3 perchè non è mai capitato di usare
			# anche il quarto livello.

			append menu "
                        </ul></div></div></li>";#fine tag del menù di livello 3
		    }
		}

		append menu "
                </ul></div></div></li>";#fine tag del menù di livello 2

	    }
	}
	append menu "
                </ul></div></div></li>";#fine tag del menù di livello 1
    }
}

append menu "
</ul></div></div>";#fine tag del div productsandservices


# Se servirà, farò comparire una funzione solo se l'utente è veramente autorizzato ad eseguirla (sfrutterò il cuore dell'iter_check_login).

