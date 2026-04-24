ad_page_contract {

    Print WALLET CODE 'CESTEC'

    @author Nelson Secco
    @cvs-id $Id: print-wallet-code.tcl

} {
    {maintainer_id ""}
    {trustee_id ""}
    {output_type "html"}
}

# La stampa è nata originalmente per i manutentori, ma ora deve funzionare anche per 
# gli amministratori di condominio.

if {$maintainer_id ne ""} {
    db_1row man "
        select name as party_name, validated_p, approved_p, wallet_id 
        from iter_maintainers 
        where maintainer_id = :maintainer_id"
} elseif {$trustee_id ne ""} {
    db_1row amm "
        select name as party_name, validated_p, approved_p, wallet_id 
        from iter_trustees
        where trustee_id = :trustee_id"
} else {
    ad_returnredirect -message "Codice manutentore o amministratore obbligatorio" /
}

set title "Stampa Codice Portafoglio"

if {[string equal $output_type "pdf"]} {
    set logo "[ah::service_root]/www/resources/Cestec.gif"
#    set logo_regione "[ah::service_root]/www/resources/LogoReg.gif"
} else {
    set logo "/resources/Cestec.gif"
#    set logo_regione "/resources/LogoReg.gif"
}

set logo_regione /resources/img/[parameter::get_from_package_key -package_key iter-portal -parameter stampe_logo_nome]

set code [template::adp_compile -file [ah::service_root]/packages/iter-portal/www/print-wallet-code.adp]
append html [template::adp_eval code]
append html "<!--PAGE BREAK-->"

    ns_return 200 text/html $html
if {[string equal $output_type "pdf"]} {

    set file_html [open /tmp/print-wallet-code-${maintainer_id}.html w]
    puts  $file_html $html
    close $file_html

    set fontsize 3
    with_catch error_msg {
        exec htmldoc --webpage --header ... --footer ... --quiet --landscape --left 0cm --right 0cm --top 0cm --bottom 0cm --fontsize $fontsize --size A4 -f /tmp/print-wallet-code-$maintainer_id.pdf /tmp/print-wallet-code-$maintainer_id.html
    } {
        # con htmldoc 1.8.23 e' necessaria la with_catch
    }

    # send pdf
    ns_returnfile 200 application/pdf /tmp/print-wallet-code-$maintainer_id.pdf

    # drops temporary files
    ns_unlink /tmp/print-wallet-code-$maintainer_id.pdf
    #ns_unlink /tmp/print-wallet-code-$maintainer_id.html

} else {
    ns_return 200 text/html $html
}

ad_script_abort

