namespace eval file_storage_includelet {}

ad_proc -public file_storage_includelet::initialize {
    element_id
} {
    The default behavior of the file storage includelet is to just wrap
    the file storage package.  Which means we display the root folder for the
    file storage instance we're associated with.
} {

    set package_id [layout::element::get_column_value \
                     -element_id $element_id \
                     -column package_id] 

    set folder_id [fs::get_root_folder -package_id $package_id]
    set node_id [site_node::get_node_id_from_object_id -object_id $package_id]
    site_node_object_map::new -object_id $folder_id -node_id $node_id

    layout::element::parameter::set_values \
        -element_id $element_id \
        -parameters [list scoped_p t folder_id $folder_id]

}
