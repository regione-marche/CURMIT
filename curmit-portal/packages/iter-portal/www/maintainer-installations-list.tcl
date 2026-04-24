ad_page_contract {

    @author         Gacalin Lufi
    @creation_date  19/02/2018
    
    USER  DATA       MODIFICHE
    ===== ========== ===============================================================================================
    mat01 03/09/2025 Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)
    mat01            Aggiunto l'attributo "alt" all'icona del modifica.
} {

}

set maintainer_id [iter::script_init]
if {[string equal $maintainer_id "0"]} {
    ad_returnredirect services
}

db_1row query "select name as maintainer_name
                    , validated_p
                    , approved_p 
                 from iter_maintainers 
                where maintainer_id = :maintainer_id"

set num_msg [iter::check_reg -maintainer_id $maintainer_id]
if {[string equal $num_msg ""] && ![string equal $validated_p "t"]} {
    set to_approve_p "t"
} else {
    set to_approve_p "f"
}

set reg_msg [iter::get_reg_msg -validated_p $validated_p -approved_p $approved_p -num_msg $num_msg]

set page_title "Lista Tipologie Impianto associate al manutentore"
set context [list "$page_title"]

# prepare actions buttons
set actions " {Aggiungi Tipologia Impianto} maintainer-installations-add?maintainer_id=$maintainer_id {Aggiungi un Tipologia a questo manutentore} "

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
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" alt="Rimuovi questa Tipologia Impianto" width="16" height="16" border="0">}
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


