ad_page_contract {

    Imposta il menu dinamicamente in funzione dell'utente, dei suoi permessi e del tipo di interfaccia utente.

    @cvs-id $Id: dynamic_menu.tcl
} {
}

set id_utente [iter_get_id_utente]
if {$id_utente == ""} {
    set login [ad_conn package_url]
        iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
}

# per velocizzare l'operazione utilizzo la cache di aolserver
if {[ns_cache get "dynamic_menu_cache" $id_utente menu] eq "0"} {
    # inizio la costruzione del menu
    set menu ""

    # Leggo i parametri necessari
    if {![db_0or1row query "select flag_menu_yui as yui_menu_p
                                 , flag_alto_contrasto
                              from coimuten
                             where id_utente = :id_utente"]
    } {
        set login [ad_conn package_url]
        iter_return_complaint "Utente $id_utente non trovato. Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
    }
    
    set pack_dir           [iter_package_key]
    set path_pack_iter_www [acs_package_root_dir $pack_dir]/www
    if {$yui_menu_p} {
        source $path_pack_iter_www/dynamic-menu-yui.tcl
    } else {
        source $path_pack_iter_www/dynamic-menu-html.tcl
    }

    # salvo nella cache il menu
    ns_cache set "dynamic_menu_cache" $id_utente $menu

}
