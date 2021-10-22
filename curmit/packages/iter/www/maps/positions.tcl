ad_page_contract {

    Google Map view, version 3.

    @author Claudio Pasolini
    @cvs-id positions.tcl
} {
    cod_cittadino
}

set user_id    [ad_conn user_id]
set package_id [ad_conn package_id]

set page_title "Posizioni geografiche"
set context [list [list /iter/src/coimcitt-list {Lista soggetti}] [list /iter/src/coimcitt-gest?cod_cittadino=$cod_cittadino] $page_title]

set party_name [db_string get "select cognome || ' ' || coalesce(nome, ' ') from coimcitt where cod_cittadino = :cod_cittadino"]

# preparo la subquery che individua tutte le occupazioni di un soggetto
set subquery "
        select to_number(cod_impianto,'99999999')
        from coimaimp
        where cod_responsabile = '[db_quote $cod_cittadino]'
"
