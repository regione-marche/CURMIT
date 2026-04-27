# /www/caldaie/main.tcl
ad_page_contract {
    Menu principale.
    
    @author Giulio Laurenzi
    @date   13/12/2002

    @cvs_id main.tcl
} {
    {nome_funz "main"}
}

if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
    set id_utente [ad_get_cookie iter_login_[ns_conn location]]
}

#settaggio current_date
db_1row sel_dual_anno ""

# leggo nome e cognome dell'utente
if {![db_0or1row sel_user ""]
} {
    iter_return_complaint  "Codice utente non valido." 
    return
}  

set page_title "Men&ugrave; principale"
set main_directory [ad_conn package_url]
set context_bar  [iter_context_bar [list "Home"]]

ns_returnredirect palm/coimgage-list-palm?nome_funz=[iter_get_nomefunz coimgage-list-palm]
#ad_return_template
