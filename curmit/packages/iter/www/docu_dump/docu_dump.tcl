#Programma che va a prendere dalla coimdocu i blob e va a creare i file pdfad_page_contract {
ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimdocu"

} {
    contenuto:trim,optional
    contenuto.tmpfile:tmpfile,optional
} -properties {
}

set output_dir "[iter_set_spool_dir]/docu_dump/"

set count 0
db_foreach sel_docu "" {
    set file_name $output_dir$cod_documento.pdf
    db_0or1row sel_docu_alle ""

#    ns_returnfile 200 $tipo_contenuto $file_name
#    ns_unlink $file_name

    incr count
}



ns_return 200 text/html "$count"; return

}
