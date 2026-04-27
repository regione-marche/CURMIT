ad_page_contract {

    @author Claudio Pasolini
    @cvs-id view.tcl

} {
    {mode "edit"}
}

set inspector_id [auth::require_login]

if {![db_0or1row check_inspector "select name as inspector_name, validated_p, approved_p from iter_inspectors where inspector_id = :inspector_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata agli Ispettori registrati." /
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

set user_id $inspector_id

set context [list "Dati Registrati"]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	# Start section2
	{-section "sec2" {legendtext "Dati anagrafici"} {fieldset {class legend}}}
        {name:text 
            {label {Cognome/Ragione sociale}}
            {html {size 50 maxlength 200}}
        }
        {first_name:text 
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
	{course_type:text(radio)
	    {label {Tipo corso frequentato}}
	    {options { {"Enea" E} {"Ente Locale" L} }}
	}
	{course_resp:text,optional
	    {label {Ente responsabile del corso}}
	    {help_text {Obbligatorio se il corso è stato organizzato da un Ente Locale}}
	}
	{course_certif:text
	    {label {Attestato del corso}}
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

	db_1row get_inspector "
        select *
        from iter_inspectors
        where inspector_id = :inspector_id"

    } -after_submit {

	ad_returnredirect services
	ad_script_abort
    }


