ad_page_contract {

    Estratto conto di un manutentore.

    @author Claudio Pasolini
    @cvs-id $Id: ec.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom02 28/02/2024 Su segnalazione di Giuliodori e' stata inibita la funzione di ricarica del
    rom02            portafoglio alle ditte di manutenzione non attive.
    
    gia01 28/10/2021 Aggiunto passaggio del campo f_ente_portafoglio nella stampa. Serve per
    gia01            creare stampe personalizzate in base all'ente portafoglio

    rom01 05/11/201 Tolto il link "Stampa" alla Regione Marche su richiesta di Sandro.

    sim02 09/05/2018 La regione Marche effettuerà i pagamenti tramite MPAY quindi procedereà
    sim02            con gli appositi programmi

    gab01 10/04/2018 Il programma può ricevere il parametro f_ente_portafoglio per gestire
    gab01            il multiportafoglio

    san01 30/07/2018 Per Ucit visualizzo il link stampa anche per i moviementi accreditati

    sim01 12/10/2016 Aggiunto filtro su campo status

} {
    maintainer_id:optional
    trustee_id:optional
    {from_date      ""}
    {to_date        ""}
    {from_date_ansi ""}
    {to_date_ansi   ""}
    {f_status       ""}
    {f_ente_portafoglio  ""}
    {rows_per_page  "999"}
    {offset         "0"}
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set sw_multi_portafoglio [parameter::get_from_package_key -package_key wallet -parameter sw_multi_portafoglio -default 0];#gab01

if {$sw_multi_portafoglio} {;#gab01 aggiunta if, else e contenuto

    set where_multi_portafoglio "and h.instance_name = :f_ente_portafoglio"

    if {![db_0or1row q "select g.group_name as nome_ente_portafoglio
                          from groups g
                             , iter_instances i
                         where g.group_id = i.instance_id
                           and i.instance_name = :f_ente_portafoglio"]} {

        ad_returnredirect -message "ATTENZIONE! E' necessario selezionare un ente portafoglio" "ec-filter?maintainer_id=$maintainer_id"
        ad_script_abort

    }


} else {
    set where_multi_portafoglio ""
    set nome_ente_portafoglio   ""
}

set page_title "Elenco movimenti $nome_ente_portafoglio"
set context [list "$page_title"]

# imposto codice Regione Lombardia come utilizzato nei movimenti
set id_regione "3"

# ottengo wallet_id e nome del soggetto titolare
if {[info exists maintainer_id]} {
    if {!$sw_multi_portafoglio} {;#gab01 aggiunta if
	db_1row maintainer "select name, wallet_id, coalesce(iban_code, 'non registrato') as iban_code from iter_maintainers where maintainer_id = :maintainer_id"
    } else {;#gab01 aggiunta else e contenuto
	if {![db_0or1row maintainer "select m.name
                             , h.wallet_id 
                             , coalesce(m.iban_code, 'non registrato') as iban_code 
                          from iter_maintainers m 
                             , wal_holders h
                         where m.maintainer_id = :maintainer_id
                           and 'MA'||lpad(h.holder_id,6,0)=m.iter_code
                        $where_multi_portafoglio"]} {
	    ad_returnredirect -message "ATTENZIONE! Non esiste un portafoglio per questo utente sul seguente ente: $nome_ente_portafoglio" "ec-filter?maintainer_id=$maintainer_id"
            ad_script_abort
	}
    }

} elseif {[info exists trustee_id]} {
    db_1row trustee "select name, wallet_id, coalesce(iban_code, 'non registrato') as iban_code from iter_trustees where trustee_id = :trustee_id"
} else {
    ad_return_complaint 1 "Questo programma deve ricevere obbligatoriamente come argomento o il codice del manutentore o il codice dell'amministratore di cui si desidera l'estratto conto."
    ad_script_abort
}

set actions "{Inserisci nuovo versamento} transactions-gest-man?f_ente_portafoglio=$f_ente_portafoglio {Nuovo versamento}";#gab01 passo f_ente_portafoglio

set db_name [db_get_database];#sim02
if {[string match "*iter-portal-marche*" $db_name]} {#sim02 if e suo contenuto

    set actions "{Inserisci nuovo versamento compensazione bollini} transactions-gest-man?f_ente_portafoglio=$f_ente_portafoglio {Nuovo versamento}";#gab01 passo f_ente_portafoglio
    
    if {[db_0or1row q "select 1
                         from iter_maintainers
                        where maintainer_id = :maintainer_id
                          and is_active_p   = 't'"]} {#rom02 Aggiunta if ma non il suo contenuto
	append actions " {Inserisci nuovo versamento con MPAY} ../wallet/MPAY/MPAY_transactions-gest-man?f_ente_portafoglio=$f_ente_portafoglio {Nuovo versamento}"
	
	#per_blocacre_mpay    append actions " {Inserisci nuovo versamento con MPAY (non ancora attivato)} {} {Nuovo versamento}";#MOMENTANEO DA TOGLIERE
	
	#   if {$user_id eq "43476"} {#solo per test
	#	append actions " {test sim} ../wallet/MPAY/MPAY_transactions-gest-man?f_ente_portafoglio=$f_ente_portafoglio {testsim}"
	#    }
    };#rom02
    
}
# creates filters form
#sim01 aggiunto f_status
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -export {maintainer_id trustee_id f_ente_portafoglio} \
    -form {
	{from_date:text,optional
	    {label {Da data movimento}}
	    {html {length 20} }
	    {value $from_date}
	}
	{to_date:text,optional
	    {label {A data movimento}}
	    {html {length 20} }
	    {value $to_date}
	}
	{f_status:text(select),optional
            {options { {"Tutti" ""} {"In lavorazione" "L"} {"Accreditato" "A"} {"Annullato" "K"} }}
            {label {Stato}}
            {value $f_status}
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
	ah::set_list_filters iter-portal ec

    }
#sim01 aggiunto status_desc
template::list::create \
    -name ec \
    -multirow ec \
    -key tran_id \
    -actions $actions \
    -elements {
	action {
	    display_template {@ec.action;noquote@}
	}
	payment_date {
	    label "Data contabile"
	}
	currency_date {
	    label "Disponib. credito"
	}
	holder {
	    label "Responsabile impianto"
	}
	city {
	    label "Località impianto"
	}
	cod_impianto_est {
	    label "Codice impianto"
	}
        potenza {
	    label "Potenza erogata (KW)"
	}
        amount_plus {
	    label "Operazione di ricarica"
	    html {align right}
	}
        amount_minus_regione {
	    label "Contributo Regione"
	    html {align right}
	}
        amount_minus_ente {
	    label "Contributo Ente Locale"
	    html {align right}
	}
	description {
	    label "Desc. Movimento"
	}
	cro {
	    label "CRO"
	}
	status_desc {
	    label "Stato"
	}
    } -filters {
	from_date {
	    hide_p 1
	    where_clause {m.creation_date >= :from_date_ansi}
	}
	to_date {
	    hide_p 1
	    where_clause {m.creation_date <= :to_date_ansi}
	}
	f_status {
	    hide_p 1
            where_clause {m.status = :status}
        }
	from_date_ansi {hide_p 1}
	to_date_ansi {hide_p 1}
    } 

# eseguo la query solo in assenza di errori nei filtri del form
if {![info exists errnum]} {

    #  Rendo dinamica la scelta della url del web service
    if {[db_get_database] eq "curit-dev"} {
        set base_url "http://wallet.sviluppo.curit.it"
    } elseif {[db_get_database] eq "curit-sta"} {
        set base_url "http://wallet.staging.curit.it"
    } else {
        set base_url "http://wallet.curit.it"
    }

    # invoco il web service ec sull'istanza wallet
#sim01    set url "lotto/ec?wallet_id=$wallet_id&from_date=$from_date_ansi&to_date=$to_date_ansi"
    set url "lotto/ec?wallet_id=$wallet_id&from_date=$from_date_ansi&to_date=$to_date_ansi&f_status=$f_status";#sim01
    # ns_log notice "\n |(ec.tcl)| url = $url|"

    #set data [ad_httpget -url $url -timeout 100]
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

#sim01    template::multirow create ec tran_id payment_date currency_date holder city cod_impianto_est potenza amount_plus amount_minus_regione amount_minus_ente dichiarazione_url impianto_url description 

    template::multirow create ec action tran_id payment_date currency_date holder city cod_impianto_est potenza amount_plus amount_minus_regione amount_minus_ente dichiarazione_url impianto_url description status_desc cro;#sim01

    set entrate 0.00
    set uscite  0.00

    foreach movement $movements {

        # ( 05.08.2008 - Nelson ) Aggiunto 'tran_id' in coda al WEB SERVICE ... id del movimento.
        #sim01 util_unlist $movement tran_type_id body_id payment_date reference pay_type_id description amount sign currency_date tran_id 
	util_unlist $movement tran_type_id body_id payment_date reference pay_type_id description amount sign currency_date tran_id status_desc cro;#sim01

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
		if {![db_0or1row -dbn $dbn iter "
                select i.cod_impianto_est
                      ,i.potenza
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
	if {![string match "*iter-portal-marche*" $db_name]} {#rom01 aggiunta if; aggiunta else e contenuto
	    if {$status_desc eq "In lavorazione"} {;#sim01 if e suo contenuto
		#gia01 set action "<a href=\"transactions-layout?tran_id=$tran_id\">Stampa<a>"
		set action "<a href=\"transactions-layout?tran_id=$tran_id&f_ente_portafoglio=$f_ente_portafoglio\">Stampa<a>";#gia01
	    } else {
		set action ""
		
		if {$cro ne "" && [db_get_database] eq "ucit"} {#san01 if e suo contenuto
		    set action "<a href=\"transactions-layout?tran_id=$tran_id\">Stampa<a>"
		}

	    }
	} else {
	    set action ""
	};#rom01

        if {$sign eq "+"} {
	    set amount_plus          $amount_pretty
	    set amount_minus_regione ""
	    set amount_minus_ente    ""


	    if {$status_desc eq "Accreditato"} {;#sim01
		set entrate [expr $entrate + $amount]
	    };#sim01
	
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

#sim01	template::multirow append ec $tran_id $payment_date $currency_date $holder $city $cod_impianto_est $potenza $amount_plus $amount_minus_regione $amount_minus_ente dichiarazione_url impianto_url $description

	template::multirow append ec $action $tran_id $payment_date $currency_date $holder $city $cod_impianto_est $potenza $amount_plus $amount_minus_regione $amount_minus_ente dichiarazione_url impianto_url $description $status_desc $cro;#sim01

    }

    set delta   [expr $entrate - $uscite]
    set delta   [ah::edit_num $delta 2];#sim01
    set entrate [ah::edit_num $entrate 2]
    set uscite  [ah::edit_num $uscite 2]

    set final_balance [ah::edit_num $final_balance 2]

} else {
    # creo una multirow fittizia 
    template::multirow create ec dummy
} 

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property iter-portal ec [export_vars -entire_form -no_empty]
}

