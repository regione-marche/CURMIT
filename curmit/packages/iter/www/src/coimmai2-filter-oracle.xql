<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_viae">
       <querytext>
             select cod_via
               from coimviae
              where cod_comune  = :f_comune
                and descr_topo  = upper(:f_desc_topo)
                and descrizione = upper(:f_desc_via)
       </querytext>
    </fullquery>

    <fullquery name="sel_conta_aimp">
       <querytext>
      select iter_edit.num(count(*),0) as conta_num
        from coimaimp a
           , coimcitt b
           $sogg_join
	   $gend_join_ora1
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
       $gend_join_ora2
       $where_cogn
       $where_nome
       $where_comune
       $where_via
       $where_civico
       $where_matricola
       $where_modello
       $where_costruttore
       </querytext>
    </fullquery>

    <fullquery name="sel_cod_aimp">
       <querytext>
      select a.cod_impianto
        from coimaimp a
           , coimcitt b
           $sogg_join
	   $gend_join_ora1
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
       $gend_join_ora2
       $where_cogn
       $where_nome
       $where_comune
       $where_via
       $where_civico
       $where_matricola
       $where_modello
       $where_costruttore
       </querytext>
    </fullquery>


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
