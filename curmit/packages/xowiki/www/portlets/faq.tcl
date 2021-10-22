if {![exists_and_not_null link]} {
    set link "/faq/"
}
if {![exists_and_not_null name]} {
    set name "Domande e Risposte"
}
if {![exists_and_not_null url]} {
    set url "/faq"
}

set n_faq_items 10
set faq_limit [expr $n_faq_items + 1]

# filtro le faq in base allo specifico package_id
array set node [site_node::get -url $url]
set package_id $node(package_id)

db_multirow faq_items faq_items_select "
select entry_id,
       question,
       answer
from   faq_q_and_as
where  faq_id = 2436
order by sort_key
limit $faq_limit
"

