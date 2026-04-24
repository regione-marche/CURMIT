ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: maintainers-list.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    mat01 11/02/2025 Il filtro per tipologia impianto ora deve essere visto da tutti.
    mat01            Aggiunto il filtro per patentino cond imp >232 kw sempre per tutti.

    rom01 13/12/2023 Corretto ordinamento di default e impaginazione per numero di righe 

    sim01 10/06/2020 Salerno ha un page title differente rispetto agli altri enti
    
} {
    {search_name ""}
    {search_city ""}
    {search_province ""}
    {search_company_type ""}
    {search_systems_type ""}
    {search_pat          ""}
    {rows_per_page     30}
    orderby:optional
    page:optional
}

set db_name [db_get_database]

if {[string match "*salerno*" $db_name]} {
    set page_title "Elenco ditte registrate al catasto impianti termici della Provincia di Salerno ed abilitate ad operare ai sensi di quanto previsto dagli art. 8 comma 5 del D.P.R. 16 aprile 2013, n. 74 e dall'art. 9 comma 6 della Legge Regione Campania 20 novembre 2018, n. 39."
} else {
    set page_title "Elenco Ditte"
}
    
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
	#rom01
	{search_province:text(select),optional
	    {options {{Scegli ""} [db_list_of_lists prov "select distinct m.province, m.province as dummy from iter_maintainers m order by province"]}}
	    {label {Cerca Provincia } }
	    {value $search_province}
	}

	{search_city:text,optional
	    {label {Cerca Comune}}
	    {html {length 20} }
	    {value $search_city}
	}
	#rom01
	    {search_company_type:text(select),optional
		{label {Cerca Tipologia ditta} }
		{html {length 20} } 
		{options {{Scegli ""} {"Manutentore" 1} {"Installatore" 0} {"Installatore/Manutentore" 2} }}
	    }
	{search_pat:text(select),optional
            {label {Patentino Conduz. imp.>232 kW}}
	    {options {{Scegli ""} {"Si" "t"} {"No" "f"}}}
            
        }
	
    }

if {1==0 } { #mat01 tolto if-else perchè luca mi ha chiesto di mettere il filtro per tipologia di impianto ma esiste già
    if {[string match "*iter-portal-marche*" $db_name]} {
	ad_form -extend -name filter -form {
	    
	    {search_systems_type:text(select),optional
		
		{options {{"" ""} [db_list_of_lists s "select distinct i.installation_type_description  
                	                                            , i.installation_type_id
                                                        from iter_installation_types i
                                                    order by installation_type_id "]}}
		{label {Cerca Tipologia Impianti} }
		{value $search_systems_type}
	    }
	}
    } else {
	ad_form -extend -name filter -form {
	    {search_systems_type:text(hidden),optional}
	    
	}
	
    }
}

#mat01
ad_form -extend -name filter -form {
    {search_systems_type:text(select),optional
	{html {length 20} }
	{options {{Scegli ""} [db_list_of_lists s "select distinct i.installation_type_description
                                                               , i.installation_type_id
                                                          from iter_installation_types i
                                                          order by installation_type_id "]}}
	
	{label {Cerca Tipologia Impianti} }
	{value $search_systems_type}
    }
}

ad_form -extend -name filter  -on_request {
	    
    } -on_submit {

    set errnum 0

    if {$errnum > 0} {
	break
    } else {
	# per evitare errori nell'esecuzione della query la eseguirò solo se 'errnum' non esiste
	unset errnum
        # imposto flag per sapere se il form è stato inviato
	set submit_p 1
    }

}

#mat01 aggiunto filtro search_pat
template::list::create \
    -name maintainers \
    -multirow maintainers \
    -page_flush_p t \
    -page_size $rows_per_page \
    -page_groupsize 10 \
    -page_query {
        select distinct m.maintainer_id
	, m.name
	, m.city
          from iter_maintainers m
          left join iter_maintainer_installations c
            on  m.maintainer_id = c.maintainer_id
          left join iter_installation_types i
            on c.installation_type_id = i.installation_type_id
         where m.validated_p = 't'
           and m.is_active_p = 't'
           and visualizza_company = 't'
        [template::list::filter_where_clauses -name maintainers -and]
        [template::list::orderby_clause -name maintainers -orderby]
    } \
    -key m.maintainer_id \
    -elements {
	name {
	    label "Ragione Sociale"
	}
	address1 {
	    label "Indirizzo"
	}
	city {
	    label "Comune"
	}
	phone {
	    label "Telefono"
	}
	email {
	    label "E-mail"
	    display_template {<a href="@maintainers.email;noquote@">@maintainers.email;noquote@</a>}
	}
    }  \
    -orderby {
        default_value "name,asc"
        city {
	    label "Comune"
	    orderby_desc "m.city desc"
	    orderby_asc  "m.city"
            default_direction "asc"
	}
        name {
	    label "Ragione sociale"
	    orderby_desc "m.name desc"
	    orderby_asc  "m.name"
            default_direction "asc"
	}
    } \
    -filters {
	search_name {
	    hide_p 1
	    where_clause {upper(m.name) like upper('%[db_quote $search_name]%')}
	}

	search_province {
	    hide_p 1
	    where_clause  { m.province = :search_province}
        }
	search_city {
	    hide_p 1
	    where_clause {upper(m.city) like upper('%[db_quote $search_city]%')}
	}
	search_company_type {
	    hide_p 1
	    where_clause {m.role = :search_company_type} 
	}
	search_systems_type {
	    hide_p 1
	    where_clause {i.installation_type_id  = :search_systems_type}
	}
	search_pat {
	    hide_p 1
	    where_clause {m.patentino= :search_pat}
	}
        rows_per_page {
	    label "Righe per pagina"
	    values {{10 10} {30 30} {100 100}}
            default_value 30
        }
    } 

    db_multirow maintainers query "
        select
            m.maintainer_id
           ,m.name
           ,m.address1
           ,m.city
           ,m.phone
           ,'mailto:' || m.email as email
           ,m.province --rom01 
           ,m.role     --rom01
--           ,i.installation_type_description as descrizione --rom01
--           ,i.installation_type_id                         --rom01
        from iter_maintainers m
--           , iter_installation_types i
--           , iter_maintainer_installations c
        where 1=1
        [template::list::page_where_clause -name maintainers -and]
	[template::list::orderby_clause -name maintainers -orderby]
    " 


