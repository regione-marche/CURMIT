ad_library {

    Forums Library - Reply Handling

    @creation-date 2002-05-17
    @author Ben Adida <ben@openforce.biz>
    @cvs-id $Id: forum-reply-procs.tcl,v 1.6 2008/09/20 12:10:28 gustafn Exp $

}

namespace eval forum::notification {

    ad_proc -public get_url {
        object_id
    } {
        returns a full url to the object_id.
        handles messages and forums.
    } { 

	set object_type [db_string select_object_type {}]

	if {$object_type eq "forums_message" } {

            # object is a message
	    set message_id $object_id
	    forum::message::get -message_id $message_id -array message
	    set forum_id $message(forum_id)
	    set forum_url "[ad_url][db_string select_forums_package_url {}]"
	    return ${forum_url}message-view?message_id=$message(root_message_id)

	} else {

	    # object_type is a forum
	    set forum_id $object_id
	    set forum_url "[ad_url][db_string select_forums_package_url {}]"	  
	    return ${forum_url}forum-view?forum_id=$forum_id

        }
    }

    ad_proc -public process_reply {
        reply_id
    } {

        # Get the data
        notification::reply::get -reply_id $reply_id -array reply

	# get rid of Outlook HTML DOCTYPE
	set reply(content) [regsub {<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4\.0 Transitional//EN">} $reply(content) {}]

        # Get the message information
        forum::message::get -message_id $reply(object_id) -array message
        # Insert the message
        forum::message::new -forum_id $message(forum_id) \
                -parent_id $message(message_id) \
                -subject $reply(subject) \
                -content $reply(content) \
                -user_id $reply(from_user)
    }
        
    
}



