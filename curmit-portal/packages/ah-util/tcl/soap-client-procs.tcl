ad_library {

    Proc di gestione stringhe xml.

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    cla01 05/02/2017 Aggiunta proc ah_muo_explorer per modulo integrato sportello unico eventi
    cla01            on-line - integrazione con impresainungiorno:
    cla01            e' identica alla ah_dom_explorer ma ha in piu' il parametro
    cla01            -omit_parent_name.

    nic01 16/12/2016 Aggiunta proc ah_xml_get_node_id_by_tag_name per web-service toponomastica.
}


proc flush_whitespace_between_brackets {xml_string} {
  # tolgo gli spazi compresi tra ><, con l'altro metodo ci impiega troppo
  # su blocchi xml grossi (9k) perche' esegue l'istruzione una volta per riga
  # (nel mio caso 200) e fa fatica a trovare memoria disponibile.
  # col mio metodo fa l'operazione solamente una volta!
  # ci impiega pochi centesimi di secondo al posto di 2 minuti!!!
  # Nicola Mortoni (Adhoc).
    regsub -all {>[ |\t|\n|\r]+<} $xml_string {><} xml_string
#nm while  {[regsub -all {(.*)>[ |\t|\n|\r]+<(.*)} $xml_string {\1><\2} xml_string] !=0} {
#nm	continue
#nm }
    return $xml_string
}


