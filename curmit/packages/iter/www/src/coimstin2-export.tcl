ad_page_contract {

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    san01 21/07/2016 Aggiunto filtro da_data_ins e a data_ins.

} {
    {funzione        "V"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {da_data_app      ""}
    {a_data_app       ""}
    {cod_comune       ""}
    {cod_manutentore ""}
    {prescr ""}
    {osserv ""}
    {raccom ""}
    {funzionare ""}
    {flag_tipo_impianto ""}
    {da_data_ins        ""}
    {a_data_ins         ""}
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
set nome_file     "Modelli controllo prescrizioni"
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
lappend head_cols "Cap"
lappend head_cols "Data verifica"
lappend head_cols "CO"
lappend head_cols "Tiraggio"
lappend head_cols "Rendimento"
lappend head_cols "Prescrizioni"
lappend head_cols "Osservazioni"
lappend head_cols "Raccomandazioni"
lappend head_cols "Può Funzionare"
lappend head_cols "TI"

set     file_cols ""
lappend file_cols "manutentore"
lappend file_cols "cod_impianto_est"
lappend file_cols "nome_resp"
lappend file_cols "indir"
lappend file_cols "denom_comune"
lappend file_cols "cap"
lappend file_cols "data_controllo"
lappend file_cols "co"
lappend file_cols "tiraggio"
lappend file_cols "rend_combust"
lappend file_cols "prescrizioni"
lappend file_cols "osservazioni"
lappend file_cols "raccomandazioni"
lappend file_cols "flag_status"
lappend file_cols "desc_tipo_impianto"

# imposto il tracciato record del file csv

if {![string equal $cod_comune ""]} {
    set where_comune " and d.cod_comune = :cod_comune"
} else {
    set where_comune ""
}


if {![string equal $cod_manutentore ""]} {
    set where_manutentore " and a.cod_manutentore = :cod_manutentore"
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


set where_data_ins "";#san01
if {![string equal $da_data_ins ""]} {#san01: aggiunta if e suo contenuto
    append where_data_ins " and a.data_ins >= :da_data_ins"
}

if {![string equal $a_data_ins ""]} {#san01: aggiunta if e suo contenuto
    append where_data_ins " and a.data_ins <= :a_data_ins"
}


set where_prescr ""
if {[string equal $prescr "S"]} {
    append stampa "<br>Solo modelli con prescrizioni "
    set where_prescr " and trim(a.prescrizioni) is not null"
}
if {[string equal $prescr "N"]} {
    append stampa "<br>Solo modelli senza prescrizioni "
    set where_prescr " and trim(a.prescrizioni) is null"
}

set where_osserv ""
if {[string equal $osserv "S"]} {
    append stampa "<br>Solo modelli con osservazioni "
    set where_osserv " and trim(a.osservazioni) is not null"
}
if {[string equal $osserv "N"]} {
    append stampa "<br>Solo modelli senza osservazioni "
    set where_osserv " and trim(a.osservazioni) is null"
}


set where_raccom ""
if {[string equal $raccom "S"]} {
    append stampa "<br>Solo modelli con raccomandazioni "
    set where_raccom " and trim(a.raccomandazioni) is not null"
}
if {[string equal $raccom "N"]} {
    append stampa "<br>Solo modelli senza raccomandazioni "
    set where_raccom " and trim(a.raccomandazioni) is null"
}

set where_funzionare ""
if {[string equal $funzionare "S"]} {
    append stampa "<br>Solo modelli con impianto puo' funzionare = S "
    set funzionare "P"
    set where_funzionare " and flag_status = :funzionare"
}
if {[string equal $funzionare "N"]} {
    append stampa "<br>Solo modelli con impianto puo' funzionare = N "
    set where_funzionare " and flag_status = :funzionare"
}


#dpr74

if {![string equal $flag_tipo_impianto ""]} {
    set where_tipo_imp "and d.flag_tipo_impianto = :flag_tipo_impianto"
} else {
    set where_tipo_imp ""
}


set sw_primo_rec "t"

db_foreach sel_dimp "select coalesce(iter_edit_data(a.data_controllo),'&nbsp;') as data_controllo
     , coalesce(a.ora_inizio,' ') as ora_inizio
     , coalesce(a.ora_fine,' ') as ora_fine
     , coalesce(b.cognome,' ')||' '||coalesce(b.nome,' ') as manutentore
     , d.cod_impianto_est
     , d.flag_tipo_impianto
     , e.cognome||' '||coalesce(e.nome,'') as nome_resp
     , coalesce(f.descr_topo,'')||' '||coalesce(f.descr_estesa,'')||' '||coalesce(d.numero,'')||' '||coalesce(d.esponente, '') as indir
     , coalesce(g.denominazione,' ') as denom_comune
     , coalesce(d.cap,' ') as cap
     , coalesce(iter_edit_num(a.tiraggio, 2),' ') as tiraggio
     , coalesce(iter_edit_num(a.co, 4),' ') as co
     , coalesce(iter_edit_num(a.rend_combust, 2),' ') as rend_combust
     , coalesce(a.prescrizioni,' ') as prescrizioni
     , coalesce(a.osservazioni,' ') as osservazioni
     , coalesce(a.raccomandazioni,' ') as raccomandazioni
     , case a.flag_status
       when 'P' then 'S'
       when 'N' then 'N'
       else '&nbsp;'
       end as flag_status
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
 $where_raccom
 $where_osserv
 $where_prescr
 $where_data_ins -- san01
 $where_funzionare
 order by a.data_controllo, a.ora_inizio
" {
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

} if_no_rows {

    set msg_err      "Nessun Allegato soddisfa la selezione richiesta"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list
}

ad_returnredirect $file_csv_url
ad_script_abort
