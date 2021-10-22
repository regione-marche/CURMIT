<?xml version="1.0"?>
<!--
    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    sim01  10/09/2014 Aggiunto nuovo campo cod_impianto_princ
-->

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_dat_check_mod_h">
       <querytext>
            select to_char(add_months(sysdate, -to_number(:valid_mod_h,'99999990')), 'yyyy-mm-dd') as dat_check_mod_h
              from dual
       </querytext>
    </fullquery>

    <partialquery name="sel_aimp_vie">
       <querytext>
select * 
  from (
      select /* FIRST_ROWS */ 
             a.cod_impianto_est
           , a.cod_impianto
           , h.cod_impianto_est    as cod_impianto_princ --sim01
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
        from coimaimp a
           , coimcitt b
           , coimcomu c
	   , coimviae d
           $sogg_join
           , coimaimp h -- sim01
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
         $where_sogg
         and c.cod_comune    (+) = a.cod_comune
         and d.cod_comune    (+) = a.cod_comune	
         and d.cod_via       (+) = a.cod_via
         and h.cod_impianto  (+) = a.cod_impianto_princ --sim01
       $where_word
       $where_nome
       $where_comune
       $where_quartiere
       $where_via
       $where_civico_da
       $where_civico_a
       $where_manu
       $where_manutentore
       $where_data_mod
       $where_utente
       $where_pot
       $where_codimp_est
       $where_comb
       $where_data_installaz
       $where_flag_dichiarato
       $where_cod_tpim
       $where_stato_conformita
       $where_tpdu
       $where_stato_aimp
       $where_last
       $where_mod_h
       $where_codimp_princ --sim01
 $ordinamento
  ) 
 where rownum <= $rows_per_page
       </querytext>
    </partialquery>


    <partialquery name="sel_aimp_no_vie">
       <querytext>
select * 
  from (
      select /* FIRST_ROWS */ 
             a.cod_impianto_est
           , a.cod_impianto
           , h.cod_impianto_est    as cod_impianto_princ --sim01
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
        from coimaimp a
           , coimcitt b
           , coimcomu c 
           $sogg_join
           , coimaimp h
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
         $where_sogg
         and c.cod_comune    (+) = a.cod_comune
         and h.cod_impianto  (+) = a.cod_impianto_princ --sim01
       $where_word
       $where_nome
       $where_comune
       $where_quartiere
       $where_via
       $where_civico_da
       $where_civico_a
       $where_manu
       $where_manutentore
       $where_data_mod
       $where_utente
       $where_pot
       $where_codimp_est
       $where_comb
       $where_data_installaz
       $where_flag_dichiarato
       $where_cod_tpim
       $where_stato_conformita
       $where_tpdu
       $where_stato_aimp
       $where_last
       $where_mod_h
 $ordinamento
  ) 
 where rownum <= $rows_per_page
       </querytext>
    </partialquery>


    <fullquery name="sel_conta_aimp">
       <querytext>
      select iter_edit.num(count(*),0) as conta_num
        from coimaimp a
           , coimcitt b
           $sogg_join
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
         $where_sogg
       $where_word
       $where_nome
       $where_comune
       $where_quartiere
       $where_via
       $where_civico_da
       $where_civico_a
       $where_manu
       $where_manutentore
       $where_data_mod
       $where_utente
       $where_pot
       $where_codimp_est
       $where_comb
       $where_data_installaz
       $where_flag_dichiarato
       $where_cod_tpim
       $where_stato_conformita
       $where_tpdu
       $where_stato_aimp
       $where_mod_h
       </querytext>
    </fullquery>

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
