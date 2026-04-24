ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: trustees-list.tcl

    USER  DATA       MODIFICHE
    ===== ========== =================================================================================================
    mat01 22/08/2025 Aggiunto l'attributo "alt" alle incone del modifica e dell'elimina nella lista. Tolto il tag <font>.
    mat01            e sostituito con <span>.
    mat01            Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)

    

} {
    {search_name ""}
    {search_fiscal_code ""}
    {search_iva_code ""}
    {search_city ""}
    {search_province ""}
    {from_date ""}
    {to_date ""}
    {from_date_ansi ""}
    {to_date_ansi ""}
    {f_validated_p ""}
    {rows_per_page     30}
    orderby:optional
    page:optional
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set page_title "Amministratori registrati"
set context [list "$page_title"]

# creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{search_name:text,optional
	    {label {Cerca ragione sociale }}
	    {html {length 20} }
	    {value $search_name}
	}
	{search_fiscal_code:text,optional
	    {label {Cerca codice fiscale }}
	    {html {length 20} }
	    {value $search_fiscal_code}
	}
	{search_iva_code:text,optional
	    {label {Cerca partita IVA }}
	    {html {length 20} }
	    {value $search_iva_code}
	}
	{search_city:text,optional
	    {label {Cerca Comune}}
	    {html {length 20} }
	    {value $search_city}
	}
	{search_province:text(select),optional
	    {options {{Tutte ""} [db_list_of_lists prov "select distinct province, province as dummy from iter_trustees order by province"]}}
	    {label {Cerca provincia }}
	    {value $search_province}
	}

	{from_date:text,optional
	    {label {Da data registrazione}}
	    {html {length 20} }
	    {value $from_date}
	}
	{to_date:text,optional
	    {label {A data registrazione}}
	    {html {length 20} }
	    {value $to_date}
	}
	{f_validated_p:text(select),optional
	    {options {{Tutti ""} {Si t} {No f}}}
	    {label "Validato?"}
	    {value $f_validated_p}
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
    ah::set_list_filters iter-portal trustees-list

}


set actions ""

#mat01 aggiunto a edit e delete l'attributo alt, nel loro display template
#mat01 sostituito i tag font in "name" con i tag span per usare i diversi colori
template::list::create \
    -name trustees \
    -multirow trustees \
    -actions $actions \
    -page_flush_p t \
    -page_size $rows_per_page \
    -page_groupsize 10 \
    -page_query {
        select trustee_id
        from iter_trustees m
        where 1 = 1
        [template::list::filter_where_clauses -name trustees -and]
        [template::list::orderby_clause -name trustees -orderby]
    } \
    -key trustee_id \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" alt="Modifica amministratore" width="16" height="16" border="0">}
	    link_html {title "Modifica amministratore"}
	    sub_class narrow
	}
	name {
	    label "Ragione Sociale"
            display_template {<if @trustees.validated_p@ true><span style="color:green">@trustees.name@</span></if><else><span style="color:red">@trustees.name@</span></else>}
	}
	creation_date {
	    label "Data reg."
            display_col creation_date_pretty
	}
	city {
	    label "Comune"
	}
	province {
	    label "Provincia"
            html {align center}
	}
        iva_code {
	    label "Partita IVA"
	}
        wallet_id {
	    label "Codice portafoglio"
	    link_url_col ec_url 
            link_html {title "Visualizza Estratto Conto"}
	}
	phone {
	    label "Telefono"
	}
	email {
	    label "E-mail"
	}
	office_mail {
	    label "St. associato"
	}
	azioni {
	    label "Azioni"
            display_template {<a href="send-mail-trustee?trustee_id=@trustees.trustee_id@&office_id=@trustees.office_id@">Mail</a>}
	    html "align left"
	}
	delete {
	    link_url_col delete_url 
            link_html {title "Cancella amministratore" onClick "return(confirm('Confermi la cancellazione?'));"}
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" alt="Cancella amministratore" width="16" height="16" border="0">}
	    sub_class narrow
	}
    }  \
    -orderby {
        default_value "name,desc"
        city {
	    label "Comune"
	    orderby_desc "m.city desc"
	    orderby_asc  "m.city"
            default_direction "asc"
	}
        province {
	    label "Provincia"
	    orderby_desc "m.province desc"
	    orderby_asc  "m.province"
            default_direction "asc"
	}
        name {
	    label "Ragione sociale"
	    orderby_desc "m.name desc"
	    orderby_asc  "m.name"
            default_direction "asc"
	}
        creation_date {
	    label "Data registrazione"
	    orderby_desc "m.creation_date desc"
	    orderby_asc  "m.creation_date"
            default_direction "desc"
	}

    } \
    -filters {
	search_name {
	    hide_p 1
	    where_clause {upper(m.name) like upper('%$search_name%')}
	}
	search_fiscal_code {
	    hide_p 1
	    where_clause {upper(m.fiscal_code) like upper('%$search_fiscal_code%')}
	}
	search_iva_code {
	    hide_p 1
	    where_clause {upper(m.iva_code) like upper('%$search_iva_code%')}
	}
	search_city {
	    hide_p 1
	    where_clause {upper(m.city) like upper('%$search_city%')}
	}
	search_province {
	    hide_p 1
	    where_clause {m.province = :search_province}
	}
        from_date {
            hide_p 1
            where_clause {m.creation_date >= :from_date_ansi}
        }
        to_date {
            hide_p 1
            where_clause {m.creation_date <= :to_date_ansi}
        }
        from_date_ansi {hide_p 1}
        to_date_ansi {hide_p 1}
        f_validated_p {
	    hide_p 1
	    where_clause {m.validated_p = :f_validated_p}
        }
        rows_per_page {
	    label "Righe per pagina"
	    values {{10 10} {30 30} {100 100}}
            default_value 30
        }
    } 

# eseguo la query solo in assenza di errori nei filtri del form
if {![info exists errnum]} {

    db_multirow -extend {edit_url ec_url delete_url} trustees query "
        select
            trustee_id
           ,m.name
           ,to_char(m.creation_date, 'DD/MM/YYYY') as creation_date_pretty
           ,m.city
           ,m.province
           ,m.iva_code
           ,m.fiscal_code
           ,m.wallet_id
           ,m.phone
           ,m.validated_p 
           ,m.email
           ,m.office_id
           ,c.email as office_mail
        from iter_trustees m left outer join iter_offices c on c.office_id = m.office_id
        where 1 = 1
        [template::list::page_where_clause -name trustees -and]
        [template::list::orderby_clause -name trustees -orderby]
    " {
	set edit_url   [export_vars -base "trustee-edit" {trustee_id}]
	set ec_url     [export_vars -base "../ec" {trustee_id}]
	set delete_url [export_vars -base "trustee-delete"   {trustee_id}]
	
    }
} else {
    # creo una multirow fittizia 
    template::multirow create trustees dummy
} 

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property iter-portal trustees-list [export_vars -entire_form -no_empty]
}
