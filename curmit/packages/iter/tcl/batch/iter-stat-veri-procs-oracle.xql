<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="iter_stat_veri.sel_cinc">
       <querytext>
            select descrizione                 as des_cinc
                 , iter_edit.data(data_inizio) as data_inizio_ed
                 , iter_edit.data(data_fine)   as data_fine_ed
                 , data_inizio
                 , data_fine
              from coimcinc
             where cod_cinc = :cod_cinc
       </querytext>
    </fullquery>

    <fullquery name="iter_stat_veri.sel_tano">
       <querytext>
        select cod_tano
             , descr_tano
          from coimtano
      order by cod_tano
       </querytext>
    </fullquery>

    <fullquery name="iter_stat_veri.sel_inco">
       <querytext>
          select cod_inco
               , cod_cinc as cod_cinc_inco
	       , ''       as cod_cimp
               , ''       as esito
            from coiminco
           where stato = 8
          $where_cond

          union

          select ''             as cod_inco
               , ''             as cod_cinc_inco
               , cod_cimp
               , esito_verifica as esito
            from coimcimp
           where cod_inco is null
          $where_cimp_cond

        order by cod_cinc_inco -- nic01
       </querytext>
    </fullquery>

    <fullquery name="iter_stat_veri.sel_anom">
       <querytext>
                   select b.cod_tanom
                     from coimcimp a
                        , coimanom b
           -- nic01 where a.cod_inco      =  :cod_inco
                    where a.cod_cimp      =  :cod_cimp -- nic01
                      and b.cod_cimp_dimp = a.cod_cimp
                      and b.flag_origine  =  'RV'
       </querytext>
    </fullquery>

    <fullquery name="iter_stat_veri.sel_cimp_inco">
       <querytext>
       select cod_cimp
            , esito_verifica as esito
         from coimcimp
        where cod_inco = :cod_inco
       </querytext>
    </fullquery>

</queryset>
