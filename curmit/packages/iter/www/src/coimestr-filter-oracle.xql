<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_via">
       <querytext>
             select cod_via
               from coimviae
              where cod_comune  = :cod_comune
                and descr_topo  = upper(:descr_topo)
                and descrizione = upper(:descr_via)
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc_count">
       <querytext>
                   select count(*) as conta
                     from coimcinc
                    where stato = '1'
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
                   select cod_cinc
                        , descrizione as desc_camp
                     from coimcinc
                    where stato = '1'
       </querytext>
    </fullquery>

</queryset>
