ad_page_contract {

    @author Serena Saccani
    @date   13.06.2012

    @cvs-id coimtdoc-list.tcl

    USER  DATA       COMMENTO
    ===== ========== ===================================================================================================
    mat01 22/08/2025 Aggiunto l'attributo "alt" all'icona del'edit.
    mat01            Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)

} {
    {f_descrizione    ""}
    {is_admin_p       ""}
    {rows_per_page    50}
    orderby:optional
    page:optional
}

set link_list [export_url_vars f_descrizione is_admin_p]

set user_id [auth::require_login]
set page_title "Lista Protocolli"
set context [list [list ../admin "Amministrazione Portale"] "Lista Protocolli"]

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
                 -no_login \
                 -object_id [ad_conn package_id] \
                 -privilege admin
	     ]

# prepare actions buttons
set actions {
    "Nuovo protocollo"   coimtdoc-add-edit   "Aggiunge un nuovo protocollo" 
}
set bulk_actions ""

# filtri in alto
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
        {f_descrizione:text,optional
            {label  "Descrizione"}
            {html   {size 30 length 30} }
            {values $f_descrizione}
        }
    } -on_request {

    } -on_submit {

        set errnum 0

        if {$errnum > 0} {
            break
        }
    }

# preparo filtri
set filters  {
    f_descrizione {
        hide_p 1
	where_clause {and upper(descrizione) like upper(%:f_descrizione%)}
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

#mat01 aggiunto all'immagine dell'edit l'attributo alt
# definisco la lista
template::list::create \
    -name           coimtdoc \
    -multirow       coimtdoc \
    -actions        $actions \
    -bulk_actions   $bulk_actions \
    -bulk_action_export_vars {f_descrizione is_admin_p funzione} \
    -bulk_action_method "post" \
    -key            id_tipo_documento \
    -page_flush_p   t \
    -page_size      $rows_per_page \
    -page_groupsize 10 \
    -page_query {
	select id_tipo_documento
	from   coimtdoc
	where  1 = 1
        [template::list::filter_where_clauses -name coimtdoc -and]
	order by descrizione
    } \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" alt="Modifica protocollo" width="16" height="16" border="0">}
	    link_html {title "Modifica"}
	    sub_class narrow
	}
	tipo_documento {
	    label "Codice"
	}
	descrizione {
	    label "Descrizione"
	}
    } \
    -filters       $filters

# preparo la query
db_multirow -extend {edit_url} coimtdoc query "
    select id_tipo_documento
         , tipo_documento
         , descrizione
      from coimtdoc 
     where 1 = 1
       [template::list::page_where_clause -name coimtdoc -and]
     order by descrizione
" {
    
    set funzione "M"
    set edit_url [export_vars -base "coimtdoc-add-edit" {id_tipo_documento tipo_documento funzione}]

}

