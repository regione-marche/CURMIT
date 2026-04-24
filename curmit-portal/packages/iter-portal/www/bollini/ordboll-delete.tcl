ad_page_contract {
    Cancellazione degli ordini bollini

    @author   Serena Saccani
    @cvs-id   ordboll-delete.tcl
} {
    ordboll_id:integer,multiple
    {da_data         ""}
    {a_data          ""}
    {da_data_pretty  ""}
    {a_data_pretty   ""}
    {f_flag_evaso   "f"}
    {is_admin_p      ""}
}

set user_id [auth::require_login]

set link_list [export_url_vars da_data a_data da_data_pretty a_data_pretty f_flag_evaso is_admin_p]

set page_title "Cancellazione Ordini Bollini"
set context [list [list ../admin "Amministrazione Portale"] [list ordboll-list?$link_list "Ordini Bollini"]]

if {$ordboll_id eq ""} {
    ad_return_complaint 1 "Non hai selezionato alcun ordine!"
    ad_script_abort
} else {
    set ordboll $ordboll_id
}

set errnum 0
set errors [list]
foreach ordboll_id $ordboll {

    # scarto i bollini già evasi
    db_1row query "select flag_evaso from iter_ordboll where ordboll_id = :ordboll_id"

    if {$flag_evaso eq "t"} {
        incr errnum
        append errors "<li>Impossibile cancellare gli ordini gia' evasi"
    }
}

if {$errnum > 0} {
    ad_return_complaint $errnum "$errors"
    ad_script_abort
}

# creo form per acquisire data di riferimento
ad_form \
    -name ordboll \
    -export {da_data a_data da_data_pretty a_data_pretty f_flag_evaso is_admin_p ordboll_id} \
    -edit_buttons [list [list "Conferma" go]] \
    -form {

    } -on_submit {

        regsub {\{} $ordboll {} ordboll
        regsub {\}} $ordboll {} ordboll

    } -after_submit {

	db_transaction {
	    
	    foreach ordboll_id $ordboll {
		# cancello l'ordine di bollini
		db_dml query "delete from iter_ordboll where ordboll_id = :ordboll_id"
	    }
	}	    

	ad_returnredirect -message "Gli ordini selezionti sono stati cancellati." ordboll-list?$link_list
        ad_script_abort
    }

