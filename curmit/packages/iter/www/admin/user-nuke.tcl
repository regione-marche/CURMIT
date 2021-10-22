ad_page_contract {

    Try to delete a pending user from the database.
    
    @author Andrew Grumet (aegrumet@alum.mit.edu)
    @creation-date 2002-08-08
    @version $Id: user-nuke.tcl,v 1.1.1.1 2014/03/06 15:04:07 nsadmin Exp $
} {
    user_id:integer,notnull
}

ad_proc -public remove_user_completely {
        {-user_id:required}
        {-on_fail soft_delete}
    } {
        Remove the user from ACS as well.  Chances are pretty good that
        this will fail because it's hard to chase down every piece
        of content the user has ever put into the system.  The net result is
        that there may be stray referential integrity contraints that
        will throw errors when we try to remove the user record permanently.

        @param on_fail indicates what we do if the permanent removal fails. Setting to
         <code>soft_delete</code> will result in a repeat call to <code>acs_user::delete</code>
         but this time without the <code>-permanent</code> flag.  Setting to <code>error</code>
         (or anything else) will result in re-throwing the original error.
    } {
        
        if { [catch {
            acs_user::delete -user_id $user_id -permanent
        } errMsg] } {
            ns_log Notice "dotlrn::remove_user_completely: permanent removal failed for user $user_id.  Invoking on_fail option '$on_fail'"
            if { [string equal $on_fail soft_delete] } {
                acs_user::delete -user_id $user_id
            } else {
                error $errMsg
            }
        }
    }

set referer "/acs-admin/users/"

db_1row select_user_info {}

set pretty_last_visit [lc_time_fmt $last_visit "%Q %T"]

form create confirm_delete

element create confirm_delete user_id \
    -datatype integer \
    -widget hidden \
    -value $user_id

element create confirm_delete confirmed_p \
    -label "Confermi l'eliminazione?" \
    -datatype text \
    -widget radio \
    -options [list [list No f] [list Si t]] \
    -value f

set context_bar [list [list /acs-admin/users/ Users] Elimina]

if [form is_valid confirm_delete] {
    form get_values confirm_delete user_id confirmed_p
    if [string equal $confirmed_p t] {
	if [catch {remove_user_completely -user_id $user_id } errMsg ] {
        set error_msg $errMsg
	    ad_return_template user-nuke-error
	} else {
	    # Nuke was successful.
	    ad_returnredirect $referer
	    ad_script_abort
	}
    } else {
	# Nuke cancelled
	ad_returnredirect $referer
	ad_script_abort
    }
}
