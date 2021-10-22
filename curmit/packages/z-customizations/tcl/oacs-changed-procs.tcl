ad_library {

    Questo file contiene le procedure OpenACS personalizzate.
    Queste procedure vengono eseguite invece di quelle originali, non
    modificate, in quanto i file di tipo *ini.tcl vengono letti dopo quelli *procs.tcl 
								

    @author claudio.pasolini@comune.mantova.it
    @cvs-id $Id:

}

ad_proc ad_return_if_another_copy_is_running {
    {max_simultaneous_copies 1} 
    {call_adp_break_p 0}
} {
    Returns a page to the user about how this server is busy if 
    another copy of the same script is running.  Then terminates 
    execution of the thread.  Useful for expensive pages that do 
    sequential searches through database tables, etc.  You don't 
    want to tie up all of your database handles and deny service 
    to everyone else.  
    
    The call_adp_break_p argument is essential 
    if you are calling this from an ADP page and want to avoid the 
    performance hit of continuing to parse and run.

    This proc is dangerous, and needs to be rewritten. See:
    http://openacs.org/forums/message-view?message_id=203381
} {
    # first let's figure out how many are running and queued
    set this_connection_url [ad_conn url]
    set n_matches 0
    foreach connection [ns_server active] {
	set query_connection_url [lindex $connection 4]
	if { $query_connection_url == $this_connection_url } {
	    # we got a match (we'll always get at least one
	    # since we should match ourselves)
	    incr n_matches
	}
    }
    if { $n_matches > $max_simultaneous_copies } {
	ad_return_warning "Già in esecuzione" "Il programma richiesto è già in esecuzione (può essere stato richiesto da un altro utente oppure causato da un doppio click). Non è possibile eseguirne più di uno alla volta per non sovraccaricare il sistema: riprova più tardi."
	# blow out of the caller as well
	if {$call_adp_break_p} {
	    # we were called from an ADP page; we have to abort processing
	    ns_adp_break
	}
	return -code return
    }
    # we're okay
    return 1
}

#
# modificata procedura per scartare le clausole sql dove non è stato digitato
# alcun filtro
#

 ad_proc -public template::list::filter_where_clauses {
    -name:required
    -and:boolean
} {
    @param  and     Set this flag if you want the result to start with an 'and' if the list of where clauses returned is non-empty.
} {
    # Get an upvar'd reference to list_properties
    get_reference -name $name

    if { [llength $list_properties(filter_where_clauses)] == 0 } {
        return {}
    }

    set result {}
    # Claudio: scarto clausole con operando nullo
    set clauses [list]
    foreach clause $list_properties(filter_where_clauses) {
	if {[string match *%%* $clause]} {
	    continue
	}
	# isolo il nome della variabile contenuto nella clausola
	if {[regexp {.*[:\$]([^ )]+)} $clause match var]} {
	    # ispeziono il contenuto della variabile nel caller scope
	    upvar $var localvar
	    if {![exists_and_not_null localvar]} {
		continue
	    }
	}
	lappend clauses $clause
    }

    if {$and_p && [llength $clauses] > 0} {
        append result "and "
    }

    append result [join $clauses "\n and "]
    
    return $result
}

