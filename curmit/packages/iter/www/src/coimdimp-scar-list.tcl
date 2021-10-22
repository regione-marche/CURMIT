ad_page_contract {
    Lista Modelli H per esportazione

    @author                  Nicola Mortoni
    @creation-date           16/05/2006

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  
    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param nome_funz_caller  identifica l'entrata di menu,
                             serve per la navigation bar
    @param receiving_element nomi dei campi di form che riceveranno gli
                             argomenti restituiti dallo script di zoom,
                             separati da '|' ed impostarli come segue:

    @cvs-id coimdimp-scar-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {last_key          ""}

   {f_cod_manu        ""}
   {f_manu_cogn       ""}
   {f_manu_nome       ""}
   {f_data_ins_iniz   ""}
   {f_data_ins_fine   ""}
   {f_data_controllo_iniz ""}
   {f_data_controllo_fine ""}

   {num_rec               ""}

}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}

# Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
  # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title      "Lista Modelli H per esportazione"
set context_bar     [iter_context_bar -nome_funz $nome_funz_caller]

# preparo link per ritorno al filtro:
set link_filter     [export_ns_set_vars "url"]

# preparo link per esportazione
set link_export     [export_ns_set_vars "url"]
set logo_dir_url    [iter_set_logo_dir_url]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set form_di_ricerca ""
set col_di_ricerca  ""
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]
set js_function ""

# determino il criterio di ordinamento
if {[string equal $f_data_ins_iniz ""]
&&  [string equal $f_data_ins_fine ""]
&& (   ![string equal $f_data_controllo_iniz ""]
    || ![string equal $f_data_controllo_fine ""])
} {
    set swc_ordinamento "data_controllo"
} else {
    set swc_ordinamento "data_ins"
}

# imposto la struttura della tabella

# la costruisco dinamicamente perche'
# a seconda dell'ordinamento visualizzo prima data_ins o data_controllo
set def_data_ins [list data_ins_edit       "Data ins."           no_sort {c}]
set def_data_controllo \
                 [list data_controllo_edit "Data&nbsp;controllo" no_sort {c}]
set def_cod_impianto_est \
                 [list cod_impianto_est    "Cod.Imp."            no_sort {l}]
set def_resp     [list resp                "Responsabile"        no_sort {l}]
set def_comune   [list comune              "Comune"              no_sort {l}]
set def_indir    [list indir               "Indirizzo"           no_sort {l}]

set table_def    ""
if {$swc_ordinamento == "data_ins"} {
    lappend table_def $def_data_ins
    lappend table_def $def_data_controllo
} else {
    lappend table_def $def_data_controllo
    lappend table_def $def_data_ins
}
lappend table_def $def_cod_impianto_est
lappend table_def $def_resp
lappend table_def $def_comune
lappend table_def $def_indir

# imposto la query SQL 

# imposto la condizione SQL per manutentore
if {![string is space $f_cod_manu]} {
    set where_manu "and a.cod_manutentore = :f_cod_manu"
} else {
    set where_manu ""
}

# se richiesta selezione per data_ins
set where_data_ins ""
if {![string equal $f_data_ins_iniz ""]} {
    # dato che oracle memorizza anche l'ora, sono costretto a fare cosi':
    append f_data_ins_iniz " 00:00:00"
    append where_data_ins  "
    and a.data_ins >= to_date(:f_data_ins_iniz,'yyyymmdd hh24:mi:ss')"
}
if {![string equal $f_data_ins_fine ""]} {
    # dato che oracle memorizza anche l'ora, sono costretto a fare cosi':
    append f_data_ins_fine " 23:59:59"
    append where_data_ins  "
    and a.data_ins <= to_date(:f_data_ins_fine,'yyyymmdd hh24:mi:ss')"
}

# se richiesta selezione per data_controllo
set where_data_controllo ""
if {![string equal $f_data_controllo_iniz ""]} {
    # questa volta non serve l'ora perche' data_controllo viene inserita senza
    append where_data_controllo  "
    and a.data_controllo >= :f_data_controllo_iniz"
}
if {![string equal $f_data_controllo_fine ""]} {
    # questa volta non serve l'ora perche' data_controllo viene inserita senza
    append where_data_controllo  "
    and a.data_controllo <= :f_data_controllo_fine"
}

