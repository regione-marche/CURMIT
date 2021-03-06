#faq/www/index.tcl

ad_page_contract {

    Displays FAQs on this site

    @author Jennie Housman (jennie@ybos.net)
    @author Elizabeth Wirth (wirth@ybos.net)
    @creation-date 2000-10-24
   
} {
} -properties {
  context:onevalue
  package_id:onevalue
  user_id:onevalue
  faqs:multirow
}

set package_id [ad_conn package_id]

set context {}


set user_id [ad_conn user_id]
 
permission::require_permission -object_id $package_id -privilege faq_view_faq

set admin_p 0


set notification_chunk [notification::display::request_widget \
                        -type all_faq_qa_notif \
			-object_id [ad_conn package_id] \
                        -pretty_name FAQs \
                        -url [ad_conn url] \
                        ]

if {[permission::permission_p -party_id $user_id -object_id $package_id -privilege faq_admin_faq]} {
    set admin_p 1
}

db_multirow faqs faq_select "" {}

ad_return_template