ad_proc -public template::list::write_csv {
    -name:required
    {-separator  ;}
} {
    Writes a CSV to the connection
} { 
    # Imposto se il formato delle colonne deve essere human readable.
    set human_readable_csv_p [parameter::get_from_package_key -package_key "mis-base" -parameter human_readable_csv_p -default 1]
    
    # Creates the '_eval' columns and aggregates
    template::list::prepare_for_rendering -name $name
 
    get_reference -name $name
    
    set __list_name $name
    set __output {}
    # Output header row
    set __cols [list]
    foreach __element_name $list_properties(display_elements) {
	template::list::element::get_reference \
	    -list_name $__list_name \
	    -element_name $__element_name \
	    -local_name __element_properties
        lappend __cols [csv_quote $__element_properties(label)]
    }
    append __output "\"[join $__cols "\"$separator\""]\"\n"


    # Output rows
    template::multirow foreach $list_properties(multirow) {

        set __cols [list]

        foreach __element_name $list_properties(display_elements) {
            template::list::element::get_reference \
                -list_name $__list_name \
                -element_name $__element_name \
                -local_name __element_properties

            if { [info exists $__element_properties(csv_col)] } {
                if {$human_readable_csv_p} {
		    lappend __cols [csv_quote [set $__element_properties(csv_col)]]
		} else {
		    lappend __cols [csv_quote [set $__element_name]]
		}
            }
        }
        append __output "\"[join $__cols "\"$separator\""]\"\n"
    }

    # ( 27.10.2007 - Nelson ) Istruzione per avere in 'output' il nome file con l'estensione ".csv" direttamente
    ns_set put [ad_conn outputheaders] Content-Disposition "attachment;filename=$name.csv"
    # ----------------------------------------------------------------------------------------------------------
    ns_return 200 application/vnd.ms-excel $__output
}

ad_proc ad_context_node_list {
    {-from_node ""}
    node_id
} {
    Starting with the given node_id, return a list of
    [list url instance_name] items for parent nodes.

    @option from_node The top-most node_id for which we'll show context bar. This can be used with 
    the node_id of the nearest subsite to get the context-bar only up to the nearest subsite.

    @author Peter Marklund
} {
    set context [list]

    while { ![empty_string_p $node_id] } {
        array set node [site_node::get -node_id $node_id]
        
        # JCD: Provide something for the name if the instance name is
        # absent.  name is the tail bit of the url which seems like a
        # reasonable thing to display.
        if {[empty_string_p $node(instance_name)]
            && [info exists node(name)]} { 
            set node(instance_name) $node(name)
        }

        set context [concat [list [list $node(url) [ad_quotehtml $node(instance_name)]]] $context]

        # We have the break here, so that 'from_node' itself is included
        if { [string equal $node_id $from_node] } {
            break
        }
        
        set node_id $node(parent_id)
    }

    # Claudio: voglio evitare di portare nella context bar la url dei vari package MIS
    set last [lrange $context end end]
    set url  [lindex $last 0]
    if {[string range $url 0 4] eq "/mis-"} {
	set context [lrange $context 0 [expr [llength $context] - 2]]
    }
  
    return $context
}

# definisco il committer
ad_proc -public 2pc_committer {
    tran_id
} { 
    Verifica se tutti i partecipanti alla transazione distribuita hanno
    completato felicemente il loro lavoro.
} {

    # poiché sto facendo una simulazione sullo stesso server, devo usare
    # un tran_id diverso per i due partecipanti alla transazione e per 
    # convenzione aggiungo il suffisso _2 per il secondo partecipante

    # devo trovare esattamente una riga per ogni partecipante
    set c1 [db_string p1 "select count(*) from pg_prepared_xacts where gid= :tran_id"]
    set c2 [db_string p2 "select count(*) from pg_prepared_xacts where gid= '${tran_id}_2'"]

    if {$c1 == 1 && $c2 == 1} {
	db_dml ci1 "commit prepared :tran_id"
	db_dml -dbn viae-dev ci2 "commit prepared '${tran_id}_2'"
    } else {
	# rollback
	if {$c1 == 1} {
	    db_dml rb1 "rollback prepared :tran_id"
	}
	if {$c2 == 1} {
	    db_dml -dbn viae-dev rb2 "rollback prepared '${tran_id}_2'"
	}
    }
    return
}