# imposto il criterio di ordinamento

# per oracle sono obbligato a fare una to_char, per postgres posso evitare
# e puo' essere meglio per il suo ottimizzatore.
if {[iter_get_parameter database] == "postgres"} {
    set def_data_ins_per_order_by "a.data_ins"
} else {
    set def_data_ins_per_order_by "to_char(a.data_ins,'yyyy-mm-dd')"
}

if {$swc_ordinamento == "data_ins"} {
    set  order_by "
         order by $def_data_ins_per_order_by
                , a.data_controllo
                , b.cod_impianto_est"
} else {
    set  order_by "
         order by a.data_controllo
                , $def_data_ins_per_order_by
                , b.cod_impianto_est"
}

# imposto la condizione per la prossima pagina
if {![string is space $last_key]} {
    set data_ins         [lindex $last_key 0]
    set data_controllo   [lindex $last_key 1]
    set cod_impianto_est [lindex $last_key 2]
    # uso maggiore e non maggiore-uguale perche' uso la limit.
    # dato che oracle memorizza anche l'ora in data_ins, uso between invece di=
    if {$swc_ordinamento == "data_ins"} {
	set where_last "
        and (
                (    a.data_ins   between to_date(:data_ins||' 00:00:00'
                                                 ,'yyyy-mm-dd hh24:mi:ss')
                                      and to_date(:data_ins||' 23:59:59'
                                                 ,'yyyy-mm-dd hh24:mi:ss')
                 and a.data_controllo   = :data_controllo
                 and b.cod_impianto_est > :cod_impianto_est)
             or (    a.data_ins   between to_date(:data_ins||' 00:00:00'
                                                 ,'yyyy-mm-dd hh24:mi:ss')
                                      and to_date(:data_ins||' 23:59:59'
                                                 ,'yyyy-mm-dd hh24:mi:ss')
                 and a.data_controllo   > :data_controllo)
             or      a.data_ins         > to_date(:data_ins||' 23:59:59'
                                                 ,'yyyy-mm-dd hh24:mi:ss')
            )"
    } else {
	set where_last "
        and (
                (    a.data_controllo   = :data_controllo
                 and a.data_ins   between to_date(:data_ins||' 00:00:00'
                                                 ,'yyyy-mm-dd hh24:mi:ss')
                                      and to_date(:data_ins||' 23:59:59'
                                                 ,'yyyy-mm-dd hh24:mi:ss')
                 and b.cod_impianto_est > :cod_impianto_est)
             or (    a.data_controllo   = :data_controllo
                 and a.data_ins         > to_date(:data_ins||' 23:59:59'
                                                 ,'yyyy-mm-dd hh24:mi:ss'))
             or      a.data_controllo   > :data_controllo
            )"
    }
} else {
    set where_last ""
}

# scrivo due query diverse a seconda se c'e' o meno il viario
iter_get_coimtgen
if {$coimtgen(flag_viario) == "T"} {
    set nome_col_toponimo  "e.descr_topo"
    set nome_col_via       "e.descrizione"
    if {[iter_get_parameter database] == "postgres"} {
	set from_coimviae  "left outer join coimviae e"
	set where_coimviae "             on e.cod_comune    = b.cod_comune
                                        and e.cod_via       = b.cod_via"
    } else {
	set from_coimviae  "              , coimviae e"
	set where_coimviae "            and e.cod_comune (+)= b.cod_comune
                                        and e.cod_via    (+)= b.cod_via"
    }
} else {
    set nome_col_toponimo  "b.toponimo"
    set nome_col_via       "b.indirizzo"
    set from_coimviae      ""
    set where_coimviae     ""
}

if {[string equal $num_rec ""]} {
    set num_rec [db_string sel_dimp_count ""]
}
set dett_num_rec "Modelli H selezionati: <b>$num_rec</b>"

set sel_dimp [db_map sel_dimp]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {data_ins data_controllo cod_impianto_est last_key nome_funz nome_funz_caller} go $sel_dimp $table_def]

# preparo url escludendo last_key che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" "last_key num_rec"]&[export_url_vars num_rec]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set    last_key [list $data_ins $data_controllo $cod_impianto_est]
    append url_vars "&[export_url_vars last_key]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head $form_di_ricerca $col_di_ricerca \
              $dett_num_rec $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
