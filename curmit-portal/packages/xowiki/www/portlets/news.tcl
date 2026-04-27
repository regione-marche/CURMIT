if {![exists_and_not_null link]} {
    set link "/news/"
}
if {![exists_and_not_null name]} {
    set name "News"
}
if {![exists_and_not_null url]} {
    set url "/news"
}

set n_news_items 6
set news_limit [expr $n_news_items + 1]

set max_post_age_days 60

# filtro le news in base allo specifico package_id
array set node [site_node::get -url $url]
set package_id $node(package_id)

db_multirow news_items news_items_select "
select item_id,
       publish_title,
       publish_lead,
       to_char(publish_date, 'DD/MM/YYYY') as pretty_publish_date,
       publish_body
from   news_items_approved
where  package_id = :package_id 
       and publish_date < current_timestamp
       and (archive_date is null or archive_date > current_timestamp)
order  by publish_date desc, item_id desc
limit $news_limit
"

