ad_library {

    Various Procs.

    @author claudio.pasolini@comune.mantova.it
    @cvs-id $Id:

}

namespace eval mis {}


ad_proc -public mis::subsite_group_list  {
    -url:required 
} { 
    Returns the list of groups belonging to the given subsite

    @param url The url of the subsite e.g. /intranet
} {

    # trovo il subsite 
    array set arr [site_node::get_from_url -url ${url}/]
    set context_id $arr(package_id)

    # ottengo il gruppo a cui appartengono, con relazione di
    # composizione, tutti gli altri gruppi 
    set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]

    return [db_list query "
    select object_id_two
    from acs_rels
    where rel_type      = 'composition_rel' and
          object_id_one = :subsite_group_id"]
}

ad_proc -public mis::user_group {
    -user_id:required
} {
    Restituisce il gruppo di cui l'utente fa parte.
    N.B. Un utente DEVE appartenere ad uno ed un solo gruppo 
} {
    # get group_id of the user
    set group_list [mis::subsite_group_list -url ""]
    set group_list [join $group_list ,]

    return [db_string query "
           select object_id_one
           from acs_rels
           where object_id_two = :user_id and
                 object_id_one in($group_list)" -default ""]
}
