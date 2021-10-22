ad_page_contract {

    Lista movimenti di portafoglio.

    @author Claudio Pasolini
    @cvs-id $Id: transactions.tcl

} {
    {f_maintainer_id  ""}
    {f_name           ""}
    {wallet_id      ""}
    {body_id        ""}
    {from_date      ""}
    {to_date        ""}
    {from_date_ansi ""}
    {to_date_ansi   ""}
    {caller    "index"}
    {nome_funz_caller ""}
    {nome_funz      ""}
    {format         "normal"}
    {rows_per_page  "100"}
    {offset         "0"}
    {messaggio      ""}
    {messaggio_ok   ""}

    orderby:optional
} -properties {
    nome_funz:onevalue
}

set name $f_name
set extra_par [list rows_per_page     $rows_per_page \
		   f_maintainer_id   $f_maintainer_id \
		   f_name            $name \
		   wallet_id       $wallet_id \
		   body_id         $body_id \
		   from_date       $from_date \
		   to_date         $to_date \
		   from_date_ansi  $from_date_ansi \
		   to_date_ansi    $to_date_ansi]


# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

#template::head::add_javascript -src /resources/acs-subsite/core.js 

#set curr_prog       [file tail [ns_conn url]]
#set url_vars [export_ns_set_vars "url" maintainer_id name wallet_id body_id from_date to_date]

#set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"
set link_gest [export_url_vars nome_funz nome_funz_caller extra_par]
set link_aggiungi "<a href=\"transactions-gest?funzione=I&$link_gest\">Inserisci versamento</a>"
set link_filter [export_url_vars caller nome_funz receiving_element maintainer_id name wallet_id body_id from_date to_date]
set link_scar [export_url_vars caller nome_funz maintainer_id name wallet_id body_id from_date to_date]
set link_righe      [iter_rows_per_page     $rows_per_page]


set list_head [iter_list_head "" "" $link_aggiungi "" $link_righe "Righe per pagina"]

set package_id [ad_conn package_id]

set page_title "Elenco movimenti"
set context [list  "$page_title"]

if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar  [iter_context_bar \
			  [list "javascript:window.close()" "Torna alla Gestione"] \
			  "$page_title"]
}

# imposto codice Regione Lombardia come utilizzato nei movimenti
set id_regione "3"

#Seleziono quale database wallet andare a guardare a seconda dell'istanza in cui mi trovo
if {[db_get_database] eq "curit-dev"} {
    set wallet_dbn "wallet-dev"
} elseif {[db_get_database] eq "curit-sta"} {
    set wallet_dbn "wallet-sta"
} else {
    set wallet_dbn "wallet"
}

# determino source_id dei soggetti provenienti da CENED
set cened_source_id [db_string cened "select source_id from wal_sources where source_name = 'CENED'"]

set actions ""

source [ah::package_root -package_key ah-util]/paging-buttons.tcl

set bulk_actions { "Storna Movimento di Portafoglio" "storno" "Storno Movimento di Portafoglio" }

template::list::create \
    -name transactions \
    -multirow transactions \
    -actions $actions \
    -selected_format $format \
    -bulk_actions $bulk_actions \
    -bulk_action_export_vars {nome_funz extra_par} \
    -key tran_id \
    -elements {
	payment_date {
	    label "Data contabile"
	    display_template {<if @transactions.reason@ not nil><font color="red">@transactions.payment_date@</font></if><else>@transactions.payment_date@</else>}
	    sub_class narrow
	}
	currency_date {
	    label "Disponib. credito"
	}
	name {
	    label "Manutentore"
	}
	holder_id {
	    label "Cod. Manu."
	}
	body_name {
	    label "Ente locale di riferim."
	}
	cod_impianto_est {
	    label "Cod. Imp."
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
	    label "Congua-<br>glio Regione"
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
        reason {
	    label "Causale dello storno"
	    html {align left}
	}
        ref_tran_id {
	    label "Cod. op. stornata"
	    html {align right}
	    sub_class narrow
	}
	nome_funz {}
    } -filters {
	f_maintainer_id {
	    hide_p 1
	    where_clause {'MA' || cast(m.holder_id as varchar(25)) = :f_maintainer_id}
	}
	name {
	    hide_p 1
	}
	wallet_id {
	    hide_p 1
	    where_clause {h.wallet_id = :wallet_id}
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
	nome_funz {hide_p 1}
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
    }  \
    -formats {
        normal {
            label "Video"
            layout table
            row {
                checkbox {}
                payment_date {}
		currency_date {}
		name {}
                holder_id {}
		body_name {}
		cod_impianto_est {}
		potenza {}
                amount_plus {}
		canale {}
		amount_minus_regione {}
		amount_minus_regione_c {}
		amount_minus_ente {}
		tran_id {}
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
		body_name {}
		cod_impianto_est {}
		potenza {}
                amount_plus {}
		canale {}
		amount_minus_regione {}
		amount_minus_regione_c {}
		amount_minus_ente {}
		tran_id {}
		reason {}
		ref_tran_id {}
            }
        }
    } 

# eseguo la query solo in assenza di errori nei filtri del form
if {![info exists errnum]} {

    if {![string is space $name]} {
	
    }
    if {[string is space $name]} {
	set where_name ""
    } else {
	set name_1     [iter_search_word $name]
	set where_name " and upper(h.name) like upper(:name_1)"
    }

    set sql " 
        select m.*, 
              'MA' || cast(h.holder_id as varchar(25)) as maintainer_id,
              h.name, h.source_id
        from wal_transactions m, wal_holders h
        where m.holder_id = h.holder_id
       $where_name
        [template::list::filter_where_clauses -name transactions -and]
        [template::list::orderby_clause -name transactions -orderby]
        limit $rows_per_page
        offset $offset"

    #ns_return 200 text/plain "$sql\n name_1:$name_1 \n :from_date_ansi=$from_date_ansi \n :to_date_ansi=$to_date_ansi"
    
    #ns_log notice $sql

    db_multirow \
	-extend {body_name cod_impianto_est potenza amount_plus amount_minus_regione amount_minus_ente canale amount_minus_regione_c nome_funz} \
	transactions query "$sql" {

	set cod_impianto_est ""
	set potenza          ""
	set canale           ""

	set holder_id "MA$holder_id"

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

	    iter_get_coimtgen
	    set body_name $coimtgen(ente)


	    # leggo i dati da iter, se ho ottenuto un dbn
	    if {$dbn ne ""} {

		if {![db_0or1row iter "
                select i.cod_impianto_est || '/' || cod_dimp as cod_impianto_est
                      ,i.potenza
                from coimdimp d, coimaimp i
                where d.cod_dimp         = :cod_dimp
                  and d.cod_impianto     = i.cod_impianto
                "]} {

# prendo l'impianto passando da coimdimp_stn se coimdimp è stato stornato
		    if {![db_0or1row iter "
                            select i.cod_impianto_est  || '/' || cod_dimp as cod_impianto_est
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
	    if {$body_id == $id_regione} {
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
       $where_name
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
        from wal_transactions m"

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
    ad_set_client_property iter src/transactions [export_vars -entire_form -no_empty]
}

if {[string equal $format "csv"]} {
    template::list::write_csv -name transactions
    ad_script_abort
}

