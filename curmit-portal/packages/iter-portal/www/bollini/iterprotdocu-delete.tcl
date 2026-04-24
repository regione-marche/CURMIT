ad_page_contract {

    @author          Serena Saccani
    @creation-date   02.12.2010

    @cvs-id          tosadocu-delete.tcl
} {
    {id_documento      ""}
    {last_id_documento ""}
    {function         "V"}
    {caller       "index"}
    {extra_par         ""}
    {save_tipo_doc     ""}
    {last_cognome      ""}
    {extra_par_occu    ""}
}

# Controlla lo user
set id_utente [auth::require_login]

set link_list [export_url_vars prot_id last_id_documento save_tipo_doc caller last_cognome extra_par_occu]

if {[db_0or1row query "
     select *
       from iterprotdocu
      where id_documento = :id_documento"] == 0} {
    tosa_return_complaint "Record non trovato"
}

db_transaction {

    db_1row unlink_allegato "
       select lo_unlink(iterprotdocu.documento)
         from iterprotdocu
        where id_documento = :id_documento"
    
    db_dml query "delete from iterprotdocu where id_documento = :id_documento"

}

ad_returnredirect "iterprotdocu-list?prot_id=$prot_id"
ad_script_abort
