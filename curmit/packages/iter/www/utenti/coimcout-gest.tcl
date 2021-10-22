ad_page_contract {
    Lista tabella "coimcout"

    @author                  Nicola Mortoni (clonato da coimcmar-gest)
    @creation-date           12/11/2013

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella
    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param nome_funz_caller  identifica l'entrata di menu,
                             serve per la navigation bar

    @cvs-id coimcmar-gest.tcl 
} { 
    {search_word       ""}
    {rows_per_page     ""}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""} 
    {extra_par         ""} 

    {funzione           "I"}
    cod_utente
    {cod_comune         ""}
    {url_cout_comu_list ""}

    {flag_ins          ""}
    relazione:array,optional
    {last_comune       ""}
    {curr_comune       ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
    form_name:onevalue
}


# Controlla lo user
switch $funzione {
    "I" {set lvl 2}
    "D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]


if {$funzione == "D"} {
    set dml_sql "delete
                   from coimcout
                  where id_utente  = :cod_utente
                    and cod_comune = :cod_comune"
    
    # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
	with_catch error_msg {
	    db_transaction {
		db_dml dml_coimcout $dml_sql
	    }
	} {
	    iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
	}
    }

    ad_returnredirect $url_cout_comu_list
    ad_script_abort
}


# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title  "Associazione comuni all'utente $cod_utente"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]


# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       ""
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Comune"
set extra_par       [list rows_per_page     $rows_per_page]
set link_aggiungi   ""
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]


set button_label "Conferma Inserimento"


set error_num 0
# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimcout"
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

element create $form_name caller             -widget hidden -datatype text -optional
element create $form_name nome_funz          -widget hidden -datatype text -optional
element create $form_name nome_funz_caller   -widget hidden -datatype text -optional
element create $form_name extra_par          -widget hidden -datatype text -optional

element create $form_name funzione           -widget hidden -datatype text -optional
element create $form_name cod_utente         -widget hidden -datatype text -optional
element create $form_name cod_comune         -widget hidden -datatype text -optional
element create $form_name url_cout_comu_list -widget hidden -datatype text -optional

element create $form_name flag_ins           -widget hidden -datatype text -optional
element create $form_name last_comune        -widget hidden -datatype text -optional
element create $form_name curr_comune        -widget hidden -datatype text -optional

element create $form_name submit             -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {
    if {$flag_ins != "S"} {
	set curr_comune  $last_comune
    }

    set actions {
	<td valign=top align=center><input type=checkbox name=relazione.$cod_comune></td>
    }
    set js_function ""
    
    # imposto la struttura della tabella
    set table_def [list \
	      [list actions       "Associa" no_sort $actions] \
	      [list denominazione "Comune"  no_sort {l}] \
	      ]
    
    # imposto la query SQL 
    if {[string equal $search_word ""]} {
	set where_word ""
    } else {
	set search_word_1 [iter_search_word $search_word]
	set where_word  " and upper(denominazione) like upper(:search_word_1)"
    }
   
    switch $flag_ins {
	"S" {# imposto la condizione per la pagina corrente
	    if {![string is space $curr_comune]} {
                set denominazione [lindex $curr_comune 0]
                set cod_comune    [lindex $curr_comune 1]
                set where_last "and (    (    upper(denominazione)  = upper(:denominazione)
                                          and cod_comune           >= :cod_comune
                                         )
                                     or  upper(denominazione) > upper(:denominazione)
                                    )"
	    } else {
                set where_last ""
	    }
	}
	
	default {   # imposto la condizione per la prossima pagina
	    if {![string is space $last_comune]} {
	        set denominazione   [lindex $last_comune 0]
	        set cod_comune      [lindex $last_comune 1]
                set where_last "and (    (    upper(denominazione)  = upper(:denominazione)
                                          and cod_comune           >= :cod_comune
                                         )
                                     or  upper(denominazione) > upper(:denominazione)
                                    )"
	    } else {
                set where_last ""
	    }
	}
    }

    # recupero la provincia dai dati d'ambiente
    iter_get_coimtgen
    set cod_comu  $coimtgen(cod_comu)
    set flag_ente $coimtgen(flag_ente)
    set cod_prov  $coimtgen(cod_provincia)

    if {$flag_ente == "C"} {
	set where_comu "and cod_comune = :cod_comu"
    } else {
	set where_comu ""
    }

    set flag_ins "N"

    set sel_cout "
             select cod_comune
                  , denominazione
               from coimcomu
              where 1 = 1
                and cod_provincia = :cod_prov
             $where_last
             $where_word
             $where_comu
                and cod_comune not in (select cod_comune 
                                         from coimcout 
                                        where id_utente = :cod_utente) 
           order by upper(denominazione), cod_comune"
    
    set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_utente denominazione cod_comune last_comune curr_comune flag_ins nome_funz nome_funz_caller url_cout_comu_list extra_par} go $sel_cout $table_def]
    
    # preparo url escludendo last_comune che viene passato esplicitamente
    # per poi preparare il link alla prima ed eventualmente alla prossima pagina
    set url_vars [export_ns_set_vars "url" "last_comune flag_ins" ]
    set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"
    
    # preparo link a pagina successiva
    set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
    
    if {$ctr_rec == $rows_per_page} {
	set last_comune [list  $denominazione $cod_comune]
	append url_vars "&[export_url_vars last_comune]"
	append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars&flag_ins=N\">pagina successiva</a>"
    }
    
    # creo testata della lista
    set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
                   $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]
    
    element set_properties $form_name caller             -value $caller
    element set_properties $form_name nome_funz          -value $nome_funz
    element set_properties $form_name nome_funz_caller   -value $nome_funz_caller
    element set_properties $form_name extra_par          -value $extra_par


    element set_properties $form_name funzione           -value $funzione
    element set_properties $form_name cod_utente         -value $cod_utente
    element set_properties $form_name cod_comune         -value $cod_comune
    element set_properties $form_name url_cout_comu_list -value $url_cout_comu_list

    element set_properties $form_name flag_ins           -value $flag_ins
    element set_properties $form_name last_comune        -value $last_comune
    element set_properties $form_name curr_comune        -value $curr_comune
}


if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    set lista_comu [array names relazione]
    foreach cod_comune $lista_comu {
	set dml_sql "
                insert
                  into coimcout
                     ( id_utente
                     , cod_comune
                     , data_ins
                     , utente_ins
                     )
                values
                     (:cod_utente
                     ,:cod_comune
                     ,to_date('[iter_set_sysdate]','YYYYMMDD')
                     ,:id_utente
                     )
        "

       # Lancio la query di manipolazione dati contenute in dml_sql
       if {[info exists dml_sql]} {
           with_catch error_msg {
               db_transaction {
                   db_dml dml_coimcout $dml_sql
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
 
    ad_returnredirect $curr_prog?funzione=I&[export_url_vars cod_utente cod_comune url_cout_comu_list flag_ins last_comune curr_comune nome_funz nome_funz_caller extra_par]
    ad_script_abort
}

db_release_unused_handles
ad_return_template 