ad_proc ah_dom_explorer {
    -parent_names:boolean
    {-xml ""}
    {-node ""}
    {-strip_string ""}
    {-prefix ""}
    {-name ""}
    {-level "1"}
    {-suffix ""}
} {
    Analizza un nodo dom e valorizza nel programma tcl chiamante le variabili
    corrispondenti ai vari nodi di testo trovati e agli eventuali attributi degli elementi.

    @parent_names  Se specificato, questo switch provoca la composizione del nome delle variabil trovate 
                   prefissandole con il nome dei padri, separati da .
                   es: parent1.parent2.element_name
    @xml           Struttura xml restituita dal web service. In alternativa a @node.
    @node          E' il nome della variabile che contiene il nodo dom da esplorare. In alternativa a @xml.
    @strip_string  Opzionale. Se specificata la stringa viene rimossa dal nome del campo.
    @prefix        E' un prefisso opzionale da mettere in testa al nome delle variabili.
                   es: prefix.element_name 
                   Puo' essere combinato con -parent_names
                   es: prefix.parent1.parent2.element_name
                   Nelle chiamate successive viene usato per contenere il nome concatenato della variabile,
                   comprensivo di prefisso e parent names separati dal carattere '.'.
    @level         Rappresenta il livello di profondita' della struttura XML che si sta esplorando.
                   Viene usato SOLO internamente nelle invocazioni ricorsive.
    @suffix        Se specificato, viene appeso al nome della variabile.
                   Viene usato SOLO internamente nelle invocazioni ricorsive.
} {

    if {($xml eq "" && $node eq "") || ($xml ne "" && $node ne "")} {
	ad_return_complaint 1 "ah_dom_explorer: I parametri -xml e -node sono alternativi e uno dei due è obbligatorio."
	ad_script_abort
    }

    if {$xml ne ""} {
        set doc  [dom parse $xml]
        set root [$doc documentElement]  ; # Envelope
        set node [$root firstChild]      ; # Body
        set node [$node firstChild]      ; # Response
        set node [$node firstChild]      ; # Result
    }

    # preparo frammento di codice richiamato successivamente
    set prepara_nome_variabile {
	if {$prefix ne $name} {
	    if {$prefix eq "" || !$parent_names_p} {
		if {$prefix ne ""} {
		    append prefix "."
		}
		append prefix $name
	    }
	}
	# elimino eventuale '.' a destra del nome
	set prefix [string trimright $prefix .]
    }

    set type [$node nodeType]

    switch $type {
	"ELEMENT_NODE" {

	    set name   [$node nodeName]
	    if {$strip_string ne ""} {
		regsub $strip_string $name {} name
	    }
	    set childs [$node childNodes]

	    if {$parent_names_p} {
                # devo concatenare il nome dell'elemento ai suoi parent ed al prefisso
		if {$level > 1 || [string is space $prefix]} {
		    if {![string is space $prefix]} {
			append prefix "."
		    }
		    append prefix $name
		    if {![string equal $suffix ""]} {
			append prefix _$suffix
		    }
		}
	    } else {
                # devo impostare prefix 
		if {$level > 1 || [string is space $prefix]} {
		    if {![string is space $prefix]} {
			append prefix "."
		    }
		    set prefix $name
		    if {![string equal $suffix ""]} {
			append prefix _$suffix
		    }
		}
	    }

            #ns_log notice "\nSOAP processing ELEMENT $name prefix=$prefix"

            # verifico innanzitutto se l'elemento ha degli attributi, ma escludo 
            # il root element, in quanto contiene attributi speciali
	    if {![string equal [$node parentNode] ""]} {
		set ids [$node attributes]
		#ns_log notice "\nDEBUG processing IDS $ids"
		foreach id $ids {
		    # ignoro elementi con attributi dichiarativi di tipo xmlns
		    if {[llength $id] > 1} {
			break
		    }
		    if {$id eq ""} {
			continue
		    }
		    eval $prepara_nome_variabile
		    # ottengo valore dell'attributo
		    set value [$node getAttribute $id]
		    set cmd [list set ${prefix}.$id $value]
                    #ns_log notice "\ndebug creo attributo $cmd"
		    uplevel $level $cmd
		}
	    }

	    if {[llength $childs] == 0} {
                #ns_log notice "\nSOAP processing ELEMENT $name - 0 childs prefix=$prefix"
                # caso in cui ho un nodo di testo vuoto
		eval $prepara_nome_variabile
		set value ""
		set cmd   [list set $prefix $value]
                #ns_log notice "\ndebug nodo vuoto $cmd"
		uplevel $level $cmd
	    } elseif {[llength $childs] == 1} {
		# avendo un unico figlio la variabile creata e' gia' univoca
		incr level

                #ns_log notice "\nSOAP processing ELEMENT $name - 1 child prefix=$prefix - calling explore"

		set child $childs 

		if {$parent_names_p} {
		    ah_dom_explorer \
			-parent_names \
			-node $child \
			-strip_string $strip_string \
			-prefix $prefix \
			-level $level \
			-suffix $suffix 
		} else {
		    ah_dom_explorer \
			-node $child \
			-strip_string $strip_string \
			-prefix $prefix \
			-level $level \
			-suffix $suffix 
		}

	    } else {

		# Avendo n figli posso avere casi in cui alcuni hanno lo stesso nome, nel qual caso devo suffissarli,
                # preparo quindi un array di nomi dei figli in cui il valore rappresenta il numero di ricorrenze
                if {[array exists childs_names]} {
		    array set childs_names [list]
		}

		foreach child $childs {

		    # isolo nome child
                    set child_name [$child nodeName]

                    # creo lista nomi childs
                    lappend nodes_names $child_name

                    # creo o incremento array
		    if {[info exists childs_names($child_name)]} {
		        incr childs_names($child_name) 
		    } else {
		        set childs_names($child_name) 1                    
		    }

		}
  
                set len [llength $childs]

		incr level

                set i 0
                while {$i < $len} {
		    # childs      = lista comandi dom
                    # nodes_names = lista nomi dei nodi corrispondenti
                    # childs_names= array con numero ricorrenze

		    set node_name [lindex $nodes_names $i]
		    set num       $childs_names($node_name)

		    if {$num == 1} {

			#ns_log notice "\nSOAP processing ELEMENT $name - n different childs prefix=$prefix - calling explore without suffix"

                        set child     [lindex $childs $i]

			if {$parent_names_p} {
			    ah_dom_explorer \
				-parent_names \
				-node $child \
 			        -strip_string $strip_string \
				-prefix $prefix \
				-level $level 
			} else {
			    ah_dom_explorer \
				-node $child \
               			-strip_string $strip_string \
				-prefix $prefix \
				-level $level 
			}
 
                        incr i

		    } else {

                        set suffix 1

		        #ns_log notice "\nSOAP processing ELEMENT $name - $num childs with same name prefix=$prefix - calling explore with suffix=$suffix"
                        # itero l'invocazione per il numero di ricorrenze del nodo
                        while {$suffix <= $num} {

                            set child     [lindex $childs $i]

			    if {$parent_names_p} {
				ah_dom_explorer \
				    -parent_names \
				    -node $child \
 			            -strip_string $strip_string \
				    -prefix $prefix \
				    -level $level \
				    -suffix $suffix 
			    } else {
				ah_dom_explorer \
				    -node $child \
			            -strip_string $strip_string \
				    -prefix $prefix \
				    -level $level \
				    -suffix $suffix 
			    }
			    incr suffix
			    incr i
			}
		    }
		}
	    }
	}
	"TEXT_NODE" {
	    eval $prepara_nome_variabile
	    set value [$node nodeValue]
            #ns_log notice "\nSOAP processing TEXT NODE $name prefix=$prefix value=$value"
            set cmd   [list set $prefix $value]
            #ns_log notice "\ndebug text node $cmd"
	    uplevel $level $cmd
	}
	"COMMENT_NODE" {#cla01: aggiunto blocco COMMENT_NODE
            # ignoro
	}
	default {
	    return -code error "NodeType non gestito: $type"
	}
    }

    return
}

