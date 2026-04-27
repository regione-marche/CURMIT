ad_page_contract {

    @author        Luca Bellini
    @creation-date

    @cvs-id .tcl
} {
}



set filout [open /var/lib/aolserver/curit/packages/iter-portal/www/temp/listing/lancia-al.txt w]

set page "iter/una-tantum/load-op"
[iter_httpget_page_status -page $page -file_out $filout]

set page "iter/una-tantum/load-rleg"
[iter_httpget_page_status -page $page -file_out $fileout]




close $filout


ns_return 200 text/html " finito upd-approved"
return
