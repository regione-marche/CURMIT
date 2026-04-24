ad_page_contract {
    Menu servizi delle software house

    @cvs-id $Id: servsoft.tcl,v 1.1.1.1 2021/11/02
} {

}

set software_house_id [auth::require_login]

if {![db_0or1row check_maint "select is_active_p from iter_software_houses where software_house_id = :software_house_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata agli Amministratori di Condominio registrati." /
    ad_script_abort
}

set page_title "Servizi per le Software-house registrate"
set context [list "Servizi"]


# trovo il subsite
array set arr [site_node::get_from_url -url /]
set context_id $arr(package_id)

# ottengo il gruppo a cui appartengono, con relazione di
# composizione, tutti gli altri gruppi
set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]

db_multirow -extend {url_via url_par} instances query "
     select g.group_name
          , p.url
          , i.instance_name as dbn_iter
       from acs_rels r
          , groups g
          , parties p
          , iter_instances i
      where r.rel_type      ='composition_rel'
        and r.object_id_one = :subsite_group_id
        and r.object_id_two = g.group_id
        and g.group_id      = p.party_id
        and g.group_id      = i.instance_id
      order by group_name
    " {
	set caller   "scarico-portale"
	set url_link [export_url_vars dbn_iter caller]
	set url_via "coimscar-viae-gest?$url_link"
	set url_par "coimscar-parm-gest?$url_link"
	
    }
