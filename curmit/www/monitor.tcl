# creo file con id dei processi da controllare
exec ps -efw | grep nsd > /tmp/nsd.txt

# open file
set input [open /tmp/nsd.txt r]

# read the input file splitting it into lines
set lines [split [read $input] \n]
close $input

template::list::create \
    -name instances \
    -multirow instances \
    -elements {
	instance_name {
	    label "Istanza"
	}
	user {
	    label "User"
	}
	pid {
	    label "PID"
	}
	size {
	    label "VSZ"
	    html {align right}
            aggregate "sum"
	}
	rssmem {
	    label "RSS"
	    html {align right}
            aggregate "sum"
	}
    }

# definisco multirow
template::multirow create instances instance_name user pid size rssmem 

foreach line $lines {

    # ottengo user
    set user [lindex $line 0]

    # ottengo process id
    if {$user eq "nsadmin"} {
	set pid [lindex $line 1]
    } else {
	# scarto processo
	continue
    }

    # isolo nome dell'istanza
    if {![regexp {lib/aolserver/(.+)/etc} $line match name]} {
	continue
    }

    # ottengo info sulla memoria del processo
    exec ps -Ao pid,vsz,rss | egrep "PID|$pid" > /tmp/pidmem.txt

    set process [open /tmp/pidmem.txt r]
    set rows [split [read $process] \n]
    close $process
    # scarto la prima riga ed elaboro la seconda
    set row [lindex $rows 1]
    set vsz [lindex $row 1]
    set rss [lindex $row 2]
    
    set vsz [ah::edit_num $vsz 0]
    set rss [ah::edit_num $rss 0]

    # costruisco multirow
    template::multirow append instances $name $user $pid $vsz $rss

}


