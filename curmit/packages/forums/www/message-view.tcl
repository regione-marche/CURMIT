ad_page_contract {
    
    view a message (and its children)

    @author Ben Adida (ben@openforce.net)
    @creation-date 2002-05-25
    @cvs-id $Id: message-view.tcl,v 1.49 2009/04/27 20:25:33 emmar Exp $

} {
    message_id:integer,notnull
    {display_mode ""}
}

#######################
#
# First check all reasons why we might abort
#
#######################

# Load up the message information
forum::message::get -message_id $message_id -array message
if {![array exists message]} {
    ns_returnnotfound
    ad_script_abort
}

# Load up the forum information
forum::get -forum_id $message(forum_id) -array forum

# If disabled!
if {$forum(enabled_p) ne "t"} {
    ad_returnredirect "./"
    ad_script_abort
}

set user_id [ad_conn user_id]
forum::security::require_read_message -message_id $message_id
forum::security::permissions -forum_id $message(forum_id) -- permissions

# Check if the user has admin on the message
set permissions(moderate_p) [forum::security::can_moderate_message_p -message_id $message_id]
if {!${permissions(moderate_p)}} {
    # Set post_p according to permissions ...
    set permissions(post_p) [forum::security::can_post_message_p -message_id $message_id]
    # ... alternatively, we could use a parameter to behave like
    # in earlier versions just leave it is a reminder, if
    # someone still likes the old behavior.  This code should be
    # removed later....
    # if {$user_id == 0 && [parameter::get -parameter "OfferPostForAnonymousUserP" -default 1]} {
    #   set permissions(post_p) 1
    # } else {
    #   set permissions(post_p) [forum::security::can_post_forum_p -forum_id $message(forum_id)]
    # }
} else {
    set permissions(post_p) 1
}

# Check if the message is approved
if {!${permissions(moderate_p)} && $message(state) ne "approved" } {
    ad_returnredirect "forum-view?forum_id=$message(forum_id)"
    ad_script_abort
}

############################################
#
# Ok we're not aborting so lets do some work
#
############################################

# Show search box?
set searchbox_p [parameter::get -parameter ForumsSearchBoxP -default 1]

# If this is a top-level thread, we allow subscriptions here
if { $message(parent_id) eq "" } {
    set notification_chunk [notification::display::request_widget \
        -type forums_message_notif \
        -object_id $message(message_id) \
        -pretty_name $message(subject) \
        -url [ad_conn url]?message_id=$message(message_id) \
    ]
} else {
    set notification_chunk ""
}

if { [forum::use_ReadingInfo_p] && $message(state) eq "approved" } {
    set msg_id $message(root_message_id)
    set db_antwort [db_exec_plsql forums_reading_info__user_add_msg {}]
}

set context [list [list "./forum-view?forum_id=$message(forum_id)" "$message(forum_name)"]]
if {$message(parent_id) ne ""} {
    lappend context [list "./message-view?message_id=$message(root_message_id)" "$message(root_subject)"]
    lappend context [_ forums.One_Message]
} else {
    lappend context "$message(subject)"
}

if { $permissions(post_p) } {
    set reply_url [export_vars -base message-post { { parent_id $message(message_id) } }]
}

set thread_url [export_vars -base forum-view { { forum_id $message(forum_id) } }]

if {$forum(presentation_type) eq "flat"} {
    set display_mode flat
}

# stylesheets
set lang [ad_conn language]
template::head::add_css -href /resources/forums/forums.css -media all -lang $lang
template::head::add_css -href /resources/forums/print.css -media print -lang $lang
 
# set vars for i18n
template::head::add_script -type "text/javascript" -script [subst {
    var collapse_alt_text='[_ forums.collapse]';
    var expand_alt_text='[_ forums.expand]';
    var collapse_link_title='[_ forums.collapse_message]';
    var expand_link_title='[_ forums.expand_message]';}] -order 1

# js scripts
template::head::add_script -type "text/javascript" -src "/resources/forums/forums.js" -order 2

set page_title "#forums.Thread_title#"
