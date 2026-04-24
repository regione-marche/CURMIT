ad_page_contract {

    @author Serena Saccani
    @cvs-id ordboll-print.tcl

} {
    {ordboll_id      ""}
    {maintainer_id   ""}
    {output_type  "pdf"}
}

if {$ordboll_id eq ""} {
    ad_return_complaint 1 "Selezionare almeno una riga."
}

if {$ordboll_id ne ""} {
    db_0or1row man "select maintainer_id from iter_ordboll where ordboll_id = :ordboll_id"
} else {
    if {$maintainer_id ne ""} {
	db_1row man "select m.name as manutentore
                       from iter_maintainers m
                      where m.maintainer_id = :maintainer_id"
    } else {
	ad_returnredirect -message "Codice manutentore obbligatorio"
    }
}

set title "Stampa Codice Portafoglio"

db_1row man "select o.num_boll_g, o.num_boll_f1, o.num_boll_f2, o.num_boll_e, consegna
                  , cod_prenotazione, to_char(data_prenotazione, 'DD/MM/YYYY') as data_prenotazione, m.name as manutentore
                  , address_ass_posta||' -  '||coalesce(zipcode_ass_posta, '')||' '||coalesce(city_ass_posta, '') as indirizzo_consegna
                  , delegato as delegato
               from iter_ordboll o, iter_maintainers m
              where o.maintainer_id = m.maintainer_id
                and o.maintainer_id = :maintainer_id
                and o.ordboll_id    = :ordboll_id"

if {$consegna eq "1"} {
    set ritiro "da consegnare a mezzo assicurata con spese postali in contrassegno al seguente indirizzo: $indirizzo_consegna"
} else {
    set ritiro "da ritirare presso UCIT S.r.l.
                <br>Persona delegata per il ritiro: $delegato."
}

set code [template::adp_compile -file [ah::service_root]/packages/iter-portal/www/bollini/ordboll-print.adp]
append html [template::adp_eval code]
append html "<!--PAGE BREAK-->"

set file_html [open /tmp/ordboll-${maintainer_id}.html w]
puts  $file_html $html
close $file_html

set fontsize 14
with_catch error_msg {
    exec htmldoc --webpage --header ... --footer ... --quiet --left 1cm --right 1cm --top 1cm --bottom 1cm --fontsize $fontsize --size A4 -f /tmp/ordboll-$maintainer_id.pdf /tmp/ordboll-$maintainer_id.html
} {
    # con htmldoc 1.8.23 e' necessaria la with_catch
}

# send pdf
ns_returnfile 200 application/pdf /tmp/ordboll-$maintainer_id.pdf

# drops temporary files
ns_unlink /tmp/ordboll-$maintainer_id.pdf

ad_script_abort

