ad_page_contract {

    @author Gabriele Lo Vaglio  
    @cvs-id coimplic-rila.tcl

    USER   DATA         MODIFICHE
    ====   ==========  ==================================================================================================
    gab01  16/01/2017  Modificato il filtro matrice per poter cercare i plichi senza avere tutta la relativa matrice 
    gab01              (ricerca con il like)
    
} {
    {ordtarg_id:multiple ""}
    {f_matrice           ""}
    {is_admin_p          ""}
    {last_order          ""}
    {funzione           "V"}
    {caller         "index"}
    {nome_funz           ""}
    {nome_funz_caller    ""}
    {extra_par           ""}
    {cod_manutentore     ""}
    {flag_attivo         ""}
    {f_manutentore       ""}
    {rows_per_page       50}
    
    {da_data         ""}
    {a_data          ""}
    {da_data_pretty  ""}
    {a_data_pretty   ""}
    {f_flag_evaso   "f"}

    orderby:optional
    page:optional

} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

set link_list [export_url_vars da_data a_data da_data_pretty a_data_pretty f_flag_evaso is_admin_p rows_per_page ordtarg_id funzione f_matrice]

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
                 -no_login \
                 -object_id [ad_conn package_id] \
                 -privilege admin
	     ]

if {$ordtarg_id eq ""} {
    ad_return_complaint 1 "Selezionare almeno una riga."
} else {
    if {[llength $ordtarg_id] > 1} {
	ad_return_complaint 1 "Hai selezionato più di una riga"
    } else {  
    # deve essere ancora inevaso
    db_1row query "select flag_evaso
                     from iter_ordtarg
                    where ordtarg_id = :ordtarg_id"
    if {$flag_evaso eq "t"} {
        ad_return_complaint 1 "Ordine bollini già evaso."
    }
}
}

#gab01 Se il programma viene chiamato dalla lista degli ordine delle targhe "ordtarg-list" cancello tutti i record
#      della tabella ordplic che relativi all'ordine selezionato
if {$caller eq "ordtarg"} {    
    db_transaction {
	db_dml query "delete from ordplic
                       where ordtarg_id = :ordtarg_id"
    }
    set caller ""
}

# prepare actions buttons
set actions [list \
                "Evadi" "coimtarg-rila?$link_list" "Conferma selezione dei plichi" \
               ]

    set maintainer_id [auth::require_login]

    set page_title "Lista Plichi"
    set context [list [list ../admin "Amministrazione Portale"] \
		[list ordtarg-list?$link_list "Ordini Targhe"] "Lista plichi"]

# filtri in alto
ad_form \
    -name filter \
    -export {ordtarg_id funzione plico_id} \
    -edit_buttons [list [list "Go" go]] \
    -form {

        {f_matrice:text,optional
            {label   "Cerca per matrice"}
            {values  $f_matrice}
        }
	{is_admin_p:text(hidden)}

    } -on_request {

    } -on_submit {
	
	set errnum 0

        if {$errnum > 0} {
            break
        }
    }

# preparo filtri
#gab01 modificato filtro f_matrice
set filters  {
    f_matrice {
        hide_p 1
        where_clause {[ah::search_clause_f -search_word $f_matrice -search_field matrice_fissa]}
    }
    is_admin_p {
        hide_p 1
    }
    ordtarg_id {
        hide_p 1
    }
    funzione {
        hide_p 1
    }
    plico_id {
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
    -name           coimplic \
    -multirow       coimplic \
    -actions        $actions \
    -key            plico_id \
    -page_flush_p   t \
    -page_size      $rows_per_page \
    -page_groupsize 10 \
    -page_query {
	select p.plico_id
	from coimplic p 
   left join ordplic op 
          on p.plico_id = op.plico_id
         and op.ordtarg_id  = :ordtarg_id
       where p.ordtarg_id is null
        [template::list::filter_where_clauses -name coimplic -and]
	[template::list::orderby_clause -name coimplic -orderby]
    order by case when op.ordplic_id is null then 0 else 1000 end desc
    } \
    -elements {
	matrice_fissa {
	    label "Matrice fissa"
	}
	matrice_da {
	    label "Matrice da"
	}
	matrice_a {
	    label "Matrice a"
	}
        link {
        label "Sel/Deselez"
	    html {align center}
	    display_template {<if @coimplic.link@ eq "S">Selez</if><else>Deselez</else>}
	    link_url_col plico_url
	    link_html {title "Selez/Deselez"}
	}
    } -orderby {
    } -filters       $filters

# preparo la query
db_multirow -extend {link plico_url} coimplic query "
    select p.plico_id
         , p.matrice_fissa
         , p.matrice_da
         , p.matrice_a
      from coimplic p
 left join ordplic op 
        on p.plico_id = op.plico_id
       and op.ordtarg_id  = :ordtarg_id         
     where p.ordtarg_id is null
     [template::list::page_where_clause -name coimplic -key p.plico_id -and]
 --       [template::list::orderby_clause -name coimplic -orderby]
     order by  case when op.ordplic_id is null then 0 else 1000 end desc

" {
    if {![db_0or1row query  "select distinct plico_id 
                               from ordplic 
                              where plico_id    = :plico_id
                                and ordtarg_id  = :ordtarg_id"]} {
        set link "S"
	set plico_url  [export_vars -base "sel-plic?link=$link&plico_id=$plico_id&$link_list" ]                            
    } else {
	set link "D"
	set plico_url  [export_vars -base "sel-plic?link=$link&plico_id=$plico_id&$link_list" ]
    }
}
