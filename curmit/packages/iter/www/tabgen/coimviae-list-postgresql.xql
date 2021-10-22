<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    gab01 02/05/2016 Aggiunta colonna cod_zona
-->

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>


    <fullquery name="sel_comu">
       <querytext>
            select denominazione as denom_comune
              from coimcomu
             where cod_comune = :cod_comune
       </querytext>
    </fullquery>

    <partialquery name="sel_viae">
       <querytext>
                   select a.cod_via
                        , a.descrizione
                        , a.descr_estesa
                        , a.descr_topo
                        , a.cod_comune
                        , a.cap
			, a.da_numero
			, a.a_numero
                        , a.cod_zona  --gab01
                     from coimviae a
                    where a.cod_comune = :cod_comune
                      and a.cod_via_new is null
                   $where_last
                   $where_word
                   $where_disattiva
                 order by a.descrizione
                        , a.cod_via
       </querytext>
    </partialquery>
</queryset>
