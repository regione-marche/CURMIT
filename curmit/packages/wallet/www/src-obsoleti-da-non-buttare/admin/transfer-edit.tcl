ad_page_contract {

  @author Claudio Pasolini
  @cvs-id transfer-edit.tcl

} {
    transfer_id:integer
}

ad_script_abort

set page_title "Modifica bonifico"
set buttons [list [list "$page_title" edit]]

set context [list [list transfers-list {Lista bonifici}] "$page_title"]

ad_form -name edit \
        -mode edit \
        -edit_buttons $buttons \
        -has_edit 1 \
        -form {
   
    transfer_id:key

        {filename:text(inform) 
            {label {Nome file}}
            {html {size 50}}
        }
        {reference:text(inform)
            {label {Riferimento}}
            {html {size 50}}
        }
        {rec62_orig:text,optional
            {label {Record 62 originale}}
            {html {size 100 disabled ""}}
        }
        {rec63_1_orig:text,optional
            {label {Record 63 originale}}
            {html {size 100 disabled ""}}
        }
        {rec63_1_elab:text
            {label {Record 63}}
            {html {size 100}}
        }
        {rec63_al_orig:text,optional 
            {label {Altri record 63 originali}}
            {html {size 100 disabled ""}}
        }
        {rec63_al_elab:text
            {label {Altri record 63}}
            {html {size 100}}
        }
        {creation_date_pretty:text(inform)
            {label {Data creazione}}
        }
        {currency_date_pretty:text(inform)
            {label {Data valuta}}
        }
        {amount_pretty:text(inform)
            {label {Importo}}
        }
        {wallet_id:text(inform)
            {label {Codice Portafoglio}}
        }
        {name:text(inform)
            {label {Nominativo}}
            {html {size 50}}
        }
        {iban_code:text(inform)
            {label {Codice IBAN}}
        }
        {cc_name:text(inform)
            {label {Intestatario}}
            {html {size 50}}
        }
        {status:text,optional
            {label {Stato}}
	    {html {disabled "" size 3}} 
        }
        {notes:text(textarea),optional,nospell 
            {label Note}
            {html {rows 3 cols 50 wrap soft}}
        }

} -edit_request {

    db_1row get_transfer_data "
        select *, 
               to_char(creation_date, 'DD/MM/YYYY') as creation_date_pretty, 
               to_char(currency_date, 'DD/MM/YYYY') as currency_date_pretty,
               ah_edit_num(amount, 2) as amount_pretty 
        from wal_transfers 
        where transfer_id = :transfer_id"

} -on_submit {

    # controllo status
    set status [db_string check "select status from wal_transfers where transfer_id = :transfer_id"]
    if {$status eq "L" || $status eq "P"} {
    } else {
	template::form::set_error edit status "Sono modificabili solo i bonifici in stato 'L' o 'P'."
	break
    }

} -edit_data {

    db_transaction {
	
	db_dml update "
            update wal_transfers set
                 rec63_1_elab  = :rec63_1_elab
               , rec63_al_elab = :rec63_al_elab
               , notes         = :notes
            where transfer_id = :transfer_id
      "
    }

} -after_submit {

    set url_vars [ad_get_client_property -default "" wallet admin/transfers-list]
    ad_returnredirect "transfers-list?$url_vars"
    ad_script_abort
}



