ad_page_contract {
    Lista tabella "coimaimp"

    @author                  Giulio Laurenzi
    @creation-date           18/03/2004

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  
    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param receiving_element nomi dei campi di form che riceveranno gli
                             argomenti restituiti dallo script di zoom,
                             separati da '|' ed impostarli come segue:

    @cvs-id coimaimp-list.tcl 

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim01 22/12/2017 Corretto filtro su data scadenza dichiarazione


} { 
    {search_word          ""}
    {rows_per_page        ""}
    {caller               "index"}
    {nome_funz            ""}
    {nome_funz_caller     ""}
    {receiving_element    ""}
    {last_cod_impianto    ""}
    {tipo_filtro   ""}

    {f_cod_impianto_est   ""}
    {f_resp_cogn          ""} 
    {f_resp_nome          ""} 

    {f_comune             ""}
    {f_quartiere          ""}
    {f_cod_via            ""}
    {f_desc_topo          ""}
    {f_desc_via           ""}
    {f_civico_da          ""}
    {f_civico_a           ""}

    {f_cod_manu           ""}

    {f_potenza_da         ""}
    {f_potenza_a          ""}
    {f_data_installaz_da  ""}
    {f_data_installaz_a   ""}
    {f_flag_dichiarato    ""}
    {f_stato_conformita   ""}
    {f_cod_combustibile   ""}
    {f_cod_tpim           ""}
    {f_cod_tpdu           ""}
    {f_stato_aimp         ""}
    {f_mesi_scad          ""}
    {f_mesi_scad_manut    ""}
    
    {conta_flag           ""}

    {url_citt             ""}
    {cod_cittadino        ""}

    {url_manu             ""}
    {cod_manutentore      ""}

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




iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)
set valid_mod_h $coimtgen(valid_mod_h)
set flag_ente   $coimtgen(flag_ente)

if {$tipo_filtro == "MAN"} {#rom01: aggiunto if, else e e loro contenut
set page_title      "Lista Impianti con manutenzione in scadenza"
} else {
set page_title   "Selezione Impianti con RCT in scadenza"
};#rom01


if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar [iter_context_bar \
                    [list "javascript:window.close()" "Torna alla Gestione"] \
                    "$page_title"]
}

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimaimp-gest"
set list_prog       "coimmaim-list"
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "responsabile"
set extra_par       [list rows_per_page        $rows_per_page \
  			  receiving_element    $receiving_element]

if {$conta_flag != "t"} {
    set link_conta      "<a href=\"$list_prog?conta_flag=t&[export_ns_set_vars url]\">Conta</a>"
} else {
    set link_conta ""
}
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]
set link_filter     [export_ns_set_vars url $tipo_filtro]
set url_list_aimp        [list [ad_conn url]?[export_ns_set_vars url]]
set url_list_aimp        [export_url_vars url_list_aimp]

if {$caller == "index"} {
    set link    "\[export_url_vars cod_impianto last_cod_impianto nome_funz_caller extra_par  \]&nome_funz=[iter_get_nomefunz coimmaim-list]"

    set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link&$url_list_aimp\">Selez.</a></td>"
    set js_function ""
} else { 
    set actions           [iter_select [list cod_impianto resp indir]]
    set receiving_element [split $receiving_element |]
    set js_function       [iter_selected $caller [list [lindex $receiving_element 0] cod_impianto [lindex $receiving_element 1] resp [lindex $receiving_element 2] indir]
}

if {$flag_ente == "C"} {
    # imposto la struttura della tabella
    set table_def [list \
        [list action           "Azioni"              no_sort    $actions] \
	[list cod_impianto_est "Codice"              no_sort         {l}] \
        [list resp             "Responsabile"        no_sort         {l}] \
        [list indir            "Indirizzo"           no_sort         {l}] \
        [list potenza          "Pot."                no_sort         {r}] \
        [list swc_dichiarato   "Di"                  no_sort         {c}] \
        [list swc_conformita   "Co"                  no_sort         {c}] \
        [list stato            "St"                  no_sort         {c}] \
        [list data_controllo   "Data controllo"      no_sort         {c}] \
    ]
} else {
    set table_def [list \
        [list action           "Azioni"              no_sort    $actions] \
	[list cod_impianto_est "Codice"              no_sort         {l}] \
        [list resp             "Responsabile"        no_sort         {l}] \
        [list comune           "Comune"              no_sort         {l}] \
        [list indir            "Indirizzo"           no_sort         {l}] \
        [list potenza          "Pot."                no_sort         {r}] \
        [list swc_dichiarato   "Di"                  no_sort         {c}] \
        [list swc_conformita   "Co"                  no_sort         {c}] \
        [list stato            "St"                  no_sort         {c}] \
        [list data_controllo   "Data controllo"      no_sort         {c}] \
    ]
}
# imposto la query SQL
if {![string equal $search_word ""]} {
    set f_resp_nome ""
} else {
    if {![string equal $f_resp_cogn ""]} {
	set search_word $f_resp_cogn
    }
}

if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and b.cognome like upper(:search_word_1)"
}

