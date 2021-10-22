ad_page_contract {
    The display logic for the fs contents includelet. 

    These includelets show the contents of the given folder in a table 

    re-using a lot of code from file-storage-includelet

    @author Arjun Sanyal (arjun@openforce.net)
    @version $Id: file-storage-contents-includelet.tcl,v 1.1.1.1 2008/07/30 11:51:15 donb Exp $

}

set user_id [ad_conn user_id]
set list_of_folder_ids $folder_id
set n_folders [llength $list_of_folder_ids]
set file_storage_package_id $package_id

if {$n_folders != 1} {
    # something went wrong, we can't have more than one folder here
    ad_return -error
}

set root_folder_id [fs::get_root_folder -package_id $file_storage_package_id]

set folder_id [lindex $list_of_folder_ids 0]
set scope_fs_url "/packages/file-storage/www/folder-chunk"
set n_past_days ""
set url [site_node_object_map::get_url -object_id $folder_id]
set recurse_p 1
set contents_url "${url}folder-contents?[export_vars {folder_id recurse_p}]&"

# Enable Notifications

set folder_name [fs_get_folder_name $folder_id]
set notification_chunk [notification::display::request_widget \
    -type fs_fs_notif \
    -object_id $folder_id \
    -pretty_name $folder_name \
    -url [ad_conn url]?folder_id=$folder_id \
    ]

if [exists_and_not_null file_storage_package_id] {
    set use_webdav_p  [parameter::get -package_id $file_storage_package_id -parameter "UseWebDavP"]
    
    if { $use_webdav_p == 1} { 
	set webdav_url [fs::webdav_url -item_id $folder_id -package_id $file_storage_package_id]
    }
}

ad_return_template 
