ad_page_contract {
    
    Form to edit a message

    @author Ben Adida (ben@openforce.net)
    @creation-date 2002-05-25
    @cvs-id $Id: message-edit.tcl,v 1.8 2003/12/17 15:45:31 leed Exp $

} {
    message_id:integer,notnull
    {return_url "../message-view"}
}

forum::message::get -message_id $message_id -array message
forum::get -forum_id $message(forum_id) -array forum

ad_return_template
