ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: supplies-list.tcl

} {
    group_id
    {search_name ""}
    {search_email ""}
    {from_date ""}
    {to_date ""}
    {from_date_ansi ""}
    {to_date_ansi ""}
    {rows_per_page     30}
    orderby:optional
}

set user_id    [auth::require_login]

set page_title "Forniture dei distributori"
set context [list [list services {Servizi}] "$page_title"]

# creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -export group_id \
    -form {
	{search_name:text,optional
	    {label {Cerca Rag. Soc. Distributore }}
	    {html {length 20} }
	    {value $search_name}
	}
	{search_email:text,optional
	    {label {Cerca email Distributore }}
	    {html {length 20} }
	    {value $search_email}
	}
	{from_date:text,optional
	    {label {Da data fornitura}}
	    {html {length 20} }
	    {value $from_date}
	}
	{to_date:text,optional
	    {label {A data fornitura}}
	    {html {length 20} }
	    {value $to_date}
	}
    } -on_request {

	if {$from_date eq ""} {
	    set from_date      "01/01/2008"
	    set from_date_ansi "2008-01-01"
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
    ah::set_list_filters iter-portal supplies-list

}


set actions ""

template::list::create \
    -name supplies \
    -multirow supplies \
    -actions $actions \
    -elements {
	name {
	    label "Ragione Sociale"
            html {align left}
	}
	email {
	    label "Email"
            html {align left}
	}
	supply_date {
	    label "Dt. fornitura"
            display_col supply_date_pretty
	}
	azioni {
	    label "Azioni"
            display_template {<a href="download?distributor_id=@supplies.distributor_id@&supply_id=@supplies.supply_id@">Download</a>}
	}
    }  \
    -orderby {
        default_value "supply_date,desc"
        name {
	    label "Ragione sociale"
	    orderby_desc "s.name desc"
	    orderby_asc  "s.name"
            default_direction "asc"
	}
        email {
	    label "Email"
	    orderby_desc "s.email desc"
	    orderby_asc  "s.email"
            default_direction "asc"
	}
        supply_date {
	    label "Data fornitura"
	    orderby_desc "s.supply_date desc"
	    orderby_asc  "s.supply_date"
            default_direction "desc"
	}
    } \
    -filters {
	group_id {
	    hide_p 1
	    where_clause {s.body_id = :group_id }
	}
	search_name {
	    hide_p 1
	    where_clause {upper(d.name) like upper('%$search_name%')}
	}
	search_email {
	    hide_p 1
	    where_clause {upper(d.email) like upper('%$search_email%')}
	}
        from_date {
            hide_p 1
            where_clause {s.supply_date >= :from_date_ansi}
        }
        to_date {
            hide_p 1
            where_clause {s.supply_date <= :to_date_ansi}
        }
        from_date_ansi {hide_p 1}
        to_date_ansi {hide_p 1}
        rows_per_page {
	    label "Righe per pagina"
	    values {{10 10} {30 30} {100 100}}
            default_value 30
        }
    } 

# eseguo la query solo in assenza di errori nei filtri del form
if {![info exists errnum]} {
    db_multirow supplies query "
        select distinct
            s.distributor_id
           ,s.supply_id
           ,to_char(s.supply_date, 'DD/MM/YYYY') as supply_date_pretty
           ,supply_date
           ,d.name
           ,d.email
        from iter_distributors_supplies s, iter_distributors d
        where s.distributor_id = d.distributor_id
        [template::list::filter_where_clauses -name supplies -and]
        [template::list::orderby_clause -name supplies -orderby]
    " {
	
    }
} else {
    # creo una multirow fittizia 
    template::multirow create supplies dummy
} 

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property iter-portal supplies-list [export_vars -entire_form -no_empty]
}
