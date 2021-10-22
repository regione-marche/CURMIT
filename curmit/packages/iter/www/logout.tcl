ad_page_contract {
    Uscita dal programma.

    @author Nicola Mortoni
    @date   31/10/2002
} {
 nome_funz
}

if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
    set id_utente [ad_get_cookie iter_login_[ns_conn location]]
}

set headers [ns_conn outputheaders]

# faccio spirare i cookies
ns_set put $headers Set-Cookie "iter_login_[ns_conn location]=irrelevant; path=/; expires=Mon, 01-Jan-1990 01:00:00 GMT"
ns_set put $headers Set-Cookie "iter_rows_[ns_conn location]=irrelevant; path=/; expires=Mon, 01-Jan-1990 01:00:00 GMT"

iter_get_coimtgen;#rom01

if {$coimtgen(regione) eq "MARCHE"} {#rom01 aggiunta if e suo contenuto
    set url_portale [parameter::get_from_package_key -package_key iter -parameter url_portale -default ""]
    append url_portale "/register";#reindirizzo gli utenti alla pagina di log-in del portale
    ad_returnredirect -allow_complete_url $url_portale
} else {
ad_returnredirect index
}
