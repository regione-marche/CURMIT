ad_page_contract {
    Permette di assumere le veci di un altro soggetto.

    @author Claudio Pasolini

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom01 22/11/2021 Aggiunto il login come software-house.

    nic01 13/06/2016 D'accordo con Sandro, visto che la query e l'impersona per gli utenti di
    nic01            tipo Ente non funzionano correttamente, li togliamo.

} {
}

set page_title "Scelta utente"
set context [list "$page_title"]

template::multirow create users user_id name type

if {[db_0or1row maint "select maintainer_id, name from iter_maintainers where validated_p = true and email='xxxxxx' limit 1"]} {
    template::multirow append users $maintainer_id $name Manutentore
} else {

    if {[db_0or1row maint "select maintainer_id, name from iter_maintainers where validated_p = true limit 1"]} {
	template::multirow append users $maintainer_id $name Manutentore
    }

}

if {[db_0or1row company "select company_id, name from iter_inspecting_companies limit 1"]} {
    template::multirow append users $company_id $name "Az. ispezione"
}

if {[db_0or1row insp "select inspector_id, name from iter_inspectors where company_id is null limit 1"]} {
    template::multirow append users $inspector_id $name Ispettore
}

if {[db_0or1row insp2 "select inspector_id, name from iter_inspectors where company_id is not null limit 1"]} {
    template::multirow append users $inspector_id $name "Ispettore dipendente"
}

if {[db_0or1row dist "select distributor_id, name from iter_distributors limit 1"]} {
    template::multirow append users $distributor_id $name Distributore
}

if {[db_0or1row trust "select trustee_id, name from iter_trustees where validated_p = true limit 1"]} {
    template::multirow append users $trustee_id $name "Amm. condominio"
}

if {[db_0or1row office "select office_id, name from iter_offices limit 1"]} {
    template::multirow append users $office_id $name "Studio associato"
}

if {[db_0or1row software_house "select software_house_id, name from iter_software_houses limit 1"]} {
    template::multirow append users $software_house_id $name "Software-house"
}


# trovo il subsite
array set arr [site_node::get_from_url -url /]
set context_id $arr(package_id)

# ottengo il gruppo a cui appartengono, con relazione di
# composizione, tutti gli altri gruppi 
#nic01 set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]

#nic01 db_1row bodies "
#nic01    select g.group_id, g.group_name
#nic01    from acs_rels r, groups g
#nic01    where r.rel_type='composition_rel' and 
#nic01          r.object_id_one = :subsite_group_id and 
#nic01          r.object_id_two = g.group_id and
#nic01          g.group_name like '%Demo%'
#nic01    limit 1"
#nic01 template::multirow append users $group_id $group_name "Ente"


