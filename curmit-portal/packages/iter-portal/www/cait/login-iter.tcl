ad_page_contract {


    @cvs-id $Id: servcait.tcl,v 1.2 2018/06/25 Romitti Luca
} {

}
set nome_db [db_get_database];#rom01
set cait_id [auth::require_login]

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :cait_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}
if {$nome_db eq "iter-portal-marche"} {#rom01 if else e loro contenuto
array set arr [site_node::get_from_url -url /]
        set context_id $arr(package_id)

        # ottengo il gruppo a cui appartengono, con relazione di
        # composizione, tutti gli altri gruppi
set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]

set url [db_string a "select p.url
    from acs_rels r, groups g, parties p, iter_instances i
    where r.rel_type='composition_rel' and
          r.object_id_one = :subsite_group_id and
          r.object_id_two = g.group_id and
          g.group_id      = p.party_id and
          g.group_id      = i.instance_id
    order by group_name
    limit 1"]
    set token_code $cait_id[randomRange 99999999]
    db_dml q "update iter_login
                     set token_code       = :token_code
                       , data_last_login  = current_timestamp
                   where utente           = :cait_id"
    set url_redirect "$url/iter/single-sign-on?id_utente=$cait_id&token_code=$token_code&caller=cait"
} else {
    set url_redirect "/iter-portal/iter-link"
};#rom01

ns_returnredirect $url_redirect

