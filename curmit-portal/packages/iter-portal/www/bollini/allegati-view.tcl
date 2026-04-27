ad_page_contract {
    Visualizzazione allegati di un documento

    @author             Paolo Formizzi
    @creation-date      14/11/2003

    @param id_documento codice documento

    @cvs-id             allegati-view.tcl
} {
    id_documento
    {function "V"}
}

# Controlla lo user
#set livello [tosa_set_livello $function]
#set utn_cde [tosa_check_login $livello]
set id_utente [auth::require_login]


set file_name [ah::package_root]/loading/listing/$id_utente-tosadocu-gest
#set root [ns_info pageroot]

#db_1row query "select path, documento, html, estensione from tosadocu where id_documento = :id_documento"
#if {$html ne "" && $documento eq "" && $path eq ""} {
#    regsub -all "/home/nsadmin/web/viae/packages/tosap/www/" $html "/tosap/" html
#    ns_return 200 text/html "$html"
#    ad_script_abort
#    return
#}
if {[db_0or1row get_file_all "
    select trim(estensione)                          as estensione
         , lo_export(iterprotdocu.documento, :file_name) as flag_export
         , documento
         , path
      from iterprotdocu
     where id_documento = :id_documento"] == 0 || [string is space $estensione]} {
    tosa_return_complaint "<li> Allegato non trovato </li>"
}

if {$documento ne ""} {
#    if {![exists_and_not_null flag_export]} {
        # Nessun allegato da visualizzare
#        tosa_return_complaint "<li> Allegato non trovato </li>"
#        return
#    }
#} elseif {$path ne ""} {
#    set file_name "$path"
#    set estensione "text/html"
} else {
    # Nessun allegato da visualizzare
    tosa_return_complaint "<li> Allegato non trovato </li>"
    return
}

ns_returnfile 200 $estensione $file_name
ns_unlink $file_name

ad_script_abort
return


