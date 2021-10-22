<?xml version="1.0"?>

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
             , 'A' , 'AT'
             , 'N' , 'N'
             , 'L' , 'AN'
             , 'D' , 'D'
             , 'R' , 'R'
             , a.stato
             ) as stato
           , decode (a.stato_conformita
             , 'S', 'SI'
             , 'N', 'NO'
             , ''
             ) as swc_conformita
	   , decode (
                (select count(*)
                   from coimdimp n
                  where n.cod_impianto         = a.cod_impianto)
                 , 0, 'NO'
                 , case
                   when a.data_scad_dich < current_date
                   then 'SC'
                   else 'SI'
                   end
             ) as swc_mod_h

           , decode ( 
                (select count(*)
                   from coimcimp r
                  where a.cod_impianto = r.cod_impianto
                    and flag_tracciato <> 'MA')
                , 0 , 'NO','SI'
             ) as swc_rapp

           , nvl(b.cognome,' ')||' '||nvl(b.nome,' ')   as resp
           , b.cognome 
           , b.nome 
           , b.cod_fiscale   as cod_fiscale
           , iter_edit.num(nvl(a.potenza,0),2) as potenza

           , decode (a.flag_dichiarato
                , 'S', 'SI'
                , 'N', 'NO'
                , 'C', 'N.C.'
             ) as swc_dichiarato

           , decode (
               (((select add_months(sysdate, :mesi_evidenza_mod) 
                    from dual) - a.data_mod)
           - abs((select add_months(sysdate, :mesi_evidenza_mod)
                    from dual) - a.data_mod))
               , 0, 'NO'
               , decode (
                   a.data_mod, a.data_ins, 'NO'                
                   , decode (
                        (a.data_mod - a.data_ins)-abs(a.data_mod - a.data_ins)
                        , 0, 'SI'
                        , 'NO'
                     )
                 )
             ) as swc_mod
           , coalesce(kk.cognome,' ')||' '||coalesce(kk.nome,' ') as manu -- Sandro 28/07/2014
           , coalesce(kk.cod_manutentore,' ') as cod_man -- Sandro 28/07/2014
           $ruolo
        from coimaimp a
           , coimcitt b
           , coimcomu c
	   , coimviae d
           , coimmanu kk -- Sandro 28/07/2014
       $sogg_join
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
      $where_sogg
         and c.cod_comune       (+) = a.cod_comune
         and d.cod_comune       (+) = a.cod_comune	
         and d.cod_via          (+) = a.cod_via
         and kk.cod_manutentore (+) = a.cod_manutentore -- Sandro 28/07/2014
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
 $ordinamento
)
       </querytext>
    </partialquery>

</queryset>
