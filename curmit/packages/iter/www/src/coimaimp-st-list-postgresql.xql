<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_aimp_st_vie">
       <querytext>
           select
                  a.cod_impianto_est
                , a.st_progressivo
                , a.cod_impianto
                , a.numero
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
                , d.descrizione as via
		, case a.stato 
                    when 'A' then 'At'
                    when 'N' then 'N'
                    when 'L' then 'An'
                    when 'D' then 'D'
                    when 'R' then 'R'
                    else a.stato
                  end as stato
                , case a.stato_conformita
                    when 'S' then 'S&igrave;'
                    when 'N' then 'No'
                    else ''
                  end as swc_conformita
	        , case
                      when (
                          select count(*)
                            from coimdimp n
                           where n.cod_impianto         = a.cod_impianto
                      ) = 0
                      then 'No'
                      else case 
                               when a.data_scad_dich < current_date 
                               then '<font color=red><b>Sc</b></font>'
                               else 'S&igrave;'  
                           end
                  end as swc_mod_h
                , case
                  when (
                      select count(*)
                        from coimcimp r
                       where a.cod_impianto = r.cod_impianto
                         and flag_tracciato <> 'MA'
                        ) = 0
                  then 'No'
                  else 'S&igrave;'
                  end as swc_rapp

                , iter_edit_num(coalesce(a.potenza,0),2) as potenza

                , case a.flag_dichiarato
                  when 'S' then 'S&igrave;'
                  when 'N' then 'No'
                  when 'C' then 'N.C.'
                  end as swc_dichiarato
                , case
                  when (select to_date(add_months(current_date, :mesi_evidenza_mod), 'yyyy-mm-dd')                        
                       ) > a.data_mod
                  then 'No'
                  else case when (a.data_ins < a.data_mod)
                    then '<font color=red><b>S&igrave</b></font>'
                    else 'No' end
                  end as swc_mod
              , a.st_utente
              , iter_edit_data(date(a.st_data_validita)) as st_data_valid
              , to_char(a.st_data_validita,'HH24:MI:SS') as st_ora_validita
              , a.st_data_validita
             from coimaimp_st a
  left outer join coimcomu c on c.cod_comune    = a.cod_comune
  left outer join coimviae d on d.cod_comune    = a.cod_comune	
              and d.cod_via       = a.cod_via
            where a.cod_impianto = :cod_impianto
         order by a.st_progressivo desc
       </querytext>
    </partialquery>


    <partialquery name="sel_aimp_st_no_vie">
       <querytext>
           select
                  a.cod_impianto_est
                , a.st_progressivo
                , a.cod_impianto
                , a.numero
                , c.denominazione       as comune
                , coalesce(a.toponimo,'')||' '||
                  coalesce(a.indirizzo,'')||
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
                , a.indirizzo as via
		, case a.stato 
                    when 'A' then 'At'
                    when 'N' then 'N'
                    when 'L' then 'An'
                    when 'D' then 'D'
                    when 'R' then 'R'
                    else a.stato
                  end as stato
                , case a.stato_conformita
                    when 'S' then 'S&igrave;'
                    when 'N' then 'No'
                    else ''
                  end as swc_conformita
	        , case
                      when (
                          select count(*)
                            from coimdimp n
                           where n.cod_impianto         = a.cod_impianto
                      ) = 0
                      then 'No'
                      else case 
                               when a.data_scad_dich < current_date 
                               then '<font color=red><b>Sc</b></font>'
                               else 'S&igrave;'  
                           end
                  end as swc_mod_h
                , case
                  when (
                      select count(*)
                        from coimcimp r
                       where a.cod_impianto = r.cod_impianto
                         and flag_tracciato <> 'MA'
                       ) = 0
                  then 'No'
                  else 'S&igrave;'
                  end as swc_rapp
                , iter_edit_num(coalesce(a.potenza,0),2) as potenza
                , case a.flag_dichiarato
                  when 'S' then 'S&igrave;'
                  when 'N' then 'No'
                  when 'C' then 'N.C.'
                  end as swc_dichiarato
                , case
                  when (select to_date(add_months(current_date, :mesi_evidenza_mod), 'yyyy-mm-dd')                        
                       ) > a.data_mod
                  then 'No'
                  else case when (a.data_ins < a.data_mod)
                    then '<font color=red><b>S&igrave</b></font>'
                    else 'No' end
                  end as swc_mod
              , a.st_utente
              , select iter_edit_data(date(a.st_data_validita)) as st_data_valid
              , select to_char(a.st_data_validita,'HH24:MI:SS') as st_ora_validita
             from coimaimp_st a
  left outer join coimcomu c on c.cod_comune    = a.cod_comune
            where a.cod_impianto = :cod_impianto
         order by a.st_progressivo desc
       </querytext>
    </partialquery>



</queryset>
