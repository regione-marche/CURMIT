ad_page_contract {

    @author Serena Saccani
    @date   13.06.2012

    @cvs-id iterprot-list.tcl
    USER  DATA       COMMENTO
    ===== ========== ===================================================================================================
    mat01 22/08/2025 Aggiunto l'attributo "alt" alle incone dell'edit e dell'attach.
    mat01            Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)


} {
    {da_data          ""}
    {a_data           ""}
    {da_data_pretty   ""}
    {a_data_pretty    ""}
    {f_num_protocollo ""}
    {f_modalita       ""}
    {f_intestatario   ""}
    {is_admin_p       ""}
    {rows_per_page    50}
    orderby:optional
    page:optional
}

set link_list [export_url_vars da_data a_data da_data_pretty a_data_pretty f_modalita f_intestatario f_num_protocollo is_admin_p]

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
    "Nuovo protocollo"   iterprot-add-edit   "Aggiunge un nuovo protocollo" 
}
set bulk_actions ""

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
        {f_num_protocollo:text,optional
            {label  "Num.Protocollo"}
            {html   {size 20 length 20} }
            {values $f_num_protocollo}
        }
        {f_intestatario:text,optional
            {label  "Intestatario"}
            {html   {size 30 length 30} }
            {values $f_intestatario}
        }
        {f_modalita:text(select),optional
            {options {{{} {}} {"Doc.in entrata" 1} {"Doc.in uscita" 2} }}
            {label   "Modalita"}
            {values  $f_modalita}
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
    set where_data "and o.data_protocollo between :da_data and :a_data"
}

# preparo filtri
set filters  {
    f_modalita {
        hide_p 1
        where_clause {o.modalita = :f_modalita}
    }
    f_num_protocollo {
        hide_p 1
        where_clause {o.var_protocollo||''||o.num_protocollo = :f_num_protocollo}
    }
    f_intestatario {
        hide_p 1
	where_clause {and upper(o.intestatario) like upper(%:f_intestatario%)}
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

#mat01 aggiunto alle immagini di edit e attach l'attributo alt. cambiato il nome dell'immagine degli allegati perchè quella di prima non esisteva (att_new.gif).
# definisco la lista
template::list::create \
    -name           iterprot \
    -multirow       iterprot \
    -actions        $actions \
    -bulk_actions   $bulk_actions \
    -bulk_action_export_vars {da_data a_data da_data_pretty a_data_pretty f_modalita f_intestatario f_num_protocollo is_admin_p funzione} \
    -bulk_action_method "post" \
    -key            prot_id \
    -page_flush_p   t \
    -page_size      $rows_per_page \
    -page_groupsize 10 \
    -page_query {
	select o.prot_id
	from iter_prot o, coimtdoc d
	where o.id_tipo_documento = d.id_tipo_documento
	$where_data
        [template::list::filter_where_clauses -name iterprot -and]
	order by data_protocollo desc, num_protocollo desc
    } \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" alt="Modifica" width="16" height="16" border="0">}
	    link_html {title "Modifica"}
	    sub_class narrow
	}
	attach {
	    link_url_col attach_url
	    display_template {<img src="/resources/acs-subsite/attach.png" alt="Gestisci allegati" width="16" height="16" class="@iterprot.attach_class@">}
	    link_html {title "Gestisci allegati"}
	    sub_class narrow
	}
	tipo_documento_edit {
	    label "Tipo Doc."
	}
	num_protocollo {
	    label "Num.Prot."
	}
	data_protocollo_edit {
	    label "Data Prot."
	}
	intestatario {
	    label "Intestatario"
	}
	indirizzo_intestatario {
	    label "Indirizzo intestatario"
	}
	modalita_edit {
	    label ""
	}
    } \
    -filters       $filters

# preparo la query
db_multirow -extend {edit_url attach_class attach_url} iterprot query "
    select o.prot_id
         , case o.modalita
              when '1' then 'Documento in entrata'
              when '2' then 'Documento in uscita'
              else '' end  as modalita_edit
         , d.descrizione   as tipo_documento_edit
         , o.var_protocollo||''||o.num_protocollo as num_protocollo
         , to_char(data_protocollo, 'DD/MM/YYYY') as data_protocollo_edit
         , o.intestatario   as intestatario
         , coalesce(o.indirizzo, '')||' '||coalesce(o.cap, '')||' '||coalesce(o.comune, '') as indirizzo_intestatario
      from iter_prot o, coimtdoc d
     where o.id_tipo_documento = d.id_tipo_documento
       $where_data
       [template::list::page_where_clause -name iterprot -and]
     order by data_protocollo desc, num_protocollo desc
" {
    
    set edit_url   [export_vars -base "iterprot-add-edit" {prot_id}]
    set attach_url [export_vars -base "iterprotdocu-list" {prot_id}]

    # Verifico se ho degli allegati.
    if {[db_0or1row query "select 1 from attachments where object_id = :prot_id limit 1"]} {
	set attach_class "has-attachment"
    } else {
	set attach_class ""
    }

}
