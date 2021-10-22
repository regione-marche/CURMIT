ad_library {

    General procs 

    @author claudio.pasolini@comune.mantova.it
    @cvs-id $Id:

}

namespace eval ah {}

ad_proc -public ah::service_root  {
} { 
    Returns the root path of the service, i.e. /var/lib/aolserver/service 
} {
    set root [ns_info pageroot]
    regsub {/www} $root {} root
    return $root
}

ad_proc -public ah::package_root  {
    -package_key
} { 
    Returns the root path, down to www, of the requested package, 
    i.e. /var/lib/aolserver/packages/mis/www
    If omitted, returns the root path of the current package.
} {
    if {![info exists package_key]} {
	set package_key [ad_conn package_key]
    }
    set path [service_root]/packages/$package_key/www
    return $path
}

ad_proc -public ah::key_selected_p  {
    -key:required
} { 
    If the parameter is null send an error message and stops the script.
    To be used by the scripts invoked via bulk_actions.
} {
    if {[string equal $key ""]} {
	ad_return_complaint 1 "Non hai selezionato alcun oggetto su cui operare: usa il tasto indietro e riprova."
	ad_script_abort
    }
}

ad_proc -public ah::search_tab  {
    -query_spec:required
    -form_name:required
    -form_key_field:required
    -form_code_field:required
    -form_name_field:required
    {-search_field       ""}
    {-search_word_field  ""}
    {-is_code_search_p  "f"}
} { 
    Crea un link al programma standard di lista. Quest'ultimo utilizza le specifiche
    contenute in 'query_spec' per costruire dinamicamente una lista e restituire al
    form 'form_name' il codice 'form_key_field' e la descrizione 'form-name_field'
    dell'elemento selezionato.  
} {

    set package_id [ad_conn package_id]
    
    if {$search_word_field eq ""} {
       if {$is_code_search_p} {
           set search_word_field $form_code_field
       } else {
           set search_word_field $form_name_field
       }
    }
    
    set search_word "' + document.$form_name.$search_word_field.value"
    
    return "<a href=\"#\" onClick=\"javascript:window.open('/ah-util/list-builder?package_id=$package_id&is_code_search_p=$is_code_search_p&query_spec=$query_spec&form_name=$form_name&form_key_field=$form_key_field&form_code_field=$form_code_field&form_name_field=$form_name_field&search_field=$search_field&search_word=$search_word, 'listbuilder2', 'scrollbars=yes,resizable=yes,width=800,height=600')\"> Cerca</a>"
}

ad_proc -public ah::search_prod  {
    -form_name:required
    -form_key_field:required
    -form_code_field:required
    -form_name_field:required
} { 
    Simile a search_tab ma passa in piu' price_list_id in modo da limitare la 
    lista dei prodotti allo specifico listino.
} {

    set package_id [ad_conn package_id]

    return "<a href=\"#\" onClick=\"javascript:window.open('/ah-util/list-builder?package_id=$package_id&query_spec=product-prices&form_name=$form_name&form_key_field=$form_key_field&form_code_field=$form_code_field&form_name_field=$form_name_field&search_word=' + document.$form_name.$form_name_field.value + '&price_list_id=' + document.$form_name.price_list_id.value, 'listbuilder2', 'scrollbars=yes,resizable=yes,width=800,height=600')\"> Cerca</a>" 
}

ad_proc -public ah::search_clause {
    -search_field:required
    -search_word:required
} { 
    This proc sets an sql where clause to search search_word into search_field
} {
    # substitute all special characters
    set search_word [db_quote $search_word]
    
    # Il '%' deve essere preceduto da backslash per non essere interpretato come 'ogni combinazione di caratteri'.
    # Devo usarne 8 perchè il backslash e' carattere di escape per tcl e postgres.
    regsub -all % $search_word {\\\\\\\\%} search_word
    
    set search_word [string trim $search_word]
    if {$search_word eq ""} {
	return ""
    }
    

    # if search_field name starts with upper_ we don't want to apply the
    # upper function to it, so as to be able to exploit eventual indexes
    if {[string range $search_field 0 5] != "upper_"} {
	set search_field "upper($search_field)"
    }

    foreach token $search_word {
	append where_clause " and $search_field like upper('%$token%') "
    }

    return $where_clause
}

