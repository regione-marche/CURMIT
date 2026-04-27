ad_page_contract {

    @author Simone Pesci   
    @cvs-id coimtarg-add-edit.tcl

    USER   DATA       MODIFICHE
    ====== ========== =================================================================================================
    rom01  17/05/202 Reso standard una modifica fatta solo per Basilicata sulle opzioni di consegna.

    gab03  02/03/2017 Modifiche alle label richieste da Gangemi

    sim01  07/02/2017 Modificato le dicitura come indicato dalla Regione Calabria ed aggiunto il campo vettore

    gab02  16/01/2017 Aggiunto help text all' address_ass_posta.

    gab01  21/12/2016 I campi: editing_user e editing_date non vengono più valorizzati in questo programma ma soltanto
    gab01             al momento dell'evasione dell'ordine                
    
} {
    ordtarg_id:integer,optional
    {mode "edit"}
}

set maintainer_id [iter::script_init]
if {[string equal $maintainer_id "0"]} {
    ad_returnredirect services
}

# Pre-generate user_id for double-click protection
#set user_id [db_nextval acs_object_id_seq]

set page_title "Crea Ordine Targhe"
set buttons [list [list "Crea" new]]
set field_mode edit

set context [list [list services "Servizi per i manutentori"] [list ordtarg-list {Lista Ordini Targhe}] $page_title]
set data_oggi [db_string query "select to_char(current_date, 'DD/MM/YYYY')"]

set db_name [db_get_database];#rom01

db_1row query "select * 
                 from iter_maintainers
                where maintainer_id = :maintainer_id"

if {!$validated_p && [string match "*iter-portal-basilicata*" $db_name]} {#rom01
    ad_returnredirect -message "E' possibile creare un ordine per le Targhe solo dopo che si è stati validati." ../../services
    ad_script_abort
}

set rappresentante_legale [db_string query "select p.name||' '||p.first_name 
                                              from iter_maintainers m
                                                 , iter_parties p 
                                             where m.representative_id = p.party_id
                                               and maintainer_id = :maintainer_id"]

ad_form -name addedit \
    -mode $mode \
    -export maintainer_id \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	ordtarg_id:key
	
	# Start section1
	{-section "sec1" {legendtext "CHIEDE"} {fieldset {class legend}}}

	{titolo1:text(inform)
	    {label ""}
	    {html {size 50 maxlength 50}}
	    {value {la fornitura delle seguenti targhe}}
	}
	{num_targhe:text
            {label {N.Targhe}}
            {html {size 10 maxlength 10}}
        }
	{titolo2:text(inform),optional
	    {label {}}
	    {html {size 50 maxlength 50}}
	    {value {Si chiede inoltre che la consegna delle targhe venga effettuata }}
	}
    }
