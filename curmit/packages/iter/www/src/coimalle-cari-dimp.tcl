ad_page_contract {
    @author          Mariano Marchini
    @creation-date   23/01/2012

} {
    {funzione        "I"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
}

set lvl 2 
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set page_title   "Caricamento scansionati e modelli G"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
set form_name "carialledimp"
# mi sposto nella directory contenente i file da caricare
form create $form_name \
    -html    ""

element create $form_name msg \
    -label   "Messaggio " \
    -widget   textarea \
    -datatype text \
    -html    "rows 10 cols 100 class form_element readonly {}" \
    -optional

element create $form_name submit      -widget submit -datatype text -label "Conferma caricamento" -html "class form_submit"
element create $form_name funzione     -widget hidden -datatype text -optional
element create $form_name caller       -widget hidden -datatype text -optional
element create $form_name nome_funz    -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name msg           -value ""
    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set spool_dir  [iter_set_spool_dir]

    #cd "$spool_dir/allegatidacaricare"
    set alleg "$spool_dir/allegatidacaricare"

    # creo l'elenco dei nomi dei file contenuti nella directory
    set msg "Segnalazioni: "

    set elenco ""

  
    if {[file exists $alleg]} {
	set elenco [glob *]
    } else {
	append msg "
Cartella di caricamento vuota"
    } 

    # contatori controllo esecuzione
    set ctrscan 0
    set ctrins 0
    
    # ns_return 200 text/html "elenco = $elenco"
    
    foreach  element $elenco {
	
	set cod_impianto [db_string query "select substr(:element,11)"]
	set data_controllo [db_string query "select substr(:element,1,10)"]

	incr ctrscan

	# imposto nome file da archiviare
	set new_file_name    "$spool_dir/allegati/coimdimp$element"
	
	# controllo che non esista un coimallegati con lo stesso codice
	
	if {[db_0or1row query "select 1 from coimallegati where tabella = 'coimdimp' and allegato = :new_file_name"] == 0} {
	    if {[db_0or1row query "select 1 from coimdimp where cod_impianto = :cod_impianto
                                                            and data_controllo = :data_controllo"] == 0} {
	
    
		incr ctrins
		# imposto nome file da archiviare
		set new_file_name    "$spool_dir/allegati/coimdimp$element"
		
		# imposto il percorso del file da caricare
		set source_file_name "$spool_dir/allegatidacaricare/$element"	
		
		file rename $source_file_name $new_file_name
		
		
		
		db_1row query "select nextval('coimdimp_s') as cod_dimp"
		db_dml cdimp "insert into coimdimp
                                     (cod_dimp,
                                      cod_impianto,
                                      data_controllo,                    
                                      data_ins,
                                      flag_tracciato)
                                values
                                     (:cod_dimp,
                                      :cod_impianto,
                                      :data_controllo,
                                       current_date,      
                                       'G')"
		
		set alle_id [db_string query "select coalesce(max(alle_id) + 1,1) from coimallegati"]
		db_dml alleg "insert into coimallegati
                                     (alle_id,
                                      tabella,
                                      codice,
                                      allegato)
                                values
                                     (:alle_id,
                                      'coimdimp',
                                      :cod_dimp,
                                      :new_file_name)"
		
		
	    } else {
		append msg "Il file $element non pu0' essere inserito poiche' esiste gia' un modello nelle stessa data"
	    }
	} else {
	    append msg "Il file $element e' gia' stato inserito in coimallegati"
	}
	
    }
  
    append msg " Fine caricamento. 
Presenti nella cartella di caricamento $ctrscan scansionati
Inseriti $ctrins"

    element set_properties $form_name msg -value $msg
    ad_return_template
}
