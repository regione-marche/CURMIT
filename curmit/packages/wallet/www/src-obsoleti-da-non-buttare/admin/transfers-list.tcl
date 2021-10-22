ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: transfers-list.tcl

} {

    {f_filename ""}
    {f_wallet_id ""}
    {f_name ""}
    {from_date ""}
    {to_date ""}
    {from_date_ansi ""}
    {to_date_ansi ""}
    {f_status "P"}
    {f_rec62_elab ""}
    {f_rec63_1_elab ""}
    {f_rec63_al_elab ""}
    {rows_per_page 30}
    orderby:optional
    page:optional
}

ad_script_abort

# creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
    {f_filename:text,optional
        {label {Cerca nome File}}
	{html {length 20} }
	{value $f_filename}
    }
    {f_wallet_id:text,optional
        {label {Cerca codice portafoglio }}
	{html {length 20} }
	{value $f_wallet_id}
    }
    {f_name:text,optional
        {label {Cerca intestatario}}
	{html {length 20} }
	{value $f_name}
    }
    {from_date:text,optional
        {label {Da data valuta}}
	{html {length 20} }
	{value $from_date}
    }
    {to_date:text,optional
        {label {A data valuta}}
	{html {length 20} }
	{value $to_date}
    }
    {f_status:text(select),optional
        {options {{Tutti ""} {"Loaded" N} {"Pending" P} {"Chiuso" C} {"Deleted" D}}}
        {label "Stato"}
	{value $f_status}
    }
    {f_rec62_elab:text,optional
        {label {Cerca record 62}}
	{html {length 20} }
	{value $f_rec62_elab}
    }
    {f_rec63_1_elab:text,optional
        {label {Cerca primo record 63}}
	{html {length 20} }
	{value $f_rec63_1_elab}
    }
    {f_rec63_al_elab:text,optional
        {label {Cerca altri record 63}}
	{html {length 20} }
	{value $f_rec63_al_elab}
    }
} -on_request {

    if {$from_date eq ""} {
	db_1row from_dates "
            select to_char(current_date - interval '1 year', 'DD/MM/YYYY') as from_date,
                   to_char(current_date - interval '1 year', 'YYYY-MM-DD') as from_date_ansi"
    }

    if {$to_date eq ""} {
	set to_date        [ah::today_pretty]
	set to_date_ansi   [ah::today_ansi]
    }

} -on_submit {

    set errnum 0

    if {$from_date eq ""} {
	db_1row from_dates "
            select to_char(current_date - interval '1 year', 'DD/MM/YYYY') as from_date,
                   to_char(current_date - interval '1 year', 'YYYY-MM-DD') as from_date_ansi"
    }

    if {$to_date eq ""} {
	set to_date        [ah::today_pretty]
	set to_date_ansi   [ah::today_ansi]
    }

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
    ah::set_list_filters wallet admin/transfers-list

}

set page_title "Lista bonifici"
set context [list "$page_title"]

set bulk_actions {"Ripristina" transfer-reset   "Riporta un bonifico da stato 'D' a stato 'P'"
                  "Elabora"    transfer-process "Elabora un bonifico in stato 'L' o 'P'"
                  "Annulla"    transfer-delete  "Annulla un bonifico in stato 'L' o 'P'"
}

template::list::create \
    -name transfers \
    -multirow transfers \
    -bulk_actions $bulk_actions \
    -key transfer_id \
    -page_flush_p t \
    -page_size $rows_per_page \
    -page_groupsize 10 \
    -page_query {
	select t.transfer_id
        from  wal_transfers t
        where 1 = 1
        [template::list::filter_where_clauses -name transfers -and]
        [template::list::orderby_clause -name transfers -orderby]
    } \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" width="16" height="16" border="0">}
	    link_html {title "Modifica bonifico"}
	    sub_class narrow
	}
	filename {
	    label "Nome file"
	}
	reference {
	    label "Riferimento"
	}
	amount {
	    display_col amount_pretty
	    label "Importo"
            html {align right}
	    aggregate "sum"
	}
 	wallet_id {
	    label "Cod. Portafoglio"
	}
 	name {
	    label "Nominativo"
	}
 	iban_code {
	    label "Cod. IBAN"
	}
	status {
	    label "Stato"
            html {align center}
	}
	delete {
	    link_url_col delete_url 
            link_html {title "Annulla questo bonifico" onClick "return(confirm('Confermi annullamento?'));"}
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	    sub_class narrow
	}
    } \
    -orderby {
        default_value "transfer_id,desc"
        transfer_id {
	    label "Cronologico"
	    orderby_desc "transfer_id desc"
	    orderby_asc  "transfer_id"
            default_direction "desc"
	}
        filename {
	    label "Nome File"
	    orderby_desc "filename desc, transfer_id desc"
	    orderby_asc  "filename, transfer_id"
            default_direction "asc"
	}
        currency_date {
	    label "Data valuta"
	    orderby_desc "currency_date desc, transfer_id desc"
	    orderby_asc  "currency_date, transfer_id"
            default_direction "asc"
	}
        name {
	    label "Intestatario"
	    orderby_desc "name desc, transfer_id desc"
	    orderby_asc  "name, transfer_id"
            default_direction "asc"
	}
    } \
    -filters {
	f_filename {
	    hide_p 1
	    where_clause {upper(filename) like upper('%$f_filename%')}
	}
	f_name {
	    hide_p 1
	    where_clause {upper(name) like upper('%$f_name%')}
	}
	f_wallet_id {
	    hide_p 1
	    where_clause {wallet_id = :f_wallet_id}
	}
        from_date {
            hide_p 1
            where_clause {currency_date >= :from_date_ansi}
        }
        to_date {
            hide_p 1
            where_clause {currency_date <= :to_date_ansi}
        }
        from_date_ansi {hide_p 1}
        to_date_ansi {hide_p 1}
        f_status {
	    hide_p 1
	    where_clause {status = :f_status}
            default_value "P"
        }
	f_rec62_elab {
	    hide_p 1
	    where_clause {upper(rec62_elab) like upper('%$f_rec62_elab%')}
	}
	f_rec63_1_elab {
	    hide_p 1
	    where_clause {upper(rec63_1_elab) like upper('%$f_rec63_1_elab%')}
	}
	f_rec63_al_elab {
	    hide_p 1
	    where_clause {upper(rec63_al_elab) like upper('%$f_rec63_al_elab%')}
	}
        rows_per_page {
	    label "Righe per pagina"
  	    values {{10 10} {30 30} {100 100}}
            default_value 30
        }
    } 

# eseguo la query solo in assenza di errori nei filtri del form
if {![info exists errnum]} {
    db_multirow -extend {edit_url delete_url} transfers query "
	select t.transfer_id,
               t.filename, 
               t.reference,
               t.amount,
               ah_edit_num(t.amount, 2) as amount_pretty,
               t.wallet_id,
               t,name,
               t.iban_code,
               t.status
        from  wal_transfers t
        where 1 = 1
        [template::list::page_where_clause -name transfers -and]
        [template::list::orderby_clause -name transfers -orderby]
    " {
	
	set edit_url    [export_vars -base "transfer-edit" {transfer_id}]
	set delete_url  [export_vars -base "transfer-delete" {transfer_id}]
    }
} else {
    # creo una multirow fittizia 
    template::multirow create transfers dummy
} 

#if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property wallet admin/transfers-list [export_vars -entire_form -no_empty]
#}
