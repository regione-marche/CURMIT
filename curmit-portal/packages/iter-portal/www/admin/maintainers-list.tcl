ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: maintainers-list.tcl

    USER  DATA       MODIFICHE
    ===== ========== =================================================================================================
    rom03 01/04/2026 FAtto in modo che la stampa dell'Anagrafica della ditta venga aperta in una nuova finestra.

    ric02 18/09/2025 Gestito javascript in funzione del caller per sviluppo punto 40 MEV REGIONE MARCHE: deleghe ditta di manutenzione.

    mat01 22/08/2025 Aggiunto l'attributo "alt" alle incone del modifica e dell'elimina nella lista. Tolto il tag <font>.
    mat01            e sostituito con <span>.
    mat01            Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)

    rom02 23/04/2025 Aggiunto link per resettare le password degli operatori da parte degli utenti amministratori.

    ric01 07/06/2024 Con la ricodifica psw non è più possibile rimandare la mail delle psw.

    rom01 25/11/2021 Su richiesta di Regione Basilicata ho reso la mail dei manutentori dei link in modo che cliccandoci
    rom01            sopra si possa inviare direttamente la mail.

    sim05 14/01/2019 Tutti gli enti devono avere la scelta delle tipologie impianto

    sim04 26/11/2019 La regione marche non può validare manualmente i manutentori

    gac01 19/02/2018 Aggiunto Tipologia Impianto alle azioni solo per regione Marche

    gab03 03/08/2017 Aggiunti i filtri search_iter_code e f_propagate_p

    gab02 07/06/2017 Corretta anomalia che si presentava quando si usa lo zoom e la ragione sociale del manutentore 
    gab02            ha un apice. 

    sim03 03/05/2017 Cambiato condizione per visualizzare il sel in modo che sia visibile per tutti i programmi che
    sim03            richiamano lo zoom.

    gab01 27/10/2016 Questo programma può essere chiamato anche come zoom dalla transactions-gest "inserimento movimento"
 
    sim02 27/09/2016 Aggiunto totale manutentori in cima alla lista

    sim01 20/07/2016 Non veniva passato nessun filtro al programma di estrazione.

} {
    {search_iter_code   ""}
    {search_name        ""}
    {search_fiscal_code ""}
    {search_iva_code    ""}
    {search_city        ""}
    {search_province    ""}
    {from_date          ""}
    {to_date            ""}
    {from_date_ansi     ""}
    {to_date_ansi       ""}
    {f_validated_p      ""}
    {f_is_active_p      ""}
    {f_propagate_p      ""}
    {rows_per_page      30}
    {caller             ""}
    {fields_suffix ""}

    orderby:optional
    page:optional
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set page_title "Manutentori registrati"
set context [list "$page_title"]

# creates filters form
#gab03 aggiunti i filtri search_iter_code e f_propagate_p
ad_form \
    -export {caller} \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{search_iter_code:text,optional
            {label {Cerca codice iter }}
            {html {length 20} }
            {value $search_iter_code}
        }
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
	{f_is_active_p:text(select),optional
	    {options {{Tutti ""} {S&igrave; t} {No f}}}
	    {label "Attivo?"}
	    {value $f_is_active_p}
	}
        {f_propagate_p:text(select),optional
            {options {{Tutti ""} {Si t} {No f}}}
            {label "Da Propagare?"}
            {value $f_propagate_p}
        }
    } -on_request {

	if {$from_date eq ""} {
	    set from_date      "01/04/2012"
	    set from_date_ansi "2012-04-01"
	}

	if {$to_date eq ""} {
	    set to_date        [ah::today_pretty]
	    set to_date_ansi   [ah::today_ansi]
	}

    } -on_submit {

    set errnum 0

    if {$from_date eq ""} {
	set from_date      "01/04/2012"
    }
    
    if {$to_date eq ""} {
	set to_date       "01/01/2100"
    }

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
 
    #gab01
    # è stato aggiunto il comando with_catch error_msg perchè quando il programma viene chiamato come uno zoom dalla 
    # transactions-gest oppure da coimplic-filter e riceve come search_name un valore con la & commerciale va in errore 
    # cliccando il tasto Go.
    with_catch error_msg {;#gab01
	ah::set_list_filters iter-portal maintainers-list
    } {
    }

}

#gab03 aggiunti i filtri search_iter_code e f_propagate_p
set link_scar [export_url_vars search_iter_code search_name search_fiscal_code search_iva_code search_city search_province from_date to_date from_date_ansi to_date_ansi f_validated_p f_is_active_p f_propagate_p];#sim01

#sim01 set actions {"Estrai CSV Manutentori" maintainers-csv "Estrai in CSV la lista dei manutentori selezionati}"
set actions [list \
		 "Estrai CSV Manutentori" maintainers-csv?$link_scar "Estrai in CSV la lista dei manutentori selezionati" \
		];#sim01

