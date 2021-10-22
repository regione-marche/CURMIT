# set user_id from db
set user_id [db_string query "select min(user_id) from users where user_id <> 0;"]

#set parent_id [db_string query "select ci.item_id from mis_scriptsx x, cr_items ci where title='mis' and x.revision_id = ci.live_revision"]

db_transaction {

    # root entry for package payments
    set parent_id [mis::script::add                    \
	-title payments                    \
	-description "Gestione bonifici"  \
	-parent_id -100             \
	-original_author $user_id         \
	-maintainer $user_id              \
	-is_active_p t                    \
        -is_executable_p f]

}

ns_return 200 text/html "scripts creati"




