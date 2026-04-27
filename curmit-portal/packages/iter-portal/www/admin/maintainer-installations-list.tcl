ad_page_contract {

    @author         Gacalin Lufi
    @creation_date  19/02/2018
    
    USER  DATA       MODIFICHE
    ===== ========== ===============================================================================================
    mat01 22/08/2025 Aggiunto l'attributo "alt" all'incona del delete.
    mat01            Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)
} {
    maintainer_id
}

set user_id    [ad_conn user_id]

set page_title "Lista Tipologie Impianto associate al manutentore"
set context [list "$page_title"]

# prepare actions buttons
set actions " {Aggiungi Tipologia Impianto} maintainer-installations-add?maintainer_id=$maintainer_id {Aggiungi un Tipologia a questo manutentore} "

#mat01 aggiunto l'attributo alt all'immagine del delete
template::list::create \
    -name maintainer \
    -multirow maintainer \
    -actions $actions \
    -elements {
	installation_type_description {
	    label "Tipologia Impianto"
	}
	delete {
	    link_url_col delete_url 
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0" alt="Cancella tipologia impianto">}
	    link_html {title "Rimuovi questa Tipologia Impianto" onClick "return(confirm('Confermi la rimozione?'));"}
	    sub_class narrow
	}
    }

db_multirow -extend {delete_url} maintainer query "
    select a.maintainer_installations_id
         , a.maintainer_id
         , a.installation_type_id
         , b.installation_type_description
      from iter_maintainer_installations a 
         , iter_installation_types b
     where a.installation_type_id = b.installation_type_id
       and a.maintainer_id = :maintainer_id
    " {
	set delete_url   [export_vars -base "maintainer-installations-delete"  {maintainer_id maintainer_installations_id}]
    }