# ====================================================================================================================================================
# ( 11.01.2011 - Claudio Vs Nelson ) Personalizzazione PROC 'store-procedure' x creazione e legame PDF creato per Fatture etc. in File Storage
#                                    (*) Ora rstituisce alla file 'item_id' e non piu' 'revision_id' così se il 'cr_items' e' ok ma 'attachments'
#                                        e' 'compromesso' stampa cmq Fatture etc.
#                                    (*) Le Query esterne ( nel file originario 'file-storage-procs.xql' ): Query 'item_exists' & Query 'get_ddt_item'
#                                        sono state copiate qui dentro 'oacs-changed-procs.tcl' per comodita' ....
# ====================================================================================================================================================
ad_proc -public fs::add_file {
    -name
    -parent_id
    -package_id
    {-item_id ""}
    {-creation_user ""}
    {-creation_ip ""}
    {-title ""}
    {-description ""}
    {-tmp_filename ""}
    {-mime_type ""}
    -no_callback:boolean
    -no_notification:boolean
} {
    Create a new file storage item or add a new revision if
    an item with the same name and parent folder already exists

    @return revision_id
} {

    if {[parameter::get -parameter "StoreFilesInDatabaseP" -package_id $package_id]} {
	set indbp "t"
        set storage_type "lob"
    } else {
	set indbp "f"
        set storage_type "file"
    }
    if {[string equal "" $mime_type]} {
        set mime_type [cr_filename_to_mime_type -create -- $name]
    }
    # we have to do this here because we create the object before
    # calling cr_import_content
    
    if {[content::type::content_type_p -mime_type $mime_type -content_type "image"]} {
        set content_type image
    } else {
        set content_type file_storage_object
    }

    if {$item_id eq ""} {
	set item_id [db_nextval acs_object_id_seq]
    }

    db_transaction {
	if {![db_string item_exists "select count(*) from cr_items where name=:name and parent_id=:parent_id"]} {
            #ns_log notice "\ndebug il file non esisteva in precedenza"	    
	    set item_id [content::item::new \
			     -item_id $item_id \
			     -parent_id $parent_id \
			     -creation_user "$creation_user" \
			     -creation_ip "$creation_ip" \
			     -package_id "$package_id" \
			     -name $name \
			     -storage_type "$storage_type" \
			     -content_type "file_storage_object" \
			     -mime_type "text/plain"
			    ]
            #ns_log notice "\ndebug creato cr_item"	    			     
	    if {![empty_string_p $creation_user]} {
		permission::grant -party_id $creation_user -object_id $item_id -privilege admin
	    }

	    # Deal with notifications. Usually send out the notification
	    # But surpress it if the parameter is given
	    if {$no_notification_p} {
		set do_notify_here_p "f"
	    } else {
		set do_notify_here_p "t"
	    }
	} else {
	    # th: fixed to set old item_id if item already exists and no new item needed to be created
	    db_1row get_old_item "select item_id from cr_items where name=:name and parent_id=:parent_id"
	    set do_notify_here_p "f"
            #ns_log notice "\ndebug il file esisteva già in precedenza item_id=$item_id"	    
	}
	if {$no_callback_p} {
	    set revision_id [fs::add_version \
				 -name $name \
				 -tmp_filename $tmp_filename \
				 -package_id $package_id \
				 -item_id $item_id \
				 -creation_user $creation_user \
				 -creation_ip $creation_ip \
				 -title $title \
				 -description $description \
				 -suppress_notify_p $do_notify_here_p \
				 -storage_type $storage_type \
				 -mime_type $mime_type \
				 -no_callback
			    ]
	} else {
	    set revision_id [fs::add_version \
				 -name $name \
				 -tmp_filename $tmp_filename \
				 -package_id $package_id \
				 -item_id $item_id \
				 -creation_user $creation_user \
				 -creation_ip $creation_ip \
				 -title $title \
				 -description $description \
				 -suppress_notify_p $do_notify_here_p \
				 -storage_type $storage_type \
				 -mime_type $mime_type
			    ]
	}
	
	if {[string is true $do_notify_here_p]} {
	    fs::do_notifications -folder_id $parent_id -filename $title -item_id $revision_id -action "new_file" -package_id $package_id
	    if {!$no_callback_p} {
		if {![catch {ad_conn package_id} package_id]} {
		    callback fs::file_new -package_id $package_id -file_id $item_id
		}
	    }
	}
    }
    #return $revision_id
    return $item_id
}

