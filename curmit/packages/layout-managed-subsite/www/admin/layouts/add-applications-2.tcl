ad_page_contract {

    Add one or more package_keys to this instance of the layout manager package

    @author Don Baccus (dhogaza@pacifier.com)
    @creation-date 
    @cvs-id $Id: add-applications-2.tcl,v 1.3 2011/02/12 02:04:44 donb Exp $

} {
    package_key:multiple
    return_url:notnull,optional
}

db_transaction {
    foreach one_package_key $package_key {
        # Mount the package_key under our URL
        site_node::instantiate_and_mount \
            -parent_node_id [ad_conn subsite_node_id] \
            -package_key $one_package_key

    }
}

if { [info exists return_url] } {
    ad_returnredirect $return_url
}