ad_proc -public ah::search_clause_f {
    -search_field:required
    -search_word:required
} { 
    This proc sets an sql where clause to search search_word into search_field (only used in set filters of a list template)
} {
    # substitute all special characters
    set search_word [db_quote $search_word]
    
    # Il '%' deve essere preceduto da backslash per non essere interpretato come 'ogni combinazione di caratteri'.
    # Devo usarne 8 perchè il backslash e' carattere di escape per tcl e postgres.
    regsub -all % $search_word {\\\\\\\\%} search_word
    
    set search_word [string trim $search_word]
    if {$search_word eq ""} {
	return ""
    }
    

    set first_char [string range $search_word 0 0]
    set last_char [string range $search_word [expr [string length $search_word] - 1] [expr [string length $search_word] - 1]]
    if {$first_char eq "*" && $last_char eq "*"} {
	set search_word [string range $search_word 1 [expr [string length $search_word] - 2]]
	append where_clause " upper($search_field) like upper('%$search_word%') "
    } elseif {$first_char eq "*"} {
	set search_word [string range $search_word 1 end]
	append where_clause " upper($search_field) like upper('%$search_word') "
    } elseif {$last_char eq "*"} {
	set search_word [string range $search_word 0 [expr [string length $search_word] - 2]]
	append where_clause " upper($search_field) like upper('$search_word%') "
    } else {
	set ctr_t 1
	foreach token $search_word {
	    if {$ctr_t eq 1} {
		append where_clause " upper($search_field) like upper('%$token%') "
	    } else {
		append where_clause " and upper($search_field) like upper('%$token%') "
	    }
	    incr ctr_t
	}
    }

    

    return $where_clause
}

ad_proc -public ah::date_clause {
    -date_field:required
    -from_date:required
    -to_date:required
} {
    This proc sets an sql where clause to match a date_field between two dates
} {
    # prepare clause if search string provided by user
    if {[string equal $from_date ""] && [string equal $to_date ""]} {
        set where_clause ""
    } else {
        if {[string equal $from_date ""]} {
            set from_date "01/01/1900"
        }
        if {[string equal $to_date ""]} {
            set to_date "31/12/2100"
        }
        set from_date [ah::check_date -input_date $from_date]
        set to_date [ah::check_date -input_date $to_date]
        if {[string equal $from_date "0"] || [string equal $to_date "0"]} {
            set where_clause ""
        } else {
            set where_clause "and $date_field between '$from_date' and '$to_date'"
        }
    }

    return $where_clause
}

ad_proc -public ah::debug {
 -package_key 
} { 
    This proc enables debugging if necessary
} {
    if {![info exists package_key]} {
	set package_key [ad_conn package_key]
    }
    # if requested debug is enabled
    set debug_p [parameter::get_from_package_key \
		     -package_key $package_key \
		     -parameter debug_p \
		     -default 0]
    if {$debug_p} {
	# useful for debugging ad_form
	ns_log notice "it's my page!"
	set mypage [ns_getform]
	if {[string equal "" $mypage]} {
	    ns_log notice "no form was submitted on my page"
	} else {
	    ns_log notice "the following form was submitted on my page"
	    ns_set print $mypage
	}
    }
}


