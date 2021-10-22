ad_page_contract {

    Analisi file di log di Aolserver

    @author Claudio Pasolini
    @cvs-id $Id: log.tcl
} {
    {search_url ""}
    {search_user ""}
    {from_date ""}
    {to_date ""}
    {from_date_ansi ""}
    {to_date_ansi ""}
    {rows_per_page 30}
    {offset 0}
}

# creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{search_url:text,optional
	    {label {Cerca Url}}
	    {html {length 20} }
	    {value $search_url}
	}
	{search_user:text(select),optional
	    {label {Scegli Utente}}
  	    {options {{Scegli ""} [db_list_of_lists query {
		select email, party_id
		from   parties
		order  by email}]}}         
	    {value $search_user}
	}
	{from_date:text,optional
	    {label {Da data}}
	    {html {length 20} }
	    {value $from_date}
	}
	{to_date:text,optional
	    {label {A data}}
	    {html {length 20} }
	    {value $to_date}
	}

    } -on_request {

	if {$from_date eq ""} {
	    db_1row from_dates "
            select to_char(current_date - interval '1 day', 'DD/MM/YYYY') as from_date,
                   to_char(current_date - interval '1 day', 'YYYY-MM-DD') as from_date_ansi"
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
	} else {
	    set to_date_ansi "${to_date_ansi} 23:59:59"
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
	ah::set_list_filters ah-util log

    }

set page_title "Log entries"
set context [list "Lista scripts"]

# prepare actions buttons
source [ah::package_root -package_key ah-util]/paging-buttons.tcl

template::list::create \
    -name log \
    -multirow log \
    -actions $actions \
    -elements {
	email {
	    label "Email"
	}        
	ipaddr {
	    label "IP"
	}
	logdate_pretty {
	    label "Data e ora"
	    html "nowrap"
	}
	url {
	    label "Url"
	}
	query_args {
	    label "Argomenti"
	}
    } \
    -filters {
        search_user {
            hide_p 1
	    where_clause {m.user_id = :search_user}
        }
	search_url {
	    hide_p 1
	    where_clause {m.url like '%$search_url%'}
	}
        from_date {
            hide_p 1
            where_clause {m.logdate >= :from_date_ansi}
        }
        to_date {
            hide_p 1
            where_clause {m.logdate <= :to_date_ansi}
        }
        from_date_ansi {hide_p 1}
        to_date_ansi {hide_p 1}

        rows_per_page {
	    label "Righe per pagina"
  	    values {{10 10} {30 30} {100 100} {Tutte 9999}}
            default_value 30
        }
    } 

# eseguo la query solo in assenza di errori nei filtri del form 
if {![info exists errnum]} {
    db_multirow log read_log "
    select m.ipaddr,
           to_char(m.logdate, 'DD/MM/YYYY HH:MI:SS') as logdate_pretty,
           m.url,
           m.query_args,
           p.email
    from mis_monitoring m left outer join parties p on m.user_id = p.party_id
    where 1 = 1
    [template::list::filter_where_clauses -name log -and]
    order by logdate
    limit $rows_per_page
    offset $offset"
} else {
    # creo una multirow fittizia 
    template::multirow create log dummy
}
if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property ah-util log [export_vars -entire_form -no_empty]
}



