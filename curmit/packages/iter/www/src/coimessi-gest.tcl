ad_page_contract {
    @author          Elisa DeBattisti Adhoc
    @creation-date   11/03/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimessi-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    sim01 19/03/2020 Sandro vista la nuova normativa ha detto che è possibile fare più appuntamenti
    sim01            su un impianto per la stessa campagna
    
} {
    {funzione        "V"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {extra_par        ""}
    {cod_impianto     ""}
    {cod_cinc         ""}
    {url_list_aimp    ""}
    {url_aimp         ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

if {[db_0or1row sel_cinc_count ""] == 0} {
    set conta 0
}
if {$conta == 0} {
    iter_return_complaint "Non ci sono campagne aperte"
}
if {$conta > 1} {
    iter_return_complaint "C'&egrave; pi&ugrave; di una campagna aperta"
}
if {$conta == 1} {
    if {[db_0or1row sel_cinc ""] == 0} {
	iter_return_complaint "Campagna non trovata"
    }
}

if {[db_0or1row sel_count_inco ""] == 0} {
    set conta_inco 0
}

#sim01 if {$conta_inco > 0} {
#sim01    iter_return_complaint "Impianto gi&agrave; estratto per la campagna in corso"
#sim01 }

# Personalizzo la pagina
set titolo       "Controllo Singolo Impianto"
set button_label "Ritorna"
set page_title   "Pianifica controllo"

if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}
set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp $extra_par]
set dett_tab [iter_tab_form $cod_impianto]

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

set tipo_estrazione   "6"
db_1row sel_dual_date "" 
set stato "0"
set ctr_scritti 0

iter_get_coimtgen

if {$coimtgen(flag_ente) == "P"
&&  $coimtgen(sigla_prov) == "LI"
} {
    set tipo_lettera "C"
} else {
    set tipo_lettera ""
}


if {[exists_and_not_null cod_impianto]} {
    with_catch error_msg {
	db_transaction {
	    # preparo le note in cui deve comparire il telefono
	    # del responsabile e dell'occupante
	    set note         ""
	    if {[db_0or1row sel_aimp_sogg ""] == 1} {
		set cod_cittadino $cod_responsabile
		if {![string is space $cod_cittadino]
		&&   [db_0or1row sel_citt_telefono ""] == 1
		} {
		    if {![string is space $telefono]} {
			set note "Telefono responsabile: $telefono. "
		    }
		}
		set cod_cittadino $cod_occupante
		if { $cod_occupante != $cod_responsabile
		&&  ![string is space $cod_cittadino]
		&&   [db_0or1row sel_citt_telefono ""] == 1
		} {
		    if {![string is space $telefono]} {
			append note "Telefono occupante: $telefono."
		    }
		}
	    }

	    incr ctr_scritti
	    db_1row sel_inco_s "" 
	    db_dml db_dml_inco [db_map ins_inco]
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }
}

if {$ctr_scritti == 0} {
    set scritti "Nessun impianto da controllare inserito"
} else {
    set scritti "E' stato inserito un nuovo appuntamento nella campagna $desc_camp"
}

ad_return_template
