ad_page_contract {

    Lista movimenti di portafoglio.

    @author Gacalin Lufi & Luca Romitti
    @cvs-id $Id: transactions-print-filter.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim01 15/11/2019 Dato che gli utenti amministratori degli enti possono vedere solo il loro portafoglio,
    sim01            ho dovuto gestirlo tramite la nuova tabella mpay_enti_portafogli_abilitati

    gac01 04/10/2017 Creati filtri

} {
    {f_maintainer_id  ""}
    {f_name           ""}
    {f_group_id        ""}
    {from_date        ""}
    {to_date          ""}
    {from_date_ansi   ""}
    {to_date_ansi     ""}
   
    {format     "normal"}
    {rows_per_page  "30"}
    {offset          "0"}

    orderby:optional
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set page_title "Stampa movimenti"
set context [list  "$page_title"]

# imposto codice Regione Lombardia come utilizzato nei movimenti
set id_regione "3"

#sim01 verifico se l'utente ha delle limitazioni
set istanze_limitate [list];#sim01

set istanze_limitate [db_list q "select instance_name 
                                       from mpay_enti_portafogli_abilitati a
                                          , users b
                                      where a.username = b.username
                                        and b.user_id  = :user_id"];#sim01
if {[llength $istanze_limitate]>0} {#sim01 if else e loro contenuto
    set where_istanze "and i.instance_name in ('[join $istanze_limitate ',']')"
} else {
    set where_istanze ""
}


# creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Stampa" go]] \
    -form {
	{f_maintainer_id:text,optional
	    {label {Cod. Manut.}}
	    {value $f_maintainer_id}
	}
	{f_name:text,optional
	    {label {Nominativo Manut.}}
	    {value $f_name}
	}
	{f_group_id:text(select)
	    {options { {"Tutti" ""} [db_list_of_lists query "
            select g.group_name,g.group_id
                from iter_instances i, groups g
                where i.instance_id   = g.group_id
                   $where_istanze --sim01
            "] }}
	    {value ""}
	    {label {Ente locale di riferimento}}
	}
	{from_date:text,optional
	    {label {Da data movimento}}
	    {value $from_date}
	}
	{to_date:text,optional
	    {label {A data movimento}}
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

	set link_gest [export_url_vars f_maintainer_id f_name f_group_id from_date from_date_ansi to_date to_date_ansi nome_funz nome_funz_caller]
	set return_url "transactions-print?$link_gest"
	
	ad_returnredirect $return_url
	ad_script_abort


    }

