ad_page_contract {

    @author Claudio Pasolini
    
    USER   DATA       COMMENTO
    ===== ========== ===================================================================================================
    mat01 22/08/2025 Aggiunto l'attributo alt al delete nella lista.
    mat01            Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)
    
} {
    group_id
}

set user_id    [ad_conn user_id]

set group_name [db_string query "select group_name from groups where group_id=:group_id"]
set page_title "Ispettori incaricati da $group_name"
set context [list [list services {Servizi}]  "$page_title"]

# prepare actions buttons
set actions " {Aggiungi ispettore} inspector-add?group_id=$group_id {Aggiungi un ispettore a questo Ente} "

#mat01 aggiunto attributo alt all'immagine del delete
template::list::create \
    -name inspectors \
    -multirow inspectors \
    -actions $actions \
    -elements {
	first_name {
	    label "Nome"
	}
	name {
	    label "Cognome"
	}
	email {
	    label "Email"
	}
	company_name {
	    label "Az. Ispezione"
	}
	is_active_p {
	    label "Attivo"
	}
	delete {
	    link_url_col delete_url 
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" alt="Rimuovi ispettore" width="16" height="16" border="0">}
	    link_html {title "Rimuovi questo ispettore" onClick "return(confirm('Confermi la rimozione?'));"}
	    sub_class narrow
	}
    }

db_multirow -extend {delete_url} inspectors query "
    select i.first_name, i.name, i.email, c.name as company_name,
           case 
             when m.is_active_p = 't' then 'Si'
             else 'No'
           end as is_active_p,
           m.map_id 
    from iter_bodies_inspectors_map m left outer join iter_inspecting_companies c
                                      on m.company_id   = c.company_id, 
         iter_inspectors i
    where m.body_id      = :group_id
      and m.inspector_id = i.inspector_id
    " {
	set delete_url [export_vars -base "inspector-delete"  {group_id map_id}]
    }


