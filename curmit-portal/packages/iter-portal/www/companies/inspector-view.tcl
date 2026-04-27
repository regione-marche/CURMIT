ad_page_contract {

    @author Claudio Pasolini
    @cvs-id inspector-view.tcl

} {
    inspector_id
    {mode "edit"}
}

set company_id [auth::require_login]

if {![db_0or1row check_company "select 1 from iter_inspecting_companies where company_id = :company_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata alle aziende di ispezione registrate." /
    ad_script_abort
}

if {![db_0or1row check_inspector "select approved_p, validated_p, name || ' ' || first_name as inspector_name from iter_inspectors where company_id = :company_id and inspector_id = :inspector_id"]} {
    ad_returnredirect -message "Spiacente, ma l'ispettore non è tra quelli registrati dall'azienda." inspectors-list
    ad_script_abort
}

if {!$approved_p} {
    ad_returnredirect -message "Funzione non disponibile per questo ispettore, in quanto non ancora approvato." inspectors-list
    ad_script_abort
}


set mode "display"

set page_title "Visualizza Dati Registrati di $inspector_name"
set buttons [list [list "OK" view]]
set field_mode display

set user_id $company_id

set context [list "$page_title"]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	inspector_id:key

	# Start section2
	{-section "sec2" {legendtext "Dati Anagrafici"} {fieldset {class legend}}}
    {name:text 
	{label {Cognome/Ragione sociale}}
	{html {size 50 maxlength 200}}
    }
    {first_name:text 
	{label {Nome}}
	{html {size 50 maxlength 200}}
    }
    {inspector_no:text,optional 
	{label {Matricola}}
	{html {size 20 maxlength 30}}
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
        {html {size 5 maxlength 2}}
    }
    {zipcode:text
        {label {C.A.P.}}
        {html {size 10 maxlength 5}}
    }
    {fiscal_code:text,optional
	{label {Codice fiscale}}
	{html {maxlength 16}}
    }
    {iva_code:text,optional
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

	db_1row get_inspector "
        select *
        from iter_inspectors
        where inspector_id = :inspector_id"

    } -after_submit {
	ad_returnredirect inspector-services
	ad_script_abort
    }
