ad_page_contract {

    @author Serena Saccani
    @cvs-id ordboll-list.tcl

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

# prepare actions buttons
set actions ""
set bulk_actions {
    "Stampa"   ordboll-print  "Stampa gli ordini selezionati"
}
if {$admin_p} {
    set funzione "I"
    append bulk_actions {
        "Evadi"     coimboll-rila  "Evadi gli ordini di Bollini selezionati"
        "Cancella"  ordboll-delete "Cancella gli ordini di Bollini selezionati"
    }
} else {
    set funzione ""
}

if {$is_admin_p eq "t" || $admin_p} {
    set maintainer_id [auth::require_login]

    set page_title "Lista Ordini Bollini"
    set context [list [list ../admin "Amministrazione Portale"] "Ordini Bollini"]

    set where_maintainer ""
} else {
    set maintainer_id [iter::script_init]
    if {[string equal $maintainer_id "0"]} {
	ad_returnredirect services
    }
    db_1row query "select name as maintainer_name, validated_p, approved_p from iter_maintainers where maintainer_id = :maintainer_id"

    set page_title "Lista Ordini Bollini $maintainer_name"
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
    -name           ordboll \
    -multirow       ordboll \
    -actions        $actions \
    -bulk_actions   $bulk_actions \
    -bulk_action_export_vars {da_data a_data da_data_pretty a_data_pretty f_flag_evaso is_admin_p funzione} \
    -bulk_action_method "post" \
    -key            ordboll_id \
    -page_flush_p   t \
    -page_size      $rows_per_page \
    -page_groupsize 10 \
    -page_query {
	select o.ordboll_id
	from iter_ordboll o, iter_maintainers m
	where o.maintainer_id = m.maintainer_id
	$where_maintainer
	$where_data
        [template::list::filter_where_clauses -name ordboll -and]
	[template::list::orderby_clause -name ordboll -orderby]
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
	num_boll_g {
	    label "N.boll.<br>All.G"
	}
	num_boll_f1 {
	    label "N.boll.<br>All.F1"
	}
	num_boll_f2 {
	    label "N.boll.<br>All.F2"
	}
	num_boll_e {
	    label "N.boll.<br>All.E"
	}
	tipo_consegna {
	    label "Consegna"
	}
	flag_evaso_pretty {
	    label "Evaso?"
	}
	num_fatt {
	    label "Num.<br>Fatt."
	}
	data_fatt {
	    label "Data<br>Fatt."
	}
	data_scad_fatt {
	    label "Dt.Scad<br>Fatt."
	}
	flag_pagato_pretty {
	    label "Pagato?"
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
db_multirow -extend {data_scad_fatt num_fatt data_fatt flag_pagato_pretty} ordboll query "
    select o.ordboll_id
         , o.num_boll_g
         , o.num_boll_f1
         , o.num_boll_f2
         , o.num_boll_e
         , o.flag_evaso
         , case o.flag_evaso when 't' then 'Si' else 'No' end as flag_evaso_pretty
         , lpad(cod_prenotazione, 20, '0') as cod_prenotazione
         , data_prenotazione
         , to_char(data_prenotazione, 'DD/MM/YYYY') as data_prenotazione_pretty
         , m.name as manutentore
         , case o.consegna 
            when '1' then 'Consegna mezzo posta'
            when '2' then 'Ritiro presso UCIT Srl'
            else ''
           end as tipo_consegna
      from iter_ordboll o, iter_maintainers m
     where o.maintainer_id = m.maintainer_id
       $where_maintainer
       $where_data
       [template::list::page_where_clause -name ordboll -and]
       [template::list::orderby_clause -name ordboll -orderby]
" {
    
    set cod_prenotazione [string trimleft $cod_prenotazione "0"]

    # in caso di ordine evaso, imposto la data, il numero e la data di scadenza della fattura
    if {$flag_evaso eq "t"} {
	if {![db_0or1row query "select num_fatt
                                     , iter_edit_data(data_fatt) as data_fatt
                                     , iter_edit_data(f.data_scadenza) as data_scad_fatt
                                     , case f.flag_pag when 'S' then 'Si' else 'No' end as flag_pagato_pretty
                              from coimfatt f, coimboll b
                             where b.ordboll_id = :ordboll_id
                               and b.cod_fatt = f.cod_fatt
                             limit 1"]} {
	    set num_fatt ""
	    set data_fatt ""
	    set data_scad_fatt ""
	}
    } else {
	set data_scad_fatt ""
	set num_fatt ""
	set data_fatt ""
    }
}