ad_proc ah_dom_tree {
    -parent_names:boolean
    -node
    -multirow
    {-prefix ""}
    {-name ""}
    {-level "1"}
    {-suffix ""}
} {
    Analizza un nodo dom e valorizza nel programma tcl chiamante le variabili
    corrispondenti ai vari nodi di testo trovati e agli eventuali attributi degli elementi.

    @parent_names  Se specificato, questo switch provoca la composizione del nome delle variabil trovate 
                   prefissandole con il nome dei padri, separati da .
                   es: parent1.parent2.element_name
    @node          E' il nome della variabile che contiene il nodo dom da esplorare
    @prefix        E' un prefisso opzionale da mettere in testa al nome delle variabili.
                   es: prefix.element_name 
                   Puo' essere combinato con -parent_names
                   es: prefix.parent1.parent2.element_name
                   Nelle chiamate successive viene usato per contenere il nome concatenato della variabile,
                   comprensivo di prefisso e parent names separati dal carattere '.'.
    @level         Rappresenta il livello di profondita' della struttura XML che si sta esplorando.
                   Viene usato SOLO internamente nelle invocazioni ricorsive.
    @suffix        Se specificato, viene appeso al nome della variabile.
                   Viene usato SOLO internamente nelle invocazioni ricorsive.
} {

    upvar 1 $multirow tree

    set type [$node nodeType]

    switch $type {
	"ELEMENT_NODE" {

	    set name   [$node nodeName]
	    set childs [$node childNodes]

	    if {$parent_names_p} {
                # devo concatenare il nome dell'elemento ai suoi parent ed al prefisso
		if {$level > 1 || [string is space $prefix]} {
		    if {![string is space $prefix]} {
			append prefix "."
		    }
		    append prefix $name
		    if {![string equal $suffix ""]} {
			append prefix _$suffix
		    }
		}
	    }

            #ns_log notice "\nSOAP processing ELEMENT $name prefix=$prefix"

            # verifico innanzitutto se l'elemento ha degli attributi, ma escludo 
            # il root element, in quanto contiene attributi speciali
	    if {![string equal [$node parentNode] ""]} {
		set ids [$node attributes]
		#ns_log notice "\nDEBUG processing IDS $ids"
		foreach id $ids {
		    # ignoro elementi con attributi dichiarativi di tipo xmlns
		    if {[llength $id] > 1} {
			break
		    }
		    if {$id eq ""} {
			continue
		    }

		    # ottengo valore dell'attributo
		    set value [$node getAttribute $id]

                    # popolo multirow
		    set pretty_var ""
		    # trimmo tutto cio' che precede l'ultimo ':' dal nome della variabile
		    regexp {.+:(.+)} ${prefix}.$id match pretty_var
		    if {$pretty_var eq ""} {
			set pretty_var ${prefix}.$id
		    }

                    set pretty_var [string repeat . [expr $level * 4]]$pretty_var
		    template::multirow append childs ${prefix}.$id $value
		}
	    }

	    if {[llength $childs] == 0} {
                #ns_log notice "\nSOAP processing ELEMENT $name - 0 childs prefix=$prefix"
                # caso in cui ho un nodo di testo vuoto

		set value ""
		# popolo multirow
		set pretty_var ""
		# trimmo tutto cio' che precede l'ultimo ':' dal nome della variabile
		regexp {.+:(.+)} ${prefix} match pretty_var
		if {$pretty_var eq ""} {
		    set pretty_var ${prefix}
		}

		set pretty_var [string repeat . [expr $level * 4]]$pretty_var
		template::multirow append childs ${prefix} $value


	    } elseif {[llength $childs] == 1} {
		# avendo un unico figlio la variabile creata e' gia' univoca
		incr level

                #ns_log notice "\nSOAP processing ELEMENT $name - 1 child prefix=$prefix - calling explore"

		set child $childs 

		if {$parent_names_p} {
		    ah_dom_tree \
			-parent_names \
			-node $child \
			-multirow tree \
			-prefix $prefix \
			-level $level \
			-suffix $suffix 
		} else {
		    ah_dom_tree \
			-node $child \
			-multirow tree \
			-prefix $prefix \
			-level $level \
			-suffix $suffix 
		}

	    } else {

		# Avendo n figli posso avere casi in cui alcuni hanno lo stesso nome, nel qual caso devo suffissarli,
                # preparo quindi un array di nomi dei figli in cui il valore rappresenta il numero di ricorrenze
                if {[array exists childs_names]} {
		    array set childs_names [list]
		}

		foreach child $childs {

		    # isolo nome child
                    set child_name [$child nodeName]

                    # creo lista nomi childs
                    lappend nodes_names $child_name

                    # creo o incremento array
		    if {[info exists childs_names($child_name)]} {
		        incr childs_names($child_name) 
		    } else {
		        set childs_names($child_name) 1                    
		    }

		}
  
                set len [llength $childs]

		incr level

                set i 0
                while {$i < $len} {
		    # childs      = lista comandi dom
                    # nodes_names = lista nomi dei nodi corrispondenti
                    # childs_names= array con numero ricorrenze

		    set node_name [lindex $nodes_names $i]
		    set num       $childs_names($node_name)

		    if {$num == 1} {

			#ns_log notice "\nSOAP processing ELEMENT $name - n different childs prefix=$prefix - calling explore without suffix"

                        set child     [lindex $childs $i]

			if {$parent_names_p} {
			    ah_dom_tree \
				-parent_names \
				-node $child \
   			        -multirow tree \
				-prefix $prefix \
				-level $level 
			} else {
			    ah_dom_tree \
				-node $child \
   			        -multirow tree \
				-prefix $prefix \
				-level $level 
			}
 
                        incr i

		    } else {

		        #ns_log notice "\nSOAP processing ELEMENT $name - n childs with same name prefix=$prefix - calling explore with suffix"

                        set suffix 1

                        # itero l'invocazione per il numero di ricorrenze del nodo
                        while {$suffix <= $num} {

                            set child     [lindex $childs $i]

			    if {$parent_names_p} {
				ah_dom_tree \
				    -parent_names \
				    -node $child \
   			            -multirow tree \
				    -prefix $prefix \
				    -level $level \
				    -suffix $suffix 
			    } else {
				ah_dom_tree \
				    -node $child \
   			            -multirow tree \
				    -prefix $prefix \
				    -level $level \
				    -suffix $suffix 
			    }
			    incr suffix
			    incr i
			}
		    }
		}
	    }
	}
	"TEXT_NODE" {
	    set value [$node nodeValue]
            #ns_log notice "\nSOAP processing TEXT NODE $name prefix=$prefix "

	    # popolo multirow
	    set pretty_var ""
	    # trimmo tutto cio' che precede l'ultimo ':' dal nome della variabile
	    regexp {.+:(.+)} ${prefix} match pretty_var
	    if {$pretty_var eq ""} {
		set pretty_var ${prefix}
	    }

	    set pretty_var [string repeat . [expr $level * 4]]$pretty_var
	    template::multirow append childs ${prefix} $value

	}
	default {
	    return -code error "NodeType non gestito: $type"
	}
    }

    return
}


