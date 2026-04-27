ad_page_contract {

    @author Serena Saccani
    @cvs-id iterprot-add-edit.tcl

    USER  DATA       COMMENTO
    ===== ========== ===================================================================================================
    mat01 05/09/2025 Corretto tutte le query con dentro lpad metto il cast "::text" al coalesce. Nelle stesse query
    mat01            ho aggiunto gli apici ai numeri per renderli char nella condizione "where modalita = 'n'". 

    
} {
    prot_id:integer,optional
    {da_data          ""}
    {a_data           ""}
    {da_data_pretty   ""}
    {a_data_pretty    ""}
    {f_modalita       ""}
    {f_intestatario   ""}
    {f_num_protocollo ""}
    {is_admin_p       ""}
    {mode         "edit"}
}

set user_id [auth::require_login]

set link_list [export_url_vars da_data a_data da_data_pretty a_data_pretty f_modalita f_intestatario f_num_protocollo is_admin_p]

if {[ad_form_new_p -key prot_id]} {
    set page_title "Crea nuovo Protocollo"
    set buttons [list [list "Crea" new]]
    set field_mode edit
    set anno [db_string query "select to_char(current_date, 'yyyy')"]

    # imposto numero protocollo dei doc in entrata 
    set var_protocollo "E$anno/"
    db_1row query "select lpad((coalesce(max(to_number(num_protocollo, '999999')), 0) +1)::text, 6, '0') as num_protocollo_max_entrata from iter_prot where modalita = '1' and to_char(data_protocollo, 'yyyy') = :anno and var_protocollo = :var_protocollo"
    set var_num_protocollo_entrata $var_protocollo$num_protocollo_max_entrata
    
    # imposto numero protocollo dei doc in uscita
    set var_protocollo "U$anno/"
    db_1row query "select lpad((coalesce(max(to_number(num_protocollo, '999999')), 0) +1)::text, 6, '0') as num_protocollo_max_uscita from iter_prot where modalita = '2' and to_char(data_protocollo, 'yyyy') = :anno and var_protocollo = :var_protocollo"
    set var_num_protocollo_uscita $var_protocollo$num_protocollo_max_uscita

    #db_1row query "select lpad(coalesce(max(to_number(num_protocollo, '999999')), 863) +1, 6, '0') as num_protocollo_max_entrata from iter_prot where modalita = 1"
    #db_1row query "select lpad(coalesce(max(to_number(num_protocollo, '999999')), 284) +1, 6, '0') as num_protocollo_max_uscita from iter_prot where modalita = 2"
} else {
    if {[string equal $mode "edit"]} {
        set page_title "Modifica Protocollo"
        set buttons [list [list "Modifica" edit]]
        set field_mode display
    } else {
        set page_title "Visualizza Protocollo"
        set buttons [list [list "OK" view]]
        set field_mode display
    }

    # leggo e imposto il num_protocollo
    db_1row query "select modalita as mod, var_protocollo||''||num_protocollo as var_num_protocollo_temp  from iter_prot where prot_id = :prot_id"
    if {$mod eq "1"} {
	set var_num_protocollo_entata $var_num_protocollo_temp
	set var_num_protocollo_uscita ""
    } else {
	set var_num_protocollo_entata ""
	set var_num_protocollo $var_num_protocollo_temp
    }
}

