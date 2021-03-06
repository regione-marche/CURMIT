ad_page_contract {

    a message chunk to be included in a table listing of messages

    @author yon (yon@openforce.net)
    @author arjun (arjun@openforce.net)
    @creation-date 2002-06-02
    @cvs-id $Id: row.tcl,v 1.11 2008/11/09 22:25:20 emmar Exp $

}

set viewer_id [ad_conn user_id]
set useScreenNameP [parameter::get -parameter "UseScreenNameP" -default 0]
set screen_name [db_string select_screen_name { select screen_name from users where user_id = :viewer_id}]

if {![exists_and_not_null rownum]} { 
    set rownum 1
}

if {![exists_and_not_null presentation_type]} {
    set presentation_type ""
}

set message(content) [ad_html_text_convert -from $message(format) -to text/html -- $message(content)]
set message(screen_name) $screen_name

# convert emoticons to images if the parameter is set
if { [string is true [parameter::get -parameter DisplayEmoticonsAsImagesP -default 0]] } {
    set message(content) [forum::format::emoticons -content $message(content)]
}

# JCD: display subject only if changed from the root subject
if {![info exists root_subject]} {
    set display_subject_p 1
} else {
    regsub {^(Response to |\s*Re:\s*)*} $message(subject) {} subject
    set display_subject_p [expr {$subject ne $root_subject }] 
}

if {[exists_and_not_null alt_template]} {
  ad_return_template $alt_template
}
if {![info exists message(message_id)]} {
    set message(message_id) none
}
if {![info exists message(tree_level)] || $presentation_type eq "flat"} {
    set message(tree_level) 0
}

set allow_edit_own_p [parameter::get -parameter AllowUsersToEditOwnPostsP -default 0]
set own_p [expr {$message(user_id) eq $viewer_id && $allow_edit_own_p}]

if { [info exists preview] } {
    set any_action_p 0
} else {
    set notflat_p [expr {$presentation_type ne "flat"}]
    set post_and_notflat_p [expr {$permissions(post_p) && $notflat_p}]
    set any_action_p [expr { $post_and_notflat_p || $viewer_id || $moderate_p }]
}
