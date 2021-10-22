ad_page_contract {
    The display logic for the fs includelet

    @author yon (yon@openforce.net)
    @author Arjun Sanyal (arjun@openforce.net)
    @cvs_id $Id: file-storage-includelet.tcl,v 1.1.1.1 2008/07/30 11:51:15 donb Exp $
} -query {
    {n_past_days "99999"}
    {page_num ""}
} -properties {
    user_id:onevalue
    user_root_folder:onevalue
    user_root_folder_present_p:onevalue
    write_p:onevalue
    admin_p:onevalue
    delete_p:onevalue
    url:onevalue
    folders:multirow
    n_folders:onevalue
}

set user_id [ad_conn user_id]
set list_of_folder_ids $folder_id
set n_folders [llength $list_of_folder_ids]

set folder_id [lindex $list_of_folder_ids 0]
set file_storage_node_id [site_node::get_node_id_from_object_id \
                             -object_id [ad_conn package_id]]
set file_storage_package_id [site_node::get_children \
                                -package_key file-storage \
                                -node_id $file_storage_node_id \
                                -element package_id]

set url [site_node_object_map::get_url -object_id $folder_id]

set recurse_p 1
set contents_url "${url}folder-contents?[export_vars {folder_id recurse_p}]&"

set admin_p [permission::permission_p -object_id $folder_id -privilege "admin"]
set write_p $admin_p
if {!$write_p} {
    set write_p [permission::permission_p -object_id $folder_id -privilege "write"]
}
set delete_p $admin_p
if {!$delete_p} {
    set delete_p [permission::permission_p -object_id $folder_id -privilege "delete"]
}

set query "select_folders"

template::list::create -name folders -multirow folders -key forum_id -pass_properties {} \
    -elements {
	icon {
	    label ""
	    display_template {
		<if @folders.type@ eq "folder">
		  <a href="@folders.url@?folder_id=@folders.object_id@">
		  <img border="0" src="/resources/file-storage/folder.gif" height="16" width="16" alt="#file-storage.Folder#">
                  </a> 
		</if>
		<elseif @folders.type@ eq "url">
		    <a href="@folders.url@url-goto?url_id=@folders.object_id@"><img border="0" src="/resources/file-storage/file.gif" alt="#file-storage.File#"></a>
		</elseif>
		<else>
		   <a href="@folders.url@download/@folders.file_upload_name@?version_id=@folders.live_revision@">
		   <img border="0" src="/resources/file-storage/file.gif" alt="#file-storage.File#"></a>
		</else>
	    }
	}
	name {
	    label ""
	    display_template {
		<if @folders.type@ eq "folder">
		  <a href="@folders.url@?folder_id=@folders.object_id@">@folders.name@</a>		
		</if>
		<elseif @folders.type@ eq "url">
		  <a href="@folders.url@url-goto?url_id=@folders.object_id@">@folders.name@</a>
		</elseif>
		<else>
		   <a href="@folders.url@download/@folders.file_upload_name@?version_id=@folders.live_revision@">@folders.name@</a>
		</else>
	    }
	}
	type {
	    label ""
	    display_template {
		<if @folders.type@ eq "folder">
		  #file-storage.folder_type_pretty_name#
		</if>
		<else>
		   @folders.type@
		</else>
	    }
	}
	size {
	    label ""
	    display_template {
		<if @folders.type@ eq "folder">
		  <if @folders.content_size@ eq 0>
		    0 #file-storage-includelet.items#
		  </if>
		  <elseif @folders.content_size@ gt 1>
		    @folders.content_size@ #file-storage-includelet.items#
		  </elseif>
	          <else>
                    @folders.content_size@ #file-storage-includelet.item#
		  </else>
		</if>
		<elseif @folders.type@ eq "url">
		   <i>n/a</i>
		</elseif>
		<else>
		   @folders.content_size@ <if @folders.content_size eq 1>#file-storage-includelet.byte#</if><else>#file-storage-includelet.bytes#</else>
		   \[<a href="@folders.url@file?file_id=@folders.object_id@">#file-storage-includelet.view_details#</a>\]
		</else>
	    }
	}
    }

db_multirow folders $query {
    # The name of the folder may contain message keys that need to be localized on the fly
    set name [lang::util::localize $name]
}

# Enable Notifications

set folder_name [fs_get_folder_name $folder_id]
set notification_chunk [notification::display::request_widget \
    -type fs_fs_notif \
    -object_id $folder_id \
    -pretty_name $folder_name \
    -url [ad_conn url]?[ad_conn query]&folder_id=$folder_id \
    ]

if [exists_and_not_null file_storage_package_id] {
    set use_webdav_p  [parameter::get -package_id $file_storage_package_id -parameter "UseWebDavP"]
    
    if { $use_webdav_p == 1} { 
	set webdav_url [fs::webdav_url -item_id $folder_id -package_id $file_storage_package_id]
        regsub -all {/\$} $webdav_url {/\\$} webdav_url
    }
}


ad_return_template 
