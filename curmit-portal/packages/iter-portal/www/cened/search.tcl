ad_page_contract {

    @author        Luca Bellini
    @creation-date

    @cvs-id .tcl
} {
    {cod_istat       ""}
    {lista_matricole ""}
    {cognome         ""}
    {nome            ""}
    {indirizzo       ""}
    {civico          ""}
}

set limite 999

if {[db_0or1row query "select instance_name, c.denominazione from iter_instances i , iter_comuni c 
                        where c.cod_istat = :cod_istat 
                          and c.body_id = instance_id "] == 0} {
    
    ns_return 200 text/html "Codice Comune errato. Controllare"; return
}

#if {$provincia ne $comune} {
#    set denominazione "Provincia di $provincia"
#    set denominazione2 "Comune di $comune"
#} else {
#    set denominazione "Comune di $comune"
#    set denominazione2 "Provincia di $comune"
#}

#set denominazione [string map {' ""} $denominazione]

#if {[db_0or1row query "
#    select trim(i.instance_name) as instance_name
#    from acs_rels r, groups g, parties p, iter_instances i
#    where r.rel_type='composition_rel' and 
#          r.object_id_two = g.group_id and
#          g.group_id      = p.party_id and
#          g.group_id      = i.instance_id and
#          upper(g.group_name) = upper('$denominazione')
#    order by group_name"] == 0} {
    
#    if {[db_0or1row query "
#    select trim(i.instance_name) as instance_name
#    from acs_rels r, groups g, parties p, iter_instances i
#    where r.rel_type='composition_rel' and 
#          r.object_id_two = g.group_id and
#          g.group_id      = p.party_id and
#          g.group_id      = i.instance_id and
#          upper(g.group_name) = upper('$denominazione2')
#    order by group_name"] == 0]} {

#    }
#}

set ricerca "Comune di $denominazione - istanza $instance_name - "
if {[exists_and_not_null lista_matricole]} {
#    set lista_matricole [join $lista_matricole ,]
    set clause "and g.matricola in ($lista_matricole)"
    append ricerca "TIPO RICERCA per lista di Matricole "

    set numero [db_string -dbn $instance_name query "select count(*) as numero
                                        from coimgend g
                                       where g.matricola in ($lista_matricole)
                                       " -default 0]
    
    
    set ritorno "$ricerca IMPIANTI TROVATI $numero \n\n"
    
    db_foreach -dbn $instance_name query "select g.matricola,
                                             g.modello,
                                             g.pot_utile_nom,
                                             g.pot_focolare_nom,
                                             i.anno_costruzione,
                                             i.data_installaz,
                                             co.descr_comb,
                                             coalesce((select max(d.data_controllo) 
                                                         from coimdimp d 
                                                        where d.cod_impianto = i.cod_impianto), null) as data_controllo,
                                             coalesce((select d.rend_combust 
                                                         from coimdimp d 
                                                        where d.cod_impianto = i.cod_impianto 
                                                     order by data_controllo desc 
                                                       limit 1) , null)   as rend_combust
                                        from coimgend g left outer join coimcomb co on co.cod_combustibile = g.cod_combustibile, 
                                             coimaimp i
                                       where g.cod_impianto = i.cod_impianto
                                         and g.matricola in ($lista_matricole)
                                       limit $limite                                       
                              " {
				  
				  
				  append ritorno "$modello|$matricola|$pot_utile_nom|$pot_focolare_nom|$anno_costruzione|$data_installaz|$descr_comb|$data_controllo|$rend_combust|\n"
			      }
    
    
    
    
} elseif {[exists_and_not_null cognome]} {
    append ricerca "TIPO RICERCA per Cognome/Nome"
    if {[exists_and_not_null nome]} {
	set nome_clause " and upper(c.nome) = upper(:nome)"
    } else {
	set nome_clause ""
    }
    if {[exists_and_not_null cognome]} {
	set cognome_clause " and upper(c.cognome) = upper(:cognome)"
    } else {
	set cognome_clause ""
    }
    set numero [db_string -dbn $instance_name query "select count(*) as numero
                                        from coimgend g,
                                             coimaimp i,
                                             coimcitt c
                                       where g.cod_impianto = i.cod_impianto
                                         and i.cod_proprietario = c.cod_cittadino
                                             $cognome_clause
                                             $nome_clause
                                       " -default 0]


    set ritorno "$ricerca IMPIANTI TROVATI $numero \n\n"
    db_foreach -dbn $instance_name query "select g.matricola,
                                             g.modello,
                                             g.pot_utile_nom,
                                             g.pot_focolare_nom,
                                             i.anno_costruzione,
                                             i.data_installaz,
                                             co.descr_comb,
                                             coalesce((select max(d.data_controllo)
                                                         from coimdimp d
                                                        where d.cod_impianto = i.cod_impianto limit 1), null) as data_controllo,
                                             coalesce((select d.rend_combust
                                                         from coimdimp d
                                                        where d.cod_impianto = i.cod_impianto
                                                     order by data_controllo desc
                                                       limit 1) , null)   as rend_combust
                                        from coimgend g left outer join coimcomb co on co.cod_combustibile = g.cod_combustibile,
                                             coimaimp i,
                                             coimcitt c
                                       where g.cod_impianto = i.cod_impianto
                                         and i.cod_proprietario = c.cod_cittadino                    
                                             $cognome_clause
                                             $nome_clause
                                       limit $limite
                              " {

				  append ritorno "$modello|$matricola|$pot_utile_nom|$pot_focolare_nom|$anno_costruzione|$data_installaz|$descr_comb|$data_controllo|$rend_combust|\n"
			      }
} elseif {[exists_and_not_null indirizzo]} {
    if {[exists_and_not_null indirizzo]} {
	set indi_clause " and upper(i.indirizzo) like upper('%$indirizzo%')"
    } else {
	set indi_clause ""
    }
    if {[exists_and_not_null civico]} {
	set civi_clause " and upper(i.numero) = upper(:civico)"
    } else {
	set civi_clause ""
    }
    append ricerca "TIPO RICERCA per Indirizzo/Civico"
    set numero [db_string -dbn $instance_name query "select count(*) as numero
                                        from coimgend g,
                                             coimaimp i
                                       where g.cod_impianto = i.cod_impianto
                                             $indi_clause
                                             $civi_clause
                                       " -default 0]
    

    set ritorno "$ricerca IMPIANTI TROVATI $numero \n\n"
    db_foreach -dbn $instance_name query "select g.matricola,
                                             g.modello,
                                             g.pot_utile_nom,
                                             g.pot_focolare_nom,
                                             i.anno_costruzione,
                                             i.data_installaz,
                                             co.descr_comb,
                                             coalesce((select max(d.data_controllo)
                                                         from coimdimp d
                                                        where d.cod_impianto = i.cod_impianto limit 1), null) as data_controllo,
                                             coalesce((select d.rend_combust
                                                         from coimdimp d
                                                        where d.cod_impianto = i.cod_impianto
                                                     order by data_controllo desc
                                                       limit 1) , null)   as rend_combust
                                        from coimgend g left outer join coimcomb co on co.cod_combustibile = g.cod_combustibile,
                                             coimaimp i
                                       where g.cod_impianto = i.cod_impianto
                                             $indi_clause
                                             $civi_clause
                                       limit $limite
                              " {


				  append ritorno "$modello|$matricola|$pot_utile_nom|$pot_focolare_nom|$anno_costruzione|$data_installaz|$descr_comb|$data_controllo|$rend_combust|\n"
			      }
}


ns_return 200 text/html $ritorno
return
