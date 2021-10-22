ad_page_contract {
    Esegue il geocoding delle occupazioni.

    @author Claudio Pasolini
    @cvs-id $Id: bulk-geocode.tcl
} {

    {limit "20000"}
}

set zoom  [parameter::get -parameter Zoom -default 15]

set goods 0
set bads  0

db_foreach address "
    select distinct
           i.cod_impianto as position_id
         , coalesce(to_char(i.potenza,'9999999.99'), 'non definita') as name
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
    where i.cod_impianto not in (select position_id from maps_positions)
      and i.cod_impianto not in (select position_id from maps_positions_errors)
    limit $limit
" {

    set response [maps::create_or_replace_position \
		      -position_id $position_id \
		      -name        $name \
		      -address     $address]

    util_unlist $response id status
    if {$status eq "OK"} {
        incr goods
    } else {
	db_dml bad "insert into maps_positions_errors values (:position_id, :status, :address)"
	incr bads
    }

    # let the web service take a breathe
    ns_sleep 4

}

ns_log notice "\nbulk-geocode Geocoding terminato. <p>Indirizzi risolti: $goods <br>Indirizzi non risolvibili: $bads"
ns_return 200 text/html "Geocoding terminato. <p>Indirizzi risolti: $goods <br>Indirizzi non risolvibili: $bads" 