if {[string match "*iter-portal-marche*" [db_get_database]]} {#sim04 if e suo contenuto
    set bulk_actions {}
} else {#sim04 
set bulk_actions {"Convalida" validate "Convalida i manutentori selezionati"}
};#sim04

#gab01
set javascript "
<script language=JavaScript>
  function sel(a,b,c) {
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
        window.opener.document.$caller.manutentore${fields_suffix}.value = c;
    } catch (error) {
        // Tollero l'assenza di questo campo e proseguo
    }


    try {
      window.opener.document.$caller.cod_manutentore${fields_suffix}.focus();
      window.opener.document.$caller.cognome_manu${fields_suffix}.onchange();
      window.opener.document.$caller.manutentore${fields_suffix}.onchange();
    } catch (error) {
        //Qualcosa è andato male, procediamo ugualmente.
    }

    window.close();
  }
</script>"

if {$caller eq "maintdeleg"} {#ric02 aggiunta if e contenuto
    set caller "addedit"
    set javascript "
<script language=JavaScript>
  function sel(a,b,c) {
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
        window.opener.document.$caller.manutentore${fields_suffix}.value = c;
    } catch (error) {
        // Tollero l'assenza di questo campo e proseguo
    }


    try {
      window.opener.document.$caller.cod_manutentore${fields_suffix}.focus();
      window.opener.document.$caller.cognome_manu${fields_suffix}.onchange();
      window.opener.document.$caller.manutentore${fields_suffix}.onchange();
    } catch (error) {
        //Qualcosa è andato male, procediamo ugualmente.
    }

    window.close();
  }
</script>"
}

set where_delegato "";#ric02
if {$caller eq "operatordeleg"} {#ric02 aggiunta if e contenuto
    set caller "addedit"
    #I ruoli 0 e 2 sono INSTALLATORI o INSTALLATORI/MANUTENTORI
    set where_delegato " and role in ('0','2')"
    set javascript "
<script language=JavaScript>
  function sel(a,b,c) {
    try {
        window.opener.document.$caller.cod_delegato${fields_suffix}.value = a;
    } catch (error) {
        // Tollero l'assenza di questo campo e proseguo
    }
    try {
        window.opener.document.$caller.cognome_delegato${fields_suffix}.value = b;
    } catch (error) {
        // Tollero l'assenza di questo campo e proseguo
    }
    try {
        window.opener.document.$caller.delegato${fields_suffix}.value = c;
    } catch (error) {
        // Tollero l'assenza di questo campo e proseguo
    }


    try {
      window.opener.document.$caller.cod_manutentore${fields_suffix}.focus();
      window.opener.document.$caller.cognome_manu${fields_suffix}.onchange();
      window.opener.document.$caller.manutentore${fields_suffix}.onchange();
    } catch (error) {
        //Qualcosa è andato male, procediamo ugualmente.
    }

    window.close();
  }
</script>"

}
#gac01 aggiunta if e suo contenuto
set db_name [db_get_database];#gac01
#sim05 if {[string match "*iter-portal-marche*" $db_name]} {#gac01
    set tipologia_impianti "<a href=\"maintainer-installations-list?maintainer_id=@maintainers.maintainer_id@\">Tipologia Impianto</a>"
#sim05} else {
#sim05    set tipologia_impianti ""
#sim05}

#gab01 aggiunta variabile elements per poter inserire delle if
set elementes ""
#sim03 if {$caller eq "transactions" || $caller eq "coimplic"} {}#gab01 aggiunta if e suo contenuto
if {$caller ne ""} {;#sim03
    append elements {
	sel {
	    display_template {@maintainers.sel;noquote@}
	    sub_class narrow
	}	
    }
}

