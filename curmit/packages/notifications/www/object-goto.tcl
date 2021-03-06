ad_page_contract {
    go to an object

    @author Tracy Adams (teadams@alum.mit.edu)
    @creation-date 22 July 2002
    @cvs-id $Id: object-goto.tcl,v 1.2.22.1 2013/08/26 07:57:13 gustafn Exp $
} {
    object_id:notnull
    type_id:notnull
} 


# added type_id parameter to redirect to the correct page for an object
# we need the implementation name which is not the same as the object_type

# look in tcl/delivery-procs.tcl, there is a get_impl_key proc that 
# queries the acs_sc_impls table for the implementation name
# but the query is delivery_type specific, so we can't use it here

set sc_impl_name [db_string get_notif_type {}]

set url [acs_sc::invoke -contract NotificationType -operation GetURL -call_args [list $object_id] -impl $sc_impl_name]

ad_returnredirect $url
