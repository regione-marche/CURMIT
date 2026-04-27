ad_page_contract {

  @author Claudio Pasolini
  @cvs-id operator-add-edit.tcl

} {
    maintainer_id
    operator_id:integer,optional
    {mode "edit"}
}

set cait_id [auth::require_login]

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :cait_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}
if {![db_0or1row check_maint "select approved_p, validated_p from iter_maintainers where cait_id = :cait_id and maintainer_id = :maintainer_id"]} {
    ad_returnredirect -message "Spiacente, ma il manutentore non è tra quelli registrati dal CAIT." /
    ad_script_abort
}
if {[string equal $approved_p "t"] && [string equal $validated_p "f"]} {
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

if {[ad_form_new_p -key operator_id]} { 
    set page_title "Crea Operatore"
    set buttons [list [list "Crea Operatore" new]]
    set field_mode edit
} else {
    if {[string equal $mode "edit"]} {
        set page_title "Modifica Operatore"
        set buttons [list [list "Modifica Operatore" edit]]
        set field_mode display
    } else {
        set page_title "Visaualizza Operatore"
        set buttons [list [list "OK" view]]
        set field_mode display
    }
}

set context [list [list services "Servizi per i manutentori"] [list operators-list {Lista Operatori}] "Lista Operatori"]

ad_form -name addedit \
        -mode $mode \
        -export maintainer_id \
        -edit_buttons $buttons \
        -has_edit 1 \
        -form {
   
    operator_id:key

        {name:text 
            {label {Cognome}}
            {html {size 50 maxlength 200}}
        }
        {first_name:text 
            {label {Nome}}
            {html {size 50 maxlength 100}}
        }
        {no:text 
            {label {Matricola}}
            {html {size 50}}
        }
        {fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }
        {phone:text,optional 
            {label {Telefono}}
        }
        {mobile:text,optional 
            {label {Cellulare}}
        }
        {address:text,optional
            {label {Recapito}}
            {html {size 50 maxlength 200}}
        }
        {role:text(radio),optional
            {label {Ruolo}}
	    {options { {"Tecnico" 0} {"Segreteria" 1}}}
        }
        {is_active_p:boolean(radio)
            {label {Attivo?}}
	    {options {{"Si" t} {"No" f}}}
        }
        {notes:text(textarea),optional,nospell 
            {label Note}
            {html {rows 5 cols 50 wrap soft}}
        }

} -new_request {
    set is_active_p "t"
} -edit_request {

    db_1row get_operator_data "
        select * 
        from iter_operators where operator_id = :operator_id"

} -on_submit {

    set data_oggi [db_string query "select to_char(current_date, 'YYYY-MM-DD')"]

} -new_data {

    # controllo codice fiscale dell'operatore
    set l [string length $fiscal_code]
    if {$l != 16} {
	template::form::set_error addedit fiscal_code "Lunghezza errata."
	break
    } else {
#	if {[db_0or1row check_fiscal_code "select 1 from iter_operators where fiscal_code = :fiscal_code and is_active_p = 't'"]} {
#	    template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
#	    break
#	}
    }

    if {[string equal $role ""]} {
	set role "0"
    }

    db_transaction {
	
	set operator_id [db_string query "select coalesce(max(operator_id) + 1, 1) from iter_operators"]
	# inserisco operatore
	db_dml operator_add "
            insert into iter_operators (
                 operator_id   
               , maintainer_id 
               , name          
               , first_name    
               , no            
               , phone         
               , mobile        
               , address       
               , is_active_p   
               , fiscal_code   
               , role
               , notes         
            ) values (
                 :operator_id
               , :maintainer_id
               , upper(:name)
               , upper(:first_name)    
               , upper(:no)
               , :phone         
               , :mobile        
               , upper(:address)
               , :is_active_p   
               , upper(:fiscal_code)   
               , :role
               , upper(:notes)         
            )"
	db_dml query "update iter_maintainers set editing_date = :data_oggi where maintainer_id = :maintainer_id"

    } on_error {
	ah::transaction_error
    }
    
} -edit_data {

    # controllo codice fiscale dell'operatore
    set l [string length $fiscal_code]
    if {$l != 16} {
	template::form::set_error addedit fiscal_code "Lunghezza errata."
	break
    }

#    if {[db_string count "select count(*) from iter_operators where fiscal_code = :fiscal_code and is_active_p = 't' and operator_id <> :operator_id"] > 1} {
#	template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
#	break
#    }

    db_transaction {
	
	db_dml query "
            update iter_operators set
                 name        = upper(:name)          
               , first_name  = upper(:first_name)
               , no          = upper(:no)
               , phone       = :phone
               , mobile      = :mobile
               , address     = upper(:address)
               , role        = :role
               , is_active_p = :is_active_p
               , fiscal_code = upper(:fiscal_code)
               , notes       = upper(:notes)

            where operator_id = :operator_id
      "
	db_dml query "update iter_maintainers set editing_date = :data_oggi where maintainer_id = :maintainer_id"

    } on_error {
	ah::transaction_error
    }
} -after_submit {

    ad_returnredirect "operators-list?maintainer_id=$maintainer_id"
    ad_script_abort
}



