ad_page_contract {

    @author Riccardo Vesentini
    @cvs-id $Id: maintainer-delegations-list.tcl

    USER  DATA       MODIFICHE
    ===== ========== =================================================================================================

} {
    {search_delegation_id ""}
    
    {search_maintainer   ""}
    {search_delegato     ""}
    
    {search_delegation_state ""}
    
    {rows_per_page      30}
    {caller             ""}
    {fields_suffix ""}

    {format "normal"}
    
    orderby:optional
    page:optional
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set page_title "Lista deleghe"
set context [list "$page_title"]

# creates filters form
ad_form \
    -export {caller} \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{search_maintainer:text,optional
	    {label {Ditta delegata alla prima accensione (CAT)}}
	    {html {length 20} }
	    {value $search_maintainer}
	}
	{search_delegato:text,optional
	    {label {Ditta di installazione delegante}}
	    {html {length 20} }
	    {value $search_delegato}
	}
	{search_delegation_state:text(select),optional
	    {label {Stato delega}}
	    {options {{Tutti ""} {Attiva A} {Disattiva D}}}
	    {value $search_delegation_state}
	}
	{search_delegation_id:text(hidden),optional}
    } -on_request {

    } -on_submit {

    set errnum 0

    if {$errnum > 0} {
	break
    } else {
	# per evitare errori nell'esecuzione della query la eseguirò solo se 'errnum' non esiste
	unset errnum
        # imposto flag per sapere se il form è stato inviato
	set submit_p 1
    }

    # recupero l'impostazione dei filtri non compresi nel form
    # è stato aggiunto il comando with_catch error_msg perchè quando il programma viene chiamato come uno zoom dalla 
    # transactions-gest oppure da coimplic-filter e riceve come search_name un valore con la & commerciale va in errore 
    # cliccando il tasto Go.
    with_catch error_msg {
	ah::set_list_filters iter-portal maintainer-delegations-list
    } {
    }

}

#set link_scar [export_url_vars search_maintainer search_delegato search_delegation_state]
#		 "Estrai CSV deleghe" maintainer-delegations-csv?$link_scar "Estrai in CSV la lista delle deleghe selezionate" 
set csv_url [export_vars -base [ad_conn url] -entire_form -no_empty {{rows_per_page 99999999} {format csv}}]
set actions [list \
		 "Estrai CSV deleghe" $csv_url                              "Estrai in CSV la lista delle deleghe selezionate" \
		 "Nuova delega"       maintainer-delegation-add-edit        "Crea nuova delega" \
		]

set formats {

    normal {
	label "Video"
	layout table
	row {
	    edit {}
	    ditta_manutenzione {}
	    installatore_delegato {}
	    start_date {}
	    end_date {}
	    delegation_state {}
	    delete {}
	}
    }

    csv {
	label "Estrai csv"
	output csv
	row {
	    ditta_manutenzione {}
	    installatore_delegato {}
	    start_date {}
	    end_date {}
	    delegation_state {}
	}
    }
}


set elementes ""
append elements {
    edit {
	link_url_col edit_url
	display_template {<img src="/resources/acs-subsite/Edit16.gif" alt="Modifica delega" width="16" height="16" border="0">}
	link_html {title "Modifica delega"}
	sub_class narrow
    }
    ditta_manutenzione {
	label "Ditta delegata alla prima accensione (CAT)"
    }
    installatore_delegato {
	label "Ditta di installazione delegante"
    }
    start_date {
	label "Data inizio"
	display_col start_date_pretty
    }
    end_date {
	label "Data fine"
	display_col end_date_pretty
    }
    delegation_state {
	label "Stato delega"
	html {align center}
	display_template {
	    <table width="100%" height="100%" border=1 cellpadding=0 cellspacing=0 style="background-color:@maintainer_delegations.background_color@;"><tr><td><font color=@maintainer_delegations.font_color@>@maintainer_delegations.delegation_state_pretty@</font></td></tr></table>
	}
	sub_class narrow
    }
    delete {
	link_url_col delete_url 
	link_html {title "Cancella il manutentore" onClick "return(confirm('Confermi la cancellazione?'));"}
	display_template {<img src="/resources/acs-subsite/Delete16.gif" alt="Cancella manutentore" width="16" height="16" border="0">}
	sub_class narrow
    }
}

template::list::create \
    -name maintainer_delegations \
    -multirow maintainer_delegations \
    -actions $actions \
    -page_flush_p t \
    -page_size $rows_per_page \
    -page_groupsize 10 \
    -page_query {
        select delegation_id
	  from iter_maintainer_delegations d
	     , iter_maintainers m
 	     , iter_maintainers o
	 where d.maintainer_id = m.maintainer_id
	   and d.delegato_id   = o.maintainer_id
	[template::list::filter_where_clauses -name maintainer_delegations -and]
        [template::list::orderby_clause -name maintainer_delegations -orderby]
    } \
    -key delegation_id \
    -selected_format $format \
    -elements $elements \
    -formats $formats \
    -filters {
	search_maintainer {
	    hide_p 1
	    where_clause {upper(m.name) like upper('%[db_quote $search_maintainer]%')}
	}
	search_delegato {
	    hide_p 1
	    where_clause {upper(o.name) like upper('%[db_quote $search_delegato]%')}
	}
	search_delegation_state {
	    hide_p 1
	    where_clause {d.delegation_state = :search_delegation_state}
	}
        rows_per_page {
	    label "Righe per pagina"
	    values {{10 10} {30 30} {100 100}}
            default_value 30
        }
    } 

# eseguo la query solo in assenza di errori nei filtri del form
if {![info exists errnum]} {

    db_multirow -extend {edit_url delete_url background_color font_color} maintainer_delegations query "
        select delegation_id

             -- ditta delegante
             , d.maintainer_id    
             , m.iter_code as cod_ditta
             , m.name as ditta_manutenzione

             -- ditta installazione delegata
             , d.delegato_id      
             , o.iter_code as cod_installatore
             , o.name as installatore_delegato
             
             , start_date       
             , to_char(start_date, 'DD/MM/YYYY') as start_date_pretty
             , end_date         
             , to_char(end_date , 'DD/MM/YYYY') as end_date_pretty
             , case d.delegation_state
               when 'D' then 'Disattiva'
               when 'A' then 'Attiva'
                end as delegation_state_pretty
             , delegation_state 
             , d.creation_date    
             , d.creation_user    
             , d.edit_date        
             , d.edit_user   
          from iter_maintainer_delegations d
             , iter_maintainers m
             , iter_maintainers o
         where d.maintainer_id = m.maintainer_id
           and d.delegato_id   = o.maintainer_id 
        [template::list::page_where_clause -name maintainer_delegations -and]
        [template::list::orderby_clause -name maintainer_delegations -orderby]
    " {
	set edit_url   [export_vars -base "maintainer-delegation-add-edit" {delegation_id}]
	set delete_url [export_vars -base "maintainer-delegation-delete"   {delegation_id}]

	set font_color "black"
	switch $delegation_state {
	    "A" {
		set font_color "white"
		set background_color "green"}
	    "D" {
		set background_color "red"
		set font_color "black"}
	}

    }
} else {
    # creo una multirow fittizia 
    template::multirow create maintainer_delegations dummy
} 

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property iter-portal maintainer-delegations-list [export_vars -entire_form -no_empty]
}

if {$format eq "csv"} {
    template::list::write_csv -name maintainer_delegations
    ad_script_abort
}
