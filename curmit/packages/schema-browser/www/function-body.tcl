ad_page_contract {
    This is file /www/doc/schema-browser/function-body.tcl.  Currently
    it only handles Postgres function bodies, and is called on to
    expand function bodies referenced by triggers.

    @param oid The oid of the pg_proc entry

    @author Don Baccus (dhogaza@pacifier.com)
    @creation-date September, 2001

} {
    oid:notnull,integer
}


db_1row function_body ""

set context [list "Trigger: $function_name"]
set page_title "Trigger: $function_name"

