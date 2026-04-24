ad_page_contract {
    Login utente
    @author        Luca Romitti
    @creation_date 05/12/2024

    @cvs-id single-sign-on-chose-uten.tcl

    USER  DATA       MODIFICHE
    ===== ========== ============================================================================================

} {
    {id_utente ""}   
    {token_code ""}
    {caller "index"}
    radio_button:multiple,optional
} -properties {
    page_title:onevalue
    context_bar:onevalue
}

set db_portale [parameter::get_from_package_key -package_key iter -parameter dbname_portale -default ""]

set page_title   "Login"
set context_bar  "&nbsp;"
set mex_error    "&nbsp;"

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "single_login"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
set button_label "Continua"

form create $form_name \
-html    $onsubmit_cmd

element create $form_name submit              -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name token_code          -widget hidden -datatype text -optional
element create $form_name id_utente           -widget hidden -datatype text -optional
element create $form_name codice_fiscale_uten -widget hidden -datatype text -optional

# creo i vari elementi per ogni riga ed una struttura multirow
# da utilizzare nell'adp
multirow create utenti radio_butt cod_manutentore denominazione

set codice_fiscale_uten [db_string q "select fiscal_code
                                        from iter_operators
                                       where iter_no = :id_utente"]

db_foreach users "
                 select coalesce(m.name,'') as denominazione
                 --   , m.iter_code         as cod_manutentore
                      , o.iter_no           as cod_manutentore
                      , o.iter_no           as cod_utente_da_loggare
                   from iter_operators   o
              left join iter_maintainers m
                     on m.maintainer_id = o.maintainer_id
                  where coalesce(o.fiscal_code)  = :codice_fiscale_uten
                    and m.is_active_p != '0' -- L'operatore non deve essere stato disabilitato dalla ditta
                    and o.is_active_p != '0' -- La ditta deve essere attiva
                    and o.iter_no is not null
                       
 " {

     set radio_butt "<input type=radio name=radio_button value=$cod_utente_da_loggare>"
     multirow append utenti $radio_butt $cod_manutentore $denominazione
 }


if {[form is_request $form_name]} {

    element set_properties $form_name token_code          -value $token_code
    element set_properties $form_name id_utente           -value $id_utente
    element set_properties $form_name codice_fiscale_uten -value $codice_fiscale_uten

    
}

if {[form is_valid $form_name]} {

    set token_code          [string trim [element::get_value $form_name token_code]]
    set id_utente           [string trim [element::get_value $form_name id_utente]]
    set codice_fiscale_uten [string trim [element::get_value $form_name codice_fiscale_uten]]
    
    set error_num 0
    if {![info exists radio_button]} {
	set mex_error "<font color=red>Si prega di selezionare un utente.</font>"
	incr error_num
    } else {
	
	db_1row q "select o.iter_no as id_utente_sel
                     from iter_operators o
                   where coalesce(o.iter_no) = :radio_button"
    }

    if {$error_num > 0} {
	ad_return_template
        return
    } else {

	set token_code_new $id_utente[randomRange 99999999] 

	db_dml q "update iter_login 
                     set token_code       = :token_code_new
                       , data_last_login  = current_timestamp 
                   where utente           = :id_utente_sel"

	# trovo il subsite
	array set arr [site_node::get_from_url -url /]
	set context_id $arr(package_id)
	
	# ottengo il gruppo a cui appartengono, con relazione di
	# composizione, tutti gli altri gruppi 
	set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]
	
	set url [db_string a "select p.url
    from acs_rels r, groups g, parties p, iter_instances i
    where r.rel_type='composition_rel' and 
          r.object_id_one = :subsite_group_id and 
          r.object_id_two = g.group_id and
          g.group_id      = p.party_id and
          g.group_id      = i.instance_id
    order by group_name
    limit 1"]

    
	ns_log notice "luca21 context_id:$context_id subsite_group_id:$subsite_group_id url:$url"
	set url_redirect "$url/iter/single-sign-on?id_utente=$id_utente&token_code=$token_code_new&caller=portale"
	#set return_url "main"
	ns_returnredirect $url_redirect
	ad_script_abort
    }
}
db_release_unused_handles
ad_return_template