#mat01 aggiunto a edit e delete l'attributo alt, nel loro display template
#mat01 sostituito i tag font in "name" con i tag span per usare i diversi colori
#ric01 tolto dalle azioni link <a href="send-mail-ma?maintainer_id=@maintainers.maintainer_id@&cait_id=@maintainers.cait_id@">Mail</a><br>
#gac01 aggiunto Tipologia Impianto alle azioni
#rom01 Aggiunto il display_template e contenuto al campo email
append elements {
    edit {
	link_url_col edit_url
	display_template {<img src="/resources/acs-subsite/Edit16.gif" alt="Modifica manutentore" width="16" height="16" border="0">}
	link_html {title "Modifica manutentore"}
	sub_class narrow
    }
    iter_code {
	label "Codice Iter"
    }
    name {
	label "Ragione Sociale"
	display_template {
	    <if @maintainers.validated_p@ true and @maintainers.iter_code@ not nil><span style="color:green">@maintainers.name@</span></if>
	    <if @maintainers.validated_p@ true and @maintainers.iter_code@ nil><span style="color:blue">@maintainers.name@</span></if>
	    <if @maintainers.validated_p@ false><span style="color:red">@maintainers.name@</span></if>
	}
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
    phone {
	label "Telefono"
    }
    email {
	label "E-mail"
      display_template {<a href="mailto:@maintainers.email@">@maintainers.email@</a>}
    }
    azioni {
	label "Azioni"
	display_template {<a href="operators-list?maintainer_id=@maintainers.maintainer_id@">Operatori</a><br> <a href="tools-list?maintainer_id=@maintainers.maintainer_id@&type=0">Analizzatori</a><br> <a href="tools-list?maintainer_id=@maintainers.maintainer_id@&type=1">Deprimometri</a><br> <a href="/iter-portal/bollini/maintainer-print?maintainer_id=@maintainers.maintainer_id@" target="maintainer-print">Stampa Anagrafica</a><br> $tipologia_impianti<br> <a href="/user/password-reset?password_hash=@maintainers.pswd_maintainer@&user_id=@maintainers.maintainer_id@&caller_admin=t" target="reset">Reset password</a>}
	html "align left nowrap"
    }
    delete {
	link_url_col delete_url 
	link_html {title "Cancella il manutentore" onClick "return(confirm('Confermi la cancellazione?'));"}
	display_template {<img src="/resources/acs-subsite/Delete16.gif" alt="Cancella manutentore" width="16" height="16" border="0">}
	sub_class narrow
    }
}

#gab03 aggiunto ai filters search_iter_code e f_propagate_p
template::list::create \
    -name maintainers \
    -multirow maintainers \
    -actions $actions \
    -bulk_actions $bulk_actions \
    -page_flush_p t \
    -page_size $rows_per_page \
    -page_groupsize 10 \
    -page_query {
        select maintainer_id
        from iter_maintainers m
        where 1 = 1
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
	search_iter_code {
            hide_p 1
            where_clause {upper(m.iter_code) like upper('%$search_iter_code%')}
        }
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
	    where_clause {upper(m.city) like upper('%[db_quote $search_city]%')}
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
        f_is_active_p {
	    hide_p 1
	    where_clause {m.is_active_p = :f_is_active_p}
        }
	f_propagate_p {
	    hide_p 1
            where_clause {(case when m.validated_p='t' and iter_code is null then 't' else 'f' end) = :f_propagate_p}
	    }
        caller {hide_p 1}
        rows_per_page {
	    label "Righe per pagina"
	    values {{10 10} {30 30} {100 100}}
            default_value 30
        }
    } 


set tot_manu [db_string query "select count(*) from iter_maintainers"];#sim02

# eseguo la query solo in assenza di errori nei filtri del form
if {![info exists errnum]} {

    db_multirow -extend {edit_url ec_url delete_url sel} maintainers query "
        select
            maintainer_id
           ,iter_code as cod_manutentore --gab01
           ,m.name as cognome_manu --gab01
           ,m.name
           ,iter_code as cod_delegato --ric02
           ,m.name as cognome_delegato --ric02
           ,to_char(m.creation_date, 'DD/MM/YYYY') as creation_date_pretty
           ,m.city
           ,m.province
           ,m.iva_code
           ,m.fiscal_code
           ,m.wallet_id
           ,m.phone
           ,m.validated_p 
           ,m.email
           ,m.cait_id
           ,m.iter_code
           ,c.email as cait_mail
           ,u.password as pswd_maintainer --rom01
        from iter_maintainers m
        left outer join iter_cait c on c.cait_id = m.cait_id
           , users u --rom02
       where 1 = 1
         and u.user_id = m.maintainer_id --rom02
         $where_delegato --ric02
        [template::list::page_where_clause -name maintainers -and]
        [template::list::orderby_clause -name maintainers -orderby]
    " {
	set edit_url   [export_vars -base "maintainer-edit?caller=$caller" {maintainer_id}];#gab01 passo il caller alla gestione
	set ec_url     [export_vars -base "../ec" {maintainer_id}]
	set delete_url [export_vars -base "maintainer-delete"   {maintainer_id}]
     
        set parametri ""
	append parametri "'$cod_manutentore'"                        ;#a
	#gab02 uso la proc ah::js_quote_escape
	append parametri ",'[ah::js_quote_escape $cognome_manu]'"    ;#b

	append parametri ",'[ah::js_quote_escape $cognome_manu]'"    ;#c

	set sel "<a href=\"javascript:sel($parametri)\">Sel</a>"	
	
	if {$where_delegato ne ""} {#ric02 aggiunta if e contenuto
	    set parametri_del ""
	    append parametri_del "'$cod_delegato'"                        ;#a
	    
	    append parametri_del ",'[ah::js_quote_escape $cognome_delegato]'"    ;#b
	    
	    append parametri_del ",'[ah::js_quote_escape $cognome_delegato]'"    ;#c

	    set sel "<a href=\"javascript:sel($parametri_del)\">Sel</a>"	
	}
	

    }
} else {
    # creo una multirow fittizia 
    template::multirow create maintainers dummy
} 

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property iter-portal maintainers-list [export_vars -entire_form -no_empty]
}

