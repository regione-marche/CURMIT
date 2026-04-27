ad_page_contract {

  @author Claudio Pasolini
  @cvs-id operator-add-edit.tcl

} {
    maintainer_id
    tool_id:integer,optional
    type
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
if {[string equal $approved_p "t"] && [string equal $validated_p "f"]} {
    ad_returnredirect -message "Funzione non disponibile per questo manutentore." /
    ad_script_abort
}

if {[string equal $type "0"]} {
    set tool_type "Analizzatore di Combustione"
    set tools_type "Analizzatori di Combustione"
} elseif {[string equal $type "1"]} {
    set tool_type "Deprimometro"
    set tools_type "Deprimometri"
} 

if {[ad_form_new_p -key tool_id]} { 
    set page_title "Crea $tool_type"
    set buttons [list [list "Crea $tool_type" new]]
    set field_mode edit
} else {
    if {[string equal $mode "edit"]} {
        set page_title "Modifica $tool_type"
        set buttons [list [list "Modifica $tool_type" edit]]
        set field_mode display
    } else {
        set page_title "Visuaalizza $tool_type"
        set buttons [list [list "OK" view]]
        set field_mode display
    }
}

set context [list [list services "Servizi per i manutentori"] [list operators-list {Lista $tools_type}] "Lista $tools_type"]

ad_form -name addedit \
        -mode $mode \
        -export {maintainer_id type} \
        -edit_buttons $buttons \
        -has_edit 1 \
        -form {
   
    tool_id:key

        {brand:text 
            {label {Marca}}
            {html {size 50 maxlength 200}}
        }
        {model:text 
            {label {Modello}}
            {html {size 50 maxlength 100}}
        }
        {no:text 
            {label {Matricola}}
            {html {size 50}}
        }
        {last_calibration_date_pretty:text 
            {label {Data Ultima Taratura}}
            {html {size 10 maxlength 10}}
        }

} -new_request {
} -edit_request {

    db_1row query "
        select * , to_char(last_calibration_date, 'DD/MM/YYYY') as last_calibration_date_pretty
        from iter_tools where tool_id = :tool_id"

} -on_submit {

    set last_calibration_date [ah::check_date -input_date $last_calibration_date_pretty]
    if {$last_calibration_date eq "0"} {
	template::form::set_error register last_calibration_date_pretty  "Data errata."
	incr errnum
    }


} -new_data {


    db_transaction {
	
	set tool_id [db_string query "select coalesce(max(tool_id) + 1, 1) from iter_tools"]
	# inserisco operatore
	db_dml query "
            insert into iter_tools (
                 tool_id
               , type
               , maintainer_id
               , brand
               , model
               , no            
               , last_calibration_date
            ) values (
                 :tool_id
               , :type
               , :maintainer_id
               , upper(:brand)
               , upper(:model)
               , upper(:no)
               , :last_calibration_date
            )"

    } on_error {
	ah::transaction_error
    }
    
} -edit_data {

    db_transaction {
	
	db_dml query "
            update iter_tools set
                 brand = upper(:brand)
               , model = upper(:model)
               , no          = upper(:no)
               , last_calibration_date = :last_calibration_date

            where tool_id = :tool_id
      "

    } on_error {
	ah::transaction_error
    }
} -after_submit {

    ad_returnredirect "tools-list?maintainer_id=$maintainer_id&type=$type"
    ad_script_abort
}



