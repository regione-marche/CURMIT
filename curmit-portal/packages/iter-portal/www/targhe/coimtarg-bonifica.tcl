ad_page_contract {

    @author Simone Pesci

} {
    {coimlott_id ""}
    {mode "edit"}
}

set user_id    [ad_conn user_id]

set select_clause ""
set page_title "Bonifica Targhe"
set buttons [list [list "$page_title" new]]
set field_mode edit

set context [list [list coimtarg-bonifica {Bonifica Targhe}] $page_title]


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
	{targa_corretta:text
	    {label {Targa Corretta}}
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
    if {![db_0or1row q "select nome_db_utilizzo    as nome_db_utilizzo_cor
                             , cod_impianto_caldo  as cod_impianto_caldo_cor
                             , cod_impianto_freddo as cod_impianto_freddo_cor 
                          from coimtarg where targa = :targa_corretta"]} {
	template::form::set_error addedit targa_corretta "Targa inesistente"
        incr error_num
    }

    if {$error_num> 0} {
	break
    }

    if {$nome_db_utilizzo_err eq ""} {
	template::form::set_error addedit targa_errata "Targa non assegnata ad alcun impianto"
	break
    }

    if {$nome_db_utilizzo_cor  ne ""} {
	template::form::set_error addedit targa_corretta "Targa già assegnata ad altri impianti. Contattare l'assistenza"
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

    if {![db_0or1row q "select distinct m.iter_code as cod_manutentore_cor
                      from coimtarg as t
                         , coimplic as p
                         ,iter_maintainers m
                     where upper(t.targa)  = upper(:targa_corretta)
                       and p.maintainer_id = m.maintainer_id
                       and p.plico_id      = t.plico_id"]} {
	template::form::set_error addedit targa_corretta "Targa non assegnata ad alcun manutentore"
        break
    }

    if {$cod_manutentore_err != $cod_manutentore_cor} {
	template::form::set_error addedit targa_errata "Impossibile procedere. La targa $targa_errata è assegnata al manutentore $cod_manutentore_err mentre la targa corretta è assegnata al manutentore $cod_manutentore_cor"
	break
    }

    #disassocio la targa usata erroneamente
    db_dml q "update coimtarg 
                 set nome_db_utilizzo    = null 
                   , cod_impianto_caldo  = null
                   , cod_impianto_freddo = null
               where targa = :targa_errata"

    #associo la targa corretta
    db_dml q "update coimtarg 
                 set nome_db_utilizzo    = :nome_db_utilizzo_err 
                   , cod_impianto_caldo  = :cod_impianto_caldo_err
                   , cod_impianto_freddo = :cod_impianto_freddo_err
               where targa = :targa_corretta"

    #metto la targa corretta sull'impianto del caldo
    db_dml -dbn $nome_db_utilizzo_err q "update coimaimp 
                                            set targa = :targa_corretta
                                          where cod_impianto=:cod_impianto_caldo_err"

    #metto la targa corretta sull'impianto del freddo
    db_dml -dbn $nome_db_utilizzo_err q "update coimaimp 
                                            set targa = :targa_corretta
                                          where cod_impianto=:cod_impianto_freddo_err"
   
} -after_submit { 

    ad_returnredirect -message "bonifica avvenuta correttamente" "coimtarg-bonifica"
    ad_script_abort
}




