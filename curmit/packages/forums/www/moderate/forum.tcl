ad_page_contract {

    Moderate a Forum

    @author Ben Adida (ben@openforce.net)
    @creation-date 2002-05-24
    @cvs-id $Id: forum.tcl,v 1.5 2003/12/17 15:45:31 leed Exp $

} {
    forum_id:integer,notnull
}

# Check that the user can moderate the forum
forum::security::require_moderate_forum -forum_id $forum_id

# Get forum data
forum::get -forum_id $forum_id -array forum

ad_return_template
