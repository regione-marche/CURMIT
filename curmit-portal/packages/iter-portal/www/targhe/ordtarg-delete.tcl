ad_page_contract {
    Cancellazione degli ordini targhe 

    @author   Simone Pesci  
    @cvs-id   ordtarg-delete.tcl
} {
    ordtarg_id:integer,multiple
    {da_data         ""}
    {a_data          ""}
    {da_data_pretty  ""}
    {a_data_pretty   ""}
    {f_flag_evaso   "f"}
    is_admin_p      
}

set user_id [auth::require_login]

set link_list [export_url_vars da_data a_data da_data_pretty a_data_pretty f_flag_evaso is_admin_p]

set page_title "Cancellazione Ordini Targhe"
set context [list [list ../admin "Amministrazione Portale"] [list ordtarg-list?$link_list "Ordini Targhe"]]

if {$ordtarg_id eq ""} {
    ad_return_complaint 1 "Non hai selezionato alcun ordine!"
    ad_script_abort
} else {
    set ordtarg $ordtarg_id
}

set errnum 0
set errors [list]
set errors "Impossibile cancellare gli ordini gia' evasi:"
foreach ordtarg_id $ordtarg {

    # scarto i bollini già evasi
    db_1row query "select flag_evaso 
                        , cod_prenotazione
                     from iter_ordtarg 
                    where ordtarg_id = :ordtarg_id"

    if {$flag_evaso eq "t"} {
        incr errnum
        append errors "<li>Cod. prenotazione $cod_prenotazione"
    }
}

if {$errnum > 0} {

    ad_return_complaint $errnum "$errors"
    ad_script_abort
}

# creo form per acquisire data di riferimento
ad_form \
    -name ordtarg \
    -export {da_data a_data da_data_pretty a_data_pretty f_flag_evaso is_admin_p ordtarg_id} \
    -edit_buttons [list [list "Conferma" go]] \
    -form {

    } -on_submit {

        regsub {\{} $ordtarg {} ordtarg
        regsub {\}} $ordtarg {} ordtarg

    } -after_submit {

	db_transaction {
	    
	    foreach ordtarg_id $ordtarg {
		# cancello l'ordine di targhe 
		db_dml query "delete from iter_ordtarg where ordtarg_id = :ordtarg_id"
	    }
	}	    

	ad_returnredirect -message "Gli ordini selezionti sono stati cancellati." ordtarg-list?$link_list
        ad_script_abort
    }

