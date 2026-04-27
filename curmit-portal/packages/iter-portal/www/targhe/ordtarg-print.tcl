ad_page_contract {

    @author Simone Pesci
    @cvs-id ordtarg-print.tcl

    USER   DATA         MODIFICHE
    =====   ==========  =======================================================================================
    rom01  17/05/2023 Reso standard una modifica fatta solo per Basilicata sul campo consegna.

    gab02   02/03/2016  Modifiche alla stampa richieste da Gangemi

    gab01   16/01/2017  modificata la parte della stampa relativa alla consegna
    
} {
    {ordtarg_id      ""}
    {maintainer_id   ""}
    {output_type  "pdf"}
}

set user_id    [ad_conn user_id]

if {$ordtarg_id eq ""} {
    ad_return_complaint 1 "Selezionare almeno una riga."
}

set db_name [db_get_database];#rom01

if {$ordtarg_id ne ""} {
    db_0or1row man "select maintainer_id 
                      from iter_ordtarg 
                     where ordtarg_id = :ordtarg_id"
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
set stampe_logo_nome [parameter::get_from_package_key -package_key iter-portal -parameter stampe_logo_nome]

db_1row man "select o.num_targhe                                              
                  , consegna
                  , cod_prenotazione
                  , to_char(data_prenotazione, 'DD/MM/YYYY') as data_prenotazione
                  , m.name as manutentore
                  , address_ass_posta||' -  '||coalesce(zipcode_ass_posta, '')||' '||coalesce(city_ass_posta, '') as indirizzo_consegna
                  , delegato as delegato
                  , vettore
               from iter_ordtarg o
                  , iter_maintainers m
              where o.maintainer_id = m.maintainer_id
                and o.maintainer_id = :maintainer_id
                and o.ordtarg_id    = :ordtarg_id"

set consegna_per_vettore  "f";#rom01
set consegna_per_delegato "f";#rom01

if {[string match "*iter-portal-basilicata*" $db_name]} {#rom01 Aggiunte if, else e il loro contenuto
    if {$consegna in [list "1" "2" "3"]} {
	set consegna_per_vettore  "t"
    } else {
	set consegna_per_delegato "t"
    }
    
} else {
    if {$consegna eq "1"} {
	set consegna_per_vettore  "t"
    } elseif {$consegna eq "2"} {
	set consegna_per_delegato "t"
    }
    
}

if {$consegna_per_vettore eq "t"} {
    #gab02 modificata la variabile ritiro
    set ritiro "da consegnare al corriere/vettore incaricato dalla ditta per il successivo recapito al seguente indirizzo: $indirizzo_consegna.<br>
Corriere/Vettore incaricato dalla ditta: $vettore"
    #gab02 creo la varibile nota
    set nota "<tr>
                <td width=\"35%\" valign=top align=\"left\"><b>Nota</b>:</td>
                <td width=\"65%\" align=\"left\">spedizione a mezzo assicurata con oneri a carico della ditta.</td>
              </tr>"

} 
if {$consegna_per_delegato eq "t"} {
    set ritiro "da ritirare presso ufficio.
                <br>Persona delegata per il ritiro: $delegato."
    
    set nota "" ;#gab02

}

set code [template::adp_compile -file [ah::service_root]/packages/iter-portal/www/targhe/ordtarg-print.adp]
append html [template::adp_eval code]
append html "<!--PAGE BREAK-->"

set file_html [open /tmp/ordtarg-${maintainer_id}.html w]
puts  $file_html $html
close $file_html

set fontsize 14
with_catch error_msg {
    exec htmldoc --webpage --header ... --footer ... --quiet --left 1cm --right 1cm --top 1cm --bottom 1cm --fontsize $fontsize --size A4 -f /tmp/ordtarg-$maintainer_id.pdf /tmp/ordtarg-$maintainer_id.html
} {
    # con htmldoc 1.8.23 e' necessaria la with_catch
}

# send pdf
ns_returnfile 200 application/pdf /tmp/ordtarg-$maintainer_id.pdf

# drops temporary files
ns_unlink /tmp/ordtarg-$maintainer_id.pdf

ad_script_abort

