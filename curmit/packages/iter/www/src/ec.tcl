ad_page_contract {

    Estratto conto di un manutentore.

    @author Claudio Pasolini
    @cvs-id $Id: ec.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim02 18/02/2016 Aggiunto scarico csv.
    
    sim01 07/02/2016 Modificato per essere chiamato da iter e non dal portale. Ho chesto a Sandro
    sim01            e mi ha confermato che gli amministratori di condominio non vanno gestiti


} {
    maintainer_id:optional
    trustee_id:optional
    {from_date      ""}
    {to_date        ""}
    {from_date_ansi ""}
    {to_date_ansi   ""}
    {rows_per_page  "999"}
    {offset         "0"}
    {nome_funz      ""}
    {nome_funz_caller ""}
    {caller    "index"}
    {extra_par ""}
    {format   "normal"}
}

#sim01 set user_id    [auth::require_login]
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

db_1row query "select id_ruolo
                 from coimuten
                where id_utente = :id_utente"


set package_id [ad_conn package_id]

set page_title "Elenco movimenti"
set context [list "$page_title"]

set link_scar  [export_url_vars caller nome_funz maintainer_id from_date to_date from_date_ansi to_date_ansi]
iter_get_coimtgen

set link_list [export_url_vars caller nome_funz receiving_element]&[iter_set_url_vars $extra_par]

set body_name  $coimtgen(ente)

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar  [iter_context_bar \
			  [list "javascript:window.close()" "Torna alla Gestione"] \
			  [list coimmanu-list?$link_list "Lista Manutentori"] \
			  "$page_title"]
}

if {$format eq "csv"} {;#sim02
    set nome_file          "Estrazione Movimenti"
    set nome_file          [iter_temp_file_name $nome_file]
    set spool_dir          [iter_set_spool_dir]
    set spool_dir_url      [iter_set_spool_dir_url]
    set file_csv           "$spool_dir/$nome_file.csv"
    set file_csv_url       "$spool_dir_url/$nome_file.csv"
    
    set file_id            [open $file_csv w]
    fconfigure $file_id -encoding iso8859-1

    set     head_cols ""
    lappend head_cols "Data contabile"
    lappend head_cols "Disponib. credito"
    lappend head_cols "Ente di riferimento"
    lappend head_cols "Responsabile impianto"
    lappend head_cols "Località impianto"
    lappend head_cols "Codice impianto"
    lappend head_cols "Potenza erogata (KW)"
    lappend head_cols "Operazione di ricarica"
    lappend head_cols "Contributo Regione"
    lappend head_cols "Contributo Ente Locale"
    lappend head_cols "Desc. Movimento"

    iter_put_csv $file_id head_cols

}

# imposto codice Regione Lombardia come utilizzato nei movimenti
set id_regione "3"

set sel_mov "select '' as payment_date         
, '' as currency_date 
, '' as body_name       
, '' as holder               
, '' as city                 
, '' as cod_impianto_est     
, '' as potenza              
, '' as amount_plus          
, '' as amount_minus_regione 
, '' as amount_minus_ente    
, '' as description         
where 1=0 ";#sim01

# ottengo wallet_id e nome del soggetto titolare
if {[info exists maintainer_id]} {
    #db_1row maintainer "select name, wallet_id, coalesce(iban_code, 'non registrato') as iban_code from iter_maintainers where maintainer_id = :maintainer_id"

    db_1row maintainer "select cognome
                             , wallet_id
                             , coalesce(iban_code, 'non registrato') as iban_code 
                          from coimmanu
                         where cod_manutentore = :maintainer_id"

#sim01 } elseif {[info exists trustee_id]} {
#sim01    db_1row trustee "select name, wallet_id, coalesce(iban_code, 'non registrato') as iban_code from iter_trustees where trustee_id = :trustee_id"
} else {
    ad_return_complaint 1 "Questo programma deve ricevere obbligatoriamente come argomento o il codice del manutentore o il codice dell'amministratore di cui si desidera l'estratto conto."
    ad_script_abort
}

# creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -export {maintainer_id trustee_id nome_funz} \
    -form {
	{from_date:text,optional
	    {label {Da data movim.}}
	    {html {size 10 maxlength 10} }
	    {value $from_date}
	}
	{to_date:text,optional
	    {label {A data movim.}}
	    {html {size 10 maxlength 10}}
	    {value $to_date}
	}

    } -on_request {

	if {$from_date eq ""} {
	    set from_date      [db_string from "select to_char(current_date - interval '1 month', 'DD/MM/YYYY')"]
	    set from_date_ansi [db_string ansi "select to_char(current_date - interval '1 month', 'YYYY-MM-DD')"]
	}

	if {$to_date eq ""} {
	    set to_date        [ah::today_pretty]
	    set to_date_ansi   [ah::today_ansi]
	}

    } -on_submit {
	
	set errnum 0

	set from_date_ansi [ah::check_date -ansi -input_date $from_date]
	if {$from_date_ansi == 0} {
	    template::form::set_error filter from_date "Data inizio errata."
	    incr errnum
	}
	set to_date_ansi [ah::check_date -ansi -input_date $to_date]
	if {$to_date_ansi == 0} {
	    template::form::set_error filter to_date "Data fine errata."
	    incr errnum
	}

	if {$errnum > 0} {
	    break
	} else {
	    # per evitare errori nell'esecuzione della query la eseguirò solo se 'errnum' non esiste
	    unset errnum
	    # imposto flag per sapere se il form è stato inviato
	    set submit_p 1
	}

	# recupero l'impostazione dei filtri non compresi nel form
#sim01	ah::set_list_filters iter-portal ec

    }

