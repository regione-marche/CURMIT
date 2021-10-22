namespace eval monitoring {}

proc monitoring::header {{stat ""}} {
    if [string length $stat] {
        set title "AOLserver Stats: [ns_info hostname] - $stat"
        set nav "<a href=index><font color=#ffffff>Main Menu</font></a> &gt; <font color=#ffcc00>$stat</font>"
    } else {
        set title "AOLserver Stats: [ns_info hostname]"
        set nav "<font color=#ffcc00><font color=#ffcc00>Main Menu</font>"
    }
    set server [lindex [lindex [util_ns_set_to_list -set [ns_configsection ns/servers]] 0] 0]
    set address [ns_config ns/server/${server}/module/nssock address ""]
    return "\
    <style>
        body    { font-family: verdana,arial,helvetica,sans-serif; font-size: 8pt; color: #000000; background-color: #ffffff; }
        td      { font-family: verdana,arial,helvetica,sans-serif; font-size: 8pt; }
        pre     { font-family: courier new, courier; font-size: 10pt; }
        form    { font-family: verdana,helvetica,arial,sans-serif; font-size: 10pt; }
        i       { font-style: italic; }
        b       { font-style: bold; }
        hl      { font-family: verdana,arial,helvetica,sans-serif; font-style: bold; font-size: 12pt; }
        small   { font-size: smaller; }
    </style>

    <table border=0 cellpadding=5 cellspacing=0 width=\"100%\">
    <tr>
        <td valign=middle bgcolor=#666699><font size=1 color=#ffffff><b>$nav</b></font></td>
        <td valign=middle bgcolor=#666699><font size=1 color=#ffffff align=center><b>Server: $address</b></font></td>
        <td valign=middle bgcolor=#666699 align=right><font size=1 color=#ffffff><b>[monitoring::fmtTime [ns_time]]</b></font></td>
    </tr>
    </table>
    <br>"
}

proc monitoring::footer {} {
    return ""
}

proc monitoring::adp {} {
    set col         [ns_queryget col 1]
    set reverseSort [ns_queryget reversesort 1]

    set numericSort 1
    set colTitles   [list File Device Inode "Modify Time" "Ref Count" Evals Size Blocks Scripts]

    if {$col == 1} {
        set numericSort 0
    }

    set results ""

    foreach {file stats} [ns_adp_stats] {
        set s  ""

        foreach {k v} $stats {
            if {[string match mtime $k]} {
                lappend s [monitoring::fmtTime $v]
            } else {
                lappend s $v
            }
        }
        lappend results [concat $file $s]
    }

    set rows [monitoring::sortResults $results [expr $col - 1] $numericSort $reverseSort]

    set html [monitoring::header ADP]
    append html [monitoring::results $col $colTitles adp $rows $reverseSort]
    append html [monitoring::footer]
    
    return $html
}

proc monitoring::cache {} {
    set col         [ns_queryget col 1]
    set reverseSort [ns_queryget reversesort 1]

    set numericSort 1

    if {$col == 1} {
        set numericSort 0
    }

    set results ""

    foreach cache [ns_cache_names] {
        set t [ns_cache_stats $cache]

        scan [ns_cache_size $cache] "%d %d" M N
        scan $t "entries: %d  flushed: %d  hits: %d  misses: %d  hitrate: %d" e f h m p

        lappend results [list $cache $M $N $e $f $h $m "$p%"]
    }

    set colTitles   [list Cache Max Current Entries Flushes Hits Misses "Hit Rate"]
    set rows        [monitoring::sortResults $results [expr $col - 1] $numericSort $reverseSort]
    
    set html [monitoring::header Cache]
    append html [monitoring::results $col $colTitles cache $rows $reverseSort]
    append html [monitoring::footer]
    
    return $html
}

proc monitoring::locks {} {
    set col         [ns_queryget col 1]
    set reverseSort [ns_queryget reversesort 1]

    set numericSort 1
    set colTitles   [list Name Owner ID Locks Busy Contention]
    set rows        ""

    if {$col == 1 || $col == 2} {
        set numericSort 0
    }

    set results ""

    foreach l [ns_info locks] {
        set name    [lindex $l 0]
        set owner   [lindex $l 1]
        set id      [lindex $l 2]
        set nlock   [lindex $l 3]
        set nbusy   [lindex $l 4]

        if {$nbusy == 0} {
            set contention 0.0
        } else {
            set contention [expr double($nbusy*100.0/$nlock)]
        }

        lappend results [list $name $owner $id $nlock $nbusy $contention]
    }

    foreach result [monitoring::sortResults $results [expr $col - 1] $numericSort $reverseSort] {
        set name        [lindex $result 0]
        set owner       [lindex $result 1]
        set id          [lindex $result 2]
        set nlock       [lindex $result 3]
        set nbusy       [lindex $result 4]
        set contention  [lindex $result 5]

        if {$contention < 2} {
            set color "black"
        } elseif {$contention < 5} {
            set color "orange"
        } else {
            set color "red"
        }

        lappend rows [list "<font color=$color>$name</font>" "<font color=$color>$owner</font>" "<font color=$color>$id</font>" "<font color=$color>$nlock</font>" "<font color=$color>$nbusy</font>" "<font color=$color>$contention</font>"]
    }
    
    set html [monitoring::header Locks]
    
    if {![ns_config -bool ns/threads mutexmeter 0]} {
        set msg "\
        Mutex metering not enabled. To enable add the following to your server configuration:
<pre>
ns_section ns/threads
ns_param mutexmeter true
</pre>"
        
        append html [monitoring::msg warning $msg]
    }
    
    append html [monitoring::results $col $colTitles locks $rows $reverseSort]
    append html [monitoring::footer]
    
    return $html
}

proc monitoring::log {} {
    set log ""

    catch {
        set f [open [ns_info log]]
        seek $f 0 end
        set n [expr [tell $f] -4000]

        if {$n < 0} {
            set n 4000
        }

        seek $f $n
        gets $f
        set log [ns_quotehtml [read $f]]
        close $f
    }

    set html [monitoring::header Log]
    append html "<font size=2><pre>$log</pre></font>"
    append html [monitoring::footer]
    
    return $html
}

proc monitoring::mempools {} {
    set talloc 0
    set trequest 0
    set tused 0
    set tlocks 0
    set twaits 0
    set tfree 0
    set tops 0   

    set html [monitoring::header Memory]

    append html "\
    <table border=0 cellpadding=0 cellspacing=0>
    <tr>
        <td valign=middle>"

    foreach p [lsort [ns_info pools]] {
        append html "\
        <b>[lindex $p 0]:</b>
        <br><br>
        <table border=0 cellpadding=0 cellspacing=1 bgcolor=#cccccc width=\"100%\">
        <tr>
            <td valign=middle align=center>
            <table border=0 cellpadding=4 cellspacing=1 width=\"100%\">
            <tr>
                <td valign=middle bgcolor=#999999><font color=#ffffff>Block Size</font></td>
                <td valign=middle bgcolor=#999999><font color=#ffffff>Frees</font></td>
                <td valign=middle bgcolor=#999999><font color=#ffffff>Gets</font></td>
                <td valign=middle bgcolor=#999999><font color=#ffffff>Puts</font></td>
                <td valign=middle bgcolor=#999999><font color=#ffffff>Bytes Req</font></td>
                <td valign=middle bgcolor=#999999><font color=#ffffff>Bytes Used</font></td>
                <td valign=middle bgcolor=#999999><font color=#ffffff>Overhead</font></td>
                <td valign=middle bgcolor=#999999><font color=#ffffff>Locks</font></td>
                <td valign=middle bgcolor=#999999><font color=#ffffff>Lock Waits</font></td>
             </tr>"

	    foreach b [lrange $p 1 end] {
		    set bs [lindex $b 0]
		    set nf [lindex $b 1]
		    set ng [lindex $b 2]
		    set np [lindex $b 3]
		    set nr [lindex $b 4]
		    set nu [expr $ng - $np]
		    set na [expr $nu * $bs]

		    incr tops [expr $ng + $np]
		    incr tlocks [lindex $b 5]
		    incr twaits [lindex $b 6]
		    incr tfree [expr $bs * $nf]
		    incr talloc $na
		    incr trequest $nr
		    incr tused $nu

		    if {$nr != 0} {
			    set ov [expr $na - $nr]
			    set op [format %4.2f%% [expr $ov.0 * 100 / $nr.0]]
		    } else {
			    set ov "N/A"
			    set op "N/A"
		    }

		    append html "<tr>"

		    foreach e [linsert [lreplace $b 4 4] 4 $nr $na $op] {
			    append html "<td bgcolor=#ffffff>$e</td>"
		    }

		    append html "</tr>"
	    }

	    append html "\
	        </table>
	        </td>
        </tr>
        </table>
        <br>"
    }

    set ov [expr $talloc - $trequest]
    set op [format %4.2f [expr $ov.0 * 100 / $trequest.0]]
    set av [format %4.2f [expr 100.0 - ($tlocks.0 * 100) / $tops.0]]

    if {$tlocks > 0} {
	    set wr [format %4.2f [expr $twaits.0 / $tlocks.0]]
    } else {
	    set wr N/A
    }

    append html "\
        </td>
    </tr>
    <tr>
        <td valign=middle>
        <b>Totals:</b><br><br>
        <table>
            <tr><td>Bytes Requested:</td><td>$trequest</td></tr>
            <tr><td>Bytes Free:</td><td>$tfree</td></tr>
            <tr><td>Bytes Allocated:</td><td>$talloc</td></tr>
            <tr><td>Bytes Wasted:</td><td>$ov</td></tr>
            <tr><td>Byte Overhead:</td><td>${op}%</td></tr>
            <tr><td>Mutex Locks:</td><td>$tlocks</td></tr>
            <tr><td>Mutex Lock Waits:</td><td>$twaits</td></tr>
            <tr><td>Lock Wait Ratio:</td><td>${wr}%</td></tr>
            <tr><td>Gets/Puts:</td><td>${tops}</td></tr>
            <tr><td>Lock Avoidance:</td><td>${av}%</td></tr>
        </table>
        </td>
    </tr>
    </table>"

    append html [monitoring::footer]
    
    return $html
}

proc monitoring::process {} {
    set values [list \
        Host "[ns_info hostname] ([ns_info address])" \
        "Boot Time" [clock format [ns_info boottime] -format %c] \
        Uptime [monitoring::fmtSeconds [ns_info uptime]] \
        Process "[ns_info pid] [ns_info nsd]" \
        Configuration [ns_info config] \
        "Page Root" [ns_info pageroot] \
        "Tcl Library" [ns_info tcllib] \
        Log [ns_info log] \
        Version "[ns_info version] ([ns_info label])" \
        "Build Date" [ns_info builddate] \
        Servers [join [ns_info servers] <br>] \
        Threads [join [ns_server threads] <br>] \
        "Keep Alive" [ns_server keepalive] \
        Callbacks [join [ns_info callbacks] <br>] \
        "Socket Callbacks" [join [ns_info sockcallbacks] <br>] \
        Active [join [ns_server active] <br>]]

    set html [monitoring::header Process]

    append html "\
    <table border=0 cellpadding=0 cellspacing=1 bgcolor=#cccccc>
    <tr>
        <td valign=middle align=center>
        <table border=0 cellpadding=3 cellspacing=1 width=\"100%\">
        <tr>
            <td valign=middle bgcolor=#999999><font face=verdana size=1 color=#ffffff><nobr>Key</nobr></font></td>
            <td valign=middle bgcolor=#999999><font face=verdana size=1 color=#ffffff><nobr>Value</nobr></font></td>
        </tr>"

        foreach {key value}  $values {
            append html "\
            <tr>
                <td valign=top bgcolor=#ffffff><font face=verdana size=1>$key</font></td>
                <td valign=top bgcolor=#ffffff><font face=verdana size=1>$value</font></td>
            </tr>"
        }

        append html "\
        </table>
        </td>
    </tr>
    </table>"

    append html [monitoring::footer]
    
    return $html
}

proc monitoring::sched {} {
    set col             [ns_queryget col 1]
    set reverseSort     [ns_queryget reversesort 1]

    set numericSort     1
    set scheduledProcs  ""

    foreach s [ns_info scheduled] {
        set id          [lindex $s 0]
        set flags       [lindex $s 1]
        set next        [lindex $s 3]
        set lastqueue   [lindex $s 4]
        set laststart   [lindex $s 5]
        set lastend     [lindex $s 6]
        set proc        [lindex $s 7]
        set arg         [lindex $s 8]

        if [catch {
            set duration [expr $lastend - $laststart]
        }] {
            set duration "0"
        }

        set state "pending"

        if [monitoring::isThreadSuspended $flags] {
            set state suspended
        }

        if [monitoring::isThreadRunning $flags] {
            set state running
        }

        lappend scheduledProcs [list $id $state $proc $arg $flags $lastqueue $laststart $lastend $duration $next]
    }

    set rows ""

    foreach s [monitoring::sortResults $scheduledProcs [expr $col - 1] $numericSort $reverseSort] {
        set id          [lindex $s 0]
        set state       [lindex $s 1]
        set flags       [join [monitoring::getSchedFlagTypes [lindex $s 4]] "<br>"]
        set next        [monitoring::fmtTime [lindex $s 9]]
        set lastqueue   [monitoring::fmtTime [lindex $s 5]]
        set laststart   [monitoring::fmtTime [lindex $s 6]]
        set lastend     [monitoring::fmtTime [lindex $s 7]]
        set proc        [lindex $s 2]
        set arg         [lindex $s 3]
        set duration    [monitoring::fmtSeconds [lindex $s 8]]

        lappend rows [list $id $state $proc $arg $flags $lastqueue $laststart $lastend $duration $next]
    }

    set colTitles [list ID Status Callback Data Flags "Last Queue" "Last Start" "Last End" Duration "Next Run"]

    set html [monitoring::header "Scheduled Proceedures"]
    append html [monitoring::results $col $colTitles sched $rows $reverseSort]
    append html [monitoring::footer]
    
    return $html
}

proc monitoring::threads {} {
    set col         [ns_queryget col 1]
    set reverseSort [ns_queryget reversesort 1]

    set numericSort 1
    set colTitles   [list Thread Parent ID Flags "Create Time" Proc Args]
    set rows        ""

    if {$col == 1 || $col == 2 || $col == 6 || $col == 7} {
        set numericSort 0
    }

    set rows ""

    foreach t [monitoring::sortResults [ns_info threads] [expr $col - 1] $numericSort $reverseSort] {
        set thread  [lindex $t 0]
        set parent  [lindex $t 1]
        set id      [lindex $t 2]
        set flags   [monitoring::getThreadType [lindex $t 3]]
        set create  [monitoring::fmtTime [lindex $t 4]]
        set proc    [lindex $t 5]
        set arg     [lindex $t 6]
        
        if {[string match "p:0x0" $proc]} {
            set proc "NULL"
        }
        
        if {[string match "a:0x0" $arg]} {
            set arg "NULL"
        }
        
        lappend rows [list $thread $parent $id $flags $create $proc $arg]
    }

    set html [monitoring::header Threads]
    append html [monitoring::results $col $colTitles threads $rows $reverseSort]
    append html [monitoring::footer]
    
    return $html
}

proc monitoring::results {{selectedColNum ""} {colTitles ""} {colUrl ""} {rows ""} {reverseSort ""} {colAlignment ""}} {
    set numCols [llength $colTitles]

    for {set colNum 1} {$colNum < [expr $numCols + 1]} {incr colNum} {
        if {$colNum == $selectedColNum} {
            set colHdrColor($colNum)        "#666666"
            set colHdrFontColor($colNum)    "#ffffff"
            set colColor($colNum)           "#ececec"
        } else {
            set colHdrColor($colNum)        "#999999"
            set colHdrFontColor($colNum)    "#ffffff"
            set colColor($colNum)           "#ffffff"
        }
    }
    
    set html "\
    <table border=0 cellpadding=0 cellspacing=1 bgcolor=#cccccc>
    <tr>
        <td valign=middle align=center>
        <table border=0 cellpadding=4 cellspacing=1 width=\"100%\">
        <tr>"

    set i 1
    
    foreach title $colTitles {
        set url $colUrl

        if {$i == $selectedColNum} {
            if $reverseSort {
                append url "?reversesort=0"
            } else {
                append url "?reversesort=1"
            }
        } else {
            append url "?reversesort=$reverseSort"
        }

        set colAlign "left"

        if [llength $colAlignment] {
            set align [lindex $colAlignment [expr $i - 1]]

            if [string length $align] {
                set colAlign $align
            }
        }

        append html "<td valign=middle align=$colAlign bgcolor=$colHdrColor($i)><a href=$url&col=$i><font color=$colHdrFontColor($i)>$title</font></a></td>"

        incr i
    }
   
    append html "</tr>"

    foreach row $rows {
        set i 1

        append html "<tr>"

        foreach column $row {
            set colAlign "left"

            if [llength $colAlignment] {
                set align [lindex $colAlignment [expr $i - 1]]

                if [string length $align] {
                    set colAlign $align
                }
            }

            append html "<td bgcolor=$colColor($i) valign=top align=$colAlign>$column</td>"

            incr i
        }

        append html "</tr>"
    }
    
    append html "\
        </table>
        </td>
    </tr>
    </table>"
    
    return $html
}

proc monitoring::msg {type msg} {
    switch $type {
        "error" {
            set color "red"
        }
        "warning" {
            set color "orange"
        }
        "success" {
            set color "green"
        }
        default {
            set color "black"
        }
    }

    return "<font color=$color><b>[string toupper $type]:<br><br>$msg</b></font>"
}

proc monitoring::getValue {key} {
    if {![nsv_exists _ns_stats $key]} {
        return ""
    }

    return [nsv_get _ns_stats $key]
}

proc monitoring::getThreadType {flag} {
    return [monitoring::getValue thread_$flag]
}

proc monitoring::getSchedType {flag} {
    return [monitoring::getValue sched_$flag]
}

proc monitoring::getSchedFlag {type} {
    return [monitoring::getValue sched_$type]
}

proc monitoring::isThreadSuspended {flags} {
    return [expr $flags & [monitoring::getSchedFlag paused]]
}

proc monitoring::isThreadRunning {flags} {
    return [expr $flags & [monitoring::getSchedFlag running]]
}

proc monitoring::getSchedFlagTypes {flags} {
    if [expr $flags & [monitoring::getSchedFlag once]] {
        set types "once"
    } else {
        set types "repeating"
    }

    if [expr $flags & [monitoring::getSchedFlag daily]] {
        lappend types "daily"
    }

    if [expr $flags & [monitoring::getSchedFlag weekly]] {
        lappend types "weekly"
    }

    if [expr $flags & [monitoring::getSchedFlag thread]] {
        lappend types "thread"
    }

    return $types
}

proc monitoring::fmtSeconds {seconds} {
    if {$seconds < 60} {
        return "${seconds} (s)"
    }

    if {$seconds < 3600} {
        set mins [expr $seconds/60]
        set secs [expr $seconds - ($mins * 60)]

        return "${mins}:${secs} (m:s)"
    }

    set hours [expr $seconds/3600]
    set mins [expr ($seconds - ($hours * 3600))/60]
    set secs [expr $seconds - (($hours * 3600) + ($mins * 60))]

    return "${hours}:${mins}:${secs} (h:m:s)"
}

proc monitoring::fmtTime {time} {
    if {$time < 0} {
        return "never"
    }

    return [clock format $time -format "%I:%M:%S %p on %m/%d/%Y"]
}

proc monitoring::sortResults {results field numeric {reverse 0}} {
    global _sortListTmp

    set _sortListTmp(field)     $field
    set _sortListTmp(numeric)   $numeric
    set _sortListTmp(reverse)   $reverse

    return [lsort -command monitoring::cmpField $results]
}

proc monitoring::cmpField {v1 v2} {
    global _sortListTmp

    set v1  [lindex $v1 $_sortListTmp(field)]
    set v2  [lindex $v2 $_sortListTmp(field)]

    if $_sortListTmp(numeric) {
        if $_sortListTmp(reverse) {
            set cmp [monitoring::cmpNumeric $v2 $v1]
        } else {
            set cmp [monitoring::cmpNumeric $v1 $v2]
        }
    } else {
        if $_sortListTmp(reverse) { 
            set cmp [string compare $v2 $v1]
        } else {
            set cmp [string compare $v1 $v2]
        }
    }

    return $cmp
}

proc monitoring::cmpNumeric {n1 n2} {
    if {$n1 < $n2} {
        return -1
    } elseif {$n1 > $n2} {
        return 1
    }

    return 0
}
