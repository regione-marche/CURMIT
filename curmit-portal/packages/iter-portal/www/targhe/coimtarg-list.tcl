ad_page_contract {

    @author Claudio Pasolini

    USER  DATA       MODIFICHE
    ===== ========== ===========================================================================
    rom01 11/10/2018 Invece di far vedere il cod_impianto faccio vedere il cod_impianto_est 
    rom01            degli impianti del caldo e freddo.

} {
    f_targa
}

set user_id    [ad_conn user_id]

set page_title "Lista Targhe"
set context [list "$page_title"]

# prepare actions buttons
set actions ""
set link_filter [export_url_vars nome_funz nome_funz_caller]

#rom01 Aggiunto cambiati i campicod_impianto_caldo e cod_impianto_freddo in cod_impianto_est_caldo e cod_impianto_est_freddo
template::list::create \
    -name coimtarg \
    -multirow coimtarg \
    -actions $actions \
    -elements {	
	targa {
	    label "Targa"
	}
	manutentore {
	    label "Manutentore"
	}
	instanza {
	    label "Ente"
	}
	cod_impianto_est_caldo {
	    label "Cod. Imp. riscaldamento"
	}
	cod_impianto_est_freddo {
	    label "Cod. Imp. raffreddamento"
	}
    }
#rom01 aggiunti i campi cod_impianto_est_caldo e cod_impianto_est_freddo nell'extend
db_multirow -extend {instanza cod_impianto_est_caldo cod_impianto_est_freddo} coimtarg query "
    select a.targa
         , b.name as manutentore
         , a.nome_db_utilizzo 
         , a.cod_impianto_caldo                                
         , a.cod_impianto_freddo
    from coimtarg a
       , coimplic p
left join iter_maintainers b
      on p.maintainer_id = b.maintainer_id
   where upper(a.targa)  = upper(:f_targa)
     and a.plico_id      =    p.plico_id
    order by targa
   
    " {

	db_0or1row q "select g.group_name as instanza
                      from acs_rels       r
                         , groups         g
                         , parties        p
                         , iter_instances i
                     where r.rel_type      = 'composition_rel'
                       and r.object_id_two = g.group_id
                       and g.group_id      = p.party_id
                       and g.group_id      = i.instance_id
                       and i.instance_name = :nome_db_utilizzo"

	if {$cod_impianto_caldo ne ""} {#rom01 aggiunta if e contenuto
	    db_1row  -dbn $nome_db_utilizzo q "select coalesce(a.cod_impianto_est,'') as cod_impianto_est_caldo
                                                from coimaimp a
                                               where a.cod_impianto = :cod_impianto_caldo"
	}	    
	if {$cod_impianto_freddo ne ""} {#rom01 aggiunta if e contenuto
	    db_1row  -dbn $nome_db_utilizzo q "select coalesce(b.cod_impianto_est,'') as cod_impianto_est_freddo
                                                 from  coimaimp b
                                                where  b.cod_impianto = :cod_impianto_freddo"
        }

    }


