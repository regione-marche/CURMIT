ad_page_contract {

    @author Claudio Pasolini
    @cvs-id maintainer-edit.tcl

} {
    maintainer_id
    {mode "edit"}
}

set cait_id [auth::require_login]

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :cait_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}
if {![db_0or1row check_maint "select approved_p, validated_p, name as maintainer_name from iter_maintainers where cait_id = :cait_id and maintainer_id = :maintainer_id"]} {
    ad_returnredirect -message "Spiacente, ma il manutentore non è tra quelli registrati dal CAIT." /
    ad_script_abort
}
if {[string equal $approved_p "f"]} {
    ad_returnredirect -message "Funzione non disponibile per questo manutentore." /
    ad_script_abort
}

set num_msg [iter::check_reg -maintainer_id $maintainer_id]
if {[string equal $num_msg ""] && ![string equal $validated_p "t"] && ![string equal $approved_p "t"]} {
    set to_approve_p "t"
} else {
    set to_approve_p "f"
}

set reg_msg [iter::get_reg_msg -validated_p $validated_p -approved_p $approved_p -num_msg $num_msg]

set mode "display"

if {[string equal $mode "edit"]} {
    set page_title "Modifica Dati Registrati"
    set buttons [list [list "Modifica Dati Registrati" edit]]
    set field_mode display
} else {
    set page_title "Visualizza Dati Registrati di $maintainer_name"
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
	
	maintainer_id:key

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
	{where_registered:text,optional
	    {label {Località Registro Imprese}}
	    {html {size 50}}
	}
	{registration_no:text,optional
	    {label {N. Registro Imprese}}
	    {html {size 50}}
	}
	{where_rea:text,optional
	    {label {Località REA}}
	    {html {size 50}}
	}
	{rea_no:text,optional
	    {label {N. REA}}
	    {html {size 50 maxlength 15}}
	}
        {role:text(radio)
            {label {Ruolo}}
	    {options { {"Manutentore" 1} {"Installatore" 0} {"Installatore/Manutentore" 2}}}
        }
	{op_number_pretty:text
	    {label {N° Operatori impegnati:}}
	    {html {size 10}}
	}
	{an_number_pretty:text
	    {label {N° Analizzatori utilizzati:}}
	    {html {size 10}}
	}
	{de_number_pretty:text
	    {label {N° Deprimometri utilizzati:}}
	    {html {size 10}}
	}
	{associated_to:text,optional
	    {label {Associazione di riferimento:}}
	    {html {size 50}}
	}
	{capital_pretty:text,optional
	    {label {Capitale versato}}
	}
        {notes:text(textarea),optional,nospell 
            {label Note}
            {html {rows 5 cols 50 wrap soft}}
        }

        {representative_id:integer(hidden)}

	# Start section3
	{-section "sec3" {legendtext "Rappresentante Legale"} {fieldset {class legend}}}
        
        {rep_name:text 
            {label {Cognome}}
            {html {size 50 maxlength 200}}
        }
        {rep_first_name:text 
            {label {Nome}}
            {html {size 50 maxlength 200}}
        }
	{rep_address1:text
	    {label {Indirizzo}}
	    {html {size 50 maxlength 200}}
	}
	{rep_city:text
	    {label {Comune}}
	    {html {size 50 maxlength 40}}
	}
	{rep_address2:text,optional 
	    {label {Località}}
	    {html {size 50 maxlength 40}}
	}
	{rep_province:text
	    {label {Provincia}}
	    {html {size 5 maxlength 4}}
	}
	{rep_zipcode:text
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
	}
        {rep_fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }

	{-section ""}

    } -edit_request {

	db_1row get_maintainer "
        select *
        from iter_maintainers_view
        where maintainer_id = :maintainer_id"

    } -after_submit {


	ad_returnredirect services
	ad_script_abort
    }

template::list::create \
    -name operators \
    -multirow operators \
    -elements {
	name {
	    label "Cognome"
	}
	first_name {
	    label "Nome"
	}
	iter_no {
	    label "Codice I.Ter"
	}
	password {
	    label "Password"
	}
	no {
	    label "Matricola"
	}
	fiscal_code {
	    label "Cod. fiscale"
	}
	phone {
	    label "Telefono"
	}
	mobile {
	    label "Cellulare"
	}
	address {
	    label "Recapito"
	}
	notes {
	    label "Note"
	}
    }

    db_multirow -extend {} operators query "
                   select *
                   from iter_operators
                   where maintainer_id = :maintainer_id
                   order by name
    " {
	
    }

template::list::create \
    -name detools \
    -multirow detools \
    -elements {
	brand {
	    label "Marca"
	}
	model {
	    label "Modello"
	}
	no {
	    label "Matricola"
	}
	last_calibration_date_pretty {
	    label "Data ultima taratura"
	}
    }

    db_multirow -extend {} detools query "
                   select *, to_char(last_calibration_date, 'DD/MM/YYYY') as last_calibration_date_pretty
                   from iter_tools
                   where maintainer_id = :maintainer_id
                     and type = '1'
                   order by brand
    " {
	
    }

template::list::create \
    -name antools \
    -multirow antools \
    -elements {
	brand {
	    label "Marca"
	}
	model {
	    label "Modello"
	}
	no {
	    label "Matricola"
	}
	last_calibration_date_pretty {
	    label "Data ultima taratura"
	}
    }

    db_multirow -extend {} antools query "
                   select *, to_char(last_calibration_date, 'DD/MM/YYYY') as last_calibration_date_pretty
                   from iter_tools
                   where maintainer_id = :maintainer_id
                     and type = '0'
                   order by brand
    " {
	
    }

