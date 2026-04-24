ad_page_contract {

    @author Claudio Pasolini
    @cvs-id view.tcl

} {
}

set office_id [auth::require_login]

if {![db_0or1row check_office "select 1 from iter_offices where office_id = :office_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata agli Studi associati registrati." /
    ad_script_abort
}

set mode "display"

set page_title "Visualizza Dati Registrati"
set buttons [list [list "OK" view]]
set field_mode display

set context [list "Dati Registrati"]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	office_id:key

	# Start section2
	{-section "sec2" {legendtext "Dati Studi associati"} {fieldset {class legend}}}
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

    } -edit_request {

	db_1row get_office "
        select *
        from iter_offices
        where office_id = :office_id"

    } -after_submit {

	ad_returnredirect services
	ad_script_abort
    }


