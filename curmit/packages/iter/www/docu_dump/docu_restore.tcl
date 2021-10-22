#Programma che va a prendere dalla coimdocu i blob e va a creare i file pdfad_page_contract {
ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimdocu"

} {
    contenuto:trim,optional
    contenuto.tmpfile:tmpfile,optional
} -properties {
}

set input_dir "[iter_set_spool_dir]/docu_dump/"

set files [ad_find_all_files $input_dir]
set list_count [llength $files]

#set input_dir_length [string length $input_dir]
set counter 0
set count 0
set lista ""
while {$counter < $list_count} {

    set file_name [lindex $files $counter]
    set file_name_length [string length $file_name]
    set file_name_length [expr $file_name_length - 5]
    set input_dir_length [string length $input_dir]
    set input_dir_length [expr $input_dir_length + 1]
    set index_docu [string range $file_name $input_dir_length $file_name_length]

    append lista "$index_docu <br>"
    set contenuto_tmpfile $file_name

    db_dml dml_ins_alle [db_map upd_docu_ins_alle]

    incr counter
    incr count
}



ns_return 200 text/html "$lista <br><br> $count"; return

}