ad_proc -public ah::script_init {
    {-script_name ""}
    {-privilege "exec"}
} {
    Controlla i permessi di accesso allo script 'script_name'.
    Se lo script non viene fornito verra' usato l'url della connessione.
    Se non esistono permessi per lo specifico script, allora si testeranno quelli
    dello script gerarchicamente superiore fino a trovarne uno.
} {

    ah::debug

    set script_id ""
    set script_name [string trim $script_name]
    if {$script_name eq ""} {
        set script_name [string trim $my_url /]
    }

    # Cerco lo script tramite nome per testare i permessi.                                                                                                            
    # Se non lo trovo risalgo le cartelle genitore e prendo i loro permessi.                                                                                           
    while {$script_name ne "" &&
	   ![db_0or1row query "                                                                                                                
            select script_id
            from mis_scripts s, acs_objects o
            where s.script_id = o.object_id and
                  o.title     = :script_name
            limit 1"]} {
        set script_name [join [lrange [split $script_name /] 0 end-1] /]
    }

    set user_id [auth::require_login]
    if {![acs_user::site_wide_admin_p -user_id $user_id]} {
        permission::require_permission -party_id $user_id -object_id $script_id -privilege $privilege
    }
}


ad_proc -public ah::script_auth {
    -script_name:required
} { 
    This proc return auth
} {

    set object_id [db_string query "
        select script_id 
        from mis_scripts s, acs_objects o
        where s.script_id = o.object_id and
              o.title     = :script_name
        limit 1" -default ""]
    set party_id [ad_conn user_id]
    
    if {![permission::permission_p -party_id $party_id -object_id $object_id -privilege read]} {
	if {![permission::permission_p -party_id $party_id -object_id $object_id -privilege exec]} {
	    return 0
	} else {
	    return 1
	}
    } else {
	return 1
    }

}

ad_proc -public ah::script_auth_recursive {
    -script_name:required
    -user_id:required
    {-privilege "exec"}
} {
    Controlla i permessi di accesso allo script 'script_name'.
    Se non esistono permessi per lo specifico script, allora si testeranno quelli
    dello script gerarchicamente superiore fino a trovarne uno.
} {

    # Cerco lo script tramite nome                                                                                                                                    
    # Se non lo trovo risalgo le cartelle genitore e prendo i loro permessi.                                                                                           
    set script_id ""
    while {$script_name ne "" &&
	   ![db_0or1row query "
            select script_id
            from mis_scripts s, acs_objects o
            where s.script_id = o.object_id and
                  o.title     = :script_name
            limit 1"]} {
        set script_name [join [lrange [split $script_name /] 0 end-1] /]
    }

    if {![permission::permission_p -party_id $user_id -object_id $script_id -privilege $privilege]} {
        return 0
    } else {
        return 1
    }

}

ad_proc -public ah::script_write {
    -script_name
} { 
    This proc initializes scripts
} {
    set script_id [db_string query "
        select script_id 
        from mis_scripts s, acs_objects o
        where s.script_id = o.object_id and
              o.title     = :script_name
        limit 1" -default ""]

    set user_id [auth::require_login]
    if {![acs_user::site_wide_admin_p -user_id $user_id]} {
        permission::require_permission -object_id $script_id -privilege exec
    }
}




ad_proc -public ah::js_quote_escape {
    literal
} { 
    Escapes single and double quotes in literals for JavaScript
} {
    regsub -all ' "$literal" \\' result
    regsub -all \" "$result" \\' result
    return $result
}

ad_proc -public ah::xml_badchars_translate {
    literal
} { 
    Translates forbidden characters in literals for xml
} {
    return [string map {"à" "&agrave;" 
                        "á" "&aacute;" 
                        "è" "&egrave;" 
                        "é" "&eacute;" 
                        "ì" "&igrave;" 
                        "í" "&iacute;" 
                        "ò" "&ograve;" 
                        "ó" "&oacute;" 
                        "ù" "&ugrave;"  
                        "ú" "&uacute;"} $literal]
}

ad_proc -public ah::set_list_filters { 
    module
    listname
} {
    Sets the filters reading them from the client property where they was stored.
    To be called when adding search fields to the regular list filters.
    Example:  ah::set_list_filters mis products-list
} {
    # get the saved filters, if any
    set url_vars [ad_get_client_property -default "" $module $listname]
    set url_vars [ns_urldecode $url_vars]

    # remove last char ifit is an '='
#    set l [expr [string length $url_vars] - 1]
#    if {[string range $url_vars $l $l] eq "="} {
#	set url_vars [string range $url_vars 0 [expr $l - 1]]
#    }

    # split the urls getting a list of name value couples
    set args [split $url_vars =&]
    set i 0
    while {$i < [llength $args]} {
        set name  [lindex $args $i]
	set value [lindex $args [expr $i + 1]]
	if {$name eq ""} {
	    incr i 2
	    continue
	}
	upvar $name filter
        if {![info exists filter] || [string equal $name "rows_per_page"]} {
	    # set the filters in the caller scope
	    uplevel  set $name $value
	}
	incr i 2
    }
}

ad_proc -public ah::callback_error_p {
    return_codes
} { 
    Check the return codes of the callbacks and returns a boolean to indicate if there are any errors.
} {

    set some_error_p 0
    foreach rc $return_codes {
	if {$rc > 0} {
	    set some_error_p 1
	    break
	}
    }

    return $some_error_p
}

ad_proc -public ah::transaction_error {
} { 
    Visualizza un messaggio di errore generico a fronte di un errore durante
    l'esecuzione di una db_transaction.
} {

    upvar errmsg errmsg

    ad_return_complaint 1 "
    Si è verificato un errore imprevisto durante l'elaborazione.
    <p>L'errore restituito da PostgreSQL è il seguente:
    <code>$errmsg </code>"

    return

}

ad_proc -public ah::today_ansi  {
} { 
    Restituisce la data del giorno nel formato ANSI YYYY-MM-DD
} {
    return [clock format [clock seconds] -format %Y-%m-%d] 
}

ad_proc -public ah::today_pretty  {
} { 
    Restituisce la data del giorno nel formato DD/MM/YYYY
} {
    return [clock format [clock seconds] -format %d/%m/%Y] 
}

ad_proc -public ah::ansi_to_pretty_date  {
    date
} { 
    Accetta una data nel formato YYYY-MM-DD e la restituisce come DD/MM/YYYY
} {
    return "[string range $date 8 9]/[string range $date 5 6]/[string range $date 0 3]"
}

ad_proc -public ah::pretty_to_ansi_date  {
    date
} { 
    Accetta una data nel formato DD/MM/YYYY e la restituisce come YYYY-MM-DD
} {
    return "[string range $date 6 9]-[string range $date 3 4]-[string range $date 0 1]"
}

ad_proc -public ah::date_to_ansi  {
    date
} { 
    Accetta una data nel formato YYYYMMDD e la restituisce come YYYY-MM-DD
    Se la data contiene è già in formato ANSI si limita a restituirla invariata.
} {
    if {[string length $date] == 10} {
	return $date
    } else {
        return "[string range $date 0 3]-[string range $date 4 5]-[string range $date 6 7]"
    }
}

ad_proc -private ah::log_append  { 
} { 
    Elabora il file di log caricando le entrate significative nella tabella
    mis_monitoring.

    Normalmente il log di aolserver viene chiuso e riaperto alla mezzanotte.
    Questo script dovrebbe quindi essere fatto girare appena prima.
} {
    set service_root [ah::service_root]
    # isolo l'ultimo token dopo l'ultima slash
    regexp {.*/(.*)$} $service_root match service_name 

    # ottengo la data dell'ultima registrazione su mis_monitoring
    set last_logdate [db_string last "
        select logdate 
        from mis_monitoring 
        order by logdate desc 
        limit 1" -default [db_string dt "select current_date - interval '1 month'"]]

ns_log notice "\nLAST DATE $last_logdate"

    # apro file di log
    set logfd [open $service_root/log/$service_name.log r]

    foreach line [split [read $logfd] \n] {

	# devo innanzituto isolare i pezzi di informazione che mi interessano e cioè:
	#
	# 1. IP (ipaddr)
	# 2. data e ora (logdate)
	# 3. url (url)
	# 4. eventuali argomenti della url (query_args)
	# 5. id utente (user_id)

	# scarto le url /resource e /favicon
	if {[regexp {GET /resources} $line] || [regexp {GET /favicon} $line] || $line eq ""} {
	    continue
	}

	# estraggo ipaddr e logdate
	regexp {(.*) - - \[(.*) \+0} $line match ipaddr logdate

        # a volte ipaddr arriva con due indirizzi, separati da ','
        regsub {,.*} $ipaddr {} ipaddr
	# converto data, che arriva in formato  dd/mmm/yyyy traducendo il mese
	# in inglese
	set logdate [string map {gen jan mag may giu jun lug jul ago aug set sep ott oct} $logdate]

        if {[db_string checkdt "select :logdate::timestamp < :last_logdate::timestamp"]} {
	    # scarto record già caricati
	    continue
	}

	# GET or POST?
	if {[regexp {GET } $line]} {
	    # isolo url
	    regexp {GET ([^ ?]*)} $line match url 
	    # isolo query_args
	    if {[regexp {GET [^ ?]*\?(.*) HTTP} $line match query_args]} {
	        set query_args [ns_urldecode $query_args]
	    } else {
		set query_args ""
	    }
	} else {
	    # isolo url
	    regexp {POST ([^ ?]*) HTTP} $line match url
	    set query_args ""
	}

	# estraggo user_id
	if {![regexp {ad_user_login=([0-9]*)%} $line match user_id]} {
	    set user_id ""
	}
        # istruzione messa per vedere cosa sono i query args più lunghi di 500 caratteri
        set query_args [string range $query_args 0 499]

	db_dml append "insert into mis_monitoring values (:ipaddr, :logdate, :url, :query_args, :user_id)"
    }

    # chiudo file di log
    close $logfd

}

ad_proc -private ah::log_sweeper  {
} { 
    Ripulisce da mis_monitoring le entrate più vecchie di un mese.
} {
    db_dml sweep "
    delete from mis_monitoring
    where logdate < current_date - interval '1 month'"
}

ad_proc ah::package_id {
    -package_key:required
    -company_url:required
} {
    Recupera il package_id del package richiesto limitando la ricerca
    al subsite specificato.
} {

    if {$company_url eq "/"} {
	set company_url ""
    }

    array set arr [site_node::get_from_url -url $company_url/$package_key/]

    return $arr(package_id)
}

ad_proc -public ah::semaphore_check  {
} { 
    Verifica esistenza di semaforo, nel qual caso restituisce un messaggio
    e interrompe l'esecuzione, altrimenti imposta il semaforo.
} {
    # uso la url dello script come nome del semaforo
    set semaphore [ad_conn url]

    # ... e il codice utente come valore
    set me [ad_conn user_id]

    # in questo modo posso capire se sono in un caso di doppio click o meno
    if {[nsv_exists $semaphore light]} {
        # lo script è già in esecuzione

	set user_id [nsv_get $semaphore light]
	if {$user_id == $me} {
            set msg "<li>Protezione da doppio click: l' aggiornamento è già stato eseguito. \
                         Quando tornerai indietro dovrai rinfescare la pagina per tener \
                         conto dell'aggiornamento effettuato."
	} else {
            set msg "<li>Il sistema è momentaneamente sovraccarico: riprova più tardi"
	}
        ad_return_complaint 1 $msg
        ad_script_abort
    } else {
	# imposto il semaforo a rosso 
	nsv_set $semaphore light $me
    }
    return
}

ad_proc -public ah::semaphore_off  {
    {-semaphore ""}
} { 
    Spegne il semaforo.

    Normalmente questa proc è chiamata all'uscita di un programma che ha
    precedentemente impostato il semaforo. Eccezionalmente, in caso di abend
    del programma, il semaforo potrebbe rimanere erroneamente impostato.

    In quest'ultimo caso la proc può essere invocata manualmente, passando 
    come argomento il nome del semaforo, cioè la url del programma.
} {
    if {$semaphore eq ""} {
        # uso la url dello script come nome del semaforo
        set semaphore [ad_conn url]
    }

    if {[nsv_exists $semaphore light]} {
        nsv_unset $semaphore light
    }

    return
}

ad_proc -public ah::convert  {
    input
    output
} { 
    Converte un file da un formato ad un altro. 

    I possibili formati di ingresso sono: odt, rtf, doc, txt, html.
    I possibili formati di output sono: pdf, odt, rtf, doc, txt, html.

} {

    set input_types  [list .odt .rtf .doc .txt .html]
    set output_types [list .pdf .odt .rtf .doc .txt .html]

    set input_extension  [file extension $input]
    set output_extension [file extension $output]

    if {$input_extension eq "$output_extension"} {
	return "Inutile convertire da $input_extension a $output_extension"
    }

    if {[lsearch $input_types $input_extension] == -1} {
	return "L'estensione $input_extension non è prevista fra quelle di input"
    }

    if {[lsearch $output_types $output_extension] == -1} {
	return "L'estensione $output_extension non è prevista fra quelle di output"
    }

#    set status [catch {exec [ah::service_root]/packages/ah-util/bin/convert.sh $input $output} result]

    set status [catch {exec java -jar /usr/lib/jodconverter-2.2.2/lib/jodconverter-cli-2.2.2.jar $input $output} result]

    if { $status == 0 } {
        # The command succeeded, and wrote nothing to stderr.
        # $result contains what it wrote to stdout, unless you
        # redirected it
    } elseif { [string equal $::errorCode NONE] } {
        # The command exited with a normal status, but wrote something
        # to stderr, which is included in $result.
	ns_log notice "CONVERT ERROR $result"
    } else {
        switch -exact -- [lindex $::errorCode 0] {
            CHILDKILLED {
                foreach { - pid sigName msg } $::errorCode break
                # A child process, whose process ID was $pid,
                # died on a signal named $sigName.  A human-
                # readable message appears in $msg.
		ns_log notice "CONVERT ERROR $pid $msg"
            }
            CHILDSTATUS {
                foreach { - pid code } $::errorCode break
                # A child process, whose process ID was $pid,
                # exited with a non-zero exit status, $code.
		ns_log notice "CONVERT ERROR $pid $code"
            }
            CHILDSUSP {
                foreach { - pid sigName msg } $::errorCode break
                # A child process, whose process ID was $pid,
                # has been suspended because of a signal named
                # $sigName.  A human-readable description of the
                # signal appears in $msg.
		ns_log notice "CONVERT ERROR $sigName $msg"
            }
            POSIX {
                foreach { - errName msg } $::errorCode break
                # One of the kernel calls to launch the command
                # failed.  The error code is in $errName, and a
                # human-readable message is in $msg.
		ns_log notice "CONVERT ERROR $errName $msg"
            }

        }
    }

    return 0

}

ad_proc -public ah::ws_convert  {
    -input
    -from
    -to
    -output
} { 
    Converte un file da un formato ad un altro invocando un web service. 

    I possibili formati di ingresso sono: odt, rtf, doc, txt, html.
    I possibili formati di output sono: pdf, odt, rtf, doc, txt, html.

    Eventuali messaggi di errore vengono scritti sul file /tmp/wget.log.

} {

    set types [list \
		   odt application/vnd.oasis.opendocument.text \
		   rtf application/rtf \
		   doc application/msword \
		   txt text/plain \
		   html text/html \
		   pdf application/pdf \
		   ]

    array set mime_types $types

    with_catch error_msg {
	exec [ah::service_root]/packages/ah-util/bin/convert.sh \
	    $input \
	    $mime_types($to) \
	    $mime_types($from) \
	    $output

    } {

        set rc 1
	ns_log notice "\nAH::CONVERT ERROR $error_msg"

    }

    return 0

}

ad_proc -public ah::db_unique {
    -table
    -column_value
    -array
} { 
    Ricevendo in ingresso una tabella e una lista di liste (campo, valore),
    ritorna se la ricerca secondo l'input ha identificato una sola riga.
    
    Se ciò avviene array conterrà l'associazione (campo, valore) identificata

} { 
    upvar 1 $array row
    
    set select_clause ""
    set where_clause  ""
    
    set i 0
    foreach {column value} $column_value {
	if {$i != 0} {
	    append select_clause ", "
	}
	append select_clause "$column "
	
	if {[set value [string trim $value]] ne ""} {
	    append where_clause " and upper($column) like upper('%$value%')"
	}
	incr i
    }
    
    with_catch errmsg {
	db_1row query "select $select_clause from $table where 1 = 1 $where_clause limit 2" -column_array row
    } {
	return 0
    }
    
    return 1
}

ad_proc -public ah::levenshtein_d  {
    -s
    -t
    {-max "omit"}
} { 
    Calcola la distanza di levenshtein tra la stringa 's' e la stringa 't'.
    Opzionalmente può fermarsi al raggiungimento di una differenza massima
    'max'.
    
    Non sono ammesse le stringhe più lunghe di 100 caratteri
    per evitare esplosioni della computazione.
    
    fonte: http://wiki.tcl.tk/3070
} { 
    set maxlength 100
    if {$max eq "omit"} { set max $maxlength }
    
    # Controllo sull'input 
    if {[string length $s] > $maxlength || [string length $t] > $maxlength} {
	ad_return_complaint 1 "Il calcolo della distanza tra stringhe viene interrotto per il superamento dei $maxlength caratteri!"
	return "Error"
    }
    
    # special case: $s is an empty string
    if {$s eq ""} {
      return [string length $t]
    }

    # initialize first row in table
    for {set i 0} {$i <= [string length $t]} {incr i} {
      lappend prevrow $i
    }

    set i 0
    foreach schar [split $s ""] {
      incr i
      set j 0
      set row [list $i]
      foreach tchar [split $t ""] {
        incr j
        set cost [expr {$schar ne $tchar}] ;# $cost is 0 if same, 1 if different
        # difference between $schar and $tchar is minimum of:
        #   [lindex $prevrow $j]   + 1     = cost of deletion
        #   [lindex $row     $j-1] + 1     = cost of insertion
        #   [lindex $prevrow $j-1] + $cost = cost of substitution (zero if same char)
        # Rispetto al codice originale ottengo il minimo dal primo elemento della lista ordinata.
        # faccio così perchè l'ambiente tcl non fornisce la funzione matematica min.
	set last_value [lindex [lsort -integer -increasing [list [expr [lindex $prevrow $j] + 1] [expr [lindex $row [expr {$j-1}]] + 1] [expr [lindex $prevrow [expr {$j-1}]] + $cost]]] 0]
	
	if {$last_value < $max} {
	    lappend row $last_value
	# Mi fermo al raggiungimento della massima distanza consentita
	} else {
	    return $last_value
	}
      }
      
      set prevrow $row
    }
    # Levenshtein distance is value at last cell of last row
    return [lindex $row end]
}

ad_proc -public ah::email_w_attachment  {
    -to_addr:required
    -from_addr:required
    -file_path:required
    -name:required
    -send_immediately
    -valid_email
    {-cc_addr       ""}
    {-bcc_addr      ""}
    {-subject       ""}
    {-body          ""}
    {-from_addr_in_cc  "t"}
} { 
    Invia una mail alla quale viene allegato il file 'filename'.
    'filename' deve essere un file esistente nel filesystem.
    
    La mail viene inviata all'indirizzo specificato e in conoscenza anche
    al mittente e si cerca, tramite gli opportuni header, di richiedere
    una conferma di lettura del messaggio.
} { 
    # Get the ip
    set creation_ip [ad_conn peeraddr]
    
    set user_id [ad_conn user_id]

    # get file-storage package id
#sim    set fs_package_id [apm_package_id_from_key file-storage]
    set fs_package_id 2439


    # get the root folder of the file-storage instance
    set folder_id [fs::get_root_folder -package_id $fs_package_id]

    # Viene creato un file temporaneo nello Storage System,
    # necessario per poter allegare un documento alla mail.
    set file_id [db_nextval "acs_object_id_seq"]
    fs::add_file \
	-name $name \
	-item_id $file_id \
	-parent_id $folder_id \
	-tmp_filename $file_path \
	-creation_user $user_id \
	-creation_ip $creation_ip \
	-package_id $fs_package_id
    
    # Aggiungo gli header per richiedere (quando supportato dal client ricevente)
    # una conferma di lettura. (Non da' comunque alcuna garanzia che il messaggio
    # sia stato letto)
    set extra_headers [list]
    
    lappend extra_headers [list "Disposition-Notification-To" $from_addr]
    lappend extra_headers [list "Return-Receipt-To" $from_addr]
    lappend extra_headers [list "X-Confirm-reading-to" $from_addr]

    #sim01 se from_addr_in_cc è diverso da t il from_addr non deve rientrare nei cc_addr

    if {$from_addr_in_cc eq "t"} {#sim01

    acs_mail_lite::send \
	-send_immediately \
	-valid_email \
	-to_addr          $to_addr \
	-cc_addr          [lappend cc_addr $from_addr] \
	-bcc_addr         $bcc_addr \
	-from_addr        $from_addr \
	-subject          $subject \
	-body             $body \
	-file_ids         [list $file_id] \
	-extraheaders     $extra_headers

    } else {#sim01 else e suo contenuto

    acs_mail_lite::send \
	-send_immediately \
	-valid_email \
	-to_addr          $to_addr \
	-cc_addr          $cc_addr \
	-bcc_addr         $bcc_addr \
	-from_addr        $from_addr \
	-subject          $subject \
	-body             $body \
	-file_ids         [list $file_id] \
	-extraheaders     $extra_headers

    }

    # Il file temporaneo viene rimosso.
    fs::delete_file -item_id $file_id -parent_id $folder_id
}

ad_proc -public ah::ftp_put  {
    -ftp_ip:required
    -ftp_user:required
    -ftp_password:required
    -wrkdir:required
    -filename:required
    {-ftp_dir ""}
    {-ftp_file ""}
} { 
    Manda un file al sito ftp indicato, eventualmente rinominandolo come ftp_file, eventualmente depositandolo
    nella directory indicata nel parametro ftp_dir
} { 
    cd $wrkdir
    # preparo script di ftp 
    set fd [open "$wrkdir/ftp_script.tmp" w]
    if {$ftp_dir ne ""} {
	set cd_cmd "cd $ftp_dir"
    } else {
	set cd_cmd ""
    }
    if {$ftp_file ne ""} {
	set rename_cmd " rename $filename $ftp_file"
    } else {
	set rename_cmd ""
    }

    puts $fd "user $ftp_user $ftp_password\n$cd_cmd\nput $filename\n$rename_cmd\nquit\n"
    close $fd
    set return_msg "Ok"
    
    with_catch errmsg {
	exec "ftp" "-n" "$ftp_ip" "<$wrkdir/ftp_script.tmp"
    } {
	ns_log notice "\nFtp $ftp_ip - $wrkdir - $filename put\nFallito ftp, errore: $errmsg"
	set return_msg "Nok $errmsg"
    }
    
    ns_unlink -nocomplain $wrkdir/ftp_script.tmp

    return $return_msg

}

ad_proc -public ah::ftp_get  {
    -ftp_ip:required
    -ftp_user:required
    -ftp_password:required
    -wrkdir:required
    {-ftp_file "*"}
    {-ftp_dir ""}
} { 
    Recupera un file dal sito ftp indicato, eventualmente andandolo a prendere nella directory indicata nel parametro
    ftp_dir. Se non indicato il nome di file, prende tutti quelli della directory
} { 
    cd $wrkdir
    # preparo script di ftp 
    set fd [open "$wrkdir/ftp_script.tmp" w]
    if {$ftp_dir ne ""} {
	set cd_cmd "cd $ftp_dir"
    } else {
	set cd_cmd ""
    }

    puts $fd "user $ftp_user $ftp_password\n$cd_cmd\nprompt\nbynary\nmget $ftp_file\nquit\n"
    close $fd
    set return_msg "Ok"
    
    with_catch errmsg {
	exec "ftp" "-n" "$ftp_ip" "<$wrkdir/ftp_script.tmp"
    } {
	ns_log notice "\nFtp $ftp_ip - $wrkdir - $ftp_file get\nFallito ftp, errore: $errmsg"
	set return_msg "Nok $errmsg"
    }
    
    ns_unlink -nocomplain $wrkdir/ftp_script.tmp

    return $return_msg

}

ad_proc -public ah::ftp_del  {
    -ftp_ip:required
    -ftp_user:required
    -ftp_password:required
    -wrkdir:required
    {-ftp_file "*"}
    {-ftp_dir ""}
} { 
    Cancella un file dal sito ftp indicato, eventualmente nella directory indicata nel parametro
    ftp_dir. Se non indicato il nome di file, cancella tutti i files della directory
} { 
    # preparo script di ftp 
    cd $wrkdir
    set fd [open "$wrkdir/ftp_script.tmp" w]
    if {$ftp_dir ne ""} {
	set cd_cmd "cd $ftp_dir"
    } else {
	set cd_cmd ""
    }

    puts $fd "user $ftp_user $ftp_password\n$cd_cmd\nmdelete $ftp_file\nquit\n"
    close $fd
    set return_msg "Ok"
    
    with_catch errmsg {
	exec "ftp" "-n" "$ftp_ip" "<$wrkdir/ftp_script.tmp"
    } {
	ns_log notice "\nFtp $ftp_ip - $wrkdir - $ftp_file del\nFallito ftp, errore: $errmsg"
	set return_msg "Nok $errmsg"
    }
    
    ns_unlink -nocomplain $wrkdir/ftp_script.tmp

    return $return_msg

}

#ad_schedule_proc -schedule_proc ns_schedule_daily [list 23 59] ah::log_append
#ad_schedule_proc -schedule_proc ns_schedule_daily [list 23 58] ah::log_sweeper
