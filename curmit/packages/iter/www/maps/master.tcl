ad_page_contract {
    Pagina di sfondo.

    @author Nicola Mortoni
    @date   01/10/2003

    @cvs_id master.tcl
} {
}

# posso valorizzare eventuali variabili tcl a disposizione del master
set logo_url [iter_set_logo_dir_url]
set css_url  [iter_set_css_dir_url]
set funz_pwd [iter_get_nomefunz coimcpwd-gest]
set funz_log_out [iter_get_nomefunz logout]
if {![info exists htmlarea]} {
    set htmlarea "f"
}

iter_get_coimtgen

# predispongo il link per tornare alla pagina di accesso-enti del sito
# per la regione se il settore dell'utente e' regione
# ed il parametro "Sfondo col logo dell'ente" vale Si' (non e' una demo)
# ed il parametro flag_ente non e' "R" (siamo sul sito di una Provincia o Com.)

if {$coimtgen(flag_master_ente)  != "F"
&&  $coimtgen(flag_ente)         != "R"
&&  [iter_get_coimuten -utente_corrente] == "ok"
&& (    $coimuten(id_settore)    == "regione"
    || (   $coimuten(id_settore) == "system"
        && $coimuten(id_ruolo)   == "admin"))
} {
    set link_regione "<a href=\"http://iterre.lombardia.curit.it/iter/regione/accesso-enti-list?nome_funz=accesso-enti\">Regione<a>"
} else {
    set link_regione "&nbsp;"
}

# in base ai parametri della coimtgen richiamo una certa pagina adp

# se il parametro "Sfondo col logo dell'ente" vale No, richiamo l'adp col
# logo di vestasoft 
if {$coimtgen(flag_master_ente) == "F"} {
    set cod_istanza "iter25"
} else {
    # richiamo l'adp creato appositamente per l'ente da parametro
    # valorizzo il codice istanza con flag_ente + nome_ente
    if {$coimtgen(flag_ente) == "C"} {
	#Tolgo eventuali spazi dalla stringa della denominazione per evitare eventuali
	#problemi di gestione del nome del master dell'ente
	regsub -all " " $coimtgen(denom_comune) "" coimtgen(denom_comune)
        set cod_istanza "$coimtgen(flag_ente)$coimtgen(denom_comune)"
    } else {
        # anche nel caso di ente Regione, uso sigla_prov, perche'
        # vi sono state memorizzate le prime due lettere della regione
        set cod_istanza "$coimtgen(flag_ente)$coimtgen(sigla_prov)"
#        set cod_istanza "$coimtgen(flag_ente)lo"
    }
    if {$coimtgen(flag_ente) == "R"} {
        set cod_istanza "$coimtgen(flag_ente)lo"
    }

}

set cod_istanza [string tolower $cod_istanza]

# cosa faccio per avere la demo iter-2.5 col logo vesta?

set package_www_dir [iter_set_package_www_dir]
ad_return_template $package_www_dir/master-$cod_istanza

