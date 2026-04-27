ad_page_contract {

    Lista movimenti di portafoglio.

    @author Simone Pesci
    @cvs-id $Id: recharge-cait-filter.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================

} {
    {from_date      ""}
    {to_date        ""}
    {from_date_ansi ""}
    {to_date_ansi   ""}
    {f_description  ""}

    {format         "normal"}
    {rows_per_page  "30"}
    {offset         "0"}

    orderby:optional
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set page_title "Elenco movimenti"
set context [list  "$page_title"]

# imposto codice Regione Lombardia come utilizzato nei movimenti
set id_regione "3"

# creates filters form
#sim01 aggiunto status e description
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{from_date:text,optional
	    {label {Da data movimento}}
	    {value $from_date}
	}
	{to_date:text,optional
	    {label {A data movimento}}
	    {value $to_date}
	}
	{f_description:text,optional
	    {label {Causale}}
	    {value $f_description}
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

	if {$from_date eq ""} {
	    set from_date "01/01/2008"
	}

	if {$to_date eq ""} {
	    set to_date "01/01/2100"
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

    } -after_submit {

#sim01	set link_gest [export_url_vars maintainer_id name wallet_id body_id from_date to_date nome_funz nome_funz_caller]
	set link_gest [export_url_vars from_date to_date f_description nome_funz nome_funz_caller];#sim01
	set return_url "recharge-cait?$link_gest"
	
	ad_returnredirect $return_url
	ad_script_abort


    }

