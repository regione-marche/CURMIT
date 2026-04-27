ad_page_contract {

    @author Simone Pesci  
    @cvs-id ordtarg-list.tcl

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    rom01  17/05/2023 Reso standard una modifica fatta solo per Basilicata sul campo consegna.

    gab01  21/12/2016 Cambiato il link nella bulk_action Evadi.

} {
    {da_data         ""}
    {a_data          ""}
    {da_data_pretty  ""}
    {a_data_pretty   ""}
    {f_flag_evaso   "f"}
    {is_admin_p      ""}
    {rows_per_page   50}
    orderby:optional
    page:optional
}

set link_list [export_url_vars da_data a_data da_data_pretty a_data_pretty f_flag_evaso is_admin_p]

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
                 -no_login \
                 -object_id [ad_conn package_id] \
                 -privilege admin
	     ]

set db_name [db_get_database];#rom01

# prepare actions buttons
set actions ""
set bulk_actions {
    "Stampa"   ordtarg-print  "Stampa gli ordini selezionati"
}

#gab01 cambiato bulk_action "Evadi"
#"Evadi"     coimtarg-rila  "Evadi gli ordini di Targhe selezionati"
if {$admin_p} {
    set funzione "I"
    set caller "ordtarg";#gab01
    append bulk_actions {
        "Evadi"     coimplic-rila  "Evadi gli ordini di Targhe selezionati"
	"Cancella"  ordtarg-delete "Cancella gli ordini di Targhe selezionati"
    }
} else {
    set funzione ""
}

if {$is_admin_p eq "t" || $admin_p} {
    set maintainer_id [auth::require_login]

    set page_title "Lista Ordini Taghe"
    set context [list [list ../admin "Amministrazione Portale"] "Ordini Targhe"]

    set where_maintainer ""
} else {
    set maintainer_id [iter::script_init]
    if {[string equal $maintainer_id "0"]} {
	ad_returnredirect services
    }
    db_1row query "select name as maintainer_name
                        , validated_p
                        , approved_p 
                     from iter_maintainers 
                    where maintainer_id = :maintainer_id"

    set page_title "Lista Ordini Targhe $maintainer_name"
    set context [list [list ../services "Servizi per i manutentori"] "Ordini Bollini"]

    set where_maintainer " and o.maintainer_id = :maintainer_id"
}

# filtri in alto
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
        {da_data_pretty:text,optional
            {label  "Dalla data"}
            {html   {size 10 length 10} }
            {values $da_data}
        }
        {a_data_pretty:text,optional
            {label  "Alla data"}
            {html   {size 10 length 10} }
            {values $a_data}
        }
        {f_flag_evaso:text(select),optional
            {options {{{} {}} {Si t} {No f} }}
            {label   "Evaso?"}
            {values  $f_flag_evaso}
        }
	{is_admin_p:text(hidden)}
    } -on_request {

    } -on_submit {

	set errnum 0

        if {$errnum > 0} {
            break
        }
    }

if {[string equal $da_data_pretty ""] && [string equal $a_data_pretty ""]} {
    set where_data ""
} else {
    if {[string equal $da_data_pretty ""] } {
        set da_data "1900-01-01"
    } else {
        set da_data [ah::check_date -ansi -input_date $da_data_pretty]
    }
    if {[string equal $a_data_pretty ""] } {
        set a_data "2100-01-01"
    } else {
        set a_data [ah::check_date -ansi -input_date $a_data_pretty]
    }
    set where_data "and o.data_prenotazione between :da_data and :a_data"
}

if {[string match "*iter-portal-basilicata*" $db_name]} {#rom01 Aggiunte if, else e il loro contenuto
    set case_consegna ", case o.consegna
            when '1' then 'Consegna mezzo posta -Pr Potenza'
            when '2' then 'Consegna mezzo posta -Cm Potenza'
            when '3' then 'Consegna mezzo posta -Pr Matera'
            when '4' then 'Ritiro presso ufficio Pr.Potenza'
            when '5' then 'Ritiro presso ufficio Cm.Potenza'
            when '6' then 'Ritiro presso ufficio Matera'
            else ''
             end as tipo_consegna"
} else {
    set case_consegna ", case o.consegna
            when '1' then 'Consegna mezzo posta'
            when '2' then 'Ritiro presso ufficio'
            else ''
             end as tipo_consegna"
}

# preparo filtri
set filters  {
    f_flag_evaso {
        hide_p 1
        where_clause {o.flag_evaso = :f_flag_evaso}
    }
    da_data_pretty {
        hide_p 1
    }
    a_data_pretty {
        hide_p 1
    }
    is_admin_p {
        hide_p 1
    }
    rows_per_page {
        label "Righe per pagina"
        values {{50 50} {100 100} {"Tutte" 9999999}}
        where_clause {1 = 1}
        default_value 50
    }
}

# definisco la lista
template::list::create \
    -name           ordtarg \
    -multirow       ordtarg \
    -actions        $actions \
    -bulk_actions   $bulk_actions \
    -bulk_action_export_vars {da_data a_data da_data_pretty a_data_pretty f_flag_evaso is_admin_p funzione ordtarg_id caller} \
    -bulk_action_method "post" \
    -key            ordtarg_id \
    -page_flush_p   t \
    -page_size      $rows_per_page \
    -page_groupsize 10 \
    -page_query {
	select o.ordtarg_id
	from iter_ordtarg o
           , iter_maintainers m
	where o.maintainer_id = m.maintainer_id
	$where_maintainer
	$where_data
        [template::list::filter_where_clauses -name ordtarg -and]
	[template::list::orderby_clause -name ordtarg -orderby]
    } \
    -elements {
	manutentore {
	    label "Manutentore"
	}
	cod_prenotazione {
	    label "Cod.<br>prenot."
	}
	data_prenotazione {
	    display_col data_prenotazione_pretty
	    label "Data<br>Prenot."
	}
	num_targhe {
	    label "N.Targhe"
	}
	tipo_consegna {
	    label "Consegna"
	}
	flag_evaso_pretty {
	    label "Evaso?"
	}
    } -orderby {
	default_value data_prenotazione,desc
	data_prenotazione {
            label "Data prenot."
            orderby data_prenotazione
	}
	cod_prenotazione {
            label "Cod.prenot."
            orderby "lpad(cod_prenotazione, 20, '0')"
	}
    } -filters       $filters

# preparo la query
db_multirow -extend {data_scad_fatt num_fatt data_fatt flag_pagato_pretty} ordtarg query "
    select o.ordtarg_id
         , o.num_targhe
         , o.flag_evaso
         , case o.flag_evaso when 't' then 'Si' else 'No' end as flag_evaso_pretty
         , lpad(cod_prenotazione, 20, '0') as cod_prenotazione
         , data_prenotazione
         , to_char(data_prenotazione, 'DD/MM/YYYY') as data_prenotazione_pretty
         , m.name as manutentore
 --rom01 , case o.consegna 
 --rom01    when '1' then 'Consegna mezzo posta'
 --rom01    when '2' then 'Ritiro presso ufficio'
 --rom01    else ''
 --rom01   end as tipo_consegna
         $case_consegna --rom01
      from iter_ordtarg o
         , iter_maintainers m
     where o.maintainer_id = m.maintainer_id
       $where_maintainer
       $where_data
       [template::list::page_where_clause -name ordtarg -and]
       [template::list::orderby_clause -name ordtarg -orderby]
" {
    
    set cod_prenotazione [string trimleft $cod_prenotazione "0"]

}
