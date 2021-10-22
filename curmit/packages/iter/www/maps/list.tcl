ad_page_contract {

    Lista delle occupazioni non georeferenziate.

    @author	Claudio Pasolini

} {
    page:optional
    {rows_per_page 30}
    orderby:optional
}

set page_title "Posizioni non georeferenziate"
set context [list $page_title]

set package_id [ad_conn package_id]

# Return URL
set return_url [get_referrer]

template::list::create \
    -name positions \
    -key cod_impianto \
    -page_flush_p t \
    -page_size $rows_per_page \
    -page_groupsize 10 \
    -page_query {
	select i.cod_impianto
        from coimaimp i
        where i.cod_impianto not in (
				  select p.position_id
				  from maps_positions p
				  )
        order by i.indirizzo
    } \
    -elements {
	party_name {
	    label "Soggetto"
	}
	cod_impianto {
	    link_url_col edit_url
	    link_html {title "Modifica indirizzo"}
	    label "Cod. impianto"
	}
	address {
	    label "Indirizzo"
	}
	gmap {
	    link_url_col gmap_url
	    display_template {<img src="/resources/acs-subsite/google24.png" border="0">}
	    link_html {title "Crea o aggiorna Google Map"}
	    sub_class narrow
	}
    }

db_multirow -extend {edit_url gmap_url} positions select_positions "
    select i.cod_impianto
         , i.descrizione as name
         , s.cognome || ' ' || coalesce(s.nome, ' ') as party_name
         , coalesce(v.descr_topo, ' ')    || ' ' ||
           coalesce(v.descrizione, ' ')   || ' ' ||
           coalesce(i.numero::text, ' ')  || ' ' ||
           coalesce(c.denominazione, ' ') || ' ' ||
           coalesce(p.denominazione, ' ') as address
    from coimaimp i
             left outer join coimviae v on v.cod_via       = i.cod_via 
             left outer join coimcomu c on c.cod_comune    = v.cod_comune
             left outer join coimprov p on p.cod_provincia = c.cod_provincia
       , coimcitt s
    where s.cod_cittadino = i.cod_responsabile
    [template::list::page_where_clause -name positions -key cod_impianto -and]
    order by address
" {
    set edit_url    [export_vars -base "/iter/src/coimaimp-gest" {cod_impianto}]
    set gmap_url    [export_vars -base "geocode" {cod_impianto name address}]
}
