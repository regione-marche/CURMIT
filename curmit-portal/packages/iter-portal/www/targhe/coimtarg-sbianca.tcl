ad_page_contract {

    @author Gacalin e Romitti

} {
    {coimlott_id ""}
    {mode "edit"}
}

set user_id    [ad_conn user_id]

set select_clause ""
set page_title "Sbianca Targhe"
set buttons [list [list "$page_title" new]]
set field_mode edit

set context [list [list coimtarg-sbianca {Sbianca Targhe}] $page_title]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -export coimlott_id \
    -has_edit 1 \
    -form {
	{targa_errata:text
	    {label {Targa Errata}}
	    {html {size 16 maxlength 16}}
	    {mode $field_mode}
	}	
} -on_request {

} -on_submit {
    
    set error_num 0
    if {![db_0or1row q "select nome_db_utilizzo    as nome_db_utilizzo_err
                             , cod_impianto_caldo  as cod_impianto_caldo_err
                             , cod_impianto_freddo as cod_impianto_freddo_err
                          from coimtarg 
                         where targa = :targa_errata"]} {
	template::form::set_error addedit targa_errata "Targa inesistente"
        incr error_num	
    }

    if {$error_num> 0} {
	break
    }

    if {$nome_db_utilizzo_err eq ""} {
	template::form::set_error addedit targa_errata "Targa non assegnata ad alcun impianto"
	break
    }

    if {![db_0or1row q "select distinct m.iter_code as cod_manutentore_err
                      from coimtarg as t
                         , coimplic as p
                         ,iter_maintainers m
                     where upper(t.targa)  = upper(:targa_errata)
                       and p.maintainer_id = m.maintainer_id
                       and p.plico_id      = t.plico_id"]} {
	template::form::set_error addedit targa_errata "Targa non assegnata ad alcun manutentore"
        break
    }

    #disassocio la targa usata erroneamente
    db_dml q "update coimtarg 
                 set nome_db_utilizzo    = null 
                   , cod_impianto_caldo  = null
                   , cod_impianto_freddo = null
               where targa = :targa_errata"


    #sbianco la targa errata sull'impianto del caldo
    db_dml -dbn $nome_db_utilizzo_err q "update coimaimp 
                                            set targa = null
                                          where cod_impianto = :cod_impianto_caldo_err"

    #sbianco la targa errata sull'impianto del freddo
    db_dml -dbn $nome_db_utilizzo_err q "update coimaimp
                                            set targa = null
                                          where cod_impianto = :cod_impianto_freddo_err"
   
} -after_submit { 

    ad_returnredirect -message "Targa sbiancata correttamente" "coimtarg-sbianca"
    ad_script_abort
}




