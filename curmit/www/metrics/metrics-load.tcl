ad_page_contract {

    Scandisce tutti i file delle istanze iter del server e costruisce
    una tabella da cui poi ricavare le statistiche richieste.

    @author Claudio Pasolini
} {
}

set hostname [info hostname]
regexp {^([^\.]+)} $hostname match hostname

if {$hostname eq "ahiter02"} {
    set origins [list iter01 iter02 iterbase itercmbt iterprav iterprli iterprrc]
} elseif {$hostname eq "OASI-ITER03"} {
    set origins [list iter iterbase itercmcarrara itercmrm iterprbl iterprce iterprkr iterprme iterprms iterrlig iterrlpr]
}

# fix per oasiub64
set origins [list iter-portal-demo ucit iterprud iterprgo iterprpn]

if {![db_table_exists iter_scripts]} {
    db_dml create_table "
    create table iter_scripts (
        package_key  varchar
        -- path completo della directory contenente il file
       ,dirpath      varchar
       ,fname        varchar
       ,ftype        varchar
       ,size         integer
    )"

    db_dml create_index "create index iter_scripts_indx on iter_scripts(package_key, dirpath)"
} else {
    # cancello precauzionalmente eventuali righe già esistenti
    db_dml clear "delete from iter_scripts"
}

foreach origin $origins {

    # devo trattare in modo particolare le istanze iterbase, iter01 e iter02, che hanno una struttura diversa
    if {$origin eq "iterbase" || $origin eq "iter01" || $origin eq "iter02"} {
        set path "/var/lib/aolserver/$origin"
    } else {
        set path "/var/lib/aolserver/$origin/packages/iter"
    }

    # A list of directories that we still need to examine
    set dirs_to_examine [list $path]

    # Perform a breadth-first search of the file tree. For each level,
    # examine dirs in $dirs_to_examine; if we encounter any directories,
    # add contained dirs to $new_dirs_to_examine (which will become
    # $dirs_to_examine in the next iteration).

    while { [llength $dirs_to_examine] > 0 } {

	set new_dirs_to_examine [list]

	foreach dir $dirs_to_examine {

	    set tcl [glob -types f  -nocomplain "$dir/*tcl"]
	    set adp [glob -types f  -nocomplain "$dir/*adp"]
	    set xql [glob -types f  -nocomplain "$dir/*xql"]
	    set sql [glob -types f  -nocomplain "$dir/*sql"]

	    set files [concat $tcl $adp $xql $sql]

	    # tratto immediatamente i file della cartella corrente
	    foreach file $files { 

		# isolo nome e tipo file
		if {[regexp {.+/(.+\.(.*))} $file match fname ftype]} {

		    # ottengo size del file
		    set size [file size $file]

		    # scrivo riga
		    db_dml write "insert into iter_scripts values (:origin, :file, :fname, :ftype, :size)"
		}
	    }

	    # check for subdir
	    foreach newdir [glob -types d -nocomplain "$dir/*"] {
		if {[regexp {CVS$|doc$|docu_dump$|javascript$|logo$|maps$|spool$|una-tantum|permanenti$|src-old$} $newdir]} {
		    # discard these directories
		    continue
		} else {
		    lappend new_dirs_to_examine $newdir
		}
	    }
	}

	set dirs_to_examine $new_dirs_to_examine
    }

}

ad_returnredirect -message "Tabella scripts caricata" index
return
