ad_page_contract {
    Bonifica costruttori

    @author                  Giulio Laurenzi
    @creation-date           01/06/2005

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  

    @param caller            se diverso da index rappresenta il nome del form da cui è partita
    @param                   la ricerca ed in questo caso imposta solo azione "sel"

    @param nome_funz         identifica l'entrata di menu, serve per le autorizzazioni

    @param receiving_element nomi dei campi di form che riceveranno gli argomenti restituiti
    @                        dallo script di zoom, separati da '|' ed impostarli come segue:

    @cvs-id coimbcos-gest.tcl 

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    nic01  25/03/2014 Quando si bonifica un costrutture, vanno spostati anche i relativi
    nic01             modelli (ed aggiornate le relative tabelle, es: coimgend).

} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {destinazione      ""}
   {compatta_list     ""}
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
   #set id_utente [ad_get_cookie   iter_login_[ns_conn location]]
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

set page_title      "Bonifica costruttori"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
set mex_error ""

# preparo link per ritorna al filtro:
set link_list [export_url_vars caller nome_funz nome_funz_caller search_word]


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimbcos"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
set button_label "Conferma"

form create $form_name \
-html    $onsubmit_cmd

element create $form_name nome_funz    -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name search_word  -widget hidden -datatype text -optional
element create $form_name caller       -widget hidden -datatype text -optional
element create $form_name submit       -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name destinazione  -widget hidden -datatype text -optional
element create $form_name compatta_list -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name search_word   -value $search_word
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name destinazione  -value $destinazione
    element set_properties $form_name compatta_list -value $compatta_list
    
    set cost_da_compattare "<table border=1 cellpadding=1 cellspacing=0>
                           <tr>
                              <th>Nome costruttore</th>
                           </tr>
                           
"
    foreach cod_cost $compatta_list {
	if {[db_0or1row query "
            select descr_cost
              from coimcost
             where cod_cost = :cod_cost
            "]
	} {
	    append cost_da_compattare "<tr>
                                         <td>$descr_cost</td>
                                      </tr>"
	}
    }
    append cost_da_compattare "</table>"
    set cod_cost $destinazione 
    if {![db_0or1row query "
         select descr_cost
           from coimcost
          where cod_cost = :cod_cost
         "]
    } {
	set descr_cost ""
    }
    set cost_destinazione "<table border=1 cellpadding=1 cellspacing=>
                          <tr>
                              <th>Nome costruttore</th>
                          </tr>
                          <tr>
                             <td>$descr_cost</td>
                          </tr>
                          </table>"
}

if {[form is_valid $form_name]} {

    with_catch error_msg {
	db_transaction {
	    foreach cod_cost $compatta_list {
		# Per prima cosa, devo spostare i modelli dal costruttore originale a quello
		# di destinazione, per ora solo accodandoli a quelli già esistenti.
		db_dml query "update coimmode
                                 set cod_cost = :destinazione
                               where cod_cost = :cod_cost";#nic01

		# Poi cambio il costruttore sui generatori
		db_dml query "update coimgend
                                 set cod_cost = :destinazione
                               where cod_cost = :cod_cost"

		db_dml query "update coimgend
                                 set cod_cost_bruc = :destinazione
                               where cod_cost_bruc = :cod_cost"

		# Ora cancello il costruttore
		db_dml query "delete
                                from coimcost
                               where cod_cost = :cod_cost"
	    }

	    # Infine compatto eventuali modelli che hanno la stessa descrizione.

	    # Prima estraggo le descr_mode che contengono doppioni
	    set lista_descr_mode_doppie [db_list query "
                                         select upper(trim(descr_mode))
                                           from coimmode
                                          where cod_cost = :destinazione
                                       group by upper(trim(descr_mode))
                                         having count(*) > 1"];#nic01

	    # nic01: aggiunta questa foreach ed il suo contenuto
	    foreach descr_mode $lista_descr_mode_doppie {

		# Poi scelgo il codice modello di destinazione
		# 02/07/2014 Su Rimini andava in errore perche' non trovava la riga con 
		#            upper(trim(descr_mode)) = '' perche' i :descr_mode venivano 
		#            trasformati in NULL. Ho risolto con la coalesce.
		db_1row query "select cod_mode as cod_mode_dest
                                 from coimmode
                                where cod_cost                = :destinazione
                 -- 02/07/2014    and upper(trim(descr_mode)) = :descr_mode
                                  and upper(trim(descr_mode)) = coalesce(:descr_mode,'') -- 02/07/2014
                             order by flag_attivo desc
                                    , cod_mode
                                limit 1"

		set lista_cod_mode_orig [db_list query "
                                         select cod_mode
                                           from coimmode
                                          where cod_cost                 = :destinazione
                                            and upper(trim(descr_mode))  = :descr_mode
                                            and cod_mode                <> :cod_mode_dest"]

		foreach cod_mode_orig $lista_cod_mode_orig {
		    # Per ogni codice modello da bonificare, aggiorno la coimgend e lo cancello
		    db_dml query "update coimgend
                                     set cod_mode = :cod_mode_dest
                                   where cod_mode = :cod_mode_orig"

		    db_dml query "update coimgend
                                     set cod_mode_bruc = :cod_mode_dest
                                   where cod_mode_bruc = :cod_mode_orig"

		    db_dml query "delete
                                    from coimmode
                                   where cod_mode = :cod_mode_orig"
		}

	    };#nic01 Fine foreach sulle descr_mode_doppie

	};#fine db_transaction

    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }


    set return_url    "coimbcos-list?[export_url_vars destinazione compatta_list nome_funz nome_funz_caller search_word]"    
    ad_returnredirect $return_url
    ad_script_abort
}

db_release_unused_handles
ad_return_template 
