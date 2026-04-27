# open file
set pglog [open /tmp/pg.log r]

while {[gets $pglog line] >= 0} {

    # cerco le 'bad' queries, che cominciano con la stringa 'statement:'
    if {![regexp {(.* duration: .*) statement: (.*)} $line match run query]} {
	set query ""
	continue
    }

    # ignoro vacuum
    if {[regexp {VACUUM} $line]} {
	continue
    }

    # estraggo dati identificativi della query
    set database [lindex $run 0]
    set date     [lindex $run 2]
    set time     [lindex $run 3]
    set duration [lindex $run 6]

    # la query potrebbe stare tutta sulla stessa riga ed essere già completa
    if {![string match "*;*" $query]} {
	# estraggo o completo la query con le righe seguenti
	while {[gets $pglog line] >= 0} {
	    if {$line eq ""} {
		continue
	    }
	    append query ${line}\n
	    if {[string match "*;*" $line] && ![string match "*&nbsp;*" $line]} {
		break
	    }
	}
    }

    # divido la query in query_root (univoca fino alla ultima 'from') e query_tail
    set i [string last "from" $query]
    if { $i == -1} {
	set query_root $query
	set query_tail ""
    } else {
	set query_root [string range $query 0 [expr $i - 1]]
	set query_tail [string range $query $i end]
    }

    # in rari casi nel log si trovano queries non terminate da ;
    # mi limito ad ignorarle
    if {$query_root > 4000} {
	continue
    }

    # se la query root non esiste la creo
    if {![db_0or1row check_query "
        select query_id
        from iter_bad_queries
        where query_root = :query_root"]} {
	# creo anagrafica
        set query_id [db_string next "select coalesce(max(query_id) + 1, 1) from iter_bad_queries"]
	db_dml query_add "
            insert into iter_bad_queries (
                query_id
              , query_code
              , query_root
            ) values (
                :query_id
              , :query_id
              , :query_root
            )"
    }

    # registro la specifica esecuzione
    set run_id [db_string next "select coalesce(max(run_id) + 1, 1) from iter_bad_queries_run"]
    db_dml query_add "
        insert into iter_bad_queries_run (
            run_id
          , query_id
          , database
          , query_date
          , duration
          , query_root
          , query_tail
        ) values (
            :run_id
          , :query_id
          , :database
          , to_timestamp('$date $time', 'YYYY-MM-DD HH:MI:SS')
          , :duration
          , :query_root
          , :query_tail
        )"
}

close $pglog

ns_return 200 text/html "Log elaborato."
