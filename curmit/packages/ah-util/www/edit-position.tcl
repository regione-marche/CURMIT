ad_page_contract {
    Esegue il geocoding dell'oggetto, dato il suo indirizzo.
    In assenza dell'indirizzo o nell'impossibilità di interpretarlo
    è possibile posizionare l'oggetto a mano.

    @author Claudio Pasolini
    @creation-date 2009-09-14
    @cvs-id $Id: edit-position
} {
    {object_id ""}
    {object_type ""}
    {address ""}
    {return_url "."}
} -validate {
    valid_object {
	# Let's validate if this object can be mapped
	if {![callback::impl_exists -callback maps::object_info -impl $object_type]} {
	    ad_complain "[_ maps.No_callback_error]"
	}
    }
}

permission::require_permission -party_id [ad_conn user_id] -object_id $object_id -privilege admin
template::add_body_handler -event onload -script "initialize()"
template::add_body_handler -event onunload -script "GUnload()"
set key [parameter::get -package_id [ad_conn package_id] -parameter "KeyGoogleMaps"]

set package_id [ad_conn package_id]

if {[exists_and_not_null object_id]} {
    set pos [maps::get_position_from_object_id -object_id $object_id]
} else {
    set object_id $package_id
    set pos [maps::get_position_from_object_id -object_id $object_id]
}

if {$pos ne ""} {	
    set position_id $pos
} 

ad_form -name form_position -export {object_id object_type address return_url} -form {
    {position_id:key}
    {position:text(hidden)}
    {center:text(hidden)}
    {zoom:text(hidden)}
    {map_id:text(hidden)}
    {name:text,optional
	{label "Indirizzo"}
	{html {readonly ""}}
	{help_text "L'indirizzo indicato non è risolvibile.<br>Se vuoi puoi posizionarlo manualmente muovendo il marker sulla mappa prima di premere 'OK'."}
    }
    {text_info:text(hidden),optional
	{label "[_ maps.text_info]"}
	{help_text "[_ maps.text_info_help_text]"}
    }
} -on_request {

    # Position info
    set map_id [maps::get_map_id -package_id $package_id]
    set position "-13.866666, -55.122"

} -new_request {

    set space [maps::get_center_and_zoom -map_id $map_id -package_id $package_id]
    set center [lindex $space 0]
    set zoom [lindex $space 1]
    set name $address
    set text_info "Posizionato a mano"

} -edit_request {

    maps::get_position_info -position_id $position_id -array position_info
    set position "$position_info(lat), $position_info(lng)"
    set end [expr [string first "<!-- end info -->" $position_info(text_info)] - 1]
    
    set text_info [string range $position_info(text_info) 24 $end] 
    set name "$position_info(name)"

    set center $position_info(center)
    set zoom $position_info(zoom)

    set space [maps::get_center_and_zoom -map_id $map_id]
    if {$center eq ""} {
	set center [lindex $space 0]
    }
    if {$zoom eq ""} {
	set zoom [lindex $space 1]
    }
    
} -on_submit {
    # Get object type specific info
    callback -impl $object_type maps::object_info -object_id $object_id
    set url $map_info(url)
    set pname $map_info(pname)
    set object_id $map_info(object_id)
    set message $map_info(message)

    # View parameters
    set map_package_id [maps::get_package_id -map_id $map_id]
    set center [string trimleft $center "("]
    set center [string trimright $center ")"]

    # User message
    set text_info "<!\[CDATA\[ <!-- info --> $text_info <!-- end info --><p><b>$message</b><a href=$url> $pname</a></p>\]\]>"

    set lat [string trim [string trim [lindex $position 0] "("] ","]
    set lng [string trim [lindex $position 1] ")"]

} -new_data {
    set center [string trimleft $center "("]
    set center [string trimright $center ")"]
    set position_id [maps::save_position -lng $lng -lat $lat \
			 -map_id $map_id -name $name -text_info $text_info \
			 -object_id $object_id -type $object_type \
			 -center $center -zoom $zoom]

} -edit_data {
    set center [string trimleft $center "("]
    set center [string trimright $center ")"]
    
    set position_id [maps::change_position -position_id $position_id -lng $lng -lat $lat \
			 -map_id $map_id -name $name -text_info $text_info \
			 -center $center -zoom $zoom]

} -after_submit {

    ad_returnredirect "$return_url"
}
