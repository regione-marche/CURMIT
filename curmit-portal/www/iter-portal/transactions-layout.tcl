ad_page_contract {

    @author Gabriele Lo Vaglio
    @cvs-id transaction-layout.tcl

} {
    {tran_id      ""}
    {maintainer_id   ""}
    {output_type  "pdf"}
}

set user_id    [ad_conn user_id]

set title "Stampa modulo richiesta accredito portafoglio cit-cal"
set stampe_logo_nome [parameter::get_from_package_key -package_key iter-portal -parameter stampe_logo_nome]

db_1row query "select b.description,
                      d.name || ' ' || d.first_name as rapp_legale,
                      a.name as nome_manutentore,
                      a.iva_code,
                      iter_edit_num (b.amount, 2) as amount,
                      c.wallet_id 
                 from iter_maintainers a
                    , wal_transactions b
                    , wal_holders c
                    , iter_parties d
                where b.holder_id = c.holder_id
                  and c.wallet_id = a.wallet_id
                  and d.party_id = a.representative_id
                  and tran_id = :tran_id"

set code [template::adp_compile -file [ah::service_root]/packages/iter-portal/www/transactions-layout.adp]
append html [template::adp_eval code]
append html "<!--PAGE BREAK-->"

set file_html [open /tmp/transactions-${tran_id}.html w]
puts  $file_html $html
close $file_html

set fontsize 14
with_catch error_msg {
    exec htmldoc --webpage --header ... --footer ... --quiet --left 1cm --right 1cm --top 1cm --bottom 1cm --fontsize $fontsize --size A4 -f /tmp/transactions-$tran_id.pdf /tmp/transactions-$tran_id.html
} {
    # con htmldoc 1.8.23 e' necessaria la with_catch
}

# send pdf
ns_returnfile 200 application/pdf /tmp/transactions-$tran_id.pdf

# drops temporary files
ns_unlink /tmp/transactions-$tran_id.pdf

ad_script_abort

