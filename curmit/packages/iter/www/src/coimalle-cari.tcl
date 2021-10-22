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




set page_title   "Caricamento scansionati"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
set form_name "carialle"
# mi sposto nella directory contenente i file da caricare
form create $form_name \
    -html    ""

set id_ruolo [db_string sel_ruolo "select id_ruolo from coimuten where id_utente = :id_utente"]
if {$id_ruolo ne "admin"} {
    iter_return_complaint "Spiacente, utente non abilitato per questa funzione: oltre ad avere i permessi corretti, è necessario avere anche ruolo di \"System administrator\""
    ad_script_abort
}

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
	
	incr ctrscan
	
	# controllo che non esista un coimallegati con lo stesso codice
	
	if {[db_0or1row query "select 1 from coimallegati where tabella = 'coimdimp' and codice = :element"] == 0} {
	    
	    incr ctrins
	    # imposto nome file da archiviare
	    set new_file_name    "$spool_dir/allegati/coimdimp$element"
	    
	    # imposto il percorso del file da caricare
	    set source_file_name "$spool_dir/allegatidacaricare/$element"	
	    
	    file rename $source_file_name $new_file_name
	    
	    set alle_id [db_string query "select coalesce(max(alle_id) + 1,1) from coimallegati"]
	    
	    db_dml query "insert into coimallegati
                                     (alle_id,
                                      tabella,
                                      codice,
                                      allegato)
                                values
                                     (:alle_id,
                                      'coimdimp',
                                      :element,
                                      :new_file_name)"


	} else {
	    append msg "
Il file $element e' gia' stato inserito in coimallegati"
	}
	
    }
  
    append msg " Fine caricamento. 
Presenti nella cartella di caricamento $ctrscan scansionati
Inseriti $ctrins"

    element set_properties $form_name msg           -value $msg
    ad_return_template
}
