ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimaimp"
    @author          Silvia Boschetti
    @creation-date   24/11/2006
    
    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimaimp-gest.tcl
} {
    
    {cod_impianto      ""}
    {last_cod_impianto ""}
    {funzione         "V"}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {extra_par         ""}
    {url_list_aimp     ""}
    {url_aimp          ""}
    {f_cod_via         ""}
    {add               ""} 
    {xrif              ""} 
    {yrif              ""}    
    {raggiorif         ""}    
    {aaa        ""}
    {address    ""}
    {flagxy     ""}
    {lat_prov   ""}
    {lon_prov   ""}
    {wrn_map    ""}
    {color      ""}
    {is_maps    "true"}

} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}
#ns_return 200 text/html "STOP"; return
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_impianto url_list_aimp url_aimp last_cod_impianto color nome_funz nome_funz_caller extra_par caller]
#preparo il link al programma Storico ubicazioni
set link_stub  [export_url_vars cod_impianto nome_funz_caller url_aimp url_list_aimp]&nome_funz=[iter_get_nomefunz coimstub-list]
#preparo il link da utilizzare quando clicco sul bottone del form per la ricerca di un impianto tramite il suo indirizzo
set link_maps [export_url_vars cod_impianto url_list_aimp url_aimp last_cod_impianto nome_funz_caller extra_par caller]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}
set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)
set flag_ente $coimtgen(flag_ente)
set cod_provincia $coimtgen(cod_provincia)
set provincia $coimtgen(sigla_prov)
set google_api_key $coimtgen(google_key)
# Personalizzo la pagina

set link_list_script {[export_url_vars last_cod_impianto caller nome_funz nome_funz_caller]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set link_return $url_list_aimp
set titolo           "Ubicazione"

set page_title  "Mappe"

#estraggo i dati di default
db_1row default_notion ""

if {$orig_x eq ""} { set orig_x 0 }
if {$orig_y eq ""} { set orig_y 0 }

if {$aaa ne ""} {
    set aaa [string map {( "" ) ""} $aaa]
    set cor [split $aaa ,]
    util_unlist $cor lat lon

    set valid_x [expr $lat-$orig_x]
    set valid_y [expr $lon-$orig_y]
	    
    if {($valid_x<$delta) && ($valid_y<$delta)} {
	set new_state "OK"
	set color "green"
	set wrn_map "COORDINATE ESATTE!"
    } else {
	set new_state "NO"
	set lat $orig_x
	set lon $orig_y
	set color "pink"
	set wrn_map "COORDINATE DA VERIFICARE!"
    }

	db_dml dml_coimaimp [db_map insert_coord]

} else {
    #azzero i campi che la query dovrebbe popolare
    set numero ""
    set indirizzo ""
    set localita ""
    set comune ""
    set provincia ""
    #eseguo la query
    db_0or1row sel_point "" 
    #Inserire query per ricavare le coordinate di default lat_prov lon_prov
    set lat_prov $orig_x
    set lon_prov $orig_y
    
    #controllo sulle coordinate con flagxy NO e coordinate nulle - CASO INIZIALE
    if {$flagxy eq "NO"} { 

	if {$gb_x eq "" || $gb_y eq ""} { 

	    set lat $lat_prov
	    set lon $lon_prov
	    set color "red"
	    set wrn_map "COORDINATE NON INSERITE!"
	    #inserimento valori nel DB anche se lat_prov e lon_prov
	}
    }
    
    #caricamento coordinate valide mappa 
    if {$flagxy eq "OK"} {
        set lat $gb_x
        set lon $gb_y
        set color "green"
        set wrn_map "COORDINATE ESATTE!"
    } 
    # caricamento manuale coordinate
    if {$flagxy eq "MA"} {
	set lat $gb_x
	set lon $gb_y
        set color "orange"
	set wrn_map "COORDINATE INSERITE MANUALMENTE!"
    }
    
    
    #l'indirizzo lo setto per evitare di doverlo scrivere tutte le volte come prova, cmq sarebbe da estrarre con la quary
    #    set address "23 Ungaretti, Montanara, Mantova IT"
    if {($numero eq "") || ($indirizzo eq "") || ($localita eq "") || ($comune eq "") || ($provincia eq "")} {
	set m_numero ""
	set m_indirizzo ""
	set m_localita ""
	set m_comune ""
	set m_provincia ""
	if {$numero eq ""} {
	    set m_numero "CIVICO MANCANTE"
	}
	if {$indirizzo eq ""} {
	    set m_indirizzo "INDIRIZZO MANCANTE"
	}
	if {$localita eq ""} {
	    set m_localita "LOCALITA MANCANTE"
	}
	if {$comune eq ""} {
	    set m_comune "COMUNE MANCANTE"
	}
	if {$provincia eq ""} {
	    set m_provincia "PROVINCIA MANCANTE"
	}
	set color "red"
	set wrn_map "INDIRIZZO NON COMPLETO! $m_numero $m_indirizzo $m_localita $m_comune $m_provincia"
	set address "$numero $indirizzo $localita $comune $provincia IT"
    } else {
	set address "$numero $indirizzo $localita $comune $provincia IT"
    }
} 
if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar  [iter_context_bar \
	             [list "javascript:window.close()" "Torna alla Gestione"] \
                     [list $url_list_aimp               "Lista Impianti"] \
                     "$page_title"]
}


ad_return_template
