ad_page_contract {

    Filtro per ricercare una singola targa.

    @author Simone Pesci
    @cvs-id $Id: coimtarg-filter.tcl

} {
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set page_title "Ricerca targa"
set context [list  "$page_title"]

# creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{f_targa:text,optional
	    {label {Targa}}
	    {html {size 16 maxlength 16}}
	}
    } -on_request {
    } -on_submit {

	set errnum 0
	
	
	

	if {$errnum > 0} {
	    break
	}

    } -after_submit {

	set link_list [export_url_vars f_targa]
	set return_url "coimtarg-list?$link_list"
	
	ad_returnredirect $return_url
	ad_script_abort
    }

