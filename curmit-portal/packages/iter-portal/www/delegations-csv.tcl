ad_page_contract {
    
    @author         Riccardo Vesentini
    @creation-date  19/09/2025
    
    @cvs-id         maintainer-delegations-csv.tcl

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    
} {
    {search_manu   ""}
    {search_delegation_state ""}
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

# imposto filtri
if {$search_manu ne ""} {
    set where_manu "and upper(o.name) like upper('%[db_quote $search_manu]%')"
} else {
    set where_manu ""
}
if {$search_delegation_state ne ""} {
    set where_delegation_state  " and d.delegation_state = :search_delegation_state"
} else {
    set where_delegation_state  "" 
}

set current_datetime   [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
set nome_file          "Estrazione deleghe a ditta di installazione"
set nome_file          [iter_temp_file_name -permanenti $nome_file]
set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]
set file_csv           "$permanenti_dir/$nome_file.csv"
set file_csv_url       "$permanenti_dir_url/$nome_file.csv"

set file_id [open $file_csv w]
fconfigure $file_id -encoding iso8859-1

# imposto la prima riga del file csv
set     head_cols ""
lappend head_cols "Ditta di manutenzione"
lappend head_cols "Data inizio"
lappend head_cols "Data fine"
lappend head_cols "Stato delega"


# imposto il tracciato record del file csv
set     file_cols ""
lappend file_cols "manutentore_delegante"
lappend file_cols "start_date_pretty"
lappend file_cols "end_date_pretty"
lappend file_cols "delegation_state_pretty"

set sw_primo_rec "t"
db_foreach query "
                select o.name as manutentore_delegante
                     , to_char(start_date, 'DD/MM/YYYY') as start_date_pretty
                     , to_char(end_date , 'DD/MM/YYYY') as end_date_pretty
                     , case d.delegation_state
                       when 'D' then 'Disattiva'
                       when 'A' then 'Attiva'
                        end as delegation_state_pretty
          from iter_maintainer_delegations d
             , iter_maintainers o
         where d.maintainer_id = o.maintainer_id 
           and d.delegato_id   = :user_id
            $where_manu
            $where_delegation_state             
" {
    set file_col_list ""

    if {$sw_primo_rec == "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols
    }
    
    foreach column_name $file_cols {
	set installatore_delegato "$manutentore_delegante"
	set start_date_pretty "$start_date_pretty"
	set end_date_pretty "$end_date_pretty"
	set delegation_state_pretty "$delegation_state_pretty"
	
	lappend file_col_list [set $column_name]
    }

    iter_put_csv $file_id file_col_list
    
} if_no_rows {
    set msg_err "Nessun manutentore selezionato con i criteri utilizzati"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list
}

ad_returnredirect $file_csv_url
ad_script_abort
