<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_data_limite">
       <querytext>
            select to_char(add_months(sysdate, -to_number(:valid_mod_h,'99999990')), 'yyyy-mm-dd') as dat_ini_ver
              from dual
       </querytext>
    </fullquery>

    <fullquery name="sel_data_inizio_contr">
       <querytext>
            select to_char(add_months(sysdate, -to_number(:mesi_scad,'99999990')), 'yyyy-mm-dd') as dat_ini_ver_contr
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
           , a.data_ultim_dich
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
           , decode ((a.data_ultim_dich - to_date(:dat_ini_ver,'yyyy-mm-dd'))+abs((a.data_ultim_dich - to_date(:dat_ini_ver,'yyyy-mm-dd')))
                ,0 , '<font color=red><b>Scaduto</b></font>'
                , to_char(add_months(a.data_ultim_dich, to_number(:valid_mod_h,'99999990')), 'dd/mm/yyyy')
             ) as data_scad

           $ruolo
        from coimaimp a
           , coimcitt b
           , coimcomu c
	   , coimviae d
           $sogg_join
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
         $where_sogg
         and c.cod_comune    (+) = a.cod_comune
         and d.cod_comune    (+) = a.cod_comune	
         and d.cod_via       (+) = a.cod_via
         and a.data_ultim_dich < :dat_ini_ver_contr
       $where_word
       $where_nome
       $where_comune
       $where_quartiere
       $where_via
       $where_civico_da
       $where_civico_a
       $where_manu
       $where_manutentore
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
 order by a.data_ultim_dich, a.cod_impianto_est
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
           , a.data_ultim_dich
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
             ) as stato
           , decode (a.stato_conformita
             , 'S', 'S&igrave;'
             , 'N', 'No'
             , ''
             ) as swc_conformita
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
           , decode ((a.data_ultim_dich - to_date(:dat_ini_ver,'yyyy-mm-dd'))+abs((a.data_ultim_dich - to_date(:dat_ini_ver,'yyyy-mm-dd')))
                ,0 , '<font color=red><b>Scaduto</b></font>'
                , to_char(add_months(a.data_ultim_dich, to_number(:valid_mod_h,'99999990')), 'dd/mm/yyyy')
             ) as data_scad

           $ruolo
        from coimaimp a
           , coimcitt b
           , coimcomu c 
           $sogg_join
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
         $where_sogg
         and c.cod_comune    (+) = a.cod_comun
         and a.data_ultim_dich < :dat_ini_ver_contr
       $where_word
       $where_nome
       $where_comune
       $where_quartiere
       $where_via
       $where_civico_da
       $where_civico_a
       $where_manu
       $where_manutentore
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
 order by a.data_ultim_dich, a.cod_impianto_est

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
         and a.data_ultim_dich < :dat_ini_ver_contr
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
       $where_pot
       $where_codimp_est
       $where_comb
       $where_data_installaz
       $where_flag_dichiarato
       $where_cod_tpim
       $where_stato_conformita
       $where_tpdu
       $where_stato_aimp
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
