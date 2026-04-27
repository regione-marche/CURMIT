ad_page_contract {

    Lista movimenti di portafoglio.

    @author Claudio Pasolini
    @cvs-id $Id: transactions.tcl

    USER  DATA       MODIFICHE
    ===== ========== ===============================================================================================
    rom02 17/01/2023 Corretta label campo potenza su segnalazione di Benevento.

    rom01 30/11/2022 Data possibilita' di estrarre la lista in csv.
    rom01.bis        Rinominata colonna con il nome dei manutentori da name a name_manu, dava problemi al nome del file csv.

    gab04 09/04/2018 Aggiunto filtro f_ente_portafoglio in caso di gestione del multiportafoglio.

    sim07 08/05/2018 Aggiunto la possibilità di ordinare per Cod. op.

    gab03 12/07/2017 Aggiunto filtro f_tipo_mov

    sim06 26/06/2017 Aggiunto possibilità di richiamare la lista filtrata per tran_id

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
    body_id:optional
    {from_date           ""}
    {to_date             ""}
    {from_date_ansi      ""}
    {to_date_ansi        ""}
    {f_status            ""}
    {f_tipo_mov          ""}
    {f_description       ""}
    {f_tran_id           ""}
    {f_ente_portafoglio  ""}

    {format         "normal"}
    {rows_per_page  "999999"}
    {offset         "0"}

    orderby:optional
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set sw_multi_portafoglio [parameter::get_from_package_key -package_key wallet -parameter sw_multi_portafoglio -default 0];#gab04

if {$sw_multi_portafoglio} {;#gab04 aggiunta if, else e contenuto
    set join_multi_portafoglio "and h.instance_name = m.instance_name"
    set where_multi_portafoglio "h.instance_name = :f_ente_portafoglio"
    set where_multiportafoglio_tot_compless "and m.instance_name = :f_ente_portafoglio"

    if {![db_0or1row q "select g.group_name as nome_ente_portafoglio
                          from groups g
                             , iter_instances i
                         where g.group_id = i.instance_id
                           and i.instance_name = :f_ente_portafoglio"]} {

	ad_returnredirect -message "ATTENZIONE! E' necessario selezionare un ente portafoglio" transactions-filter
	ad_script_abort
	
    }


} else {
    set where_multi_portafoglio ""
    set join_multi_portafoglio  ""
    set nome_ente_portafoglio   ""
}

set page_title "Elenco movimenti $nome_ente_portafoglio"
set context [list  "$page_title"]

# imposto codice Regione Lombardia come utilizzato nei movimenti
set id_regione "3"

# determino source_id dei soggetti provenienti da CENED
set cened_source_id [db_string cened "select source_id from wal_sources where source_name = 'CENED'"]

set database [db_get_database];#gab01

# creates filters form
#gab04 aggiunto filtro f_ente_portafoglio
#gab03 aggiunto filtro f_tipo_mov
#sim01 aggiunto f_description e f_status. tolto da video e csv canale {}
#sim06 aggiunto f_tran_id
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
    ad_form -extend -name filter -form {
	{f_ente_portafoglio:text(select)
	    {options { {"Scegli" ""} [db_list_of_lists query "
            select g.group_name, i.instance_name
              from groups g, iter_instances i
             where g.group_id = i.instance_id
            "] }}
	    {label {Ente portafoglio}}
            {value $f_ente_portafoglio}
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
	{f_tran_id:text,optional
	    {value $f_tran_id}
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
	ah::set_list_filters iter-portal admin/transactions

    }

set actions ""

source [ah::package_root -package_key ah-util]/paging-buttons.tcl

#gab04 aggiunto f_ente_portafoglio
#gab03 aggiunto f_tipo_mov
#sim06 aggiunto f_tran_id
set link_gest [export_url_vars nome_funz nome_funz_caller caller f_maintainer_id f_name f_wallet_id f_ente_portafoglio body_id from_date to_date from_date_ansi to_date_ansi f_status f_tipo_mov f_description f_tran_id]

set bulk_actions { "Storna Movimento di Portafoglio" storno "Storno Movimento di Portafoglio" }
set actions   "{Inserisci nuovo versamento compensazione bollini} transactions-gest?$link_gest {Nuovo versamento}" 
append actions " {Estrai in csv} transactions?$link_gest&format=csv&rows_per_page=999999 {Estrai in csv}";#rom01


if {$database eq "iter-portal-prrc"} {;#gab01 if e else e loro contenuto
    set numero_accredito "num_ordine {}"
} else {
    
    set numero_accredito "num_reversale {} 
                          anno_reversale {}"
}

#gab04 aggiunto f_ente_portafoglio ai filtri e bulk_action_export_vars
#gab03 aggiunto f_tipo_mov ai filtri
#sim01 aggiunto status_desc e description
#gab01 aggiunto num_ordine
#sim06 aggiunto f_tran_id
#sim07 aggiunto ordinamento su tran_id
template::list::create \
    -name transactions \
    -multirow transactions \
    -actions $actions \
    -selected_format $format \
    -bulk_actions $bulk_actions \
    -bulk_action_export_vars {
	f_ente_portafoglio
    } \
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
	name_manu {
	    label "Manut."
	}
	maintainer_id {
	    label "Cod. Manu."
	}
	wallet_id {
	    label "Cod. Portafoglio"
	}
	body_name {
	    label "Ente locale di riferim."
	}
	cod_impianto_est {
	    label "Cod. imp."
	}
        potenza {
	    label "Pot. erogata (kW)"
	}
        amount_plus {
	    label "Oper. di ricarica"
	    html {align right}
	}
        canale {
	    label "Canale di ricarica"
	}
        amount_minus_regione {
	    label "Contrib. Regione"
	    html {align right}
	}
        amount_minus_regione_c {
	    label "Conguaglio Regione"
	    html {align right}
	}
        amount_minus_ente {
	    label "Contr. Ente Locale"
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
	f_tran_id {
	    hide_p 1
	    where_clause {m.tran_id = :f_tran_id}
	}
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
        f_ente_portafoglio {
            hide_p 1
            where_clause {$where_multi_portafoglio}
        }
	body_id {
	    hide_p 1
	    where_clause {m.body_id = :body_id}
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
	f_tipo_mov {
            hide_p 1
            where_clause {m.tran_type_id = :f_tipo_mov}
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
        name_manu {
	    label "Nominativo Manutentore"
	    orderby_desc "h.name desc"
	    orderby_asc  "h.name"
            default_direction "asc"
	}
        body_name {
	    label "Ente locale"
	    orderby_desc "g.group_name desc"
	    orderby_asc  "g.group_name"
            default_direction "asc"
	}
        payment_date {
	    label "Data contabile"
	    orderby_desc "m.payment_date desc"
	    orderby_asc  "m.payment_date"
            default_direction "desc"
	}
        currency_date {
	    label "Data contabile"
	    orderby_desc "m.currency_date desc"
	    orderby_asc  "m.currency_date"
            default_direction "desc"
	}
	tran_id {
            label "Cod. op."
	    orderby_desc "m.tran_id desc"
	    orderby_asc  "m.tran_id"
	    default_direction "desc"
        }
    }  \
    -formats {
        normal {
            label "Video"
            layout table
            row {
                checkbox {}
		link_action {}
                payment_date {}
		currency_date {}
		name_manu {}
                maintainer_id {}
		wallet_id {}
		body_name {}
		cod_impianto_est {}
		potenza {}
                amount_plus {}
		amount_minus_ente {}
		amount_minus_regione {}
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
		name_manu {}
                maintainer_id {}
		wallet_id {}
		body_name {}
		cod_impianto_est {}
		potenza {}
                amount_plus {}
		amount_minus_regione {}
		amount_minus_regione_c {}
		amount_minus_ente {}
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
               m.body_id as body_id_multi, --gab02
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
              h.name as name_manu, h.source_id
              ,h.wallet_id
              ,case when status = 'L' then 'In lavorazione'
                    when status = 'A' then 'Accreditato'
                    when status = 'K' then 'Annullato'
                end as status_desc
        from wal_transactions m
        left join iter_instances i  --sim04
                  on i.instance_name = split_part(m.reference,' ',2) --sim04 
        left join groups g  --sim04
                  on i.instance_id   = g.group_id --sim04
           , wal_holders h
       where m.holder_id = h.holder_id
        $join_multi_portafoglio
        [template::list::filter_where_clauses -name transactions -and]
        [template::list::orderby_clause -name transactions -orderby]
        limit $rows_per_page
        offset $offset"

    #ns_log notice $sql

    db_multirow \
	-extend {body_name cod_impianto_est potenza amount_plus amount_minus_regione amount_minus_ente canale amount_minus_regione_c link_action} \
	transactions query "$sql" {

	set cod_impianto_est ""
	set potenza          ""
	set canale           ""


	if {$status eq "L"} {;#sim01
	    set link_action "<a href=\"transactions-approve?tran_id=$tran_id&accredita_p=t&$link_gest\">Accredita</a>"
	    append link_action " <a href=\"transactions-approve?tran_id=$tran_id&accredita_p=f&$link_gest\">Annulla</a>"

	    #se sono di MPAY non posso fare nessuna azione
	    if {[db_0or1row q "select 1 from mpay_paymentrequest where tran_id=:tran_id limit 1"]} {
		set link_action ""
	    }
	    
	} elseif {$status eq "A" && $tran_type_id == 1} {;#sim03
	    set link_action "<a href=\"transactions-complete?tran_id=$tran_id&$link_gest\">Completa</a>"
	} else {
	    set link_action ""
	}
        # devo identificare i movimenti provenienti da iter, che hanno il campo reference contenente
        # codice dichiarazione e nome del database

        if {[llength $reference] == 2 && [string range [lindex $reference 1] 0 3] eq "iter"} {
	    # dovrebbe essere un movimento generato da iter
	    util_unlist $reference cod_dimp dbn

	    # determino l'ente di competenza in base all'istamza Iter
	    set body_name [db_string ente "
                select g.group_name
                from iter_instances i, groups g
                where i.instance_name = :dbn
                  and i.instance_id   = g.group_id" -default ""]

	    # leggo i dati da iter, se ho ottenuto un dbn
	    if {$dbn ne ""} {

		if {![db_0or1row -dbn $dbn iter "
                select i.cod_impianto_est || '/' || cod_dimp as cod_impianto_est --sim05
                   --sim05 i.cod_impianto_est
                      ,i.potenza
                from coimdimp d, coimaimp i
                where d.cod_dimp         = :cod_dimp
                  and d.cod_impianto     = i.cod_impianto
                "]} {

# prendo l'impianto passando da coimdimp_stn se coimdimp è stato stornato
		    if {![db_0or1row -dbn $dbn iter "
                            select i.cod_impianto_est
                                     ,i.potenza
                                  from coimdimp_stn d, coimaimp i
                             where d.cod_dimp         = :cod_dimp
                         and d.cod_impianto     = i.cod_impianto
                    "]} {
			# scarto i movimenti provenienti da iter per i quali non trovo l'impianto
                     # B80 *** 07/07/2010 andrebbe commentato il continue in modo da visualizzare i movimenti che corrispondono a dichiarazioni non inserite - DB CRASH
			# continue
		    }
		}
	    } else {

                # scarto i movimenti provenienti da iter per i quali non dispongo del database
                continue
	    }
	}

        if {$source_id eq "$cened_source_id"} {
	    set cod_impianto_est $reference
	}

        # edito date e campi numerici
	set amount_pretty [ah::edit_num $amount 2]
        set payment_date  [string range $payment_date 8 9]/[string range $payment_date 5 6]/[string range $payment_date 0 3]
        set currency_date [string range $currency_date 8 9]/[string range $currency_date 5 6]/[string range $currency_date 0 3]

        if {$tran_type_id == 1} {
            # ricarica
	    set amount_plus          $amount_pretty
	    set amount_minus_regione ""
	    set amount_minus_ente    ""
	    set amount_minus_regione_c

	    # isolo il canale di provenienza
	    if {[string range $filename 0 4] eq "LOTTO"} {
		set canale "Lottomatica"
	    } elseif {[string range $filename 0 2] eq "RH_"} {
		set canale "Bonifico"
	    } else {
		set canale "Non definito"
	    }
	} else {
            set amount_plus_pretty ""
            #gab02 uso il body_id_multi nella query 
            #gab02 if {$body_id == $id_regione}
	    if {$body_id_multi == $id_regione} {
		if {$description eq "CONGUAGLIO"} {
		    set amount_minus_regione_c $amount_pretty
		    set amount_minus_regione ""
		} else {
		    set amount_minus_regione $amount_pretty
		    set amount_minus_regione_c ""
		}			
		set amount_minus_ente    ""
	    } else {
		set amount_minus_regione ""
		set amount_minus_regione_c ""
		set amount_minus_ente    $amount_pretty
	    }
	}

	set dichiarazione_url [export_vars -base "#" {cod_dimp}]
	set impianto_url      [export_vars -base "#" {cod_impianto}]

    }

    ns_log notice "simone  [template::list::filter_where_clauses -name transactions -and]"

    # calcolo i totali periodo
    if {[db_0or1row tot_periodo "
        select
            coalesce(round(sum(case when tran_type_id = 1 and body_id is null then amount else 0 end), 2), 0.00) as carico_portafoglio_periodo
           ,coalesce(round(sum(case when tran_type_id = 1 and body_id = 3 then amount else 0 end), 2), 0.00) as storno_regione_periodo
           ,coalesce(round(sum(case when tran_type_id = 1 and body_id is not null and body_id <> 3 then amount else 0 end), 2), 0.00) as storno_enti_periodo
           ,coalesce(round(sum(case when tran_type_id = 2 and body_id = 3 then amount else 0 end), 2), 0.00) as debito_regione_periodo
           ,coalesce(round(sum(case when tran_type_id = 2 and coalesce(body_id,0) <> 3 then amount else 0 end), 2), 0.00) as debito_enti_periodo
        from wal_transactions m, wal_holders h
        where m.holder_id = h.holder_id
              $join_multi_portafoglio
          and coalesce(m.status,'') = 'A' --sim01
        [template::list::filter_where_clauses -name transactions -and]
    "]} {
	
     # calcolo i campi derivati
 	set saldo_regione_periodo      [expr $debito_regione_periodo - $storno_regione_periodo]
	set saldo_enti_periodo         [expr $debito_enti_periodo - $storno_enti_periodo]
	set credito_residuo_periodo    [expr ($carico_portafoglio_periodo + $storno_regione_periodo + $storno_enti_periodo) - ($debito_regione_periodo + $debito_enti_periodo)]
	# edito tutti i campi
	set carico_portafoglio_periodo [ah::edit_num $carico_portafoglio_periodo 2]
	set storno_regione_periodo     [ah::edit_num $storno_regione_periodo 2]
	set storno_enti_periodo        [ah::edit_num $storno_enti_periodo 2]
	set debito_regione_periodo     [ah::edit_num $debito_regione_periodo 2]
	set debito_enti_periodo        [ah::edit_num $debito_enti_periodo 2]
 	set saldo_regione_periodo      [ah::edit_num $saldo_regione_periodo 2]
	set saldo_enti_periodo         [ah::edit_num $saldo_enti_periodo 2]
	set credito_residuo_periodo    [ah::edit_num $credito_residuo_periodo 2]
    } else {
	set carico_portafoglio_periodo 0,00
	set storno_regione_periodo     0,00
	set storno_enti_periodo        0,00
	set debito_regione_periodo     0,00
	set debito_enti_periodo        0,00
	set saldo_regione_periodo      0,00
	set saldo_enti_periodo         0,00
	set credito_residuo_periodo    0,00
    }

    # calcolo i totali generali
    db_0or1row tot_gen "
        select
            coalesce(round(sum(case when tran_type_id = 1 and body_id is null then amount else 0 end), 2), 0.00) as carico_portafoglio_gen
           ,coalesce(round(sum(case when tran_type_id = 1 and body_id = 3 then amount else 0 end), 2), 0.00) as storno_regione_gen
           ,coalesce(round(sum(case when tran_type_id = 1 and body_id is not null and body_id <> 3 then amount else 0 end), 2), 0.00) as storno_enti_gen
           ,coalesce(round(sum(case when tran_type_id = 2 and body_id = 3 then amount else 0 end), 2), 0.00) as debito_regione_gen
           ,coalesce(round(sum(case when tran_type_id = 2 and coalesce(body_id,0) <> 3 then amount else 0 end), 2), 0.00) as debito_enti_gen
        from wal_transactions m
        where coalesce(m.status,'') = 'A' --sim01
          $where_multiportafoglio_tot_compless --gab04"

    # calcolo i campi derivati
    set saldo_regione_gen      [expr $debito_regione_gen - $storno_regione_gen]
    set saldo_enti_gen         [expr $debito_enti_gen - $storno_enti_gen]
    set credito_residuo_gen    [expr ($carico_portafoglio_gen + $storno_regione_gen + $storno_enti_gen) - ($debito_regione_gen + $debito_enti_gen)]
    # edito tutti i campi
    set carico_portafoglio_gen [ah::edit_num $carico_portafoglio_gen 2]
    set storno_regione_gen     [ah::edit_num $storno_regione_gen 2]
    set storno_enti_gen        [ah::edit_num $storno_enti_gen 2]
    set debito_regione_gen     [ah::edit_num $debito_regione_gen 2]
    set debito_enti_gen        [ah::edit_num $debito_enti_gen 2]
    set saldo_regione_gen      [ah::edit_num $saldo_regione_gen 2]
    set saldo_enti_gen         [ah::edit_num $saldo_enti_gen 2]
    set credito_residuo_gen    [ah::edit_num $credito_residuo_gen 2]

} else {
    # creo una multirow fittizia 
    template::multirow create transactions dummy
} 

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property iter-portal admin/transactions [export_vars -entire_form -no_empty]
}

if {[string equal $format "csv"]} {
    template::list::write_csv -name transactions
    ad_script_abort
}

