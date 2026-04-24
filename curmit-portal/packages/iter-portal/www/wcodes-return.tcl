ad_page_contract {

  @author Claudio Pasolini
  @cvs-id wcodes-add-edit.tcl

} {
    party_type
}

set user_id [auth::require_login]
set page_title "Esito Registrazione"

switch $party_type {
     maintainer {
	# set return_to services
       set return_to /iter-portal/services
	set context [list [list $return_to "Servizi per i manutentori"] $page_title]
    }
    cait       {
	# set return_to cait/services
       set return_to /iter-portal/cait/servcait
	set context [list [list $return_to "Servizi per i manutentori"] $page_title]
    }
    trustee    {
	# set return_to jbuild/servtrust
       set return_to /iter-portal/jbuild/servtrust
	set context [list [list $return_to "Servizi per gli amministratori"] $page_title]
    }
    office     {
	# set return_to offices/trustees-services
       set return_to /iter-portal/jbuild/servtrust
	set context [list [list $return_to "Servizi per gli amministratori"] $page_title]
    }
    default    {
	ad_returnredirect /
	ad_script_abort
    }
}