if {[string match "*iter-portal-basilicata*" $db_name]} {#rom01 Aggiunta if e il suo contenuto
    ad_form -extend -name addedit -form {
	#cambiato label delle options
        {consegna:boolean(select)
            {label ""}
	    {options {{"Selezionare un valore" ""} {"Consegna mezzo vettore incaricato dalla ditta -Pr Potenza" 1} {"Consegna mezzo vettore incaricato dalla ditta -Cm Potenza" 2} {"Consegna mezzo vettore incaricato dalla ditta -Pr Matera" 3} {"Presso ufficio Apea Pr.Potenza (compilare la specifica del delegato al ritiro)" 4} {"Presso ufficio Comune Potenza (compilare la specifica del delegato al ritiro)" 5} {"Presso ufficio Apea Pr.Matera (compilare la specifica del delegato al ritiro)" 6} }}
        }
    }
} else {#rom01 Aggiunta else ma non il suo contenuto
    ad_form -extend -name addedit -form {
        #cambiato label delle options
        {consegna:boolean(select)
            {label ""}
	    {options {{"Selezionare un valore" ""} {"Consegna mezzo vettore incaricato dalla ditta" 1} {"Presso ufficio regionali (compilare la specifica del delegato al ritiro)" 2} }}
	}
    }
};#rom01
ad_form -extend -name addedit -form {
	# Start section2
        #gab03 aggiunto "incaricato dalla ditta" al titolo della sezione
	{-section "sec2" {legendtext "Indirizzo per consegna mezzo corriere/vettore incaricato dalla ditta"} {fieldset {class legend}}}
	#sim01 aggiunto vettore
	{vettore:text,optional
            {label {Corriere/Vettore}}
            {html {size 80 maxlength 100}}
        }
        #gab02 aggiunto help_text
        #gab03 modificato help_text	
	{address_ass_posta:text,optional
            {label {Indirizzo per assicurata postale}}
            {html {size 50 maxlength 50}}
            {help_text "assicurata a carico della ditta"}
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
	{-section "sec3" {legendtext "Dati del delegato per ritiro"} {fieldset {class legend}}}
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
	    {value ""}
	    {help_text "Generato automaticamente."}
        }

	# Reset section
	{-section ""}
	
    } -new_request {
	
    } -edit_request {

	db_1row get_operator_data "select * from iter_ordtarg where ordtarg_id = :ordtarg_id"

    } -on_submit {

	set errnum 0

	set targhe_max_per_ordine [parameter::get_from_package_key -package_key iter-portal -parameter targhe_max_per_ordine]
	set targhe_perc_blocco_ordine [parameter::get_from_package_key -package_key iter-portal -parameter targhe_perc_blocco_ordine]
	set targhe_per_plico [parameter::get_from_package_key -package_key iter-portal -parameter targhe_per_plico]

	if {$num_targhe > $targhe_max_per_ordine} {
	    template::form::set_error addedit num_targhe "Non è possibile ordinare più di $targhe_max_per_ordine targhe per volta"
	    incr errnum
	}

	#controllo che il numero di targhe sia un multiplo del parametro targhe_per_plico
	set mult 0.00
	set mult [expr ($num_targhe % $targhe_per_plico)]

	if {$mult != 0} {
	    template::form::set_error addedit num_targhe "E' necessario ordinare un numero di targhe multiplo di $targhe_per_plico"
	    incr errnum
	}

	db_1row q "select count(*) as tot_targhe
                     from coimtarg t
                        , coimplic p
                    where p.maintainer_id = :maintainer_id
                      and t.plico_id = p.plico_id"

	db_1row q "select count(*) as tot_targhe_inutilizzate
                     from coimtarg t
                        , coimplic p
                    where p.maintainer_id = :maintainer_id
                      and t.plico_id = p.plico_id
                      and coalesce(nome_db_utilizzo,'') = ''"

	if {$tot_targhe > 0} {
	    set perc_non_utilizzata [expr ($tot_targhe_inutilizzate * 1.00) / $tot_targhe * 100.00]
	    
	    if {$targhe_perc_blocco_ordine < $perc_non_utilizzata} {
		template::form::set_error addedit num_targhe "Non è possibile effettuare l'ordine. Sono già state assegnate $tot_targhe_inutilizzate targhe non ancora utilizzate"
		incr errnum
	    }
	}

	set consegna_per_vettore  "f";#rom01
	set consegna_per_delegato "f";#rom01

	if {[string match "*iter-portal-basilicata*" $db_name]} {#rom01 Aggiunte if, else e il loro contenuto
	    if {$consegna in [list "1" "2" "3"]} {
		set consegna_per_vettore  "t"
	    } else {
		set consegna_per_delegato "t"
	    }
	    
	} else {
	    if {$consegna eq "1"} {
		set consegna_per_vettore  "t"
	    } elseif {$consegna eq "2"} {
		set consegna_per_delegato "t"
            }

        }

	if {$consegna_per_vettore eq "t"} {
	    if {$vettore eq ""} {
		template::form::set_error addedit vettore "Campo Obbligatorio"
		incr errnum
	    }
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
	} 
	if {$consegna_per_delegato eq "t"} {
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
	    
	    set ordtarg_id [db_string query "select coalesce(max(ordtarg_id) + 1, 1) from iter_ordtarg"]
	    set cod_prenotazione [db_nextval ordtarg_seq]
	    # inserisco operatore
	    db_dml operator_add "
            insert into iter_ordtarg (
                 ordtarg_id   
               , maintainer_id 
               , num_targhe
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
 --gab01       , editing_user
 --gab01       , editing_date
               , flag_evaso
               , vettore --sim01
            ) values (
                :ordtarg_id
               ,:maintainer_id
               ,:num_targhe
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
 --gab01       ,:maintainer_id 
 --gab01       ,current_date
               ,'f'
               ,:vettore --sim01 
            )"

	} on_error {
	    ah::transaction_error
	}
	
    } -edit_data {

    } -after_submit {

	ad_returnredirect "ordtarg-print?maintainer_id=$maintainer_id&ordtarg_id=$ordtarg_id"
	ad_script_abort
    }

