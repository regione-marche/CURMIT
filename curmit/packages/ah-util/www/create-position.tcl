ad_page_contract {
    Crea una nuova posizione.

    @author Claudio Pasolini
    @creation-date 2009-09-14
    @cvs-id $Id: create-position
} {
    object_id
    lng
    lat
    return_url
}

permission::require_permission -party_id [ad_conn user_id] -object_id $object_id -privilege admin
set package_id [ad_conn package_id]

# Position info
set map_id [maps::get_map_id -package_id $package_id]
set space  [maps::get_center_and_zoom -map_id $map_id -package_id $package_id]
set center "$lat,$lng"
set zoom   15

# Get object type specific info
set object_type [acs_object_type $object_id]
callback -impl $object_type maps::object_info -object_id $object_id
set url     $map_info(url)
set pname   $map_info(pname)
set message $map_info(message)
set name    [db_string name "select acs_object__name($object_id)"]

# User message
set text_info "<!\[CDATA\[ <!-- info --> Sede <!-- end info --><p><b>$message</b><a href=$url> $pname</a></p>\]\]>"

set position_id [maps::save_position -lng $lng -lat $lat \
		     -map_id $map_id -name $name -text_info $text_info \
		     -object_id $object_id -type $object_type \
		     -center $center -zoom $zoom]

ad_returnredirect "$return_url"

ad_script_abort
