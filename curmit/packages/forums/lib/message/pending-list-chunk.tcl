ad_page_contract {

    Moderate a Forum

    @author Ben Adida (ben@openforce.net)
    @creation-date 2002-05-24
    @cvs-id $Id: pending-list-chunk.tcl,v 1.1 2003/12/17 15:45:29 leed Exp $

}

# Get the threads that need approval
db_multirow pending_threads select_pending_threads {}

if {[exists_and_not_null alt_template]} {
  ad_return_template $alt_template
}
