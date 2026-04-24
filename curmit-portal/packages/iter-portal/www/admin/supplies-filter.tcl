ad_page_contract {

    Lista forniture

    @author 
    @cvs-id $Id: supplies-filter.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    mat01 05/11/2025 Aggiunto nella scelta dell'ente competente una condizione affinchè compaiano
    mat01            solo gli enti a cui lo user è associato. Per indicazione di sandro copio
    mat01            la logica del programma transactions-filter.tcl
} {
    {f_name_distributor ""}
    {f_comune      ""}
    {f_combustibile      ""}
    {f_competente        ""}
    {f_anno_rif          ""}
    {format         "normal"}
    {rows_per_page  "30"}
    {offset         "0"}

    orderby:optional
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set page_title "Filtri elenco forniture"
set context [list  "$page_title"]

db_list query " select anno_rif
                     , name
                     , comune_nome
                     , combustibile_tipo
                  from iter_supplies_sync s
                     , iter_distributors d
                where d.distributor_id  = s.distributor_id"


set istanze_limitate [list];#mat01
set istanze_limitate [db_list q "select instance_name
                                       from mpay_enti_portafogli_abilitati a
                                          , users b
                                      where a.username = b.username
                                        and b.user_id  = :user_id"];#mat01
if {[llength $istanze_limitate]>0} {#mat01 if else e loro contenuto
    set where_istanze "and i.instance_name in ('[join $istanze_limitate ',']')"
} else {
    set where_istanze ""
}
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{f_anno_rif:text
	    {label {Anno}}
	    {value $f_anno_rif}
	}
	{f_name_distributor:text,optional
	    {label {Distributore}}
	    {value $f_name_distributor}
	}
	{f_comune:text,optional
	    {label {Comune}}
	    {value $f_comune}
	}
	    {f_combustibile:text(select),optional
	     {options { {"Scegli" ""} [db_list_of_lists q "
                                        select tipo_combustibile
                                              , codice_combustibile
                                         from iter_combustibili"]}}
		 {label {Combustibile}}
		    {value $f_combustibile}
	    }
	{f_competente:text(select)
	    {options { {"Scegli" ""} [db_list_of_lists query "
             select g.group_name, i.instance_name
              from groups g, iter_instances i
             where g.group_id = i.instance_id
                 $where_istanze  --mat01
            "] }}
		{label {Autorità competente}}
		{value $f_competente}
	    }
	    
    } -on_request {

    } -on_submit {

	set errnum 0
      	if {$f_competente eq ""} {
	    template::form::set_error filter f_competente "selezionare Autorità competente"
	    incr errnum
	}

	if {$errnum > 0} {
	    break
	} else {
	    # per evitare errori nell'esecuzione della query la eseguirò solo se 'errnum' non esiste
	    unset errnum
	    # imposto flag per sapere se il form è stato inviato
	    set submit_p 1
	}

    } -after_submit {
  
        	
	set link_gest [export_url_vars f_anno_rif f_name_distributor f_comune  f_combustibile f_competente]
	set return_url "distr-attachments?$link_gest"
	ad_returnredirect $return_url
	ad_script_abort


    }

