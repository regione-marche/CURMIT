ad_page_contract {
    Creates dynamically a list, provided a 'query_spec'.
    If a search field is specified, the query will be filtered
    upon it. If not, then the query will be filtered on one
    of the columns predefined as code and name in the xml.
    
    Returns the results of the selected element to 
    the calling 'form_name'.

    @author Claudio Pasolini
    @date   Agosto 2004
    @cvs-id list-builder.tcl

    @param query_spec        Name of an xml file containing the query specs
    @param form_name         Name of calling form
    
    @param search_field      Search which field should I search?
    @param search_word       Search string
    @param form_key_field    Target key field for the element selected
    @param form_code_field   Target code field for the element selected
    @param form_name_field   Target name field for the element selected
    @is_code_search_p        Should I search by code instead that by name?

} {
    query_spec
    form_name
    
    search_word
    
    {search_field ""}
    
    {form_key_field    ""}
    {form_code_field   ""}
    {form_name_field   ""}
    
    {is_code_search_p "f"}
}


# leggo la lunghezza del codice conto
set compound_lengths [mis::acct::compound_lengths]
set account_length   [lindex $compound_lengths end]


# leggo file di configurazione
set fd [open $query_spec.xml r]

# creo struttura dom leggendo il file di configurazione
set doc [dom parse [read $fd]]
close $fd

# e acquisisco l'elemento radice
set root [$doc documentElement]


# recupero titolo della lista
set page_title [$root getAttribute title]
set context [list $page_title]


# recupero query
set query_node [$root firstChild]
set query_text [$query_node firstChild]
set query_sql  [$query_text nodeValue]

# eseguo un round di sostituzioni 
set query_sql [subst $query_sql]


# estendo query con search_clause, generando se necessario una where clause
if {![regexp -nocase where "$query_sql"]} {
    set where_clause " where 1=1 "
} else {
    set where_clause ""
}

append query_sql $where_clause


# Se non e' specificato un campo nel quale cercare...
if {$search_field eq ""} {
    # ... ma vengono fornite le colonne per codice o nome
    if {$form_code_field ne "" || $form_name_field ne ""} {

	# ...se la ricerca e' esplicitamente per codice...
	if {$is_code_search_p} {
	    # ...il campo nel quale cercare sara' la colonna specificata nell'xml...
	    set search_field [$root getAttribute code_col ""]

	    # ...o se mancante, il campo codice fornito.
	    if {$search_field eq ""} {
		set search_field $form_code_field
	    }
	# ...altrimenti la ricerca sara' per nome...
	} else {
	    # ...la colonna da cercare sara' quella dell'xml
   	    set search_field [$root getAttribute name_col ""]

	    # ...o se mancante, il campo nome fornito.
	    if {$search_field eq ""} {
		set search_field $form_name_field
	    }
	}
    }
}

# Se dopo tutto questo ancora non ho una colonna per filtrare segnalo errore.
if {$search_field eq ""} {
    ad_return_complaint 1 "E' necessario impostare un campo nel quale cercare. Impossibile procedere."
    ad_script_abort
}

append query_sql [ah::search_clause -search_word [DoubleApos $search_word] -search_field $search_field]


# se la search clause e' troppo lasca rischio di restituire un set enorme,
# per cui lo limito a 100
append query_sql " limit 100"


# inizio compilazione lista
set list_template "
    template::list::create -name table_list  -multirow table_list -elements \{
    sel \{
    display_template \{@table_list.sel;noquote@\} 
    sub_class narrow
    \}
    "

# se viene specificato un campo chiave, ne tengo conto.
if {$form_key_field ne ""} {
    set key_col  [$root getAttribute key_col]
        
    lappend sel_call_args "'\$$key_col'"
    lappend sel_def_args "$form_key_field"
    append sel_code "
	try {
	    window.opener.document.$form_name.$form_key_field.value = $form_key_field;
	} catch (err) {
	    //Il campo chiave non esiste nella form chiamante.
	}
    "
}

# se viene specificato un campo codice, ne tengo conto.
if {$form_code_field ne ""} {
    set code_col [$root getAttribute code_col]
    
    lappend sel_call_args "'\[ah::js_quote_escape \$$code_col\]'"
    lappend sel_def_args "$form_code_field"
    append sel_code "
	try {
	    window.opener.document.$form_name.$form_code_field.value = $form_code_field;
	} catch (err) {
	    //Il campo codice non esiste nella form chiamante.
	}
    "
}

# se viene specificato un campo nome, ne tengo conto.
if {$form_name_field ne ""} {
    set name_col [$root getAttribute name_col]
    
    lappend sel_call_args "'\[ah::js_quote_escape \$$name_col\]'"
    lappend sel_def_args "$form_name_field"
    append sel_code "
	try {
	    window.opener.document.$form_name.$form_name_field.value = $form_name_field;
	} catch (err) {
	    //Il campo nome non esiste nella form chiamante.
	}
    "
}

# Itero tutti gli elementi della lista
set element_list [$root selectNodes //col]
foreach element $element_list {
    set name       [$element getAttribute name] 
    set label      [$element getAttribute label "$name"] ; # default name

    # continuo definizione dinamica di list_template
    append list_template "
        $name {
            label \"$label\"
        }
        "

    # I campi forniti esplicitamente come da esportare verranno saltati
    # perche' gia' aggiunti prima.
    if {$form_key_field ne ""} {
	if {$name eq $key_col} {
	    continue
	}
    }

    if {$form_code_field ne ""} {
	if {$name eq $code_col} {
	    continue
	}
    }
    
    if {$form_name_field ne ""} {
	if {$name eq $name_col} {
	    continue
	}
    }
    
    # definisco dinamicamente la funzione js che passa alla form
    # chiamante i dati della lista.
    lappend sel_call_args "'\[ah::js_quote_escape \$$name\]'"
    lappend sel_def_args $name
    append  sel_code "
	try {
	    window.opener.document.$form_name.$name.value = $name;
	} catch (err) {
	    //Il campo $name non esiste nella form chiamante.
	}
    "
}

set sel_call_args [join $sel_call_args ,]
set sel_def_args [join $sel_def_args ,]

append list_template "\}"

# inizio definizione della struttura multirow per popolare list_template
set list_multirow "
db_multirow \\
    -extend {sel} table_list query {
      $query_sql
    } {
	set sel \"<a href=\\\"javascript:sel($sel_call_args)\\\">Sel</a>\"
    }
"

# ora creo un'unica struttura che rappresenta il programma di lista 
append list_template $list_multirow    

#ns_log notice "\nDEBUG\n$list_template"

# ed eseguo il frammento di codice generato
eval $list_template


# define JS function for adp page
set javascript "
<script language=JavaScript>
  function sel($sel_def_args) {
    $sel_code
    window.close();
  }
</script>
"
