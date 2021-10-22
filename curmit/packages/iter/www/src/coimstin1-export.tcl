ad_page_contract {

} {
    {funzione        "V"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {da_data_app      ""}
    {a_data_app       ""}
    {cod_comune       ""}
    {cod_manutentore ""}
    {flag_tipo_impianto ""}
}

set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
#set id_utente "sandro"
# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]

# imposto il nome dei file
set nome_file     "Modelli G controllo orario congruo"
set nome_file     [iter_temp_file_name -permanenti $nome_file]
set file_csv      "$permanenti_dir/$nome_file.csv"
set file_csv_url  "$permanenti_dir_url/$nome_file.csv"

set file_id       [open $file_csv w]
fconfigure $file_id -encoding iso8859-1

# imposto la prima riga del file csv
set     head_cols ""
lappend head_cols "Manutentore"
lappend head_cols "Codice impianto"
lappend head_cols "Responsabile"
lappend head_cols "Ubicazione"
lappend head_cols "Comune"
lappend head_cols "Data verifica"
lappend head_cols "Da Ora"
lappend head_cols "A Ora"
lappend head_cols "TI"

set     file_cols ""
lappend file_cols "manutentore"
lappend file_cols "cod_impianto_est"
lappend file_cols "nome_resp"
lappend file_cols "indir"
lappend file_cols "denom_comune"
lappend file_cols "data_controllo"
lappend file_cols "ora_inizio"
lappend file_cols "ora_fine"
lappend file_cols "desc_tipo_impianto"


# imposto il tracciato record del file csv

if {![string equal $cod_comune ""]} {
    set where_comune " and d.cod_comune = :cod_comune"
} else {
    set where_comune ""
}


if {![string equal $cod_manutentore ""]} {
    set where_manutentore " and d.cod_manutentore = :cod_manutentore"
} else {
    set where_manutentore ""
}

set where_data_app ""
set da_data_app_edit [iter_edit_date $da_data_app]
set a_data_app_edit  [iter_edit_date $a_data_app]

if {![string equal $da_data_app ""]
&&   [string equal $a_data_app ""]
} {
    set where_data_app " and a.data_controllo >= :da_data_app"
}

if { [string equal $da_data_app ""]
&&  ![string equal $a_data_app ""]
} {
    set where_data_app " and a.data_controllo <= :a_data_app"
} 

if {![string equal $da_data_app ""]
&&  ![string equal $a_data_app ""]
} {
    set where_data_app " and a.data_controllo between :da_data_app and :a_data_app"
}

#dpr74

if {![string equal $flag_tipo_impianto ""]} {
    set where_tipo_imp "and d.flag_tipo_impianto = :flag_tipo_impianto"
} else {
    set where_tipo_imp ""
}

#dpr74

set desc_tipo_impianto ""

if {[string equal $flag_tipo_impianto ""]} {
   set desc_tipo_impianto "Non Noto"
} 
if {[string equal $flag_tipo_impianto "R"]} {
   set desc_tipo_impianto "Riscaldamento"
} 
if {[string equal $flag_tipo_impianto "F"]} {
   set desc_tipo_impianto "Raffrddamento"
} 
if {[string equal $flag_tipo_impianto "C"]} {
   set desc_tipo_impianto "Cogenerazione"
} 
if {[string equal $flag_tipo_impianto "T"]} {
   set desc_tipo_impianto "Teleriscaldamento"
} 
#fine dpr74

set sw_primo_rec "t"

db_foreach sel_dimp "select coalesce(iter_edit_data(a.data_controllo),'&nbsp;') as data_controllo
     , coalesce(a.ora_inizio,'00:00:00') as ora_inizio
     , coalesce(a.ora_fine,'00:00:00') as ora_fine
     , coalesce(b.cognome,' ')||' '||coalesce(b.nome,' ') as manutentore
     , d.cod_impianto_est
     , d.flag_tipo_impianto
     , e.cognome||' '||coalesce(e.nome,'') as nome_resp
     , coalesce(f.descr_topo,'')||' '||coalesce(f.descr_estesa,'')||' '||coalesce(d.numero,'')||' '||coalesce(d.esponente, '') as indir
     , coalesce(g.denominazione,' ') as denom_comune
  from coimdimp a
       inner join coimaimp d on d.cod_impianto = a.cod_impianto
                             $where_comune
                             $where_tipo_imp
  left outer join coimmanu b on b.cod_manutentore = a.cod_manutentore
  left outer join coimcitt e on e.cod_cittadino = d.cod_responsabile
  left outer join coimviae f on f.cod_via       = d.cod_via
                            and f.cod_comune    = d.cod_comune
  left outer join coimcomu g on g.cod_comune    = d.cod_comune
 where 1 = 1
 $where_manutentore
 $where_data_app
 order by a.data_controllo, a.ora_inizio
" {
set ora_nc 0
set ora1 0
set ora2 0
if {![string equal $ora_inizio "00:00:00"]} {
         set ora1 [db_string query "select substr(:ora_inizio,1,2 )::integer " ]
         set ora2 [db_string query "select substr(:ora_fine,1,2 )::integer " ]
	  set ora_nc [expr $ora2 - $ora1]
 if {![string equal $ora_nc "1"]} {

    set file_col_list ""

    if {$sw_primo_rec == "t"} {
        set sw_primo_rec "f"
        iter_put_csv $file_id head_cols
    }

    set file_col_list ""
    foreach column_name $file_cols {
        lappend file_col_list [set $column_name]
    }

    iter_put_csv $file_id file_col_list
}
}
} if_no_rows {

    set msg_err      "Nessun modello G soddisfa la selezione richiesta"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list
}

ad_returnredirect $file_csv_url
ad_script_abort