if {[string equal $f_resp_nome ""]} {
    set where_nome ""
} else {
    set f_resp_nome_1 [iter_search_word $f_resp_nome]
    set where_nome  " and b.nome like upper(:f_resp_nome_1)"
}

if {![string equal $f_cod_impianto_est ""]} {
    set where_codimp_est " and a.cod_impianto_est = upper(:f_cod_impianto_est)"
} else {
    set where_codimp_est ""
}

if {![string equal $f_quartiere ""]} {
    set where_quartiere "and a.cod_qua = :f_quartiere"
} else {
    set where_quartiere ""
}

# imposto la condizione per gli impianti di un soggetto

if {![string equal $cod_cittadino ""]} {
    set nome_funz_citt [iter_get_nomefunz coimcitt-gest]
    set sogg_join   [db_map sogg_join]
    set where_sogg  [db_map where_sogg]
    set ruolo [db_map ruolo_citt]
} else {
    set nome_funz_citt ""
    set sogg_join  ""
    set where_sogg ""
    set ruolo          ""
}

# imposto la condizione SQL per il comune e la via
if {![string equal $f_comune ""]} {
    set where_comune "and a.cod_comune = :f_comune"
} else {
    set where_comune ""
}

set where_via ""
if {![string equal $f_cod_via ""]
&&  $flag_viario == "T"
} {
    set where_via "and a.cod_via = :f_cod_via"
} 

if {(![string equal $f_desc_via ""]
||   ![string equal $f_desc_topo ""])
&&  $flag_viario == "F"
} {
    set f_desc_via1  [iter_search_word $f_desc_via]
    set f_desc_topo1 [iter_search_word $f_desc_topo]
    set where_via "and a.indirizzo like upper(:f_desc_via1)
                   and a.toponimo  like upper(:f_desc_topo1)"
}

# se richiesta selezione per civico
if {![string equal $f_civico_da ""]} {
    set where_civico_da "and to_number(a.numero,'99999999') >= :f_civico_da"
} else {
    set where_civico_da ""
}
if {![string equal $f_civico_a ""]} {
    set where_civico_a "and to_number(a.numero,'99999999') <= :f_civico_a"
} else {
    set where_civico_a ""
}

# se richiesta selezione per potenza
if {![string equal $f_potenza_da ""] 
||  ![string equal $f_potenza_a ""]
} {
   if {[string equal $f_potenza_da ""]} {
       set f_potenza_da 0
   }
   if {[string equal $f_potenza_a ""]} {
       set f_potenza_a 9999999.99
   }
   set where_pot "and a.potenza between :f_potenza_da
                                    and :f_potenza_a"
} else {
   set where_pot ""
}

# imposto la condizione SQL per cod_combustibile
if {![string equal $f_cod_combustibile ""]} {
    set where_comb "and a.cod_combustibile = :f_cod_combustibile"
} else {
    set where_comb ""
}

