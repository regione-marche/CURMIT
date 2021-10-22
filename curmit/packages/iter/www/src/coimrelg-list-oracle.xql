<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_relg">
       <querytext>
           select cod_relg
                , iter_edit.data(data_rel) as data_rel_edit
                , data_rel
                , ente_istat
                , resp_proc
                , iter_edit.num(nimp_tot_stim_ente,0) as nimp_tot_stim_ente
                , iter_edit.num(ntot_autodic_perv,0)  as ntot_autodic_perv
                , iter_edit.num((select n
                                   from coimrelt
                                  where cod_relg   =  coimrelg.cod_relg
                                    and sezione    = 'C'
                                    and id_clsnc   =  5
                                    and id_stclsnc =  1
                                    and obj_refer  = 'I'
                                    and id_pot     =  9
                                    and id_per     =  9
                                    and id_comb    =  9)
                                ,0) as nimp_verificati
                , iter_edit.num((select n
                                   from coimrelt
                                  where cod_relg   =  coimrelg.cod_relg
                                    and sezione    = 'C'
                                    and id_clsnc   =  5
                                    and id_stclsnc =  3
                                    and obj_refer  = 'I'
                                    and id_pot     =  9
                                    and id_per     =  9
                                    and id_comb    =  9)
                                ,0) as nimp_verificati_nc
             from coimrelg
            where 1 = 1
           $where_last
         order by data_rel
                , ente_istat
       </querytext>
    </partialquery>

</queryset>
