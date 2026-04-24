ad_page_contract {

    Accesso al programma iter riservato a mnutentori, amministratori di condominio, CAIT,
    Studi associati, Aziende di ispezione e Ispettori registrati e validati.

    @author Claudio Pasolini
    @cvs-id $Id: iter-link.tcl

    USER   DATA         MODIFICHE
    =====  ==========  ======================================================================
    gab01  17/04/2018  Per il portale della regione marche tolgo dai link il prefisso http://
    

} {
}

# originalmente l'accesso era riservato ai manutentori, ma ora è possibile anche per gli amministratori,
# CAIT, Studi associati, aziende di ispezione e Ispettori
set party_id [auth::require_login]

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
                 -no_login \
                 -object_id [ad_conn package_id] \
                 -privilege admin
	    ]

if {$admin_p} {
    # si tratta di un amministrazione
    set party_type ""
} else {
    if {![db_0or1row check_maint "select validated_p, 'maintainer' as party_type from iter_maintainers where maintainer_id = :party_id"]} {
	if {![db_0or1row check_trustee "select validated_p, 'trustee' as party_type from iter_trustees where trustee_id = :party_id"]} {
	    if {![db_0or1row check_cait "select 1 as validated_p, 'cait' as party_type from iter_cait where cait_id = :party_id"]} {
		if {![db_0or1row check_trustee "select 1 as validated_p, 'office' as party_type from iter_offices where office_id = :party_id"]} {
		    if {![db_0or1row check_trustee "select 1 as validated_p, 'company' as party_type from iter_inspecting_companies where company_id = :party_id"]} {
			if {![db_0or1row check_trustee "select validated_p, 'inspector' as party_type from iter_inspectors where inspector_id = :party_id"]} {
			    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai soggetti registrati." /
			    ad_script_abort
			}
		    }
		}
	    }
	}
    }

    if {!$validated_p} {
	ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai soggetti validati." /
	ad_script_abort
    }
}

set db_name [db_get_database];#gab01

if {[string match "*iter-portal-marche*" $db_name]} {
    set page_title "Accesso al programma CURMIT"
    set context [list "Accesso ad CURMIT"]
} else {
    set page_title "Accesso al programma"
    set context [list "Accesso ad I.Ter"]
}

# trovo il subsite
array set arr [site_node::get_from_url -url /]
set context_id $arr(package_id)

# ottengo il gruppo a cui appartengono, con relazione di
# composizione, tutti gli altri gruppi 
set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]

# ai fini della demo imposto una url fissa per tutti
db_multirow instances query "
    select g.group_name, 
           p.url,
           i.instance_name
    from acs_rels r, groups g, parties p, iter_instances i
    where r.rel_type='composition_rel' and 
          r.object_id_one = :subsite_group_id and 
          r.object_id_two = g.group_id and
          g.group_id      = p.party_id and
          g.group_id      = i.instance_id
    order by group_name" 