# Modificata per fare edit_num dei totali alla fine della lista
ad_proc -private template::list::prepare_for_rendering {
    {-name:required}
} {
    Build all the variable references that are required when rendering a list
    template.

    @param name The name of the list template we hope to be able to render eventually.
} {
    set __level [template::adp_level]

    # Provide a reference to the list properties for use by the list template
    # This one is named __list_properties to avoid getting scrambled by below multirow
    get_reference -name $name -local_name __list_properties

    # Sort in webserver layer, if requested to do so    
    set __multirow_cols [template::list::multirow_cols -name $__list_properties(name)]
    if { $__multirow_cols ne "" } {
        eval template::multirow sort $__list_properties(multirow) $__multirow_cols
    }

    # Upvar other variables passed in through the pass_properties property
    foreach var $__list_properties(pass_properties) {
        upvar #$__level $var $var
    }

    #
    # Dynamic columns: display_eval, link_url_eval, aggregate
    #

    # TODO: If we want to be able to sort by display_eval'd element values,
    # we'll have to do those in a separate run from doing the aggregates.
    
    if { $__list_properties(dynamic_cols_p) || $__list_properties(aggregates_p) } {
        foreach __element_ref $__list_properties(element_refs) {
            # We don't need to prefix it with __ to become __element_properties here
            # because we're not doing the multirow foreach loop yet.
            upvar #$__level $__element_ref element_properties
            
            # display_eval, link_url_eval
            foreach __eval_property { display link_url } {
                if { [exists_and_not_null element_properties(${__eval_property}_eval)] } {

                    # Set the display col to the name of the new, dynamic column
                    set element_properties(${__eval_property}_col) "$element_properties(name)___$__eval_property"

                    # And add that column to the multirow
                    template::multirow extend $__list_properties(multirow) $element_properties(${__eval_property}_col)
                }
            }

            # aggregate
            if { [exists_and_not_null element_properties(aggregate)] } {
                # Set the aggregate_col to the name of the new, dynamic column
                set element_properties(aggregate_col) "$element_properties(name)___$element_properties(aggregate)"
                set element_properties(aggregate_group_col) "$element_properties(name)___$element_properties(aggregate)_group"

                # Add that column to the multirow
                template::multirow extend $__list_properties(multirow) $element_properties(aggregate_col)
                template::multirow extend $__list_properties(multirow) $element_properties(aggregate_group_col)

                # Initialize our counters to 0
                set __agg_counter($element_properties(name)) 0
                set __agg_sum($element_properties(name)) 0

                # Just in case, we also initialize our group counters to 0
                set __agg_group_counter($element_properties(name)) 0
                set __agg_group_sum($element_properties(name)) 0
            }
        }

        # This keeps track of the value of the group-by column for sub-totals
        set __last_group_val {}

        template::multirow foreach $__list_properties(multirow) {

            foreach __element_ref $__list_properties(element_refs) {
                # We do need to prefix it with __ to become __element_properties here
                # because we are inside the multirow foreach loop yet.
                # LARS: That means we should probably also __-prefix element_ref, eval_property, and others.
                upvar #$__level $__element_ref __element_properties
                
                # display_eval, link_url_eval
                foreach __eval_property { display link_url } {
                    if { [exists_and_not_null __element_properties(${__eval_property}_eval)] } {
                        set $__element_properties(${__eval_property}_col) [subst $__element_properties(${__eval_property}_eval)]
                    }
                }

                # aggregate
                if { [exists_and_not_null __element_properties(aggregate)] } {
                    # Update totals
                    incr __agg_counter($__element_properties(name))
                    if {$__element_properties(aggregate) eq "sum" } {
                        set __agg_sum($__element_properties(name)) \
                            [expr {$__agg_sum($__element_properties(name)) + ([set $__element_properties(name)] ne "" ? [set $__element_properties(name)] : 0)} ]
                    }

                    # Check if the value of the groupby column has changed
                    if { [exists_and_not_null $__list_properties(groupby)] } {
                        if { $__last_group_val ne [set $__list_properties(groupby)] } {
                            # Initialize our group counters to 0
                            set __agg_group_counter($__element_properties(name)) 0
                            set __agg_group_sum($__element_properties(name)) 0
                        }
                        # Update subtotals
                        incr __agg_group_counter($__element_properties(name))
                        set __agg_group_sum($__element_properties(name)) \
                            [expr $__agg_group_sum($__element_properties(name)) + [expr {[string is double [set $__element_properties(name)]] ? [set $__element_properties(name)] : 0}]]
                    }

                    switch $__element_properties(aggregate) {
                        sum {
                            set $__element_properties(aggregate_col) $__agg_sum($__element_properties(name))
                            if { [exists_and_not_null $__list_properties(groupby)] } {
                                set $__element_properties(aggregate_group_col) $__agg_group_sum($__element_properties(name))
                            }
                        }
                        average {
                            set $__element_properties(aggregate_col) \
                                [expr {$__agg_sum($__element_properties(name)) / $__agg_counter($__element_properties(name))}]
                            if { [exists_and_not_null $__list_properties(groupby)] } {
                                set $__element_properties(aggregate_group_col) \
                                    [expr {$__agg_sum($__element_properties(name)) / $__agg_group_counter($__element_properties(name))}]
                            }
                        }
                        count {
                            set $__element_properties(aggregate_col) \
                                [expr {$__agg_counter($__element_properties(name))}]
                            if { [exists_and_not_null $__list_properties(groupby)] } {
                                set $__element_properties(aggregate_group_col) \
                                    [expr {$__agg_group_counter($__element_properties(name))}]
                            }
                        }
                        default {
                            error "Unknown aggregate function '$__element_properties(aggregate)'"
                        }
                    }
                    
# Uso ah::edit_num invece di lc_numeric
#                    set $__element_properties(aggregate_group_col) [lc_numeric [set $__element_properties(aggregate_group_col)]] 
#                    set $__element_properties(aggregate_col) [lc_numeric [set $__element_properties(aggregate_col)]] 
                    set $__element_properties(aggregate_group_col) [ah::edit_num [set $__element_properties(aggregate_group_col)] 2] 
                    set $__element_properties(aggregate_col) [ah::edit_num [set $__element_properties(aggregate_col)] 2] 
                }
            }

            # Remember this value of the groupby column
            if { [exists_and_not_null $__list_properties(groupby)] } { 
                set __last_group_val [set $__list_properties(groupby)]
            }
        }
    }
}

