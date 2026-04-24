ad_page_contract {

    Pre-filtro multiportafoglio estratto conto di un manutentore

    @author Gabriele Lo Vaglio
    @cvs-id $Id: ec-filter.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================

} {
    maintainer_id
    {f_ente_portafoglio  ""}

}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set page_title "Ente portafoglio"
set context [list  "$page_title"]

# creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -export {
	maintainer_id
    } \
    -form {
	
	{f_ente_portafoglio:text(select)
	    {options { {"Scegli" ""} [db_list_of_lists query "
            select g.group_name, i.instance_name
              from groups g, iter_instances i
             where g.group_id = i.instance_id
            "] }}
	    {label {Ente portafoglio}}
	}	
	
    } -on_request {

    } -on_submit {
	
	set errnum 0

	if {$errnum > 0} {
	    break
	} 

    } -after_submit {

	set link_gest [export_url_vars maintainer_id f_ente_portafoglio]
	set return_url "ec?$link_gest"
	
	ad_returnredirect $return_url
	ad_script_abort


    }