set context [list [list ../admin "Amministrazione Portale"] [list iterprot-list "Lista Protocolli"] $page_title]
set data_oggi [db_string query "select to_char(current_date, 'DD/MM/YYYY')"]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	prot_id:key
	
        {modalita:text(select)
            {label "Modalita'"}
	    {options {{"" ""} {"Documento in entrata" "1"} {"Documento in uscita" "2"}}}
        }
        {id_tipo_documento:text(select)
            {label "Tipo Documento"}
	    {options {{"Scegli" ""} [db_list_of_lists query {select descrizione, id_tipo_documento from coimtdoc order by descrizione}] }}
	}
        {var_num_protocollo_entrata:text(inform)
            {label "Num.Prot. Entrata"}
            {html {size 20 maxlength 20}}
        }
        {var_num_protocollo_uscita:text(inform)
            {label "Num.Prot. Uscita"}
            {html {size 20 maxlength 20}}
        }
        {data_protocollo:text 
            {label "Data Protocollo"}
            {html {size 10 maxlength 10}}
        }
        {data_documento:text,optional
            {label "Data Documento"}
            {html {size 10 maxlength 10}}
        }
        {mod_ricezione:text(select),optional
            {label "Mod.ricezione Doc."}
	    {options {{"Scegli" ""} {"FAX" "f"} {"POSTA PRIORITARIA" "p"} {"POSTA RACCOMANDATA" "r"} {"CONSEGNATA A MANO" "m"} {"EMAIL" "e"} {"PEC" "c"} }}
	}
        {intestatario:text 
            {label "Intestatario"}
            {html {size 80 maxlength 100}}
        }
        {indirizzo:text,optional
            {label "Indirizzo"}
            {html {size 80 maxlength 100}}
        }
        {cap:text,optional
            {label "Cap"}
            {html {size 5 maxlength 5}}
        }
        {comune:text,optional
            {label "Comune"}
            {html {size 40 maxlength 40}}
        }
        {note:text(textarea),optional
            {label "Note"}
	    {html {rows 4 cols 80 wrap soft}}
        }
	
    } -new_request {

	set data_protocollo [db_string query "select to_char(current_date, 'dd/mm/yyyy')"]

    } -edit_request {

	db_1row query "
           select o.prot_id
                , o.modalita
                , o.var_protocollo
                , o.num_protocollo
                , o.var_protocollo||''||o.num_protocollo as var_num_protocollo
                , to_char(data_protocollo, 'DD/MM/YYYY') as data_protocollo
                , to_char(data_documento, 'DD/MM/YYYY') as data_documento
                , o.intestatario   as intestatario
                , o.indirizzo
                , o.mod_ricezione
                , o.cap
                , o.comune
                , o.id_tipo_documento
                , note
             from iter_prot o
            where prot_id = :prot_id"

	if {$modalita eq "1"} {
	    set var_num_protocollo_entrata "$var_num_protocollo"
	    set var_num_protocollo_uscita ""
	} else {
	    set var_num_protocollo_entrata ""
	    set var_num_protocollo_uscita "$var_num_protocollo"
	}

    } -on_submit {

	set errnum 0

	if {$data_protocollo ne ""} {
	    set data_protocollo [ah::check_date -ansi -input_date $data_protocollo]
	    if {$data_protocollo == 0} {
		template::form::set_error addedit data_protocollo "Data errata"
		incr errnum
	    }
	}
	if {$data_documento ne ""} {
	    set data_documento [ah::check_date -ansi -input_date $data_documento]
	    if {$data_documento == 0} {
		template::form::set_error addedit data_documento "Data errata"
		incr errnum
	    }
	}

	if {$errnum > 0} {
	    break
	}
	
    } -new_data {

	if {$modalita eq "1"} {
	    # imposto numero protocollo dei doc in entrata come sopra
	    set var_protocollo "E$anno/"
           set num_protocollo [db_string query "select lpad((coalesce(max(to_number(num_protocollo, '999999')), 0) +1)::text, 6, '0') as num_protocollo_max_entrata from iter_prot where modalita = '1' and to_char(data_protocollo, 'yyyy') = :anno and var_protocollo = :var_protocollo"]
          #set num_protocollo [db_string query "select lpad(coalesce(max(to_number(num_protocollo, '999999')), 863) +1, 6, '0') from iter_prot where modalita = 1"]
	    #set var_protocollo "E2012/"
	} else {
           set var_protocollo "U$anno/"
           set num_protocollo [db_string query "select lpad((coalesce(max(to_number(num_protocollo, '999999')), 0) +1)::text, 6, '0') as num_protocollo_max_entrata from iter_prot where modalita = '2' and to_char(data_protocollo, 'yyyy') = :anno and var_protocollo = :var_protocollo"]
	    # imposto numero protocollo dei doc in uscita come sopra
	    #set num_protocollo [db_string query "select lpad(coalesce(max(to_number(num_protocollo, '999999')), 284) +1, 6, '0') from iter_prot where modalita = 2"]
	    #set var_protocollo "U2012/"
	}

	db_transaction {
	    
	    set prot_id [db_string query "select coalesce(max(prot_id), 0) + 1 from iter_prot"]
	    # inserisco operatore
	    db_dml operator_add "
            insert into iter_prot (
                 prot_id   
               , modalita
               , data_protocollo
               , var_protocollo
               , num_protocollo
               , data_documento
               , tipo_documento
               , intestatario
               , indirizzo
               , comune
               , cap
               , note
               , id_tipo_documento
               , mod_ricezione
            ) values (
                :prot_id
               ,:modalita
               ,:data_protocollo
               ,:var_protocollo
               ,:num_protocollo
               ,:data_documento
               ,null
               ,:intestatario
               ,:indirizzo
               ,:comune
               ,:cap
               ,:note
               ,:id_tipo_documento
               ,:mod_ricezione )"

	} on_error {
	    ah::transaction_error
	}
	
    } -edit_data {

	db_transaction {
	    
	    # aggiorno (tranne var e num_protocollo in quanto impostati automaticamente in inserimento)
	    db_dml query "
             update iter_prot
                set modalita          = :modalita
                  , data_protocollo   = :data_protocollo
                  , data_documento    = :data_documento
                  , intestatario      = :intestatario
                  , indirizzo         = :indirizzo
                  , comune            = :comune
                  , cap               = :cap
                  , note              = :note
                  , id_tipo_documento = :id_tipo_documento
                  , mod_ricezione     = :mod_ricezione
             where prot_id            = :prot_id"

	} on_error {
	    ah::transaction_error
	}

    } -after_submit {

	ad_returnredirect "iterprot-list"
	ad_script_abort
    }

