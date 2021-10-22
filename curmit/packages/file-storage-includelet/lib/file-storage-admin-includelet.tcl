ad_page_contract {

    The display logic for the file storage admin includelet.

    @author yon (yon@openforce.net)
    @creation-date 2002-05-13
    @version $Id: file-storage-admin-includelet.tcl,v 1.2 2008/08/25 20:25:17 donb Exp $

}

set return_url [ns_conn url]

set user_id [ad_conn user_id]

set url [site_node::get_url_from_object_id -object_id $package_id]
set fs_url "/shared/parameters?[export_url_vars package_id return_url]"
set show_fs_url_p [parameter::get_from_package_key -parameter ShowParametersLinkP -package_key file-storage-includelet -default 1]
