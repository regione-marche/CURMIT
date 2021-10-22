?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_tot_inco">
       <querytext>
              select count(*) as tot_inco
                from coiminco a,
                     coimaimp z
               where (data_verifica between :f_data1 and :f_data2
                   or data_verifica is null)
                   and a.cod_impianto=z.cod_impianto
                   $where_tipo_imp
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_stato">
       <querytext>
              select b.descr_inst as stato
                   , count(*) as inco_count_stato
                from coiminco a
                   , coiminst b
                   , coimaimp z
               where (data_verifica between :f_data1 and :f_data2
                   or data_verifica is null)
                 and b.cod_inst = a.stato
                 and a.cod_impianto=z.cod_impianto
                 $where_tipo_imp
            group by b.descr_inst
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_eff_pote">
       <querytext>
              select c.cod_potenza
                   , c.descr_potenza as potenza
                   , count(*) as inco_count_pote
                from coiminco a
                   , coimaimp z
                   , coimpote c
               where (a.data_verifica between :f_data1 and :f_data2
                   or a.data_verifica is null)
                 and a.stato = '8'
                 and a.cod_impianto = z.cod_impianto
                 and c.cod_potenza = z.cod_potenza
                  $where_tipo_imp
               group by c.descr_potenza, c.cod_potenza
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_eff_tpes_pote">
       <querytext>
              select descr_tpes as tp_estr
                   , count(*) as count_tpes
                from coiminco a
                   , coimtpes b
                   , coimaimp z
               where (data_verifica between :f_data1 and :f_data2
                   or data_verifica is null)
                 and a.stato = '8'
                 and cod_tpes = tipo_estrazione
                 and z.cod_impianto = a.cod_impianto
                 and z.cod_potenza = :cod_potenza
                 $where_tipo_imp
               group by descr_tpes
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_eff_tpes">
       <querytext>
              select descr_tpes as tipo_estrazione
                   , count(*) as inco_count_tpes
                from coiminco a
                   , coimtpes b
                   , coimaimp z
               where (data_verifica between :f_data1 and :f_data2
                   or data_verifica is null)
                 and a.stato = '8'
                 and cod_tpes = tipo_estrazione
                 and a.cod_impianto=z.cod_impianto
                  $where_tipo_imp
               group by descr_tpes
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_motivi_ann">
       <querytext>
              select descr_noin as motivo_ann
                   , count(*) as inco_count_ann
                from coiminco a
                   , coimnoin b
                   , coimaimp  z
               where (data_verifica between :f_data1 and :f_data2
                   or data_verifica is null)
                 and a.stato = '5'
                 and a.cod_noin = b.cod_noin
                 and a.cod_impianto=z.cod_impianto
                   $where_tipo_imp
            group by descr_noin
       </querytext>
    </fullquery>

</queryset>
