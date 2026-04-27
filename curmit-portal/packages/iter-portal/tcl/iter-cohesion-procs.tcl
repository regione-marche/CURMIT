ad_library {

    Proc per l'integrazione con Cohesion della Regione Marche

    @author xxxxxxx
    @cvs-id $Id:

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    sim02 17/04/2020 Per le Marche i proprietari e gli occupanti possono vedere i loro impianti
    sim02            anche se non sono responsabili

    sim01 15/03/2019 Per motivi di sicurezza i messaggi che poi verranno visualizzati in pagina
    sim01            non possono essere passati via url come parametri.
    sim01            Andrò quindi a passare un codice e sarà poi il programma login-cohesion-cittadino
    sim01            a visualizzare il testo corretto.
}

namespace eval iter {}

ad_proc -public iter::check_login_cohesion {
    -nome_array_output:required
    {-dbn_iter     ""}
    {-cod_impianto ""}
    {-targa        ""}
} {
    Controlla se il cittadino e' loggato tramite cohesion e restituisce l'array con i dati
    messi a disposizione dal token.
    Se vengono passati sia il dbn_iter che il cod_impianto, controlla anche che il codice
    fiscale sia collegato all'impianto.
    Se vengono passati sia il dbn_iter che la targa, controlla anche che il codice
    fiscale sia collegato agli impianti relativi alla targa.
    
    Creata da Nicola M. in ottobre 2018
    @param nome_array_output  Nome dell'array contenente i dati di output.
} {
    #Associo l'array locale di nome output ad un'array nello scope del chiamante il cui
    #nome e' specificato in $nome_array_output:
    upvar 1 $nome_array_output array_output
    
    set token_cohesion [ad_get_client_property iter token_cohesion]

    if {$token_cohesion eq ""} {
#sim01	set messaggio     "Per accedere ai servizi del cittadino &egrave; necessario effettuare la procedura di login cliccando sul bottone \"Entra\" sotto riportato."
	set messaggio "msg_login";#sim01
	set url           [export_vars -base "/iter-portal/login-cohesion-cittadino" {messaggio}]
	ad_returnredirect $url
	ad_script_abort
	
    } else {
	# Per ora, devo solo recuperare il contenuto del tag codice_fiscale.
	# Per semplicita' uso una regexp.

	set codice_fiscale ""
	set sw_trovato     [regexp {<codice_fiscale>(.*)</codice_fiscale>} $token_cohesion match codice_fiscale]

	if {!$sw_trovato || [string is space $codice_fiscale]} {
	    iter_return_complaint "Il token restituito dal Servizio di autenticazione Cohesion della Regione Marche non contiene il tag codice_fiscale"
	    #la iter_return_complaint fa anche ad_script_abort
	}

	if {![string is space $dbn_iter] && ![string is space $cod_impianto]} {
	    if {![db_0or1row -dbn $dbn_iter query "
                select 1
                  from coimaimp a
                     , coimcitt c
                 where a.cod_impianto  = :cod_impianto
--sim02                   and c.cod_cittadino = a.cod_responsabile
                   and (c.cod_cittadino = a.cod_responsabile or
                        c.cod_cittadino = a.cod_proprietario or
                        c.cod_cittadino = a.cod_occupante) --sim02
                   and c.cod_fiscale   = upper(:codice_fiscale)
                 limit 1
                "]
	    } {
		iter_return_complaint "Il tuo codice fiscale ($codice_fiscale) non &egrave; identico a quello del responsabile dell'impianto che stai consultando."
		#la iter_return_complaint fa anche ad_script_abort
	    }
	}

	if {![string is space $dbn_iter] && ![string is space $targa]} {
	    if {![db_0or1row -dbn $dbn_iter query "
                select 1
                  from coimaimp a
                     , coimcitt c
                 where a.targa         = :targa
--sim02                   and c.cod_cittadino = a.cod_responsabile
                   and (c.cod_cittadino = a.cod_responsabile or
                        c.cod_cittadino = a.cod_proprietario or
                        c.cod_cittadino = a.cod_occupante) --sim02
                   and c.cod_fiscale   = upper(:codice_fiscale)
                 limit 1
                "]
	    } {
		iter_return_complaint "Il tuo codice fiscale ($codice_fiscale) non &egrave; identico a quello del responsabile dell'impianto che stai consultando."
		#la iter_return_complaint fa anche ad_script_abort
	    }
	}

	set array_output(codice_fiscale) $codice_fiscale
	return $codice_fiscale
    }
    
}


ad_proc -public iter::get_ip_pubblico {
} {
    Restituisce l'indirizzo ip pubblico che poi serviera' per richiamare la servlet
    presente su tomcat.
    Creata da Nicola M. in ottobre 2018
} {
    # Quando andremo in produzione, dovro' chiamare i db in modo diverso e subordinare
    # il tutto ad una if sul risultto della db_get_database.
    #set ip_pubblico "34.244.115.149"
    set ip_pubblico "84.38.48.31"
    return $ip_pubblico
}
