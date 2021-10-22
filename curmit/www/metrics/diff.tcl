ad_page_contract {

    Evidenzia le differenze fra due file.

    @author Claudio Pasolini
} {
    one
    two
}

# ricavo i parametri necessari per ritornare al chiamante
regexp {/var/lib/aolserver/([^/]+)/} $two match origin2
regexp {/var/lib/aolserver/([^/]+)/[^\.]+.(...)} $one match origin1 ftype
set pattern /var/lib/aolserver/${origin1}(/.+)
regexp $pattern $one match dirpath

set fname /[file tail $one]
regsub $fname $dirpath {} dirpath
set dirpath [string range $dirpath 1 end]

with_catch errmsg {
    exec diff $one $two > /tmp/diff.txt
} {
    # ignoro eventuali errori
}

set fd [open /tmp/diff.txt r]
set diff [read $fd]
close $fd
ns_unlink /tmp/diff.txt


