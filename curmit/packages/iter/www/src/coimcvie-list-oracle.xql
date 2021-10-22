<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


    <fullquery name="sel_comu">
       <querytext>
            select denominazione as denom_comune
              from coimcomu
             where cod_comune = :cod_comune
       </querytext>
    </fullquery>

    <partialquery name="sel_viae">
       <querytext>
                   select cod_via
                        , descrizione
                        , descr_estesa
                        , descr_topo
                        , cod_comune
                     from coimviae
                    where cod_comune = :cod_comune
                   $where_word
                 order by descrizione
                        , cod_via
       </querytext>
    </partialquery>

</queryset>
