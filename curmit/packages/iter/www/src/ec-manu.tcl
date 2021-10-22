ad_page_contract {

    Estratto conto di un manutentore.

    @author Claudio Pasolini
    @cvs-id $Id: ec.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================

} {
    {rows_per_page  "999"}
    {offset         "0"}
    {nome_funz      ""}
    {nome_funz_caller ""}
    {caller    "index"}
}

#sim01 set user_id    [auth::require_login]
set lvl 1
set cod_manutentore [iter_check_login_portafoglio $lvl $nome_funz] 

set package_id [ad_conn package_id]

set return_url "ec?maintainer_id=$cod_manutentore&[export_url_vars caller nome_funz nome_funz_caller]"

ad_returnredirect $return_url
ad_script_abort
