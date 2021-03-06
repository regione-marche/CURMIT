ad_page_contract {
    
    disable an FAQ
    @author Lars Pind (lars@collaboraid.biz)
    @creation-date 2003-03-06

} {
    faq_id:naturalnum,notnull
    referer:optional
}
set package_id [ad_conn package_id]

permission::require_permission -object_id  $package_id -privilege faq_delete_faq

db_dml disable_faq {}

if { ![info exists referer] } {
    set referer "index"
}

ad_returnredirect $referer
