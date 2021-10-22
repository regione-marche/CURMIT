ad_page_contract {
    Lista tabella "coimanrg"

    @author                  Tania Masullo Adhoc
    @creation-date           11/08/2005

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

    @cvs-id coimanrg-gest.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller       "index"}
   {funzione         "I"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {url_list_rgen     ""}
   {cod_tano          ""}
   {url_rgen          ""}
   {descr_breve       ""}
   {flag_ins          ""}
    cod_rgen
    relazione:array,optional
   {last_tano         ""}
   {curr_tano         ""}
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
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
  # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    set id_utente [iter_get_id_utente]
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set link_tab [iter_links_rgen $cod_rgen $nome_funz_caller $url_list_rgen $url_rgen]
set dett_tab [iter_tab_rgen $cod_rgen]

set page_title      "Lista Anomalie da associare"
set titolo          "Anomalie dei Raggruppamenti Ente"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       ""
#set form_di_ricerca [iter_search_form $curr_prog $search_word]
#set col_di_ricerca  "Anomalia"
set extra_par       [list rows_per_page     $rows_per_page \
			 receiving_element $receiving_element]
set link_aggiungi   ""
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]


set button_label "Conferma Inserimento"


set error_num 0
# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimanrg"
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
    -html   $onsubmit_cmd


element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name cod_rgen      -widget hidden -datatype text -optional
element create $form_name flag_ins      -widget hidden -datatype text -optional
element create $form_name url_list_rgen -widget hidden -datatype text -optional
element create $form_name url_rgen      -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_tano     -widget hidden -datatype text -optional
element create $form_name curr_tano     -widget hidden -datatype text -optional
element create $form_name cod_tano      -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    if {$flag_ins != "S"} {
	set curr_tano  $last_tano
    }
    
    set actions {
	<td valign=top align=center><input type=checkbox name=relazione.$cod_tano></td>
    }
    set js_function ""
    
    # imposto la struttura della tabella
    set table_def [list \
	          [list actions         "Associa"      no_sort $actions] \
	          [list cod_tano        "Cod."         no_sort {l}] \
	          [list descr_breve     "Anomalia"     no_sort {l}] \
	          ]
    
    # imposto la query SQL 
    if {[string equal $search_word ""]} {
	set where_word ""
    } else {
	set search_word_1 [iter_search_word $search_word]
	set where_word  " and upper(descr_breve) like upper(:search_word_1)"
    }
   
    set flag_ins "N"

    set sel_anrg [db_map sel_anrg]
    
    set table_result [ad_table  -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_rgen descr_breve cod_tano last_tano curr_tano flag_ins nome_funz nome_funz_caller url_list_rgen url_rgen extra_par} go $sel_anrg $table_def]
    
    # preparo url escludendo last_tano che viene passato esplicitamente
    # per poi preparare il link alla prima ed eventualmente alla prossima pagina
    set url_vars [export_ns_set_vars "url" "last_tano flag_ins" ]
    
    # creo testata della lista
    set list_head [iter_list_head  "" "" \
	      $link_aggiungi "" "" ""]
    
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name cod_rgen         -value $cod_rgen
    element set_properties $form_name last_tano        -value $last_tano
    element set_properties $form_name curr_tano        -value $curr_tano
    element set_properties $form_name flag_ins         -value $flag_ins
    element set_properties $form_name cod_tano         -value $cod_tano
    element set_properties $form_name url_list_rgen    -value $url_list_rgen
    element set_properties $form_name url_rgen         -value $url_rgen
 
}


if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    set lista_tano [array names relazione]     
    foreach cod_tano   $lista_tano {
            set dml_sql [db_map ins_anrg]

       # Lancio la query di manipolazione dati contenute in dml_sql
       if {[info exists dml_sql]} {
           with_catch error_msg {
               db_transaction {
                   db_dml dml_coimrgen $dml_sql
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
 
    ad_returnredirect $curr_prog?funzione=I&[export_url_vars cod_rgen descr_breve cod_tano last_tano curr_tano flag_ins nome_funz nome_funz_caller extra_par url_list_rgen url_rgen]
    ad_script_abort
}

db_release_unused_handles
ad_return_template 

