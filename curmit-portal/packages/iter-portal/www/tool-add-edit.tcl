ad_page_contract {

  @author Claudio Pasolini
  @cvs-id operator-add-edit.tcl

  USER  DATA       MODIFICHE
  ===== ========== ==========================================================================
  rom02 29/08/2024 In fase di modifica degli strumenti ora è possibile modificare solo data calibrazione
  rom02            e il flag Attivo.

  but01 12/06/2023 Aggiunto il campo attivo "is_active_p"

  rom01 08/07/2020 Quando inserisco un nuoco strumento vado a salvarmi anche la data e
  rom01            l'utente di inserimento.

} {
    tool_id:integer,optional
    type
    {mode "edit"}
}

set user_id    [ad_conn user_id];#rom01

set maintainer_id [iter::script_init]
if {[string equal $maintainer_id "0"]} {
    ad_returnredirect services
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
    set readonly_fld "";#rom02
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
    set readonly_fld "readonly {}";#rom02
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
            {html {size 50 maxlength 200 $readonly_fld}}
        }
        {model:text 
            {label {Modello}}
            {html {size 50 maxlength 100 $readonly_fld}}
        }
        {no:text 
            {label {Matricola}}
            {html {size 50 $readonly_fld}}
        }
        {last_calibration_date_pretty:text 
            {label {Data Ultima Taratura}}
            {html {size 10 maxlength 10}}
        }
    {is_active_p:boolean(radio)
	{options {{S&igrave; t} {No f}}}
	{label "Attivo"}
	{value t}
	}
    

} -new_request {
} -edit_request {

    db_1row query "
        select * , to_char(last_calibration_date, 'DD/MM/YYYY') as last_calibration_date_pretty
        from iter_tools where tool_id = :tool_id"

} -on_submit {

    set errnum 0

    set last_calibration_date [ah::check_date -input_date $last_calibration_date_pretty]
    if {$last_calibration_date eq "0"} {
	template::form::set_error register last_calibration_date_pretty  "Data errata."
	incr errnum
    }

    if {$errnum > 0} {
	break
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
               , creation_date --rom01
               , creation_user --rom01
               , is_active_p --but01
            ) values (
                 :tool_id
               , :type
               , :maintainer_id
               , upper(:brand)
               , upper(:model)
               , upper(:no)
               , :last_calibration_date
               , current_date --rom01
               , :user_id     --rom01
               , :is_active_p --but01
            )"

	set data_oggi [db_string query "select to_char(current_date, 'YYYY-MM-DD')"]
	db_dml query "update iter_maintainers set editing_date = :data_oggi where maintainer_id = :maintainer_id"
	
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
               , is_active_p = :is_active_p --but01

            where tool_id = :tool_id
      "

	set data_oggi [db_string query "select to_char(current_date, 'YYYY-MM-DD')"]
	db_dml query "update iter_maintainers set editing_date = :data_oggi where maintainer_id = :maintainer_id"
	
    } on_error {
	ah::transaction_error
    }
} -after_submit {

    ad_returnredirect "tools-list?maintainer_id=$maintainer_id&type=$type"
    ad_script_abort
}



