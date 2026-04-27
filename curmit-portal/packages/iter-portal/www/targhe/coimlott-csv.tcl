ad_page_contract {
    
    @author         Simone Pesci  
    @creation-date  04.03.2013
    
    @cvs-id         coimlott-csv.tcl

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================                
    sim01 20/07/2021 Lo stampatore della Basilicata vuole la targa divisa nella matrice e nel suo progressivo
    
} {
    {lotto_id           ""}
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]


set current_datetime   [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
set nome_file          "Estrazione Targhe lotto numero $lotto_id"
set nome_file          [iter_temp_file_name -permanenti $nome_file]
set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]
set file_csv           "$permanenti_dir/$nome_file.csv"
set file_csv_url       "$permanenti_dir_url/$nome_file.csv"

set file_id [open $file_csv w]
fconfigure $file_id -encoding iso8859-1

# imposto la prima riga del file csv
set     head_cols ""
lappend head_cols "Targa"

set db_name [db_get_database];#sim01
if {[string match "*iter-portal-basilicata*" $db_name]} {#sim01 if e suo contenuto
    set head_cols ""
    lappend head_cols "Matrice"
    lappend head_cols "Progressivo"
}

# imposto il tracciato record del file csv
set     file_cols ""
lappend file_cols "targa"

if {[string match "*iter-portal-basilicata*" $db_name]} {#sim01 if e suo contenuto
    set file_cols ""
    lappend file_cols "matrice"
    lappend file_cols "progressivo"
}

set sw_primo_rec "t"
db_foreach query "
     select t.targa
       from coimtarg t
          , coimplic p
     where lotto_id = :lotto_id           
       and t.plico_id = p.plico_id
    order by t.targa
" {
    set file_col_list ""

    set matrice [string range $targa 0 [string length $targa]-3];#sim01

    set progressivo [string range $targa [string length $targa]-2 [string length $targa]];#sim01

    if {$sw_primo_rec == "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols
    }

   
    foreach column_name $file_cols {
       	lappend file_col_list [set $column_name]
    }
    iter_put_csv $file_id file_col_list
    
} if_no_rows {
    set msg_err "Nessuna Targa selezionata con i criteri utilizzati"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list
}

ad_returnredirect $file_csv_url
ad_script_abort
