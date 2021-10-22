ad_page_contract {
    Lista tabella "coimopve"

    @author                  Giulio Laurenzi
    @creation-date           05/10/2005

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

    @cvs-id coimopve-list.tcl 
} { 
    {search_word       ""}
    {rows_per_page     ""}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""} 
    {receiving_element ""}
    {cod_enve          ""}
    {cod_opve          ""}
    {last_cod_opve     ""}
    {data_verifica     ""}
    {ora_verifica      ""}
    {cod_inco          ""}
    {cognome           ""}
    {nome              ""}
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

if {[string equal $cognome ""]
&&  [string equal $nome ""]
&&  ![string equal $cod_opve ""]
} {
    set cod_opve ""
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title      "Lista Disponibilit&agrave; Ispettori"

set context_bar [iter_context_bar \
		[list "javascript:window.close()" "Ritorna"] \
                "$page_title"]

set error_num 0
set error_list "<a href=\"javascript:window.close()\">Ritorna</a>"

if {[db_0or1row sel_cinc ""] == 0} {
    incr error_num
    append error_list "Non esiste una campagna aperta"
}

if {[db_0or1row sel_enve ""] == 0} {
    if {$caller != "index"} {
	incr error_num
	append error_list "<li>Ente verificatore non selezionato<\li>"
    } else {
	incr error_num
	append error_list "<li>Ente verificatore non trovato<\li>"
    }
}


if {![string equal $data_verifica ""]
&&  [iter_check_date $data_verifica] == 0
} {
    incr error_num
    append error_list "<li>Data appuntamento scorretta</li>"
}

if {![string equal $ora_verifica ""]
&&  [iter_check_time $ora_verifica] == 0
} {
    incr error_num
    append error_list "<li>Ora appuntamento scorretta deve essere hh:mm</li> "
}

if {$error_num > 0} {
    iter_return_complaint  $error_list 
}


# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimopve-gest"
#set form_di_ricerca [iter_search_form $curr_prog $search_word]
set form_di_ricerca ""
set col_di_ricerca  "Cognome"
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]

#set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
#set link_righe      [iter_rows_per_page     $rows_per_page]
set link_righe ""


set actions [iter_select [list cod_enve cod_opve nome cognome data ora_verifica cod_inco]]
set receiving_element [split $receiving_element |]
set js_function [iter_selected $caller [list [lindex $receiving_element 0]  cod_enve [lindex $receiving_element 1] cod_opve [lindex $receiving_element 2] nome [lindex $receiving_element 3] cognome [lindex $receiving_element 4] data_verifica [lindex $receiving_element 5] ora_verifica [lindex $receiving_element 6] cod_inco]]


set comune_color {
   [set colorestato "black"
    set colorefont  "white"
#    set vcomune "non definito" 
    if {$comune == ""} {
	set colorestato "green"
        set vcomune     "&nbsp;" 
        set colorefont  "white"
    }
    if {$comune != ""} {
        set colorestato "red"
        set colorefont  "black"
        set vcomune     $comune
    }

    return "<td nowrap align=centre bgcolor=$colorestato><font color=$colorefont>$vcomune</font></td>"]
}


# imposto la struttura della tabella
set table_def [list \
        [list actions       "Azioni"    no_sort $actions] \
	[list cognome       "Cognome"   no_sort      {l}] \
	[list nome          "Nome"      no_sort      {l}] \
	[list data          "Data"      no_sort      {l}] \
	[list ora_verifica  "Ora"       no_sort      {l}] \
	[list comune        "Comune"    no_sort $comune_color] \
]

# imposto la query SQL 
if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and upper(cognome) like upper(:search_word_1)"
}

# imposto la condizione per la prossima pagina
if {![string is space $cod_opve]} {
    set where_opve " and a.cod_opve = :cod_opve"
} else {
    set where_opve ""
}

if {![string is space $data_verifica]} {
    set data_verifica [iter_check_date $data_verifica]
    set where_data " and a.data_verifica = :data_verifica"
} else {
    set where_data ""
}

if {![string is space $ora_verifica]} {
    set where_ora " 
        and a.ora_verifica between (select c.ora_da
                                      from coimopdi c
                                     where c.cod_opve = a.cod_opve
                                       and c.ora_da <= :ora_verifica
                                       and c.ora_a > :ora_verifica
                                   ) 
                                   and 
                                   (select c.ora_da
                                      from coimopdi c
                                     where c.cod_opve = a.cod_opve
                                       and c.ora_da <= :ora_verifica
                                       and c.ora_a > :ora_verifica
                                   )"
} else {
    set where_ora ""
}

set order_by "order by ordine, data_verifica, cognome, nome, ora_verifica"
if {![string equal $cod_inco ""]} {
    # se esiste il cod incontro estraggo i verificatori della zona, in modo
    # da visualizzare per primi, nella lista, i verificatori assegnati alla 
    # zona dell'impianto.
    set lista_opve_area "("
    set flag_aree "t"
    db_foreach sel_join_opve_zona "" {
	 append lista_opve_area "'$cod_opve_zona',"
    } if_no_rows {
	set flag_aree "f"
    }   
    # elimino l'ultima virgola e poi accodo la parentesi
    set lista_opve_area [string range $lista_opve_area 0 [expr [string length $lista_opve_area] - 2]]
    append lista_opve_area ")"   

    if {$flag_aree == "t"} {
	set where_opve_area_1 "and a.cod_opve in $lista_opve_area"
	set where_opve_area_2 "and a.cod_opve not in $lista_opve_area"
	set ordine1 ", '1' as ordine"
	set ordine2 ", '2' as ordine"
	set ordine3 ", '3' as ordine"
    } else {
	set where_opve_area_1 ""
	set where_opve_area_2 ""
	set ordine1 ""
	set ordine2 ""
	set ordine3 ""
	set order_by "order by data_verifica, cognome, nome, ora_verifica"
    }
} else {
    set where_opve_area_1 ""
    set where_opve_area_2 ""
    set ordine1 ""
    set ordine2 ""
    set ordine3 ""
    set order_by "order by data_verifica, cognome, nome, ora_verifica"
}

set sel_opve [db_map sel_opve]

set table_result [ad_table  -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_enve cod_opve last_cod_opve nome_funz nome_funz_caller extra_par data_verifica ora_verifica cod_inco} go $sel_opve $table_def]

# preparo url escludendo last_cod_opve che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_cod_opve]
#set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"
set link_altre_pagine ""

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_cod_opve $cod_opve
    append url_vars "&[export_url_vars last_cod_opve]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}
# creo testata della lista

set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              "" $link_altre_pagine $link_righe ""]

db_release_unused_handles
ad_return_template 
