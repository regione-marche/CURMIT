ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: maintainers-list.tcl

    USER  DATA       MODIFICHE
    ===== ========== =================================================================================================
    sim01 21/06/2017 Gestito la possibilità che il programma venga chiamato come uno zoom

} {
    {search_name ""}
    {search_fiscal_code ""}
    {search_iva_code ""}
    {search_city ""}
    {search_province ""}
    {from_date ""}
    {to_date ""}
    {from_date_ansi ""}
    {to_date_ansi ""}
    {f_validated_p ""}
    {rows_per_page     30}
    {caller             ""}
    {fields_suffix ""}
    orderby:optional
    page:optional
}

set cait_id [auth::require_login]

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :cait_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}

set package_id [ad_conn package_id]

set page_title "Manutentori registrati"
set context [list "$page_title"]

# creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{search_name:text,optional
	    {label {Cerca ragione sociale }}
	    {html {length 20} }
	    {value $search_name}
	}
	{search_fiscal_code:text,optional
	    {label {Cerca codice fiscale }}
	    {html {length 20} }
	    {value $search_fiscal_code}
	}
	{search_iva_code:text,optional
	    {label {Cerca partita IVA }}
	    {html {length 20} }
	    {value $search_iva_code}
	}
	{search_city:text,optional
	    {label {Cerca Comune}}
	    {html {length 20} }
	    {value $search_city}
	}
	{search_province:text(select),optional
	    {options {{Tutte ""} [db_list_of_lists prov "select distinct province, province as dummy from iter_maintainers order by province"]}}
	    {label {Cerca provincia }}
	    {value $search_province}
	}

	{from_date:text,optional
	    {label {Da data registrazione}}
	    {html {length 20} }
	    {value $from_date}
	}
	{to_date:text,optional
	    {label {A data registrazione}}
	    {html {length 20} }
	    {value $to_date}
	}
	{f_validated_p:text(select),optional
	    {options {{Tutti ""} {Si t} {No f}}}
	    {label "Validato?"}
	    {value $f_validated_p}
	}
    } -on_request {

	if {$from_date eq ""} {
	    set from_date      "01/01/2008"
	    set from_date_ansi "2008-01-01"
	}

	if {$to_date eq ""} {
	    set to_date        [ah::today_pretty]
	    set to_date_ansi   [ah::today_ansi]
	}

    } -on_submit {

    set errnum 0

    set from_date_ansi [ah::check_date -ansi -input_date $from_date]
    if {$from_date_ansi == 0} {
        template::form::set_error filter from_date "Data inizio errata."
        incr errnum
    }
    set to_date_ansi [ah::check_date -ansi -input_date $to_date]
    if {$to_date_ansi == 0} {
	template::form::set_error filter to_date "Data fine errata."
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

    # recupero l'impostazione dei filtri non compresi nel form
    ah::set_list_filters iter-portal cait-maintainers-list

}


set actions ""

set javascript "
<script language=JavaScript>
  function sel(a,b) {
    try {
        window.opener.document.$caller.cod_manutentore${fields_suffix}.value = a;
    } catch (error) {
        // Tollero l'assenza di questo campo e proseguo
    }
    try {
        window.opener.document.$caller.cognome_manu${fields_suffix}.value = b;
    } catch (error) {
        // Tollero l'assenza di questo campo e proseguo
    }

    try {
      window.opener.document.$caller.cod_manutentore${fields_suffix}.focus();
      window.opener.document.$caller.cognome_manu${fields_suffix}.onchange();
    } catch (error) {
        //Qualcosa è andato male, procediamo ugualmente.
    }

    window.close();
  }
</script>";#sim01

#sim01 aggiunta variabile elements per poter inserire delle if
set elementes "";#sim01
if {$caller ne ""} {;#sim01
    append elements {
	sel {
	    display_template {@maintainers.sel;noquote@}
	    sub_class narrow
	}	
    }
}

append elements {
    edit {
	link_url_col edit_url
	display_template {<img src="/resources/acs-subsite/Edit16.gif" width="16" height="16" border="0">}
	link_html {title "Gestisci i dati del manutentore"}
	sub_class narrow
    }
    print {
	link_url_col prt_url
	display_template {<img src="/resources/acs-subsite/printer.gif" width="16" height="16" border="0">}
	link_html {title "Stampa Codice Manutentore"}
	sub_class narrow
    }
    unlink {
	link_url_col unlink_url
	display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	link_html {title "Scollega questo manutentore"}
	    sub_class narrow
    }
    iter_code {
	label "Codice Iter"
    }
    name {
	label "Ragione Sociale"
	display_template {<if @maintainers.status@ eq 1><font color="green">@maintainers.name@</font></if><if @maintainers.status@ eq 3><font color="blue">@maintainers.name@</font></if><if @maintainers.status@ eq 2><font color="yellow">@maintainers.name@</font></if><if @maintainers.status@ eq 4><font color="red">@maintainers.name@</font></if>}
    }
    creation_date {
	label "Data reg."
	display_col creation_date_pretty
    }
    city {
	label "Comune"
    }
	province {
	    label "Provincia"
            html {align center}
	}
    iva_code {
	label "Partita IVA"
    }
    wallet_id {
	label "Codice portafoglio"
    }
    phone {
	label "Telefono"
    }
}

template::list::create \
    -name maintainers \
    -multirow maintainers \
    -actions $actions \
    -page_flush_p t \
    -page_size $rows_per_page \
    -page_groupsize 10 \
    -page_query {
        select maintainer_id
        from iter_maintainers m
        where cait_id = :cait_id
        [template::list::filter_where_clauses -name maintainers -and]
        [template::list::orderby_clause -name maintainers -orderby]
    } \
    -key maintainer_id \
    -elements $elements \
    -orderby {
        default_value "name,desc"
        city {
	    label "Comune"
	    orderby_desc "m.city desc"
	    orderby_asc  "m.city"
            default_direction "asc"
	}
        province {
	    label "Provincia"
	    orderby_desc "m.province desc"
	    orderby_asc  "m.province"
            default_direction "asc"
	}
        name {
	    label "Ragione sociale"
	    orderby_desc "m.name desc"
	    orderby_asc  "m.name"
            default_direction "asc"
	}
        creation_date {
	    label "Data registrazione"
	    orderby_desc "m.creation_date desc"
	    orderby_asc  "m.creation_date"
            default_direction "desc"
	}

    } \
    -filters {
	search_name {
	    hide_p 1
	    where_clause {upper(m.name) like upper('%[db_quote $search_name]%')}
	}
	search_fiscal_code {
	    hide_p 1
	    where_clause {upper(m.fiscal_code) like upper('%$search_fiscal_code%')}
	}
	search_iva_code {
	    hide_p 1
	    where_clause {upper(m.iva_code) like upper('%$search_iva_code%')}
	}
	search_city {
	    hide_p 1
	    where_clause {upper(m.city) like upper('%$search_city%')}
	}
	search_province {
	    hide_p 1
	    where_clause {m.province = :search_province}
	}
        from_date {
            hide_p 1
            where_clause {m.creation_date >= :from_date_ansi}
        }
        to_date {
            hide_p 1
            where_clause {m.creation_date <= :to_date_ansi}
        }
        from_date_ansi {hide_p 1}
        to_date_ansi {hide_p 1}
        f_validated_p {
	    hide_p 1
	    where_clause {m.validated_p = :f_validated_p}
        }
        rows_per_page {
	    label "Righe per pagina"
	    values {{10 10} {30 30} {100 100}}
            default_value 30
        }
    } 

# eseguo la query solo in assenza di errori nei filtri del form
if {![info exists errnum]} {
    #sim01 aggiunto sel
    db_multirow -extend {edit_url unlink_url prt_url delete_url status sel} maintainers query "
        select
            maintainer_id
           ,iter_code as cod_manutentore --sim01
           ,m.name as cognome_manu       --sim01
           ,name
           ,to_char(m.creation_date, 'DD/MM/YYYY') as creation_date_pretty
           ,city
           ,province
           ,iva_code
           ,fiscal_code
           ,wallet_id
           ,phone
           ,validated_p 
           ,approved_p
           ,iter_code
        from iter_maintainers m
        where cait_id = :cait_id
        [template::list::page_where_clause -name maintainers -and]
        [template::list::orderby_clause -name maintainers -orderby]
    " {
	set edit_url   [export_vars -base "services" {maintainer_id}]
	set prt_url   [export_vars -base "../print-wallet-code" {maintainer_id}]
	set unlink_url [export_vars -base "unlink" {maintainer_id}]
	set delete_url [export_vars -base "maintainer-delete"   {maintainer_id}]
	set num_msg [iter::check_reg -maintainer_id $maintainer_id]
	if {$validated_p} {
	    set status "1"
	} elseif {[string equal $num_msg ""] && ![string equal $validated_p "t"] && [string equal $approved_p "t"]} {
	    set status "2"
	} elseif {[string equal $num_msg ""] && ![string equal $validated_p "t"] && ![string equal $approved_p "t"]} {
	    set status "3"
	} else {
	    set status "4"
	}

	set parametri "";#sim01
	append parametri "'$cod_manutentore'"                        ;#a sim01
	append parametri ",'[ah::js_quote_escape $cognome_manu]'"    ;#b sim01

	set sel "<a href=\"javascript:sel($parametri)\">Sel</a>";#sim01	
	
    }
} else {
    # creo una multirow fittizia 
    template::multirow create maintainers dummy
} 

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property iter-portal cait-maintainers-list [export_vars -entire_form -no_empty]
}