# se richiesta selezione per data_installazione
if {![string equal $f_data_installaz_da ""] 
||  ![string equal $f_data_installaz_a ""]
} {
   if {[string equal $f_data_installaz_da ""]} {
	set f_data_installaz_da "18000101"
   }
   if {[string equal $f_data_installaz_a ""]} {
	set f_data_installaz_a  "21001231"
   }
   set where_data_installaz "and a.data_installaz between :f_data_installaz_da
                                                      and :f_data_installaz_a"
} else {
   set where_data_installaz ""
}

# imposto la condizione SQL per flag_dichiarato
if {![string is space $f_flag_dichiarato]} {
    set where_flag_dichiarato "and a.flag_dichiarato = :f_flag_dichiarato"
} else {
    set where_flag_dichiarato ""
}

# imposto la condizione SQL per tipologia
if {![string is space $f_cod_tpim]} {
    set where_cod_tpim "and a.cod_tpim = :f_cod_tpim"
} else {
    set where_cod_tpim ""
}

# imposto la condizione SQL per stato_conformita
if {![string is space $f_stato_conformita]} {
    set where_stato_conformita "and a.stato_conformita = :f_stato_conformita"
} else {
    set where_stato_conformita ""
}

# imposto la condizione SQL per cod_tpdu
if {![string is space $f_cod_tpdu]} {
    set where_tpdu "and a.cod_tpdu = :f_cod_tpdu"
} else {
    set where_tpdu ""
}

# imposto la condizione SQL per stato
if {![string is space $f_stato_aimp]} {
    set where_stato_aimp "and a.stato = :f_stato_aimp"
} else {
    set where_stato_aimp ""
}

# imposto la condizione SQL per manutentore
if {![string is space $f_cod_manu]} {
    set where_manu "and a.cod_manutentore = :f_cod_manu"
} else {
    set where_manu ""
}

# imposto la condizione SQL per manutentore proveniente da vis. manutentori
if {![string is space $cod_manutentore]} {
    set where_manutentore "and a.cod_manutentore = :cod_manutentore"
    set nome_funz_manu [iter_get_nomefunz coimmanu-gest]
} else {
    set where_manutentore ""
    set nome_funz_manu ""
}


# stabilisco l'ordinamento ed uso una inner join al posto di una outer join
# sulle tabelle dove uso un filtro (Ottimizzazione solo per postgres)
set citt_join_pos "left outer join"
set citt_join_ora "(+)"
if {![string equal $f_cod_impianto_est ""]} {
    set ordine ""
} else {
    if {![string equal $f_resp_cogn ""]
    ||  ![string equal $f_resp_nome ""]
    || (    ![string equal $f_cod_manu  ""]
        &&   [string equal $f_quartiere ""]
	&&   [string equal $f_cod_via   ""]
	&&   [string equal $f_desc_topo ""]
	&&   [string equal $f_desc_via  ""])
    } {
	set ordine        "nome"
        set citt_join_pos "inner join"
        set citt_join_ora ""
    } else {
	set ordine "via"
    }
}

# imposto l'ordinamento della query e la condizione per la prossima pagina
#switch $ordine {
#    "via" {
#	switch $flag_viario {
#	    "T" {set col_via "d.descrizione"}
#	    "F" {set col_via "a.indirizzo" }
#	}
#        set col_numero  "to_number(a.numero,'99999999')"
#
#        set ordinamento "order by $col_via
#                                , $col_numero
#                                , a.cod_impianto_est"
#
#	if {![string equal $last_cod_impianto ""]} {
#	    set via              [lindex $last_cod_impianto 0]
#	    set numero           [lindex $last_cod_impianto 1]
#	    set cod_impianto_est [lindex $last_cod_impianto 2]

