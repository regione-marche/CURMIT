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

set bollini_ritiro_presso  [parameter::get_from_package_key -package_key iter-portal -parameter bollini_ritiro_presso]
set stampe_logo_nome [parameter::get_from_package_key -package_key iter-portal -parameter stampe_logo_nome]

set title "Stampa Codice Portafoglio"

db_1row man "select o.num_boll_g, o.num_boll_f1, o.num_boll_f2, o.num_boll_e, o.num_boll_freddo1, o.num_boll_freddo2, o.num_boll_g_sec_iva, o.num_boll_f1_sec_iva, o.num_boll_f2_sec_iva, o.num_boll_e_sec_iva, o.num_boll_freddo1_sec_iva, o.num_boll_freddo2_sec_iva, o.num_boll_cogenerazione, o.num_boll_teleriscaldamento, consegna
                  , cod_prenotazione, to_char(data_prenotazione, 'DD/MM/YYYY') as data_prenotazione, m.name as manutentore
                  , address_ass_posta||' -  '||coalesce(zipcode_ass_posta, '')||' '||coalesce(city_ass_posta, '') as indirizzo_consegna
                  , delegato as delegato
               from iter_ordboll o, iter_maintainers m
              where o.maintainer_id = m.maintainer_id
                and o.maintainer_id = :maintainer_id
                and o.ordboll_id    = :ordboll_id"

set totale_boll_iva_10 [expr $num_boll_g + $num_boll_f1 + $num_boll_f2 + $num_boll_e + $num_boll_freddo1 + $num_boll_freddo2]
set totale_boll_iva_22 [expr $num_boll_g_sec_iva + $num_boll_f1_sec_iva + $num_boll_f2_sec_iva + $num_boll_e_sec_iva + $num_boll_freddo1_sec_iva + $num_boll_freddo2_sec_iva]

if {$consegna eq "1"} {
    set ritiro "da consegnare a mezzo spedizione postale al seguente indirizzo: $indirizzo_consegna"
} else {
    set ritiro "da ritirare presso $bollini_ritiro_presso
                <br>Persona delegata per il ritiro: $delegato."
}

set code [template::adp_compile -file [ah::service_root]/www/iter-portal/bollini/ordboll-print.adp]
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

