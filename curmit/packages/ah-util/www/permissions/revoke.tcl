ad_page_contract {

  @author rhs@mit.edu
  @creation-date 2000-08-20
  @cvs-id $Id: revoke.tcl,v 1.1.1.1 2014/03/06 15:04:07 nsadmin Exp $
} {
  object_id:integer,notnull
  {revoke_list:multiple,optional {}}
  {application_url ""}
}

ad_require_permission $object_id admin

if {[llength $revoke_list] == 0} {
  ad_returnredirect "./?[export_url_vars object_id]"
  ad_script_abort
}

doc_body_append "[ad_header "Conferma rimozione permessi"]

<h2>Conferma rimozione permessi</h2>

<hr>
Sei sicuro di voler cancellare i permessi selezionati su [db_string name {select acs_object__name(:object_id)}]?

<ul>
"
foreach item $revoke_list {
  set party_id [lindex $item 0]
  set privilege [lindex $item 1]
  doc_body_append "  <li>[db_string party_name {select coalesce(email, group_name) from parties left outer join groups on party_id = group_id where party_id = :party_id}]</li>\n"
}

doc_body_append "</ul>

<form method=get action=revoke-2>
[export_vars -form {object_id application_url}]

"

foreach item $revoke_list {
  doc_body_append "<input type=hidden name=revoke_list value=\"$item\">\n"
}

doc_body_append "

<input name=operation type=submit value=Si> <input name=operation type=submit value=No>

</form>

</body>
</html>
"
