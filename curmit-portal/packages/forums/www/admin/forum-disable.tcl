ad_page_contract {
    
    Disable a Forum

    @author Ben Adida (ben@openforce.net)
    @creation-date 2002-05-28
    @cvs-id $Id: forum-disable.tcl,v 1.6 2003/10/03 18:26:31 lars Exp $

} {
    forum_id:integer,notnull
}

forum::disable -forum_id $forum_id

ad_returnredirect "."



