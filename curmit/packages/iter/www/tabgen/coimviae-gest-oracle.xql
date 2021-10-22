<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="del_viae">
       <querytext>
                   delete
                     from coimviae
                    where cod_via    = :cod_via
                      and cod_comune = :cod_comune
       </querytext>
    </partialquery>

    <partialquery name="upd_viae">
       <querytext>
                   update coimviae
                      set descrizione  = :descrizione
                        , descr_topo   = :descr_topo
                        , descr_estesa = :descr_estesa
                    where cod_via      = :cod_via
                      and cod_comune   = :cod_comune
       </querytext>
    </partialquery>

    <partialquery name="ins_viae">
       <querytext>
                   insert
                     into coimviae 
                        ( cod_via
                        , cod_comune
                        , descrizione
                        , descr_topo
                        , descr_estesa)
                   values 
                        (:cod_via
                        ,:cod_comune
                        ,:descrizione
                        ,:descr_topo
                        ,:descr_estesa)
       </querytext>
    </partialquery>

    <fullquery name="sel_check_viae">
       <querytext>
                    select '1'
                      from coimviae
                     where cod_via    = upper(:cod_via)
                       and cod_comune = :cod_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_check_viae_2">
       <querytext>
                    select '1'
                      from coimviae
                     where cod_comune  = :cod_comune
                       and descrizione = upper(:descrizione)
                       and descr_topo  = upper(:descr_topo)
                     $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_cod">
        <querytext>
           select coimviae_s.nextval as cod_via
             from dual
       </querytext>
    </fullquery>

    <fullquery name="sel_viae">
       <querytext>
                    select descrizione
                         , descr_topo
                         , descr_estesa
                      from coimviae
                     where cod_via    = :cod_via
                       and cod_comune = :cod_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_comu">
       <querytext>
                    select denominazione as denom_comune
                      from coimcomu
                     where cod_comune = :cod_comune 
       </querytext>
    </fullquery>

</queryset>