# Modificata per poter inviare piu' file ad una form
ad_proc -public util_http_file_upload { 
  -files
  -datas 
  -binary:boolean 
  {-filenames {}}
  {-names {}}
  {-mime_types {}}
  {-mode formvars} 
  {-rqset ""} 
  url 
  {formvars {}} 
  {timeout 30} 
  {depth 10} 
  {http_referer ""}
} {
    Implement client-side HTTP file uploads as multipart/form-data as per 
    RFC 1867.
    <p>

    Similar to <a href="proc-view?proc=util_httppost">util_httppost</a>, 
    but enhanced to be able to upload multiple file as <tt>multipart/form-data</tt>.  
    Also useful for posting to forms that require their input to be encoded 
    as <tt>multipart/form-data</tt> instead of as 
    <tt>application/x-www-form-urlencoded</tt>.

    <p>

    The switches <tt>-files {/path/to/file /path/to/second-file ... }</tt> and <tt>-datas {$raw_data_1 $raw_data_2 ...}</tt>
    are mutually exclusive.  You can specify one or the other, but not
    both.  NOTE: it is perfectly valid to not specify either, in which
    case no file is uploaded, but form variables are encoded using
    <tt>multipart/form-data</tt> instead of the usual encoding (as
    noted aboved).

    <p>

    If you specify either <tt>-files</tt> or <tt>-datas</tt> you 
    <strong>must</strong> supply a value for <tt>-names</tt>, which is
    the list of names of the respective <tt>&lt;INPUT TYPE="file" NAME="..."&gt;</tt> form
    tag.

    <p>

    Specify the <tt>-binary</tt> switch if the file (or data) needs
    to be base-64 encoded.  Not all servers seem to be able to handle
    this.  (For example, http://mol-stage.usps.com/mml.adp, which
    expects to receive an XML file doesn't seem to grok any kind of
    Content-Transfer-Encoding.)

    <p>

    If you specify <tt>-files</tt> then <tt>-filenames</tt> is optional
    (it can be infered from the name of the file).  However, if you
    specify <tt>-datas</tt> then it is mandatory.

    <p>

    If <tt>-mime_types</tt> is not specified then <tt>ns_guesstype</tt>
    is used to try and find a mime type based on the <i>filename</i>.  
    If <tt>ns_guesstype</tt> returns <tt>*/*</tt> the generic value
    of <tt>application/octet-stream</tt> will be used.
   
    <p>

    Any form variables may be specified in one of four formats:
    <ul>
    <li><tt>array</tt> (list of key value pairs like what [array get] returns)
    <li><tt>formvars</tt> (list of url encoded formvars, i.e. foo=bar&x=1)
    <li><tt>ns_set</tt> (an ns_set containing key/value pairs)
    <li><tt>vars</tt> (a list of tcl vars to grab from the calling enviroment)
    </ul>

    <p>

    <tt>-rqset</tt> specifies an ns_set of extra headers to send to
    the server when doing the POST.

    <p>

    timeout, depth, and http_referer are optional, and are included
    as optional positional variables in the same order they are used
    in <tt>util_httppost</tt>.  NOTE: <tt>util_http_file_upload</tt> does
    not (currently) follow any redirects, so depth is superfulous.

    @author Michael A. Cleverly (michael@cleverly.com)
    @creation-date 3 September 2002
    
    Modified by Antonio Pisano (apisano@oasisoftware.it) to allow the sending of multiple files to the form
} {

    # sanity checks on switches given
    if {[lsearch -exact {formvars array ns_set vars} $mode] == -1} {
        error "Invalid mode \"$mode\"; should be one of: formvars,\
            array, ns_set, vars"
    }
 
    if {[info exists files] && [info exists datas]} {
        error "Both -files and -datas are mutually exclusive; can't use both"
    }

    if {[info exists files]} {
	foreach file $files filename $filenames mime_type $mime_types {
	    if {![file exists $file]} {
		error "Error reading file: $file not found"
	    }

	    if {![file readable $file]} {
		error "Error reading file: $file permission denied"
	    }

	    set fp [open $file]
	    fconfigure $fp -translation binary
	    lappend datas [read $fp]
	    close $fp

	    if {$filename eq ""} {
		lappend filenames [file tail $file]
	    }

	    if {$mime_type eq ""} {
		lappend mime_types [ns_guesstype $file]
	    }
	}
    }

    set boundary [ns_sha1 [list [clock clicks -milliseconds] [clock seconds]]]
    set payload {}

    if {[info exists datas]} {
        if {[llength $datas] != [llength $names]} {
            error "Cannot upload file without specifing form variable -name"
        }
    
        if {[llength $datas] != [llength $filenames]} {
            error "Cannot upload file without specifing -filename"
        }
    
	foreach data $datas filename $filenames name $names mime_type $mime_types {
	    if {$mime_type eq ""} {
		set mime_type [ns_guesstype $filename]
	
		if {[string equal $mime_type */*] || $mime_type eq ""} {
		    set mime_type application/octet-stream
		}
	    }

	    if {$binary_p} {
		set data [base64::encode base64]
		set transfer_encoding base64
	    } else {
		set transfer_encoding binary
	    }

	    append payload --$boundary \
			  \r\n \
			  "Content-Disposition: form-data; " \
			  "name=\"$name\"; filename=\"$filename\"" \
			  \r\n \
			  "Content-Type: $mime_type" \
			  \r\n \
			  "Content-transfer-encoding: $transfer_encoding" \
			  \r\n \
			  \r\n \
			  $data \
			  \r\n
	}
    }


    set variables [list]
    switch -- $mode {
        array {
            set variables $formvars 
        }

        formvars {
            foreach formvar [split $formvars &] {
                set formvar [split $formvar  =]
                set key [lindex $formvar 0]
                set val [join [lrange $formvar 1 end] =]
                lappend variables $key $val
            }
        }

        ns_set {
            for {set i 0} {$i < [ns_set size $formvars]} {incr i} {
                set key [ns_set key $formvars $i]
                set val [ns_set value $formvars $i]
                lappend variables $key $val
            }
        }

        vars {
            foreach key $formvars {
                upvar 1 $key val
                lappend variables $key $val
            }
        }
    }

    foreach {key val} $variables {
        append payload --$boundary \
                       \r\n \
                       "Content-Disposition: form-data; name=\"$key\"" \
                       \r\n \
                       \r\n \
                       $val \
                       \r\n
    }

    append payload --$boundary-- \r\n

    if { [catch {
        if {[incr depth -1] <= 0} {
            return -code error "util_http_file_upload:\
                Recursive redirection: $url"
        }

        set http [util_httpopen POST $url $rqset $timeout $http_referer]
        set rfd  [lindex $http 0]
        set wfd  [lindex $http 1]

        _ns_http_puts $timeout $wfd \
            "Content-type: multipart/form-data; boundary=$boundary\r"
        _ns_http_puts $timeout $wfd "Content-length: [string length $payload]\r"
        _ns_http_puts $timeout $wfd \r
        _ns_http_puts $timeout $wfd "$payload\r"
        flush $wfd
        close $wfd
        
        set rpset [ns_set new [_ns_http_gets $timeout $rfd]]
        while 1 {
            set line [_ns_http_gets $timeout $rfd]
            if { ![string length $line] } break
            ns_parseheader $rpset $line
        }

        set headers $rpset
        set response [ns_set name $headers]
        set status [lindex $response 1]
        set length [ns_set iget $headers content-length]
        if { "" eq $length } { set length -1 }
        set err [catch {
            while 1 {
                set buf [_ns_http_read $timeout $rfd $length]
                append page $buf
                if { "" eq $buf } break
                if {$length > 0} {
                    incr length -[string length $buf]
                    if {$length <= 0} break
                }
            }
        } errMsg]

        ns_set free $headers
        close $rfd

        if {$err} {
            global errorInfo
            return -code error -errorinfo $errorInfo $errMsg
        }
    } errmsg] } {
        if {[info exists wfd] && [lsearch [file channels] $wfd] >= 0} {
            close $wfd
        }

        if {[info exists rfd] && [lsearch [file channels] $rfd] >= 0} {
            close $rfd
        }

        set page -1
    }
    
    return $page
}

