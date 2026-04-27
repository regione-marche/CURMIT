ad_page_contract {

    Initializes attachments package.
    All the attachments will be held into the root folder of
    the file-storage package.

} {
}

# get file-storage package id
set package_id [apm_package_id_from_key file-storage]

# get the root folder of the file-storage instance
set folder_id [fs::get_root_folder -package_id $package_id]

# map this package to the root folder
attachments::map_root_folder -package_id [ad_conn package_id] -folder_id $folder_id

ns_return 200 text/html "Il package (id=[ad_conn package_id]) è stato mappato sul folder $folder_id"