# eseguo la query solo in assenza di errori nei filtri del form
if {![info exists errnum]} {

    # invoco il web service ec sull'istanza wallet
    set url "lotto/ec?wallet_id=$wallet_id&from_date=$from_date_ansi&to_date=$to_date_ansi"

    # ns_log notice "\n |(ec.tcl)| url = $url|"

    set data [iter_httpget_wallet $url]

    array set result $data

    # result(page) contiene la risposta del web service e cioè una lista contenente:

    #  1. return code può assumere il valore 'OK' oppure descrivere l'errore
    #  2. saldo iniziale o 0 in caso di errore
    #  3. saldo finale   o 0 in caso di errore
    #  4. lista dei movimenti o una lista vuota in caso di errore

    #Ogni elemento della lista di movimenti è a sua volta costituito da:
    #  1. id_tipo_movimento, 
    #  2. id_ente, 
    #  3. data, 
    #  4. riferimento, 
    #  5. id_tipo_pagamento, 
    #  6. descrizione, 
    #  7. importo
    #  8. data valuta

    util_unlist $result(page) retcode starting_balance final_balance movements

    if {$retcode ne "OK"} {
	ad_return_complaint 1 "<li>Si è verificato un errore imprevisto: $retcode"
	ad_script_abort
    }

    set entrate 0.00
    set uscite  0.00
    set extra_rows ""

    foreach movement $movements {

        # ( 05.08.2008 - Nelson ) Aggiunto 'tran_id' in coda al WEB SERVICE ... id del movimento.
        util_unlist $movement tran_type_id body_id payment_date reference pay_type_id description amount sign currency_date tran_id

	set cod_impianto_est ""
	set potenza          ""
	set holder           ""
	set city             ""

        # devo identificare i movimenti provenienti da iter, che hanno il campo reference contenente
        # codice dichiarazione e nome del database
        if {[llength $reference] == 2 && [string range [lindex $reference 1] 0 3] eq "iter"} {
	    # dovrebbe essere un movimento generato da iter
	    util_unlist $reference cod_dimp dbn

            #ns_log notice "\n..processing cod_dimp=$cod_dimp dbn=$dbn"

	    # leggo i dati da iter, se ho ottenuto un dbn
	    if {$dbn ne ""} {
		if {![db_0or1row iter "
                select i.cod_impianto_est
                      ,iter_edit_num(i.potenza,2) as potenza
                      ,s.cognome || ' ' || coalesce(s.nome, ' ') as holder
                      ,c.denominazione as city
                from coimdimp d, coimaimp i, coimcitt s, coimcomu c
                where d.cod_dimp         = :cod_dimp
                  and d.cod_impianto     = i.cod_impianto
                  and i.cod_responsabile = s.cod_cittadino
                  and i.cod_comune       = c.cod_comune
                "]} {
		    # (10.12.2008 Luk) non scarto più i movimenti provenienti da iter per i quali non trovo l'impianto
		    set cod_impianto_est ""
		    set potenza          ""
		    set holder           ""
		    set city             ""
                    # continue
		}
	    } else {
                # scarto i movimenti provenienti da iter per i quali non dispongo del database
                continue
	    }
	}

        # edito date e campi numerici
	set amount_pretty [ah::edit_num $amount 2]
        set payment_date  [string range $payment_date 8 9]/[string range $payment_date 5 6]/[string range $payment_date 0 3]
        set currency_date [string range $currency_date 8 9]/[string range $currency_date 5 6]/[string range $currency_date 0 3]

        if {$sign eq "+"} {
	    set amount_plus          $amount_pretty
	    set amount_minus_regione ""
	    set amount_minus_ente    ""

            set entrate [expr $entrate + $amount]
	} else {
            set amount_plus ""
	    if {$body_id == $id_regione} {
		set amount_minus_regione $amount_pretty
		set amount_minus_ente    ""
	    } else {
		set amount_minus_regione ""
		set amount_minus_ente    $amount_pretty
	    }

	    set uscite [expr $uscite + $amount]
	}
	
	set dichiarazione_url [export_vars -base "#" {cod_dimp}]
	set impianto_url      [export_vars -base "#" {cod_impianto}]

	if {$format eq "csv"} {
	 
	    set file_row ""
	    lappend file_row $payment_date
	    lappend file_row $currency_date
	    lappend file_row $body_name
	    lappend file_row $holder
	    lappend file_row $city
	    lappend file_row $cod_impianto_est
	    lappend file_row $potenza
	    lappend file_row $amount_plus
	    lappend file_row $amount_minus_regione
	    lappend file_row $amount_minus_ente
	    lappend file_row $description

	    iter_put_csv $file_id file_row
  
	} else {
	    # Per usare l'ad_table, faccio una select fittizia dei record ottenuti dal
	    # web-service

	    regsub -all "'" $holder "''" holder

	    append sel_mov "union all select '$payment_date'         
, '$currency_date'        
, '$body_name'
, '$holder'               
, '$city'                 
, '$cod_impianto_est'     
, '$potenza'              
, '$amount_plus'          
, '$amount_minus_regione' 
, '$amount_minus_ente'    
, '$description' ";#sim01

	}

    }

    set delta   [expr $entrate - $uscite]
    set entrate [ah::edit_num $entrate 2]
    set uscite  [ah::edit_num $uscite 2]

    set final_balance [ah::edit_num $final_balance 2]


} 

set table_def [list \
		   [list payment_date         "Data contabile"               no_sort {l}] \
		   [list currency_date        "Disponib. credito"            no_sort {l}] \
		   [list body_name            "Ente di riferimento"          no_sort {l}] \
		   [list holder               "Responsabile impianto"        no_sort {l}] \
		   [list city                 "Località impianto"            no_sort {l}] \
		   [list cod_impianto_est     "Codice impianto"              no_sort {l}] \
		   [list potenza              "Potenza erogata (KW)"         no_sort {l}] \
		   [list amount_plus          "Operazione di ricarica"       no_sort {l}] \
		   [list amount_minus_regione "Contributo Regione" no_sort {l}] \
		   [list amount_minus_ente    "Contributo Ente Locale"       no_sort {l}] \
		   [list description          "Desc. Movimento"              no_sort {l}] \
		  ];#sim01

if {$format eq "csv"} {
    close $file_id
    ad_returnredirect $file_csv_url
    ad_script_abort
}

set ec [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {nome_funz nome_funz_caller extra_par} go $sel_mov $table_def];#sim01

if {![info exists submit_p]} {

    # save current url vars for future reuse
    ad_set_client_property iter-portal ec [export_vars -entire_form -no_empty]
}
