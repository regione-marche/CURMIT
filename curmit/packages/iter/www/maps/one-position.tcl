ad_page_contract {

    Google Map view, version 3.

    @author Claudio Pasolini
    @cvs-id one-position.tcl
} {
    cod_impianto:integer
}

set user_id    [ad_conn user_id]

set page_title "Posizione geografica"
set context [list [list /iter/src/coimaimp-gest?cod_impianto=$cod_impianto "Lista impianti"] $page_title]

# trovo indirizzo
db_1row get "
    select s.cognome || ' ' || coalesce(s.nome, ' ') as name
         , coalesce(v.descr_topo, ' ')    || ' ' ||
           coalesce(v.descrizione, ' ')   || ' ' ||
           coalesce(i.numero::text, ' ')  || ' ' ||
           coalesce(c.denominazione, ' ') || ' ' ||
           coalesce(p.denominazione, ' ') as address
    from coimaimp i
             left outer join coimviae v on v.cod_via       = i.cod_via 
                                       and v.cod_comune    = i.cod_comune 
             left outer join coimcomu c on c.cod_comune    = v.cod_comune
             left outer join coimprov p on p.cod_provincia = c.cod_provincia
             left outer join coimcitt s on s.cod_cittadino = i.cod_responsabile
    where i.cod_impianto  = :cod_impianto
"

set return_url [export_vars -base  {cod_impianto}]

if {[db_0or1row position "select 1 from maps_positions where position_id = :cod_impianto"]} {
    # ho già le coordinate e posso visualizzare la mappa
    ad_return_template
} else {
    # tento di trovare le coordinate tramite l'indirizzo
    set response [maps::create_or_replace_position \
		      -position_id    $cod_impianto \
		      -name           $name \
		      -address        $address \
		     ]

    util_unlist $response position_id status

    if {$status eq "OK"} {
	ad_return_template
    } else {
	ad_returnredirect -message "Impossibile visualizzare la mappa. Si è verificato l'errore: $status" [export_vars -base /iter/src/coimaimp-gest {cod_impianto}]
	ad_script_abort
    }
}



