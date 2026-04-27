ad_page_contract {

    @author Luca Romitti
    @cvs-id software-house-view

} {
    {mode "edit"}
}

set software_house_id [auth::require_login]

if {![db_0or1row check_maint "select is_active_p from iter_software_houses where software_house_id = :software_house_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata agli Amministratori di Condominio registrati." /
    ad_script_abort
}

set mode "display"

if {[string equal $mode "edit"]} {
    set page_title "Modifica Dati Registrati"
    set buttons [list [list "Modifica Dati Registrati" edit]]
    set field_mode display
} else {
    set page_title "Visualizza Dati Registrati"
    set buttons [list [list "OK" view]]
    set field_mode display
}

set user_id [auth::require_login] 

set context [list "Dati Registrati"]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	cait_id:key

	# Start section2
	{-section "sec2" {legendtext "Dati Amministratore"} {fieldset {class legend}}}
        {name:text 
            {label {Cognome/Ragione sociale}}
            {html {size 50 maxlength 200}}
        }
        {first_name:text 
            {label {Ragione sociale}}
            {html {size 50 maxlength 200}}
        }
        {iter_code:text ,optional
            {label {Codice Iter}}
            {html {size 50 maxlength 200}}
        }
        {password:text,optional
            {label {Password}}
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
	{email:email
	    {label Email}
	    {html {size 30}}
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

    } -on_request {

	db_1row get_maintainer "
        select *
        from iter_software_houses
        where software_house_id = :software_house_id"

    } -after_submit {


	ad_returnredirect servsoft
	ad_script_abort
    }


