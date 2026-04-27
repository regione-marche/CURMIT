ad_page_contract {

    @author Serena Saccani
    @cvs-id ordboll-add-edit.tcl

} {
    ordboll_id:integer,optional
    {mode "edit"}
}

set maintainer_id [iter::script_init]
if {[string equal $maintainer_id "0"]} {
    ad_returnredirect services
}

# Pre-generate user_id for double-click protection
#set user_id [db_nextval acs_object_id_seq]

set page_title "Crea Ordine Bollini"
set buttons [list [list "Crea" new]]
set field_mode edit

set context [list [list services "Servizi per i manutentori"] [list ordboll-list {Lista Ordini Bollini}] $page_title]
set data_oggi [db_string query "select to_char(current_date, 'DD/MM/YYYY')"]

db_1row query "select * from iter_maintainers where maintainer_id = :maintainer_id"
set rappresentante_legale [db_string query "select p.name||' '||p.first_name from iter_maintainers m, iter_parties p where m.representative_id = p.party_id and maintainer_id = :maintainer_id"]

ad_form -name addedit \
    -mode $mode \
    -export maintainer_id \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	ordboll_id:key
	
	# Start section1
	{-section "sec1" {legendtext "CHIEDE"} {fieldset {class legend}}}

	{titolo1:text(inform)
	    {label ""}
	    {html {size 50 maxlength 50}}
	    {value {la fornitura dei seguenti bollini così suddivisi}}
	}
	{num_boll_g:text
            {label {N.bollini All.G}}
            {html {size 10 maxlength 10}}
        }
        {num_boll_f1:text 
            {label {N.bollini All.F1}}
            {html {size 10 maxlength 10}}
        }
        {num_boll_f2:text 
            {label {N.bollini All.F2}}
            {html {size 10 maxlength 10}}
        }
        {num_boll_e:text 
            {label {N.bollini All.E}}
            {html {size 10 maxlength 10}}
        }
	{titolo2:text(inform),optional
	    {label {}}
	    {html {size 50 maxlength 50}}
	    {value {Si chiede inoltre che la consegna dei bollini venga effettuata }}
	}
        {consegna:boolean(select)
            {label ""}
	    {options {{"Selezionare un valore" ""} {"Indirizzo per consegna mezzo posta" 1} {"Dati del delegato per ritiro presso UCIT Srl" 2} }}
        }
	# Start section2
	{-section "sec2" {legendtext "Indirizzo per consegna mezzo posta"} {fieldset {class legend}}}
	{address_ass_posta:text,optional
            {label {Indirizzo per assicurata postale}}
            {html {size 50 maxlength 50}}
        }
        {zipcode_ass_posta:text,optional
            {label {CAP}}
            {html {size 5 maxlength 5}}
        }
        {city_ass_posta:text,optional
            {label {Comune}}
            {html {size 50 maxlength 40}}
        }
	# Start section3
	{-section "sec3" {legendtext "Dati del delegato per ritiro presso UCIT Srl"} {fieldset {class legend}}}
	{delegato:text,optional
            {label {Delego il/la Sig./Sig.ra}}
            {html {size 80 maxlength 100}}
        }
        {delegato_comune_nas:text,optional
            {label {nato a}}
            {html {size 50 maxlength 40}}
        }
        {delegato_data_nas:text,optional
            {label {nato il}}
            {html {size 10 maxlength 10}}
        }
	# Start section4
	{-section "sec4" {legendtext "Dati prenotazione"} {fieldset {class legend}}}
        {data_prenotazione:text,optional
            {label {Data Prenotazione}}
            {html {size 10 maxlength 10}}
	    {value $data_oggi}
        }
        {cod_prenotazione:text(inform),optional
            {label {Cod.Prenotazione}}
	    {help_text "Generato automaticamente."}
        }

	# Reset section
	{-section ""}
	
    } -new_request {
	
    } -edit_request {

	db_1row get_operator_data "select * from iter_ordboll where ordboll_id = :ordboll_id"

    } -on_submit {

	set errnum 0
	if {$consegna eq "1"} {
	    if {$address_ass_posta eq ""} {
		template::form::set_error addedit address_ass_posta "Campo Obbligatorio"
		incr errnum
	    }
	    if {$zipcode_ass_posta eq ""} {
		template::form::set_error addedit zipcode_ass_posta "Campo Obbligatorio"
		incr errnum
	    }
	    if {$city_ass_posta eq ""} {
		template::form::set_error addedit city_ass_posta "Campo Obbligatorio"
		incr errnum
	    }
	} elseif {$consegna eq "2"} {
	    if {$delegato eq ""} {
		template::form::set_error addedit delegato "Campo Obbligatorio"
		incr errnum
	    }
	    if {$delegato_comune_nas eq ""} {
		template::form::set_error addedit delegato_comune_nas "Campo Obbligatorio"
		incr errnum
	    }
	    if {$delegato_data_nas eq ""} {
		template::form::set_error addedit delegato_data_nas "Campo Obbligatorio"
		incr errnum
	    }
	}

	if {$delegato_data_nas ne ""} {
	    set delegato_data_nas [ah::check_date -ansi -input_date $delegato_data_nas]
	    if {$delegato_data_nas == 0} {
		template::form::set_error addedit delegato_data_nas "Data errata"
		incr errnum
	    }
	}

	if {$data_prenotazione ne ""} {
	    set data_prenotazione [ah::check_date -ansi -input_date $data_prenotazione]
	    if {$data_prenotazione == 0} {
		template::form::set_error addedit data_prenotazione "Data errata"
		incr errnum
	    }
	}

	if {$errnum > 0} {
	    break
	}
	
    } -new_data {

	db_transaction {
	    
	    set ordboll_id [db_string query "select coalesce(max(ordboll_id) + 1, 1) from iter_ordboll"]
	    set cod_prenotazione [db_nextval ordboll_seq]
	    # inserisco operatore
	    db_dml operator_add "
            insert into iter_ordboll (
                 ordboll_id   
               , maintainer_id 
               , num_boll_g
               , num_boll_f1
               , num_boll_f2
               , num_boll_e
               , consegna
               , address_ass_posta
               , city_ass_posta
               , zipcode_ass_posta
               , delegato
               , delegato_comune_nas
               , delegato_data_nas
               , data_prenotazione
               , cod_prenotazione
               , creation_user
               , creation_date
               , editing_user
               , editing_date
               , flag_evaso
            ) values (
                :ordboll_id
               ,:maintainer_id
               ,:num_boll_g
               ,:num_boll_f1
               ,:num_boll_f2
               ,:num_boll_e
               ,:consegna
               ,:address_ass_posta
               ,:city_ass_posta
               ,:zipcode_ass_posta
               ,:delegato
               ,:delegato_comune_nas
               ,:delegato_data_nas
               ,:data_prenotazione
               ,:cod_prenotazione
               ,:maintainer_id 
               ,current_date
               ,:maintainer_id 
               ,current_date
               ,'f'
            )"

	} on_error {
	    ah::transaction_error
	}
	
    } -edit_data {

    } -after_submit {

	ad_returnredirect "ordboll-print?maintainer_id=$maintainer_id&ordboll_id=$ordboll_id"
	ad_script_abort
    }

