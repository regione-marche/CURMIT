<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>


    <fullquery name="sel_data_limite">
       <querytext>
            select to_char(add_months(current_date, -to_number(:valid_mod_h,'99999990')), 'yyyy-mm-dd') as dat_ini_ver
       </querytext>
    </fullquery>

    <fullquery name="sel_data_inizio_contr">
       <querytext>
            select to_char(add_months(current_date, + to_number(:mesi_scad,'99999990')), 'yyyy-mm-dd') as dat_ini_ver_contr --sim01
                   --sim01 to_char(add_months(current_date, -to_number(:mesi_scad,'99999990')), 'yyyy-mm-dd') as dat_ini_ver_contr
       </querytext>
    </fullquery>

    <partialquery name="sel_aimp_vie">
       <querytext>
           select 
                  a.cod_impianto_est
                , a.cod_impianto
                , a.data_ultim_dich
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
                , coalesce(b.cognome,' ')||' '||coalesce(b.nome,' ')   as resp
                , b.cognome 
                , b.nome
                , iter_edit_num(coalesce(a.potenza,0),2) as potenza

                , case a.flag_dichiarato
                  when 'S' then 'S&igrave;'
                  when 'N' then 'No'
                  when 'C' then 'N.C.'
                  end as swc_dichiarato
                , iter_edit_data(a.data_ultim_dich) as data_controllo
                $ruolo
             from coimaimp a
	     $sogg_join
   $citt_join_pos coimcitt b
               on b.cod_cittadino = a.cod_responsabile
  left outer join coimcomu c
               on c.cod_comune    = a.cod_comune
  left outer join coimviae d
               on d.cod_comune    = a.cod_comune	
              and d.cod_via       = a.cod_via
            where 1 = 1
--sim01              and a.data_ultim_dich < :dat_ini_ver_contr
                and a.data_scad_dich  < :dat_ini_ver_contr --sim01
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
           $where_last

           order by a.data_ultim_dich, a.cod_impianto_est

            limit $rows_per_page
       </querytext>
    </partialquery>


    <partialquery name="sel_aimp_no_vie">
       <querytext>
           select
                  a.cod_impianto_est
                , a.cod_impianto
                , a.data_ultim_dich
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
                , coalesce(b.cognome)||' '||coalesce(b.nome,' ')   as resp
                , b.cognome 
                , b.nome 
                , iter_edit_num(coalesce(a.potenza,0),2) as potenza
                , case a.flag_dichiarato
                  when 'S' then 'S&igrave;'
                  when 'N' then 'No'
                  when 'C' then 'N.C.'
                  end as swc_dichiarato
                , iter_edit_data(a.data_ultim_dich) as data_controllo
                $ruolo
             from coimaimp a
	     $sogg_join
   $citt_join_pos coimcitt b
               on b.cod_cittadino = a.cod_responsabile
  left outer join coimcomu c 
               on c.cod_comune    = a.cod_comune

            where 1 = 1
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
           $where_last

            order by a.data_ultim_dich, a.cod_impianto_est

           limit $rows_per_page
       </querytext>
    </partialquery>

    <fullquery name="sel_anno_dat_ver">
       <querytext>
            select to_number(to_char(current_date, 'yyyy'),'9999') - 2
                as dat_ini_ver
       </querytext>
    </fullquery>

    <fullquery name="sel_conta_aimp">
       <querytext>
           select iter_edit_num(count(*),0) as conta_num
             from coimaimp a
	     $sogg_join
   $citt_join_pos coimcitt b
               on b.cod_cittadino = a.cod_responsabile
            where 1 = 1
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

    <partialquery name="sogg_join">
       <querytext>
        inner join coimcitt e on a.cod_responsabile = e.cod_cittadino
                              or a.cod_intestatario = e.cod_cittadino 
                              or a.cod_proprietario = e.cod_cittadino
                              or a.cod_occupante    = e.cod_cittadino
                              or a.cod_amministratore = e.cod_cittadino
       </querytext>
    </partialquery>

    <partialquery name="where_sogg">
       <querytext>
          and e.cod_cittadino = :cod_cittadino
       </querytext>
    </partialquery>

</queryset>
