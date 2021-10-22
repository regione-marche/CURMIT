ad_page_contract {
    Pagina di accesso agli enti della Regione Lombardia.
    
    @author Nicola Mortoni, Gianni Prosperi
    @date   26/10/2006

    @cvs_id accesso-enti-list.tcl
} {
    {nome_funz "accesso-enti-list"}
}
set logo_url [iter_set_logo_dir_url]

if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
}

set titolo     "Men&ugrave; principale"
set page_title $titolo
set main_directory [ad_conn package_url]
set context_bar [iter_context_bar [list ${main_directory}main "Home"] "$titolo"]


# @max_line@ è il numero massimo di enti visualizzati per riga
set max_line 5
# @ente_width@ rappresenta la larghezza delle celle della tabella con l'elenco degli enti
# e viene calcolato in base al numero di enti per riga
set ente_width [expr 100 / $max_line]

# leggo nome e cognome dell'utente
if {![db_0or1row sel_user ""]} {
    iter_return_complaint  "Codice utente non valido." 
    return
} 

set url_nome_funz [export_url_vars nome_funz]



# creo la tabella degli enti regionali in base ai dati estratti dalla tabella coimereg
# la stringa table_enti_reg memorizzerà il codice per la creazione sul template della tabella
# contenente i collegamenti verso gli enti regionali.
set table_enti_reg ""
set line_counter 0

append table_enti_reg "<tr>\n"
db_foreach sel_ente_reg "" {
    if {$logo_ente eq ""} {
	set logo_ente "vesta.jpg"
    }

    if {$line_counter < $max_line} {
	append table_enti_reg "<td width=\"$ente_width%\"  valign =\"middle\">\n"

	append table_enti_reg "<table width=\"100%\" border=\"0\" cellpaddin=\"0\" cellspacing=\"0\" align=\"center\"><tr><td height=\"100%\">\n"
 	append table_enti_reg "<img src=\"$logo_url/$logo_ente\" hspace=\"8\" vspace=\"4\" alt=\"Logo\">\n"
	append table_enti_reg "</td>\n"
	append table_enti_reg "<td height=\"100%\" valign=\"middle\">\n"

 	if {$url_ente ne ""} {
 	    append table_enti_reg "<a href=\"accesso-enti-gest?sito=$url_ente&$url_nome_funz\"><strong>$denominazione_ente</strong></a>\n"
 	} else {
 	    append table_enti_reg "<strong>$denominazione_ente</strong>\n"
 	}
	append table_enti_reg "</td></tr></table>\n"

	
	append table_enti_reg "</td>\n"
	incr line_counter

    } else {

 	set line_counter 0 
 	append table_enti_reg "</tr>\n"
 	append table_enti_reg "<tr>\n"

 	append table_enti_reg "<td width=\"$ente_width%\">\n"
	append table_enti_reg "<table width=\"100%\" border=\"0\" cellpaddin=\"0\" cellspacing=\"0\" align=\"center\"><tr><td height=\"100%\">\n"
 	append table_enti_reg "<img src=\"$logo_url/$logo_ente\" hspace=\"8\" vspace=\"4\" alt=\"Logo\">\n"
	append table_enti_reg "</td>\n"
	append table_enti_reg "<td height=\"100%\" valign=\"middle\">\n"

 	if {$url_ente ne ""} {
 	    append table_enti_reg "<a href=\"accesso-enti-gest?sito=$url_ente&$url_nome_funz\"><strong>$denominazione_ente</strong></a>\n"
 	} else {
 	    append table_enti_reg "<strong>$denominazione_ente</strong>\n"
 	}
	append table_enti_reg "</td></tr></table>\n"


 	append table_enti_reg "</td>\n"
 	incr line_counter
	
    }
}
append table_enti_reg "</tr>\n"


ad_return_template
