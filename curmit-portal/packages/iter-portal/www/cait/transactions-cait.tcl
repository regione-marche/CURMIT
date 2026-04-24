ad_page_contract {

    Lista movimenti di portafoglio.

    @author Claudio Pasolini
    @cvs-id $Id: transactions.tcl

    USER  DATA       MODIFICHE
    ===== ========== ===============================================================================================
    sim05 11/04/2017 Oltre all'impianto visualizzo anche il codice del dimp

    gab02 03/04/2017 Assegno un alias al body_id estratto nella multirow per evitare problemi con il relativo filtro

    sim04 23/11/2016 Corretto l'ordinamenteo sull'ente di riferimento

    gab01 10/11/2016 Aggiunto num_oridine alla lista per Reggio Calabria

    sim03 21/10/2016 Aggiunto link a transactions-complete che permette di completare
    sim03            con i dati del rea i movimenti accreditati.

    sim02 17/10/2016 Corretto filtro da data a data

    sim01 12/10/2016 Aggiunto filtro su campo status e description

} {
    {f_maintainer_id  ""}
    {f_name           ""}
    {f_wallet_id      ""}
    {from_date      ""}
    {to_date        ""}
    {from_date_ansi ""}
    {to_date_ansi   ""}
    {f_status       ""}
    {f_description  ""}

    {format         "normal"}
    {rows_per_page  "999999"}
    {offset         "0"}

    orderby:optional
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set page_title "Elenco movimenti"
set context [list  "$page_title"]

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :user_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}