#	    if {[string equal $via ""]} {
#		set via_eq      "is null"
#               set or_via      ""
#	    } else {
#		set via_eq      "= :via"
#		set or_via      "or ($col_via > :via)"
#	    }
#	    if {[string equal $numero ""]} {
#		set numero_eq   "is null"
#                set or_numero   ""
#	    } else {
#		set numero_eq   "= :numero"
#                set or_numero   "or (    $col_via    $via_eq
#                                     and $col_numero > :numero)"
#	    }
#	    set where_last "and (
#                                    (    $col_via   $via_eq
#                                     and $col_numero $numero_eq
#                                     and a.cod_impianto_est > :cod_impianto_est)
#                                 $or_numero
#                                 $or_via
#                                )"
#	} else {
#	    set where_last ""
#        }
#    }
#
#    "nome"   {
#	set ordinamento "order by b.cognome, b.nome, a.cod_impianto_est"
#
#	if {![string equal $last_cod_impianto ""]} {
#	    set cognome          [lindex $last_cod_impianto 0]
#	    set nome             [lindex $last_cod_impianto 1]
#	    set cod_impianto_est [lindex $last_cod_impianto 2]
#	    if {[string equal $cognome ""]} {
#		set cognome_eq  "is null"
#		set or_cognome  ""
#	    } else {
#		set cognome_eq  "= :cognome"
#		set or_cognome  "or  (b.cognome > :cognome)"
#	    }
#	    
#	    if {[string equal $nome ""]} {
#		set nome_eq     "is null"
#		set or_nome     ""
#	    } else {
#		set nome_eq     "= :nome"
#		set or_nome     "or  (     b.cognome $cognome_eq
#                                      and  b.nome    > :nome)"
#	    }
#
#	    set where_last "and (
#                                     (    b.cognome  $cognome_eq
#                                     and b.nome     $nome_eq
#                                      and a.cod_impianto_est > :cod_impianto_est)
#                                 $or_nome
#                                 $or_cognome
#                                )"
#         } else {
#             set where_last ""
#         }
#    }
#    default {
#	set ordinamento ""
#	set where_last  ""
#    }
#}

if {![string equal $last_cod_impianto ""]} {
    set data_ultim_dich  [lindex $last_cod_impianto 0]
    set cod_impianto_est [lindex $last_cod_impianto 1]
    set where_last "and (  a.data_ultim_dich > :data_ultim_dich
                       or (a.data_ultim_dich = :data_ultim_dich
                      and  a.cod_impianto_est > :cod_impianto_est))
                   "
} else {
    set where_last ""
}


if {![string equal $f_mesi_scad ""]} {
    #sim01 set mesi_scad [expr 48 - $f_mesi_scad]
    set mesi_scad $f_mesi_scad;#sim01
} else {
    set mesi_scad "48"
}

if {![string equal $f_mesi_scad_manut ""]} {
    set mesi_scad_manut [expr 12 - $f_mesi_scad_manut]
    if {$mesi_scad_manut < $mesi_scad} {
	set mesi_scad $mesi_scad_manut
    }
}

db_1row sel_data_inizio_contr ""
db_1row sel_data_limite ""

if {$conta_flag == "t"} {
    # estraggo il numero dei record estratti
    db_1row sel_conta_aimp ""
    set link_conta "Impianti selezionati: <b>$conta_num</b>"
}

if {$flag_viario == "T"} {
    set sel_aimp [db_map sel_aimp_vie]
} else {
    set sel_aimp [db_map sel_aimp_no_vie]
}

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_impianto last_cod_impianto nome_funz extra_par provincia comune localita indir via numero cod_ubicazione cognome nome ordine descrizione cod_impianto cod_impianto_est url_list_aimp swc_dichiarato nome_funz_caller conta_num data_ultim_dich} go $sel_aimp $table_def]

# preparo url escludendo last_cod_impianto che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_cod_impianto]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"


# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_cod_impianto [list $data_ultim_dich $cod_impianto_est]
#    switch $ordine {
#	"nome" {set last_cod_impianto [list $cognome $nome $cod_impianto_est]}
#        "via"  {set last_cod_impianto [list $via $numero $cod_impianto_est]}
#    }
    append url_vars "&[export_url_vars last_cod_impianto]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_conta $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
