ad_page_contract {

    Lista movimenti di portafoglio.

    @author Simone Pesci
    @cvs-id $Id: transactions-filter.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim02 24/09/2019 Dato che gli utenti amministratori degli enti possono vedere solo il loro portafoglio,
    sim02            ho dovuto gestirlo tramite la nuova tabella mpay_enti_portafogli_abilitati

    gab02 09/04/2018 Aggiunto filtro f_ente_portafoglio visibile solo se è presente la gestione
    gab02            del multiportafoglio

    gab01 12/07/2017 Aggiunto filtro f_tipo_mov

    sim01 12/10/2016 Aggiunto filtro su campo status e description

} {
    {f_maintainer_id  ""}
    {f_name           ""}
    {f_wallet_id      ""}
    body_id:optional
    {from_date           ""}
    {to_date             ""}
    {from_date_ansi      ""}
    {to_date_ansi        ""}
    {f_status            ""}
    {f_tipo_mov          ""}
    {f_description       ""}
    {f_ente_portafoglio  ""}

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

set sw_multi_portafoglio [parameter::get_from_package_key -package_key wallet -parameter sw_multi_portafoglio -default 0];#gab02

# creates filters form
#gab02 aggiunto f_ente_portafoglio
#gab01 aggiunto f_tipo_mov
#sim01 aggiunto status e description
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{f_maintainer_id:text,optional
	    {label {Cod. Manut.}}
	    {value $f_maintainer_id}
	}
	{f_name:text,optional
	    {label {Nominativo Manut.}}
	    {value $f_name}
	}
	{f_wallet_id:text,optional
	    {label {Codice portafoglio}}
	    {value $f_wallet_id}
	}
    }

if {$sw_multi_portafoglio} {

    #sim02 verifico se l'utente ha delle limitazioni
    set istanze_limitate [list];#sim02

    set istanze_limitate [db_list q "select instance_name 
                                       from mpay_enti_portafogli_abilitati a
                                          , users b
                                      where a.username = b.username
                                        and b.user_id  = :user_id"];#sim02
    if {[llength $istanze_limitate]>0} {#sim02 if else e loro contenuto
	set where_istanze "and i.instance_name in ('[join $istanze_limitate ',']')"
    } else {
	set where_istanze ""
    }
    
    ad_form -extend -name filter -form { 
	{f_ente_portafoglio:text(select)
	    {options { {"Scegli" ""} [db_list_of_lists query "
            select g.group_name, i.instance_name
              from groups g, iter_instances i
             where g.group_id = i.instance_id
                 $where_istanze --sim02
            "] }}
	    {label {Ente portafoglio}}
	}
    }
}

ad_form -extend -name filter -form {
        {body_id:text(select),optional
	    {options { {"Tutti" ""} [db_list_of_lists query "
            select body_name, body_id
            from wal_bodies
            order by body_name
            "] }}
	    {value ""}
	    {label {Ente competente}}
	}
	{from_date:text,optional
	    {label {Da data movimento}}
	    {value $from_date}
	}
	{to_date:text,optional
	    {label {A data movimento}}
	    {value $to_date}
	}
	{f_status:text(select),optional
            {options { {"Tutti" ""} {"In lavorazione" "L"} {"Accreditato" "A"} {"Annullato" "K"} }}
	    {label {Stato}}
	    {value $f_status}
	}
	{f_tipo_mov:text(select),optional
	    {options { {"Tutti" ""} {"Attivi" "1"} {"Passivi" "2"} }}
            {label {Tipo movimento}}
            {value $f_tipo_mov}
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
	set link_gest [export_url_vars f_maintainer_id f_name f_wallet_id f_ente_portafoglio body_id from_date to_date f_status f_tipo_mov f_description nome_funz nome_funz_caller];#sim01;#gab01;#gab02
	set return_url "transactions?$link_gest"
	
	ad_returnredirect $return_url
	ad_script_abort


    }