ad_proc ah_xml_get_root_id {string_xml} {
   legge il documento xml ed ottiene la radice (envelope)
} {
    set doc  [dom parse $string_xml]
    # env:Envelope
    set root [$doc documentElement]
    return $root
}


ad_proc ah_xml_get_text_value {
    -optional:boolean
    root
    node_name
} {
    cerca nella struttura xml il nodo testo node_name.
    se viene richiamato con -optional, se non lo trova restituisce ""
    altrimenti genera un errore.
} {
    set node [$root selectNodes .//$node_name/text()]
    if {[string is space $node]} {
	if {$optional_p} {
	    set result ""
	} else {
	    return -code error "Nodo $node_name non trovato nella struttura xml"
	}
    } else {
	set result [$node nodeValue]
    }
    return $result
    # se lista??
}


ad_proc ah_xml_get_node_id {root node_name {xpath_query_inp ""}} {
    cerca nella struttura xml il nodo node_name e restituisce la lista di
    nodi trovati<br>
    se viene indicato il parametro xpath_query, restituisce solo i nodi
    che soddisfano la query indicata.
} {
    if {![string is space $xpath_query_inp]} {
	set xpath_query  {[}
	append xpath_query $xpath_query_inp
	append xpath_query {]}
    } else {
	set xpath_query  ""
    }
    set node_id [$root selectNodes .//$node_name$xpath_query]
    return $node_id
}


ad_proc ah_xml_get_node_id_by_tag_name {root tag_name} {
    Cerca nella struttura xml i tag di nome tag_name e restituisce la lista di
    id dei nodi trovati<br>
    Questa proc e' stata creata perche', per alcuni casi, la proc ah_xml_get_node_id
    non trovava nessun nodo mentre questa si'.
} {#nic01: creata proc
    set node_ids [$root getElementsByTagName $tag_name]
    return $node_ids
}

ad_proc ah_muo_explorer {
    -parent_names:boolean
    {-xml ""}
    {-node ""}
    {-strip_string ""}
    {-prefix ""}
    {-name ""}
    {-level "1"}
    {-suffix ""}
    {-omit_parent_name ""}
} {
    Analizza un nodo dom e valorizza nel programma tcl chiamante le variabili
    corrispondenti ai vari nodi di testo trovati e agli eventuali attributi degli elementi.

    @parent_names  Se specificato, questo switch provoca la composizione del nome delle variabil trovate 
                   prefissandole con il nome dei padri, separati da .
                   es: parent1.parent2.element_name
    @xml           Struttura xml restituita dal web service. In alternativa a @node.
    @node          E' il nome della variabile che contiene il nodo dom da esplorare. In alternativa a @xml.
    @strip_string  Opzionale. Se specificata la stringa viene rimossa dal nome del campo.
    @prefix        E' un prefisso opzionale da mettere in testa al nome delle variabili.
                   es: prefix.element_name 
                   Puo' essere combinato con -parent_names
                   es: prefix.parent1.parent2.element_name
                   Nelle chiamate successive viene usato per contenere il nome concatenato della variabile,
                   comprensivo di prefisso e parent names separati dal carattere '.'.
    @level         Rappresenta il livello di profondita' della struttura XML che si sta esplorando.
                   Viene usato SOLO internamente nelle invocazioni ricorsive.
    @suffix        Se specificato, viene appeso al nome della variabile.
                   Viene usato SOLO internamente nelle invocazioni ricorsive.
    @omit_parent_name
                   Omette il nome specificato dalla stringa concatenata del nome della variabile
} {

    if {($xml eq "" && $node eq "") || ($xml ne "" && $node ne "")} {
	ad_return_complaint 1 "ah_muo_explorer: I parametri -xml e -node sono alternativi e uno dei due è obbligatorio."
	ad_script_abort
    }

    if {$xml ne ""} {
        set doc  [dom parse $xml]
        set root [$doc documentElement]  ; # Envelope
        set node [$root firstChild]      ; # Body
        set node [$node firstChild]      ; # Response
        set node [$node firstChild]      ; # Result
    }

    # preparo frammento di codice richiamato successivamente
    set prepara_nome_variabile {
	if {$prefix ne $name} {
	    if {$prefix eq "" || !$parent_names_p} {
		if {$prefix ne ""} {
		    append prefix "."
		}
		append prefix $name
	    }
	}
	# elimino eventuale '.' a destra del nome
	set prefix [string trimright $prefix .]
    }

    set type [$node nodeType]

    switch $type {
	"ELEMENT_NODE" {

	    set name   [$node nodeName]
	    if {$strip_string ne ""} {
		regsub $strip_string $name {} name
	    }
	    set childs [$node childNodes]

	    if {$parent_names_p} {
                # devo concatenare il nome dell'elemento ai suoi parent ed al prefisso
		if {$level > 1 || [string is space $prefix]} {
		    if {![string is space $prefix]} {
			append prefix "."
		    }
		    append prefix $name
		    if {![string equal $suffix ""]} {
			append prefix _$suffix
		    }
		}
	    } else {
                # devo impostare prefix 
		if {$level > 1 || [string is space $prefix]} {
		    if {![string is space $prefix]} {
			append prefix "."
		    }
		    set prefix $name
		    if {![string equal $suffix ""]} {
			append prefix _$suffix
		    }
		}
	    }

            #ns_log notice "\nSOAP processing ELEMENT $name prefix=$prefix"

            # verifico innanzitutto se l'elemento ha degli attributi, ma escludo 
            # il root element, in quanto contiene attributi speciali
	    if {![string equal [$node parentNode] ""]} {
		set ids [$node attributes]
		#ns_log notice "\nDEBUG processing IDS $ids"
		foreach id $ids {
		    # ignoro elementi con attributi dichiarativi di tipo xmlns
		    if {[llength $id] > 1} {
			break
		    }
		    if {$id eq ""} {
			continue
		    }
		    eval $prepara_nome_variabile
		    # ottengo valore dell'attributo
		    set value [$node getAttribute $id]
		    set cmd [list set ${prefix}.$id $value]
                    #ns_log notice "\ndebug creo attributo $cmd"
		    if {${omit_parent_name} ne ""} {
		        regsub ${omit_parent_name}. $cmd {} cmd
		    }
		    uplevel $level $cmd
		    # conto le variabili
		    uplevel $level "incr var_counter"
		}
	    }

	    if {[llength $childs] == 0} {
                #ns_log notice "\nSOAP processing ELEMENT $name - 0 childs prefix=$prefix"
                # caso in cui ho un nodo di testo vuoto
		eval $prepara_nome_variabile
		set value ""
		set cmd   [list set $prefix $value]
                #ns_log notice "\ndebug nodo vuoto $cmd"
		if {${omit_parent_name} ne ""} {
		    regsub ${omit_parent_name}. $cmd {} cmd
		}
		uplevel $level $cmd
		# conto le variabili
		uplevel $level "incr var_counter"

	    } elseif {[llength $childs] == 1} {
		# avendo un unico figlio la variabile creata e' gia' univoca
		incr level

                #ns_log notice "\nSOAP processing ELEMENT $name - 1 child prefix=$prefix - calling explore"

		set child $childs 

		if {$parent_names_p} {
		    ah_muo_explorer \
			-parent_names \
			-node $child \
			-strip_string $strip_string \
			-prefix $prefix \
			-level $level \
			-suffix $suffix \
			-omit_parent_name $omit_parent_name
 		} else {
		    ah_muo_explorer \
			-node $child \
			-strip_string $strip_string \
			-prefix $prefix \
			-level $level \
			-suffix $suffix \
			-omit_parent_name $omit_parent_name
		}

	    } else {

		# Avendo n figli posso avere casi in cui alcuni hanno lo stesso nome, nel qual caso devo suffissarli,
                # preparo quindi un array di nomi dei figli in cui il valore rappresenta il numero di ricorrenze
                if {[array exists childs_names]} {
		    array set childs_names [list]
		}

		foreach child $childs {

		    # isolo nome child
                    set child_name [$child nodeName]

                    # creo lista nomi childs
                    lappend nodes_names $child_name

                    # creo o incremento array
		    if {[info exists childs_names($child_name)]} {
		        incr childs_names($child_name) 
		    } else {
		        set childs_names($child_name) 1                    
		    }

		}
  
                set len [llength $childs]

		incr level

                set i 0
                while {$i < $len} {
		    # childs      = lista comandi dom
                    # nodes_names = lista nomi dei nodi corrispondenti
                    # childs_names= array con numero ricorrenze

		    set node_name [lindex $nodes_names $i]
		    set num       $childs_names($node_name)

		    if {$num == 1} {

			#ns_log notice "\nSOAP processing ELEMENT $name - n different childs prefix=$prefix - calling explore without suffix"

                        set child     [lindex $childs $i]

			if {$parent_names_p} {
			    ah_muo_explorer \
				-parent_names \
				-node $child \
 			        -strip_string $strip_string \
				-prefix $prefix \
				-level $level \
			        -omit_parent_name $omit_parent_name
			} else {
			    ah_muo_explorer \
				-node $child \
               			-strip_string $strip_string \
				-prefix $prefix \
				-level $level \
			        -omit_parent_name $omit_parent_name
			}
 
                        incr i

		    } else {

                        set suffix 1

		        #ns_log notice "\nSOAP processing ELEMENT $name - $num childs with same name prefix=$prefix - calling explore with suffix=$suffix"
                        # itero l'invocazione per il numero di ricorrenze del nodo
                        while {$suffix <= $num} {

                            set child     [lindex $childs $i]

			    if {$parent_names_p} {
				ah_muo_explorer \
				    -parent_names \
				    -node $child \
 			            -strip_string $strip_string \
				    -prefix $prefix \
				    -level $level \
				    -suffix $suffix \
			            -omit_parent_name $omit_parent_name 
			    } else {
				ah_muo_explorer \
				    -node $child \
			            -strip_string $strip_string \
				    -prefix $prefix \
				    -level $level \
				    -suffix $suffix \
			            -omit_parent_name $omit_parent_name
			    }
			    incr suffix
			    incr i
			}
		    }
		}
	    }
	}
	"TEXT_NODE" {
	    eval $prepara_nome_variabile
	    set value [$node nodeValue]
            #ns_log notice "\nSOAP processing TEXT NODE $name prefix=$prefix value=$value"
            set cmd   [list set $prefix $value]
            #ns_log notice "\ndebug text node $cmd"
	    if {${omit_parent_name} ne ""} {
		regsub ${omit_parent_name}. $cmd {} cmd
	    }
	    uplevel $level $cmd
	    # conto le variabili
	    uplevel $level "incr var_counter"
	}
	"COMMENT_NODE" {
            # ignoro
	}
	default {
	    return -code error "NodeType non gestito: $type"
	}
    }

    return
}
