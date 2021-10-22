<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_viae">
       <querytext>
             select cod_via
               from coimviae
              where cod_comune  = :f_comune
                and descr_topo  = upper(:f_desc_topo)
                and descrizione = upper(:f_desc_via)
       </querytext>
    </fullquery>


    <fullquery name="sel_lol_2">
       <querytext>
           select coalesce(b.ragione_01, '')||' '||iter_edit_data(a.data_caric)||' '||a.cod_acts
                , a.cod_acts 
             from coimacts a
             left outer join coimdist b on b.cod_distr = a.cod_distr 
            order by a.data_caric desc, a.cod_acts desc
       </querytext>
    </fullquery>

</queryset>