ad_proc -public db_quote { string } { Quotes a string value to be placed in a SQL statement. } {
    # Per cercare correttamente i backslash devo rimpiazzarli tutti con un doppio backslash.
    # Devo usarne 16 perchè il backslash e' carattere di escape per tcl e postgres.
    regsub -all {\\} "$string" {\\\\\\\\\\\\\\\\} string
    
    # Le virgolette chiudono una stringa, quindi per cercarle devo mettere davanti un backslash
    # per non confondere tcl
    regsub -all {\"} "$string" {\\\"} string
    
    regsub -all {'} "$string" {''} result
    
    
    return $result
}

ad_proc -public auth::get_registration_form_elements {
} {
    Returns a list of elements to be included in the -form chunk of an ad_form form.
    All possible elements will always be present, but those that shouldn't be displayed 
    will be hidden and have a hard-coded empty string value.

    Personalizzata per limitare la maxlenght dello username a 10 caratteri perchè altrimenti
    verrebbe troncato su I.Ter. quando viene memorizzato sul db (colonna cod_utente delle varie
    tabelle).
} {
    array set data_types {
        username text
        email text
        first_names text
        last_name text
        screen_name text
        url text
        password text
        password_confirm text
        secret_question text
        secret_answer text
    }

    array set widgets {
        username text 
        email text
        first_names text
        last_name text
        screen_name text
        url text
        password password
        password_confirm password
        secret_question text
        secret_answer text
    }

    array set labels [list \
                          username [_ acs-subsite.Username] \
                          email [_ acs-subsite.Email] \
                          first_names [_ acs-subsite.First_names] \
                          last_name [_ acs-subsite.Last_name] \
                          screen_name [_ acs-subsite.Screen_name] \
                          url [_ acs-subsite.lt_Personal_Home_Page_UR] \
                          password [_ acs-subsite.Password] \
                          password_confirm [_ acs-subsite.lt_Password_Confirmation] \
                          secret_question [_ acs-subsite.Question] \
                          secret_answer [_ acs-subsite.Answer]]
    
    array set html {
        username {size 10 maxlength 10}
        email {size 30}
        first_names {size 30}
        last_name {size 30}
        screen_name {size 30}
        url {size 50 value "http://"}
        password {size 20}
        password_confirm {size 20}
        secret_question {size 30}
        secret_answer {size 30}
    }

    array set element_info [auth::get_registration_elements]

    if { [lsearch $element_info(required) password] != -1 } {
        lappend element_info(required) password_confirm
    }
    if { [lsearch $element_info(optional) password] != -1 } {
        lappend element_info(optional) password_confirm
    }
    
    # required_p will have 1 if required, 0 if optional, and unset if not in the form
    array set required_p [list]
    foreach element $element_info(required) {
        set required_p($element) 1
    }
    foreach element $element_info(optional) {
        set required_p($element) 0
    }

    set form_elements [list]
    foreach element [auth::get_all_registration_elements -include_password_confirm] {
        if { [info exists required_p($element)] } {
            set form_element [list]

            # The header with name, datatype, and widget
            set form_element_header "${element}:$data_types($element)($widgets($element))"

            if { !$required_p($element) } {
                append form_element_header ",optional"
            }
            lappend form_element $form_element_header

            # The label
            lappend form_element [list label $labels($element)]

            # HTML
            lappend form_element [list html $html($element)]

            # The form element is finished - add it to the list
            lappend form_elements $form_element
        } else {
            lappend form_elements "${element}:text(hidden),optional [list value {}]"
        }
    }

    return $form_elements
}

ad_proc -public permission::require_permission {
    {-party_id ""}
    {-object_id:required}
    {-privilege:required}
} {
    require that party X have privilege Y on object Z

    Personalizzata per I.Ter.: messaggio in italiano e suggerimento di usare il tasto back del 
    browser (come faceva la vecchia iter_check_login)
} {
    if {$party_id eq ""} {
        set party_id [ad_conn user_id]
    }

    if {![permission_p -party_id $party_id -object_id $object_id -privilege $privilege]} {
        if {!${party_id}} {
            auth::require_login
        } else {
            ns_log notice "permission::require_permission: $party_id doesn't have $privilege on object $object_id"
            #iter ad_return_forbidden \
            #iter    "Permission Denied" \
            #iter    "You don't have permission to $privilege [db_string name {}]."
	    set script_name [db_string query "select acs_object__name(:object_id)
                                                from dual"];#iter

	    iter_return_complaint "
                 Spiacente, utente non abilitato per questa funzione (non hai il permesso di $privilege $script_name)";#iter

        }

        ad_script_abort
    }
}
