<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


    <partialquery name="sel_aimp_vie">
       <querytext>
select * 
  from (
      select /* FIRST_ROWS */ 
             a.cod_impianto_est
           , a.cod_impianto
           , a.numero
	   , a.cod_comune
           , c.denominazione       as comune
           , nvl(d.descr_topo,'')||' '||
             nvl(d.descrizione,'')||' '||
             nvl(a.numero,'')      as indir
           , d.descrizione as via
	   , decode (
                (select count(*)
                   from coimdimp n
                  where n.cod_impianto         = a.cod_impianto
                    and n.data_controllo between  :dat_ini_ver
                                             and   sysdate)
                 , 0, 'No', 'S&igrave;'
             ) as swc_mod_h

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
           , iter_edit.num(nvl(a.potenza,0),2) as potenza

           , decode (a.flag_dichiarato
                , 'S', 'S&igrave;'
                , 'N', 'No'
                , 'C', 'N.C.'
             ) as swc_dichiarato
        from coimaimp a
           $tab_join_ora
           , coimcitt b
           , coimcomu c
	   , coimviae d
       where b.cod_cittadino (+) = a.cod_responsabile
         and c.cod_comune    (+) = a.cod_comune
         and d.cod_comune    (+) = a.cod_comune	
         and d.cod_via       (+) = a.cod_via
       $on_cond_ora
       $where_via
       $where_last
       $where_codaces_est
       $where_citt       
       $where_piva   
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
           , a.numero
	   , a.cod_comune
           , c.denominazione       as comune
           , nvl(a.toponimo,'')||' '||
             nvl(a.indirizzo,'')||' '||
             nvl(a.numero,'')      as indir
           , a.indirizzo as via
	   , decode (
                (select count(*)
                   from coimdimp n
                  where n.cod_impianto         = a.cod_impianto
                    and n.data_controllo between  :dat_ini_ver
                                             and   sysdate)
                 , 0, 'No', 'S&igrave;'
             ) as swc_mod_h

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
           , iter_edit.num(nvl(a.potenza,0),2) as potenza

           , decode (a.flag_dichiarato
                , 'S', 'S&igrave;'
                , 'N', 'No'
                , 'C', 'N.C.'
             ) as swc_dichiarato
        from coimaimp a
           $tab_join_ora
           , coimcitt b
           , coimcomu c 
       where b.cod_cittadino (+) = a.cod_responsabile
         and c.cod_comune    (+) = a.cod_comune
       $on_cond_ora
       $where_via
       $where_last
       $where_codaces_est
       $where_citt       
       $where_piva 
 $ordinamento
  ) 
 where rownum <= $rows_per_page
       </querytext>
    </partialquery>


    <fullquery name="sel_anno_dat_ver">
       <querytext>
       select to_number(to_char(sysdate, 'yyyy'),'9999') -2  as dat_ini_ver from dual
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
                , coimacts b 
            where 1 = 1
              and a.cod_aces = :cod_aces
              and b.cod_acts = a.cod_acts
       </querytext>
    </partialquery>

    <partialquery name="set_where_citt">
       <querytext>
       and trim(trim(nvl(e.cognome,''))||' '||trim(nvl(e.nome,''))) like
           upper(:cogn_nome)
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
