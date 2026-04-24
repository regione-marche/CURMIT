ad_page_contract {

    @author Claudio Pasolini
    
    USER  DATA       MODIFICHE
    ===== ========== =================================================================================================
    mat01 22/08/2025 Aggiunto l'attributo "alt" all'incona del modifica nella lista.
    mat01            Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)
} {
}

set user_id    [ad_conn user_id]

set page_title "Lista Enti"
set context [list "$page_title"]

# prepare actions buttons
set actions { "Aggiungi Ente" group-add-edit "Aggiungi un nuovo Ente" }
#mat01 aggiunto all'immagine di edit l'attributo alt
template::list::create \
    -name groups \
    -multirow groups \
    -actions $actions \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" alt="Modifica ente" width="16" height="16" border="0">}
	    link_html {title "Modifica Ente"}
	    sub_class narrow
	}
	group_name {
	    label "Nome Ente"
	}
	email {
	    label "Email"
	}
	url {
	    label "Url"
	}
	instance_name  {
	    label "Istanza ITER"
	}
	members {
	    link_url_col members_url 
            link_html {title "Visualizza i membri di questo Ente"}
	    display_template {Membri}
	}
	inspectors {
	    link_url_col inspectors_url 
            link_html {title "Visualizza gli Ispettori incaricati da questo Ente"}
	    display_template {Ispettori}
	}
    }


# trovo il subsite
array set arr [site_node::get_from_url -url /]
set context_id $arr(package_id)

# ottengo il gruppo a cui appartengono, con relazione di
# composizione, tutti gli altri gruppi 
set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]


db_multirow -extend {edit_url members_url inspectors_url} groups query "
    select g.group_id, 
           g.group_name, 
           p.email,
           p.url,
           i.instance_name
    from acs_rels r, groups g, parties p, iter_instances i
    where r.rel_type='composition_rel' and 
          r.object_id_one = :subsite_group_id and 
          r.object_id_two = g.group_id and
          g.group_id      = p.party_id and
          g.group_id      = i.instance_id
    order by group_name
    " {
	set edit_url       [export_vars -base "group-add-edit" {group_id}]
	set members_url    [export_vars -base "group-members-list" {group_id}]
	set inspectors_url [export_vars -base "../bodies/group-inspectors-list" {group_id}]
    }


