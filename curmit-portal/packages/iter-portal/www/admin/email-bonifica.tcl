ad_page_contract {

    @author Michele Maffezzoni

} {
    {email_errata ""}
    {mode "edit"}
}

set user_id    [ad_conn user_id]

set select_clause ""
set page_title "Bonifica email"
set buttons [list [list "$page_title" new]]
set field_mode edit

set context [list [list email-bonifica {Bonifica email}] $page_title]

set page_title "Bonifica email Manutentore"


ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -export coimlott_id \
    -has_edit 1 \
    -form {
	{email_errata:text
	    {label {Email Errata}}
	    {html {size 40 maxlength 100}}
	    {mode $field_mode}
	}	
	{email_corretta:text
	    {label {Email Corretta}}
	    {html {size 40 maxlength 100}}
            {mode $field_mode}
        }
} -on_submit {
    set errormsgnuova ""
    set error_num_vecchia 0
    set error_num_nuova 0
    #avvio controlli sulla mail vecchia
    if {![db_0or1row vecchia_tabmanu "select maintainer_id as maintainer_id_da_agg
                                        from iter_maintainers ma
                                       where ma.email = :email_errata"]} {
	set maintainer_id_da_agg ""
	incr error_num_vecchia
    }

    if {![db_0or1row vecchia_tabusers "select user_id as user_id_da_agg
                                      from users usr
                                      where usr.username = :email_errata"]} {
	set user_id_da_agg ""
	incr error_num_vecchia
    }
    
    if {![db_0or1row vecchia_tabparties "select party_id as party_id_da_agg
                                         from parties par
                                         where par.email = :email_errata"]} {
	set party_id_da_agg ""
	incr error_num_vecchia
    }
    
    #avvio controlli sulla mail nuova
    if {[db_0or1row nuova_tabmanu "select coalesce(iter_code,'') || ' ' || name || ' (' || maintainer_id  || ')' as manu
                                     from iter_maintainers ma
                                    where ma.email=:email_corretta"]} {
	append errormsgnuova "Email già assegnata al manutentore $manu <br>"
	incr error_num_nuova
    }
    
    if {[db_0or1row nuova_tabusers "select user_id as utente
                                      from users usr
                                     where usr.username=:email_corretta"]} {
	append errormsgnuova "Email già assegnata all'utente $utente <br>"
	incr error_num_nuova
    }

    if {[db_0or1row nuova_tabparties "select party_id as pid
                                        from parties par
                                       where par.email=:email_corretta"]} {
	append errormsgnuova "Email già assegnata a party_id= $pid"
	incr error_num_nuova
    }

    
    if {$error_num_vecchia> 0} {
	template::form::set_error addedit email_errata "Email inesistente"
	break
    }

    if {$error_num_nuova > 0} {
	template::form::set_error addedit email_corretta "$errormsgnuova <br>Contattare l'assistenza."
	break
    }

    db_transaction {

	db_dml q "update iter_maintainers
                     set email         = :email_corretta
                       , editing_date  = current_date
                       , editing_user  = :user_id 
                   where maintainer_id = :maintainer_id_da_agg"

	db_dml q "update users
                     set username = :email_corretta
                   where user_id  = :user_id_da_agg"

	db_dml q "update parties
                     set email    = :email_corretta
                   where party_id = :party_id_da_agg"

	ns_log notice "L'utente $user_id ha modificato la mail $email_errata in $email_corretta sullo user $user_id_da_agg"
	
    } on_error {
	ah::transaction_error
    }
    
} -after_submit { 

    ad_returnredirect -message "bonifica avvenuta correttamente" "email-bonifica"
    ad_script_abort
}
