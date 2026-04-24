ad_page_contract {

  @author Claudio Pasolini
  @cvs-id adjust.tcl

} {
}

# =======================================================
# ( Parte di Validazione e recupero 'maintainer_id' ... )
# =======================================================

# ( ???? ) set maintainer_id [iter::script_init -validated_par "f"]
set maintainer_id [iter::script_init]
if {[string equal $maintainer_id "0"]} {
    ad_returnredirect services
}

# ( ???? ) Qui secondo me va' controlloato che sia un Manutentore: 'approvato' e 'validato' altrimenti esco!!!
# db_1row query "select name, validated_p, approved_p from iter_maintainers where maintainer_id = :maintainer_id"
# if {[string equal $approved_p "t"]} {
#     ad_returnredirect "services"
#     ad_script_abort
# }


set page_title "Bonifica impianti"
set buttons [list [list "Invia" new]]
set context [list [list services "Servizi per i manutentori"] "$page_title"]

ad_form -name adjust \
        -mode edit \
        -export maintainer_id \
        -edit_buttons $buttons \
        -has_edit 1 \
        -form {
   
        {iter_code:text 
            {label {Codice}}
        }
        {password:text(password)
            {label {Password}}
        }

} -on_submit {

    if {[db_0or1row check  "select to_char(ad.one_time_date, 'DD/MM/YYYY') as one_time_date_pretty,
                                   ad.one_time_user,
                                   substr(u.username, 1, 30)               as username_pretty 
                              from iter_maintainers_to_adjust ad left outer join users u on u.user_id = ad.one_time_user 
                             where ad.iter_code  = :iter_code
                               and ad.password   = :password
                               and ad.f_one_time = 't'"]} {
	template::form::set_error adjust iter_code "La bonifica e' stata gia' eseguita in data: $one_time_date_pretty dall'utente: $username_pretty (user_id = $one_time_user). Non e' possibile eseguire una seconda volta la Bonifica."
	break
    }

    if {![db_0or1row check "select instance_name
                              from iter_maintainers_to_adjust 
                             where iter_code = :iter_code
                               and password  = :password"]} {
	template::form::set_error adjust iter_code "Non risulta alcun dato per il 'CODCIE' e la 'PASSWORD' inseriti."
	break
    }

#    if {$password ne "$psw"} {
#	template::form::set_error adjust password "Password errata."
#	break
#    }

} -after_submit { 

    ad_returnredirect [export_vars -base adjust-2 {maintainer_id iter_code instance_name password}]
    ad_script_abort
}



