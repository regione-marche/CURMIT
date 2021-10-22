ad_library {

    Package upgrade.

    @author claudio.pasolini@comune.mantova.it
    @cvs-id $Id:

}

ad_proc ah-util_upgrade_callback {
    -from_version_name:required
    -to_version_name:required
} {
    apm_upgrade_logic \
	-from_version_name $from_version_name \
	-to_version_name $to_version_name \
	-spec {
	    0.1d 2.1.1 {
		#apm_parameter_register ra_account_code "Conto debito verso Erario. Usato per imputare le ritenute d'acconto." mis-acct "042001110012" string "Parametri di controllo"
		#mis::script::new mis-acct/account-entry-link
		lang::catalog::import -package_key acs-subsite

                # ( 18.01.2011 - Livio Vs Nelson ) " DYNAMIC MENU' " ...
                mis::script::new ah-util/script-menu-delete
                mis::script::new ah-util/scripts-menu-list
	    }
	}
}

