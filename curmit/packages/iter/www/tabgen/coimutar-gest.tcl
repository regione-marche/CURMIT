ad_page_contract {
    Lista tabella "coimutar"

    @author                  Katia Coazzoli Adhoc
    @creation-date           23/04/2004

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

    @cvs-id coimutar-gest.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller       "index"}
   {funzione         "I"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {url_list_area     ""}
   {id_utente         ""}
   {url_area          ""}
   {cognome           ""}
   {flag_ins          ""}
    cod_area
    relazione:array,optional
   {last_utente       ""}
   {curr_utente       ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
    form_name:onevalue
}

# Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente_ins [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
  # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    set id_utente_ins [iter_get_id_utente]
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set link_tab [iter_links_area $cod_area $nome_funz_caller $url_list_area $url_area]
set dett_tab [iter_tab_area $cod_area]

set page_title      "Lista Utenti da associare"
set titolo          "utenti dell' area"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       ""
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Utente"
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_aggiungi   ""
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente_ins]
set link_righe      [iter_rows_per_page     $rows_per_page]


set button_label "Conferma Inserimento"


set error_num 0
# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimutar"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
   "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
       }
   "M" {set readonly_fld \{\}
        set disabled_fld \{\}
       }
}

form create $form_name \
-html    $onsubmit_cmd


element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name cod_area      -widget hidden -datatype text -optional
element create $form_name flag_ins      -widget hidden -datatype text -optional
element create $form_name url_list_area -widget hidden -datatype text -optional
element create $form_name url_area      -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_utente   -widget hidden -datatype text -optional
element create $form_name curr_utente   -widget hidden -datatype text -optional
element create $form_name id_utente     -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    if {$flag_ins != "S"} {
	set curr_utente   $last_utente
    }

    set actions {
	<td valign=top align=center><input type=checkbox name=relazione.$id_utente></td>
    }
    set js_function ""
    
    # imposto la struttura della tabella
    set table_def [list \
	      [list actions                "Associa" no_sort $actions] \
	      [list cognome                 "Utente"      no_sort {l}] \
	      [list nome                          ""      no_sort {l}] \
	      [list ruolo                    "Ruolo"      no_sort {c}] \
	      [list settore                "Settore"      no_sort {c}] \
	      [list livello                "Livello"      no_sort {c}] \
	      ]
    
    # imposto la query SQL 
    if {[string equal $search_word ""]} {
	set where_word ""
    } else {
	set search_word_1 [iter_search_word $search_word]
	set where_word  " and upper(cognome) like upper(:search_word_1)"
    }
   
    switch $flag_ins {
	"S" {# imposto la condizione per la pagina corrente
	    if {![string is space $curr_utente]} {
                set cognome         [lindex $curr_utente 0]
                set id_utente       [lindex $curr_utente 1]
                set where_last "and ((upper(cognome)    = upper(:cognome)  and
                                      upper(id_utente) >= upper(:id_utente)) or
                                      upper(cognome)   >  upper(:cognome))"
	    } else {
                set where_last ""
	    }
	}
	
	default {   # imposto la condizione per la prossima pagina
	    if {![string is space $last_utente]} {
	        set cognome         [lindex $last_utente 0]
	        set id_utente       [lindex $last_utente 1]
	        set where_last "and ((upper(cognome)    = upper(:cognome)  and
                                      upper(id_utente) >= upper(:id_utente)) or
                                      upper(cognome)   >  upper(:cognome))"
	    } else {
                set where_last ""
	    }
	}
    }

    set flag_ins "N"
    
    set sel_utar [db_map sel_utar]
    
    set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_area cognome id_utente last_utente curr_utente flag_ins nome_funz nome_funz_caller url_list_area url_area extra_par} go $sel_utar $table_def]
    
    # preparo url escludendo last_utente che viene passato esplicitamente
    # per poi preparare il link alla prima ed eventualmente alla prossima pagina
    set url_vars [export_ns_set_vars "url" "last_utente flag_ins" ]
    set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"
    
    # preparo link a pagina successiva
    set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
    
    if {$ctr_rec == $rows_per_page} {
	set last_utente [list  $cognome $id_utente]
	append url_vars "&[export_url_vars last_utente]"
	append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars&flag_ins=N\">pagina successiva</a>"
    }
    
    # creo testata della lista
    set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
	      $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]
    
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name cod_area         -value $cod_area
    element set_properties $form_name last_utente      -value $last_utente
    element set_properties $form_name curr_utente      -value $curr_utente
    element set_properties $form_name flag_ins         -value $flag_ins
    element set_properties $form_name id_utente        -value $id_utente
    element set_properties $form_name url_list_area    -value $url_list_area
    element set_properties $form_name url_area         -value $url_area
}


if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    set lista_uten [array names relazione]     
    foreach id_utente $lista_uten {
            set dml_sql [db_map ins_utar]

       # Lancio la query di manipolazione dati contenute in dml_sql
       if {[info exists dml_sql]} {
           with_catch error_msg {
               db_transaction {
                   db_dml dml_coimarea $dml_sql
               }
           } {
               iter_return_complaint "Spiacente, ma il DBMS ha restituito il
               seguente messaggio di errore <br><b>$error_msg</b><br>
               Contattare amministratore di sistema e comunicare il messaggio
               d'errore. Grazie."
 	   }
       }
    }

    set flag_ins "S"
 
    ad_returnredirect $curr_prog?funzione=I&[export_url_vars cod_area cognome id_utente last_utente curr_utente flag_ins nome_funz nome_funz_caller extra_par url_list_area url_area]
    ad_script_abort
}

db_release_unused_handles
ad_return_template 

