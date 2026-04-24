ad_page_contract {  
    Attachments list

    @author Claudio Pasolini

    @cvs-id index.tcl 
} {
    object_id:integer
}

# decode object
set object_description "<b>Allegato al protocollo</b>"

set package_id [apm_package_id_from_key iter-portal]

# get file-storage package id
set package_id [apm_package_id_from_key file-storage]

# get the root folder of the file-storage instance
set folder_id [fs::get_root_folder -package_id $package_id]

set return_url   [ad_conn url]?[ad_conn query]
set pretty_name  [ad_convert_to_text $object_description]

# creates attachments url
set attachment_add_url "[attachments::get_url]/file-add?pretty_object_name=[ns_urlencode $pretty_name]&folder_id=$folder_id&object_id=$object_id&return_url=[ns_urlencode $return_url]"

# prepare actions buttons
set actions [list "Aggiungi un allegato" "$attachment_add_url" "Aggiunge un nuovo allegato" ]

# grabs all vars 
set url_vars [export_ns_set_vars "url" {}]

set base_url [ad_conn url]

template::list::create \
    -name attachments \
    -multirow attachments \
    -actions $actions \
    -elements {
	name {
	    label "Nome"
	    link_url_col view_url
	    link_html {title "Visualizza allegato"}
	}
	description {
	    label "Descrizione"
	}
	delete {
	    link_url_col delete_url 
            link_html {title "Cancella questo allegato" onClick "return(confirm('Confermi la cancellazione?'));"}
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	    sub_class narrow
	}
    }


#
## get existing attachments 
#

set attach_list [attachments::get_attachments -object_id $object_id -base_url /iter-portal/]

# attach_list is a list of lists where each row contains 1.attachment_id 2.name
# and 3.url of the attachment
multirow create attachments attachment_id name view_url description delete_url

foreach attachment $attach_list {

    util_unlist $attachment attachment_id name view_url

    set description [db_string query "
    select description from cr_items ci, cr_revisions cr
    where ci.item_id       = :attachment_id and
          ci.live_revision = cr.revision_id" -default "&nbsp;"]

    set delete_url [export_vars -base "unattach" {object_id attachment_id}]
    
    multirow append attachments $attachment_id $name $view_url $description $delete_url
}



