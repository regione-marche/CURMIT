ad_page_contract {

    Viasualizza un menu dinamico

    
    @author Claudio Pasolini

} {
    {menu_id "1"}
}

set user_id [ad_conn user_id]
set group_id [db_string query "
    select object_id_one 
    from acs_rels 
    where rel_type     = 'membership_rel' 
     and object_id_two = :user_id 
     and object_id_one > 0
    order by object_id_one desc
    limit 1
" -default ""]
set username [db_string query "select username from users where user_id = :user_id"]

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
		 -no_login \
		 -object_id [apm_package_id_from_key iter] \
		 -privilege admin]

set title [db_string menu "select menu_name from mis_menus where menu_id = :menu_id"] 
set context ""

db_multirow menu_items item "
    select i.script_id
         , i.item_name
         , case 
             when i.params is null then '/' || s.title
             else '/' || s.title || '?' || i.params
           end as path
    from mis_menu_items i, mis_fast_scripts s
    where i.menu_id   = :menu_id
      and i.group_id  = :group_id
      and s.script_id = i.script_id
    order by i.script_seq
" {
    if {!$admin_p} {
        if {![permission::permission_p -party_id $user_id -object_id $script_id -privilege read]} {
	    continue
	}
    }
}
    
