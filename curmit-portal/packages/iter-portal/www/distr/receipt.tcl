ad_page_contract {  
    Stampa ricevuta

    @author Claudio Pasolini

    @cvs-id receipt.tcl 
} {
    object_id
    attachment_id
}

set user_id [auth::require_login]

set page_title "Ricevuta della fornitura"
set context [list [list services {Servizi per i distributori}] $page_title]

# decodifico distributore
set name [db_string query "select name from iter_distributors where distributor_id = :object_id"]

# leggo dati fornitura
db_1row query "
    select description, 
           to_char(publish_date,'DD/MM/YYYY') as publish_date 
    from cr_items ci, cr_revisions cr
    where ci.item_id       = :attachment_id and
          ci.live_revision = cr.revision_id"

