ad_page_contract {
    
    Posting History for a User

    @author Ben Adida (ben@openforce.net)
    @creation-date 2002-05-29
    @cvs-id $Id: user-history.tcl,v 1.13 2007/03/04 23:06:09 nimam Exp $

} {
    user_id:integer,notnull
    {view "date"}
    {groupby "forum_name"}
}

# Get user information
oacs::user::get -user_id $user_id -array user

set context [list [_ forums.Posting_History]]

ad_return_template
