<?xml version="1.0"?>

    <partialquery name="sel_aimp_st_vie">
       <querytext>
select * 
  from (
      select /* FIRST_ROWS */ 
             a.cod_impianto_est
           , a.cod_impianto
           , a.numero
           , c.denominazione       as comune
           , nvl(d.descr_topo,'')||' '||
             nvl(d.descrizione,'')||
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
   	   , decode (a.stato 
             , 'A' , 'At'
             , 'N' , 'N'
             , 'L' , 'An'
             , 'D' , 'D'
             , 'R' , 'R'
             , a.stato
             ) as stato
           , decode (a.stato_conformita
             , 'S', 'S&igrave;'
             , 'N', 'No'
             , ''
             ) as swc_conformita
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
             , decode ( 
                (select count(*)
                   from coimcimp r
                  where a.cod_impianto = r.cod_impianto
                    and flag_tracciato <> 'MA')
                , 0 , 'No','S&igrave;'
             ) as swc_rapp

           , nvl(b.cognome,' ')||' '||nvl(b.nome,' ')   as resp
           , b.cognome 
           , b.nome 
           , b.cod_fiscale   as cod_fiscale
           , iter_edit.num(nvl(a.potenza,0),2) as potenza

           , decode (a.flag_dichiarato
                , 'S', 'S&igrave;'
                , 'N', 'No'
                , 'C', 'N.C.'
             ) as swc_dichiarato

           , decode (
               (((select add_months(sysdate, :mesi_evidenza_mod) 
                    from dual) - a.data_mod)
           - abs((select add_months(sysdate, :mesi_evidenza_mod)
                    from dual) - a.data_mod))
               , 0, 'No'
               , decode (
                   a.data_mod, a.data_ins, 'No'                
                   , decode (
                        (a.data_mod - a.data_ins)-abs(a.data_mod - a.data_ins)
                        , 0, '<font color=red><b>S&igrave;</b></font>'
                        , 'No'
                     )
                 )
             ) as swc_mod

           $ruolo
        from coimaimp_st a
           , coimcitt_st b
           , coimcomu c
	   , coimviae d
           $sogg_join
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
         a.cod_impianto = :f_cod_impianto
     order by a.st_progressivo
  ) 
       </querytext>
    </partialquery>


    <partialquery name="sel_aimp_st_no_vie">
       <querytext>
select * 
  from (
      select /* FIRST_ROWS */ 
             a.cod_impianto_est
           , a.cod_impianto
           , a.numero
           , c.denominazione       as comune
           , nvl(a.toponimo,'')||' '||
             nvl(a.indirizzo,'')||
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
   	   , decode (a.stato 
             , 'A' , 'At'
             , 'N' , 'N'
             , 'L' , 'An'
             , 'D' , 'D'
             , 'R' , 'R'
             , a.stato
             , ''
             ) as stato
           , decode (a.stato_conformita
             , 'S', 'S&igrave;'
             , 'N', 'No'
             , ''
             ) as swc_conformita
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
           , decode ( 
                (select count(*)
                   from coimcimp r
                  where a.cod_impianto = r.cod_impianto
                    and flag_tracciato <> 'MA')
                , 0 , 'No','S&igrave;'
             ) as swc_rapp

           , nvl(b.cognome,' ')||' '||nvl(b.nome,' ')   as resp
           , b.cognome 
           , b.nome 
           , b.cod_fiscale  as cod_fiscale
           , iter_edit.num(nvl(a.potenza,0),2) as potenza

           , decode (a.flag_dichiarato
                , 'S', 'S&igrave;'
                , 'N', 'No'
                , 'C', 'N.C.'
             ) as swc_dichiarato

           , decode (
               (((select add_months(sysdate, :mesi_evidenza_mod) 
                    from dual) - a.data_mod)
           - abs((select add_months(sysdate, :mesi_evidenza_mod)
                    from dual) - a.data_mod))
               , 0, 'No'
               , decode (
                   a.data_mod, a.data_ins, 'No'                
                   , decode (
                        (a.data_mod - a.data_ins)-abs(a.data_mod - a.data_ins)
                        , 0, '<font color=red><b>S&igrave;</b></font>'
                        , 'No'
                     )
                 )
             ) as swc_mod
           $ruolo
        from coimaimp_st a
           , coimcitt_st b
           , coimcomu c 
           $sogg_join
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
         a.cod_impianto = :f_cod_impianto
     order by a.st_progressivo
  ) 
       </querytext>
    </partialquery>



    <partialquery name="ruolo_citt">
       <querytext>
           , decode(a.cod_intestatario,   e.cod_cittadino, 'I ', '')
           ||decode(a.cod_proprietario,   e.cod_cittadino, 'P ', '')
           ||decode(a.cod_occupante,      e.cod_cittadino, 'O ', '')
           ||decode(a.cod_amministratore, e.cod_cittadino, 'A ', '')
           ||decode(a.cod_responsabile, e.cod_cittadino, decode(a.flag_resp, 'T', 'T', ''),'') as ruolo
       </querytext>
    </partialquery>

    <partialquery name="sogg_join">
       <querytext>
         , coimcitt e
       </querytext>
    </partialquery>

    <partialquery name="where_sogg">
       <querytext>
             and e.cod_cittadino = :cod_cittadino
             and (a.cod_responsabile   = e.cod_cittadino
              or  a.cod_intestatario   = e.cod_cittadino 
              or  a.cod_proprietario   = e.cod_cittadino
              or  a.cod_occupante      = e.cod_cittadino
              or  a.cod_amministratore = e.cod_cittadino)
       </querytext>
    </partialquery>

</queryset>
