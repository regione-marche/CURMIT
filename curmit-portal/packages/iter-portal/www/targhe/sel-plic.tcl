ad_page_contract {

  @author Gabriele Lo Vaglio

} {
    {plico_id            ""}
    {ordtarg_id          ""}
    {link                ""}
    {f_matrice           ""}
    {is_admin_p          ""}
    {last_order          ""}
    {funzione           "V"}
    {caller         "index"}
    {nome_funz           ""}
    {nome_funz_caller    ""}
    {extra_par           ""}
    {cod_manutentore     ""}
    {flag_attivo         ""}
    {f_manutentore       ""}
    {rows_per_page       50}

    {da_data             ""}
    {a_data              ""}
    {da_data_pretty      ""}
    {a_data_pretty       ""}
    {f_flag_evaso       "f"}
    
}

set link_list [export_url_vars da_data a_data da_data_pretty a_data_pretty f_flag_evaso is_admin_p rows_per_page ordtarg_id funzione f_matrice]


set plico_id_tot [db_list query "select distinct plico_id
                               from ordplic
                              where ordtarg_id = :ordtarg_id"]

#gab01 estraggo il numero di targhe richieste nell'ordine
set num_targhe [db_string query "select o.num_targhe
                                  from iter_ordtarg o
                                 where ordtarg_id = :ordtarg_id"]

#gab01 controllo che il numero di taghe ordinate sia inferiore a quello dei plichi selezionati
set targhe_per_plico [parameter::get_from_package_key -package_key iter-portal -parameter targhe_per_plico]
set num_plichi [llength $plico_id_tot]
set targhe_tot [expr $targhe_per_plico * $num_plichi]

if {$targhe_tot >= $num_targhe && $link eq "S"} {#gab01 solo se cerco di selezionare un altro plico
       ad_returnredirect -message "Il numero delle targhe dei plichi selezionati sono superiori  alle targhe richieste nell'ordine" "coimplic-rila?$link_list"
       return
}

if {$link eq "S"} {
    db_transaction {

        set ordplic_id [db_string query "select coalesce(max(ordplic_id), 0) + 1 from ordplic"]	
	db_dml q "insert into ordplic
                           ( ordplic_id
                           , ordtarg_id 
                           , plico_id
                  ) values (
                            :ordplic_id
                           ,:ordtarg_id
                           ,:plico_id
                           )"
	
    } on_error {
	ah::transaction_error
    }
    set message "Plico aggiunto al carrello"
} else {

    db_transaction {	
        db_dml q "delete
                    from ordplic 
                   where ordtarg_id = :ordtarg_id
                     and plico_id   = :plico_id"
	
    } on_error {
	ah::transaction_error
    }
    set message "Plico eliminato dal carrello"
}

ad_returnredirect -message "$message" "coimplic-rila?$link_list"
ad_script_abort
