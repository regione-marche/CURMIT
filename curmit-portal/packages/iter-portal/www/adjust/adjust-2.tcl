ad_page_contract {

  @author Nelson Secco
  @cvs-id adjust-2.tcl

} {
    maintainer_id
    iter_code
    instance_name
    password
}

# ===============================================================================================
# ( "iter_code" è quello "vecchio", da bonificare contenuto in "iter_maintainers_to_adjust" ... )
# ===============================================================================================
# ns_log notice "\n Nelson (1): |maintainer_id = $maintainer_id|iter_code = $iter_code|instance_name = $instance_name|"

# ===============================================================================================
# ( qui recupero il NUOVO "iter_code" che mi servira' per la bonifica degli impianti ... )
# ===============================================================================================
db_1row query "select name, iter_code as new_iter_code from iter_maintainers where maintainer_id = :maintainer_id"

# ns_log notice "\n Nelson (2): |maintainer_id = $maintainer_id|new_iter_code = $new_iter_code|iter_code = $iter_code|instance_name = $instance_name|"

set page_title "Bonifica impianti del Manutentore $name ( dal 'vecchio' Codice:  $iter_code  al  'Nuovo' Codice:  $new_iter_code )"
set context [list "$page_title"]

# ----------------------------------
# ( Preparo 'Bulk Actions' Buttons )
# ----------------------------------
set bulk_actions [list "Bonifica impianti selezionati" adjust-3 "Bonifica impianti evidenziati a video"]

template::list::create \
    -name adjust \
    -multirow adjust \
    -bulk_actions $bulk_actions \
    -bulk_action_export_vars {maintainer_id iter_code new_iter_code instance_name password} \
    -key cod_impianto \
    -elements {
	cod_impianto_est {
	    label "Codice"
	}
	resp {
	    label "Responsabile"
	}
	cod_fiscale {
	    label "Cod.Fisc./P.Iva"
	}
	comune {
	    label "Comune"
	}
	indir {
	    label "Indirizzo"
	}
	potenza {
	    label "Potenza"
            html {align right}
	}
	stato {
	    label "St."
	}

    }

#   ===================================================================================================================
#   ( 13.01.2009 - Nelson ) In SVILUPPO esiste solo l'instance: 'iterrl-dev' e non tutte le istanze (...)
#   ===================================================================================================================

    db_multirow -dbn $instance_name adjust query "
           select cod_manutentore
                , replace(a.cod_impianto_est, ' ', '&nbsp;') as cod_impianto_est
                , a.cod_impianto
                , c.denominazione       as comune
                , coalesce(d.descr_topo,'')||' '||
                  coalesce(d.descrizione,'')||
                  case
                    when a.numero is null then ''
                    else ', '||a.numero
                  end ||
                  case
                    when a.esponente is null then ''
                    else '/'||a.esponente
                  end ||
                  case
                    when a.scala is null then ''
                    else ' S.'||a.scala
                  end ||
                  case
                    when a.piano is null then ''
                    else ' P.'||a.piano
                  end ||
                  case
                    when a.interno is null then ''
                    else ' In.'||a.interno
                  end
                                        as indir
                , case a.stato
                    when 'A' then 'At'
                    when 'N' then 'N'
                    when 'L' then 'An'
                    when 'D' then 'D'
                    when 'R' then 'R'
                    else a.stato
                  end as stato
                , coalesce(b.cognome,' ')||' '||coalesce(b.nome,' ')   as resp
                , b.cod_fiscale    as cod_fiscale
                , iter_edit_num(coalesce(a.potenza,0),2) as potenza
 
             from coimaimp a
 
             left outer join coimcitt b on b.cod_cittadino = a.cod_responsabile
             left outer join coimcomu c on c.cod_comune    = a.cod_comune
             left outer join coimviae d on d.cod_comune    = a.cod_comune and d.cod_via = a.cod_via
 
             where a.cod_manutentore = :iter_code
           
             order by b.cognome, b.nome, a.cod_impianto_est" 


