ad_page_contract {

    @author Claudio Pasolini
    @cvs-id trustee-edit.tcl

} {
    trustee_id
}

set office_id [iter::office_script_init]

if {![db_0or1row check_trustee "
    select approved_p, validated_p, name as trustee_name from iter_trustees where office_id = :office_id and trustee_id = :trustee_id"]} {
    ad_returnredirect -message "Spiacente, ma l'amministratore non è tra quelli registrati dallo Studio associato." /
    ad_script_abort
}

if {!$approved_p} {
    ad_returnredirect -message "Funzione non disponibile per questo amministratore." /
    ad_script_abort
}

if {!$validated_p && !$approved_p} {
    set to_approve_p "t"
} else {
    set to_approve_p "f"
}

set reg_msg [iter::get_reg_msg -validated_p $validated_p -approved_p $approved_p -num_msg ""]

set mode "display"

set page_title "Visualizza Dati Registrati di $trustee_name"
set buttons [list [list "OK" view]]
set field_mode display

set context [list "Dati Registrati"]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	trustee_id:key

	# Start section2
	{-section "sec2" {legendtext "Dati Anagrafici"} {fieldset {class legend}}}
        {name:text 
            {label {Ragione sociale}}
            {html {size 50 maxlength 200}}
        }
	{address1:text
	    {label {Indirizzo}}
	    {html {size 50 maxlength 200}}
	}
	{city:text
	    {label {Comune}}
	    {html {size 50 maxlength 40}}
	}
	{address2:text,optional 
	    {label {Località}}
	    {html {size 50 maxlength 40}}
	}
	{province:text
	    {label {Provincia}}
	    {html {size 5 maxlength 4}}
	}
	{zipcode:text
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
	}
	{jtype:text(radio)
	    {label {Natura Giuridica}}
	    {options { {"Persona Fisica" 1} {"Persona Giuridica" 0}}}
	}
        {fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }
        {iva_code:text
            {label {P.IVA}}
            {html {maxlength 11}}
        }
	{phone:text
	    {label {Telefono}}
	}
	{fax:text,optional 
	    {label {Fax}}
	}
	{mobile:text,optional 
	    {label {Cellulare}}
	}
        {notes:text(textarea),optional,nospell 
            {label Note}
            {html {rows 5 cols 50 wrap soft}}
        }


	{-section ""}

    } -edit_request {

	db_1row get_trustee "
        select *
        from iter_trustees_view
        where trustee_id = :trustee_id"

    } -after_submit {

	ad_returnredirect trustees-services
	ad_script_abort
    }