# creates filters form
#sim01 aggiunto f_description e f_status. tolto da video e csv canale {}
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
        {f_description:text,optional
            {label {Causale}}
            {value $f_description}
        }

    } -on_request {

	if {$from_date eq ""} {
	    set from_date      [db_string from "select to_char(current_date - interval '1 month', 'DD/MM/YYYY')"]
	    set from_date_ansi [db_string ansi "select to_char(current_date - interval '1 month', 'YYYY-MM-DD')"]
	} else {;#sim02
	    #set from_date_ansi [db_string ansi "select to_char(:from_date, 'YYYY-MM-DD')"]
	    set from_date_ansi [iter_check_date $from_date]
	    set from_date_ansi "[string range $from_date_ansi 0 3]-[string range $from_date_ansi 4 5]-[string range $from_date_ansi 6 7]"
	}

	if {$to_date eq ""} {
	    set to_date        [ah::today_pretty]
	    set to_date_ansi   [ah::today_ansi]
	} else {;#sim02
	    set to_date_ansi [iter_check_date $to_date]
	    set to_date_ansi "[string range $to_date_ansi 0 3]-[string range $to_date_ansi 4 5]-[string range $to_date_ansi 6 7]"
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

	# recupero l'impostazione dei filtri non compresi nel form
	ah::set_list_filters iter-portal cait/transactions-cait

    }

set actions ""

source [ah::package_root -package_key ah-util]/paging-buttons.tcl

set link_gest [export_url_vars nome_funz nome_funz_caller caller f_maintainer_id f_name f_wallet_id from_date to_date from_date_ansi to_date_ansi f_status f_description]

set bulk_actions "" 
set actions   "{Inserisci nuovo versamento} transactions-cait-gest?$link_gest {Nuovo versamento}" 

set numero_accredito "num_reversale {} 
                          anno_reversale {}"


#sim01 aggiunto status_desc e description
#gab01 aggiunto num_ordine
template::list::create \
    -name transactions \
    -multirow transactions \
    -actions $actions \
    -selected_format $format \
    -bulk_actions $bulk_actions \
    -key tran_id \
    -elements {
	link_action {
	    display_template {@transactions.link_action;noquote@}
	}
	payment_date {
	    label "Data contabile"
	    display_template {<if @transactions.reason@ not nil><font color="red">@transactions.payment_date@</font></if><else>@transactions.payment_date@</else>}
	}
	currency_date {
	    label "Data accredito"
	}
	name {
	    label "Manut."
	}
	maintainer_id {
	    label "Cod. Manu."
	}
	wallet_id {
	    label "Cod. Portafoglio"
	}
        amount_plus {
	    label "Oper. di ricarica"
	    html {align right}
	}        
        tran_id {
	    label "Cod. op."
	    html {align right}
	}
	description {
	    label "Causale"
	    html {align right}
        }
	num_reversale {
	    label "Num. reversale"
	}
	anno_reversale {
	    label "Anno reversale"
	}
	cro {
	    label    "CRO"
	}
        num_ordine {
            label "Num. ordine"
        }
	status_desc {
	    label "Stato"
	    html {align right}
        }
        reason {
	    label "Causale dello storno"
	    html {align left}
	}
        ref_tran_id {
	    label "Cod. op. stornata"
	    html {align right}
	}
    } -filters {
	f_maintainer_id {
	    hide_p 1
	    where_clause {'MA' || lpad(cast(h.holder_id as varchar(10)),6,0) = :f_maintainer_id}
	}
	f_name {
	    hide_p 1
	    where_clause {upper(h.name) like upper('%[db_quote $f_name]%')}
	}
	f_wallet_id {
	    hide_p 1
	    where_clause {h.wallet_id = :f_wallet_id}
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
	f_status {
	    hide_p 1
            where_clause {m.status = :f_status}
	}
	f_description {
	    hide_p 1
            where_clause {upper(m.description) like upper('%[db_quote $f_description]%')}
	}
        rows_per_page {
	        label "Righe per pagina"
	    values {{10 10} {30 30} {100 100} {Tutte 999999}}
            default_value 30
        }
    }   \
    -orderby {
        default_value "payment_date,desc"
        name {
	    label "Nominativo Manutentore"
	    orderby_desc "h.name desc"
	    orderby_asc  "h.name"
            default_direction "asc"
	}       
        payment_date {
	    label "Data contabile"
	    orderby_desc "m.payment_date desc, tran_id desc"
	    orderby_asc  "m.payment_date, tran_id"
            default_direction "desc"
	}
        currency_date {
	    label "Data contabile"
	    orderby_desc "m.currency_date desc, tran_id desc"
	    orderby_asc  "m.currency_date, tran_id"
            default_direction "desc"
	}
    }  \
    -formats {
        normal {
            label "Video"
            layout table
            row {
		payment_date {}
		currency_date {}
		name {}
                maintainer_id {}
		wallet_id {}
                amount_plus {}
		tran_id {}
		status_desc {}
		description {}
		$numero_accredito
		cro {}
                reason {}
		ref_tran_id {}
            }
        }
        csv {
            label "Excel"
            output csv
            row {
                payment_date {}
		currency_date {}
		name {}
                holder_id {}
		wallet_id {}
                amount_plus {}
		tran_id {}
		status_desc {}
                description {}
		$numero_accredito
		cro {}
                reason {}
		ref_tran_id {}
            }
        }
    } 

# eseguo la query solo in assenza di errori nei filtri del form
if {![info exists errnum]} {
    #gab02 dalla query estraggo tutte le colonne della tabella wal_transactions senza usare m.* perchè devo dare un alias al body_id
    #gab02 select m.*, 
    set sql " 
        select m.tran_id,             --gab02
               m.holder_id,           --gab02
               m.tran_type_id,        --gab02
               m.pay_type_id,         --gab02
               m.payment_date,        --gab02
               m.creation_date,       --gab02
               m.currency_date,       --gab02
               m.description,         --gab02
               m.reference,           --gab02
               m.amount,              --gab02
               m.currency,            --gab02
               m.currency_amount,     --gab02
               m.filename,            --gab02
               m.reason,              --gab02
               m.ref_tran_id,         --gab02
               m.status,              --gab02
               m.num_reversale,       --gab02
               m.anno_reversale,      --gab02
               m.cro,                 --gab02
               m.num_ordine,          --gab02
              'MA' || lpad(cast(h.holder_id as varchar(10)),6,0) as maintainer_id,
              h.name, h.source_id
              ,h.wallet_id
              ,case when status = 'L' then 'In lavorazione'
                    when status = 'A' then 'Accreditato'
                    when status = 'K' then 'Annullato'
                end as status_desc
        from wal_transactions_cait m
        left join iter_instances i  --sim04
                  on i.instance_name = split_part(m.reference,' ',2) --sim04 
        left join groups g  --sim04
                  on i.instance_id   = g.group_id --sim04
           , wal_holders h
       where m.holder_id = h.holder_id
        [template::list::filter_where_clauses -name transactions -and]
        [template::list::orderby_clause -name transactions -orderby]
        limit $rows_per_page
        offset $offset"

    #ns_log notice $sql

    db_multirow \
	-extend {amount_plus link_action} \
	transactions query "$sql" {

	if {$status eq "A" && $tran_type_id == 1} {;#sim03
	    set link_action "<a href=\"transactions-cait-complete?tran_id=$tran_id&$link_gest\">Completa</a>"
	} else {
	    set link_action ""
	}


        # edito date e campi numerici
	set amount_pretty [ah::edit_num $amount 2]
        set payment_date  [string range $payment_date 8 9]/[string range $payment_date 5 6]/[string range $payment_date 0 3]
        set currency_date [string range $currency_date 8 9]/[string range $currency_date 5 6]/[string range $currency_date 0 3]

	if {$tran_type_id == 1} {
            # ricarica
            set amount_plus          $amount_pretty
        } else {
	    set amount_plus          [expr $amount * -1.00]
            set amount_plus          [ah::edit_num $amount_plus]
	}

	set dichiarazione_url [export_vars -base "#" {cod_dimp}]
	set impianto_url      [export_vars -base "#" {cod_impianto}]

    }

    # calcolo i totali periodo
    if {[db_0or1row tot_periodo "
        select
            coalesce(round(sum(case when tran_type_id = 1 then amount else 0 end), 2), 0.00) as carico_portafoglio_man_periodo
           ,coalesce(round(sum(case when tran_type_id = 2 then amount else 0 end), 2), 0.00) as storno_portafoglio_man_periodo
        from wal_transactions_cait m, wal_holders h
        where m.holder_id = h.holder_id
          and coalesce(m.status,'') = 'A' --sim01
        [template::list::filter_where_clauses -name transactions -and]
    "]} {
	
     # calcolo i campi derivati
 	set saldo_portafoglio_man_periodo  [expr $carico_portafoglio_man_periodo - $storno_portafoglio_man_periodo]
	set carico_portafoglio_man_periodo [ah::edit_num $carico_portafoglio_man_periodo 2]
	set storno_portafoglio_man_periodo [ah::edit_num $storno_portafoglio_man_periodo 2]
	set saldo_portafoglio_man_periodo  [ah::edit_num $saldo_portafoglio_man_periodo 2]
    } else {
	set saldo_portafoglio_man_periodo  0,00
	set carico_portafoglio_man_periodo 0,00
	set storno_portafoglio_man_periodo 0,00
    }

    # calcolo i totali generali
    db_0or1row tot_gen "
        select
            coalesce(round(sum(case when tran_type_id = 1 then amount else 0 end), 2), 0.00) as carico_portafoglio_man_gen
           ,coalesce(round(sum(case when tran_type_id = 2 then amount else 0 end), 2), 0.00) as storno_portafoglio_man_gen
        from wal_transactions_cait m
        where coalesce(m.status,'') = 'A' --sim01"

    # calcolo i campi derivati
    set saldo_portafoglio_man_gen [expr $carico_portafoglio_man_gen - $storno_portafoglio_man_gen]
    # edito tutti i campi
    set saldo_portafoglio_man_gen  [ah::edit_num $saldo_portafoglio_man_gen 2]
    set carico_portafoglio_man_gen [ah::edit_num $carico_portafoglio_man_gen 2]
    set storno_portafoglio_man_gen [ah::edit_num $storno_portafoglio_man_gen 2]

} else {
    # creo una multirow fittizia 
    template::multirow create transactions dummy
} 

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property iter-portal cait/transactions-cait [export_vars -entire_form -no_empty]
}

if {[string equal $format "csv"]} {
    template::list::write_csv -name transactions
    ad_script_abort
}

