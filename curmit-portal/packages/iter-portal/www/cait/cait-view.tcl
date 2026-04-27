ad_page_contract {

    @author Claudio Pasolini
    @cvs-id maintainer-edit.tcl

} {
    {mode "edit"}
}
set nome_db [db_get_database];#rom01
set cait_id [auth::require_login]

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :cait_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}

if {[string match "*iter-portal-marche*" $db_name]} {#rom01 if else e loro contenuto
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

    set token_code $cait_id[randomRange 99999999]
    db_dml q "update iter_login
                     set token_code       = :token_code
                       , data_last_login  = current_timestamp
                   where utente           = :cait_id"
    set url_redirect "$url/iter/single-sign-on?id_utente=$cait_id&token_code=$token_code&caller=cait"
} else {
    set url_redirect "/iter-portal/iter-link"
};#rom01


set mode "display"

if {[string equal $mode "edit"]} {
    set page_title "Modifica Dati Registrati"
    set buttons [list [list "Modifica Dati Registrati" edit]]
    set field_mode display
} else {
    set page_title "Visualizza Dati Registrati"
    set buttons [list [list "OK" view]]
    set field_mode display
}

set user_id [auth::require_login] 

set context [list "Dati Registrati"]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	cait_id:key

	# Start section2
	{-section "sec2" {legendtext "Dati CAIT"} {fieldset {class legend}}}
        {name:text 
            {label {Ragione sociale}}
            {html {size 50 maxlength 200}}
        }
	{address1:text
	    {label {Indirizzo}}
	    {html {size 50 maxlength 200}}
	}
	{city:text
	    {label {Comune}}
	    {html {size 50 maxlength 40}}
	}
	{address2:text,optional 
	    {label {Località}}
	    {html {size 50 maxlength 40}}
	}
	{province:text
	    {label {Provincia}}
	    {html {size 5 maxlength 4}}
	}
	{zipcode:text
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
	}
	{email:email
	    {label Email}
	    {html {size 30}}
	}
	{phone:text
	    {label {Telefono}}
	}
	{fax:text,optional 
	    {label {Fax}}
	}
	{mobile:text,optional 
	    {label {Cellulare}}
	}
        {notes:text(textarea),optional,nospell 
            {label Note}
            {html {rows 5 cols 50 wrap soft}}
        }

        {representative_id:integer(hidden)}


	{-section ""}

    } -edit_request {

	db_1row get_maintainer "
        select *
        from iter_cait
        where cait_id = :cait_id"

    } -after_submit {


	ad_returnredirect servcait
	ad_script_abort
    }


