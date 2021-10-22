<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_viae">
       <querytext>
                   select cod_via
                        , descrizione
                        , descr_estesa
                        , descr_topo
                        , cod_comune
                     from coimviae
                    where cod_via = :cod_via
                      and cod_comune = :cod_comune
       </querytext>
    </fullquery>

    <partialquery name="upd_aimp">
       <querytext>
          update coimaimp
	     set cod_via = :destinazione
           where cod_via = :cod_via
             and cod_comune = :cod_comune
       </querytext>
    </partialquery>

    <partialquery name="del_viae">
       <querytext>
           delete 
             from coimviae
            where cod_via = :cod_via
              and cod_comune = :cod_comune
       </querytext>
    </partialquery>


</queryset>
