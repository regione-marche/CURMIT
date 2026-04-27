ad_page_contract {

    @author Riccardo Vesentini
    @cvs-id $Id: delegations-list.tcl

    USER  DATA       MODIFICHE
    ===== ========== =================================================================================================

} {
    {search_manu     ""}
    
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
	{search_manu:text,optional
	    {label {Ditta delegata alla prima accensione (CAT)}}
	    {html {length 20} }
	    {value $search_manu}
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

set csv_url [export_vars -base [ad_conn url] -entire_form -no_empty {{rows_per_page 99999999} {format csv}}]
set actions [list \
		 "Estrai CSV deleghe"   $csv_url   "Estrai in CSV la lista delle deleghe selezionate" \
		]

set formats {

    normal {
	label "Video"
	layout table
	row {
	    manutentore_delegante {}
	    start_date {}
	    end_date {}
	    delegation_state {}
	}
    }

    csv {
	label "Estrai csv"
	output csv
	row {
	    manutentore_delegante {}
	    start_date {}
	    end_date {}
	    delegation_state {}
	}
    }
}

set elementes ""
append elements {
    manutentore_delegante {
	label "Ditta delegata alla prima accensione (CAT)"
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
	    <table width="100%" height="100%" border=1 cellpadding=0 cellspacing=0 style="background-color:@delegations_list.background_color@;"><tr><td><font color=@delegations_list.font_color@>@delegations_list.delegation_state_pretty@</font></td></tr></table>
	}
	sub_class narrow
    }
}

template::list::create \
    -name delegations_list \
    -multirow delegations_list \
    -actions $actions \
    -page_flush_p t \
    -page_size $rows_per_page \
    -page_groupsize 10 \
    -page_query {
        select delegation_id
	  from iter_maintainer_delegations d
	     , iter_maintainers o
	 where d.maintainer_id = o.maintainer_id
	   and d.delegato_id   = :user_id
	[template::list::filter_where_clauses -name delegations_list -and]
        [template::list::orderby_clause -name delegations_list -orderby]
    } \
    -key delegation_id \
    -selected_format $format \
    -elements $elements \
    -formats $formats \
    -filters {
	search_manu {
	    hide_p 1
	    where_clause {upper(o.name) like upper('%[db_quote $search_manu]%')}
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

    db_multirow -extend {edit_url delete_url background_color font_color} delegations_list query "
        select delegation_id

            -- ditta installazione delegata
             , d.delegato_id      
             , o.iter_code as cod_manu
             , o.name as manutentore_delegante
             
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
             , iter_maintainers o
         where d.maintainer_id = o.maintainer_id 
           and d.delegato_id   = :user_id
        [template::list::page_where_clause -name delegations_list -and]
        [template::list::orderby_clause -name delegations_list -orderby]
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
    template::multirow create delegations_list dummy
} 

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property iter-portal maintainer-delegations-list [export_vars -entire_form -no_empty]
}

if {$format eq "csv"} {
    template::list::write_csv -name delegations_list
    ad_script_abort
}
