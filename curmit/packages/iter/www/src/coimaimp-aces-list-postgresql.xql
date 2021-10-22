<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_aimp_vie">
       <querytext>
           select
                  a.cod_impianto_est
                , a.cod_impianto
                , a.numero
                , a.cod_comune
                , c.denominazione       as comune
                , coalesce(d.descr_topo,'')||' '||
                  coalesce(d.descrizione,'')||' '||
                  coalesce(a.numero,'')      as indir
                , d.descrizione as via
	        , case
                  when (
                      select count(*)
                        from coimdimp n
                       where n.cod_impianto         = a.cod_impianto
                         and n.data_controllo between  :dat_ini_ver
                                                  and   current_date
                        ) = 0
                  then 'No'
                  else 'S&igrave;'
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

                , coalesce(b.cognome,' ')||' '||coalesce(b.nome,' ')   as resp
                , b.cognome 
                , b.nome 
                , iter_edit_num(coalesce(a.potenza,0),2) as potenza

                , case a.flag_dichiarato
                  when 'S' then 'S&igrave;'
                  when 'N' then 'No'
                  when 'C' then 'N.C.'
                  end as swc_dichiarato
             from coimaimp a
      $citt_join2 $tab_join
      $on_cond
  left outer join coimcitt b
               on b.cod_cittadino = a.cod_responsabile
  left outer join coimcomu c
               on c.cod_comune    = a.cod_comune
  left outer join coimviae d
               on d.cod_comune    = a.cod_comune	
              and d.cod_via       = a.cod_via
            where 1 = 1
           $where_via
           $where_last
           $where_codaces_est
           $where_citt       
           $where_piva       
           $ordinamento

            limit $rows_per_page
       </querytext>
    </partialquery>


    <partialquery name="sel_aimp_no_vie">
       <querytext>
           select
                  a.cod_impianto_est
                , a.cod_impianto
                , a.numero
                , a.cod_comune
                , c.denominazione       as comune
                , coalesce(a.toponimo,'')||' '||
                  coalesce(a.indirizzo,'')||' '||
                  coalesce(a.numero,'')      as indir
                , a.indirizzo as via

                , case
                  when (
                      select count(*)
                        from coimdimp n
                       where n.cod_impianto         = a.cod_impianto
                         and n.data_controllo between  :dat_ini_ver
                                                  and   current_date
                       ) = 0
                  then 'No'
                  else 'S&igrave;'
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

                , coalesce(b.cognome)||' '||coalesce(b.nome,' ')   as resp
                , b.cognome 
                , b.nome 
                , iter_edit_num(coalesce(a.potenza,0),2) as potenza
                , case a.flag_dichiarato
                  when 'S' then 'S&igrave;'
                  when 'N' then 'No'
                  when 'C' then 'N.C.'
                  end as swc_dichiarato
             from coimaimp a
      $citt_join2 $tab_join
      $on_cond
  left outer join coimcitt b
               on b.cod_cittadino = a.cod_responsabile
  left outer join coimcomu c 
               on c.cod_comune    = a.cod_comune
            where 1 = 1
           $where_via
           $where_last
           $where_codaces_est
           $where_citt       
           $where_piva       
           $ordinamento

            limit $rows_per_page
       </querytext>
    </partialquery>

    <fullquery name="sel_anno_dat_ver">
       <querytext>
            select to_number(to_char(current_date, 'yyyy'),'9999') - 2
                as dat_ini_ver
       </querytext>
    </fullquery>

    <partialquery name="sel_aces">
       <querytext>
           select a.cod_aces_est
                , a.cod_acts
                , a.cod_combustibile
                , a.natura_giuridica
                , a.cognome
                , a.nome
                , a.indirizzo
                , a.numero
                , a.esponente
                , a.scala
                , a.piano
                , a.interno
                , a.cap
                , a.localita
                , a.comune
                , a.provincia
                , a.cod_fiscale_piva   as piva
                , a.stato_01
                , b.cod_distr          as cod_distributore
             from coimaces a
       inner join coimacts b 
               on b.cod_acts = a.cod_acts
            where 1 = 1
              and a.cod_aces = :cod_aces
        
       </querytext>
    </partialquery>

    <partialquery name="set_where_citt">
       <querytext>
       and trim(trim(coalesce(e.cognome,''))||' '||trim(coalesce(e.nome,''))) like     upper(:cogn_nome)
       </querytext>
    </partialquery>

    <fullquery name="sel_cod_comu">
        <querytext>
	    select b.cod_comune as cod_comu_filt
	      from coimaces a
                 , coimcomu b
             where a.cod_aces = :cod_aces
               and upper(b.denominazione) = upper(a.comune)
	</querytext>
    </fullquery>

</queryset>
