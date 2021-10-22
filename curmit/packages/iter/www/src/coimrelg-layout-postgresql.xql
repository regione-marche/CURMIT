<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_relg">
       <querytext>
           select iter_edit_data(data_rel) as data_rel
                , ente_istat
                , resp_proc
                , iter_edit_num(nimp_tot_aut_ente,0) as nimp_tot_aut_ente
                , iter_edit_num(nimp_tot_centr_ente,0) as nimp_tot_centr_ente
                , iter_edit_num(nimp_tot_telerisc_ente,0) as nimp_tot_telerisc_ente
                , iter_edit_data(conv_ass_categ) as conv_ass_categ
                , case conf_dgr7_7568
                     when 'Y' then 'S&igrave;'
                     when 'N' then 'No'
                     else  '&nbsp;'
                  end as conf_dgr7_7568
                , npiva_ader_conv
                , npiva_ass_acc_reg
                , case delib_autodic
                     when 'Y' then 'S&igrave;'
                     when 'N' then 'No'
                     else  '&nbsp;'
                  end as delib_autodic
                , iter_edit_data(rifer_datai) as rifer_datai
                , iter_edit_data(rifer_dataf) as rifer_dataf
                , iter_edit_data(valid_datai) as valid_datai
                , iter_edit_data(valid_dataf) as valid_dataf
                , ntot_autodic_perv
                , ntot_prescrizioni
                , n_ver_interni
                , n_ver_esterni
                , n_accert_enea
                , n_accert_altri
             from coimrelg
            where cod_relg = :cod_relg
       </querytext>
    </fullquery>

    <fullquery name="sel_relt_id_clsnc_pot">
       <querytext>
           select coalesce(sum(n),0) as n
                , id_pot
             from coimrelt 
            where cod_relg   = :cod_relg
              and id_clsnc   = :id_clsnc
              and id_stclsnc = :id_stclsnc
              and obj_refer  = 'I'
              and sezione    = 'V'
            group by id_pot
       </querytext>
    </fullquery>

    <fullquery name="sel_relt_id_clsnc_pot_per">
       <querytext>
           select coalesce(sum(n),0) as n
                , id_pot
                , id_per
             from coimrelt 
            where cod_relg   = :cod_relg
              and id_clsnc   = :id_clsnc 
              and id_stclsnc = :id_stclsnc
              and obj_refer  = 'I'
              and sezione    = 'V'
            group by id_pot, id_per
       </querytext>
    </fullquery>

    <fullquery name="sel_relt_id_clsnc_pot_comb">
       <querytext>
           select coalesce(sum(n),0) as n
                , id_pot
                , id_comb
             from coimrelt 
            where cod_relg   =  :cod_relg
              and id_clsnc   =  :id_clsnc
              and id_stclsnc =  :id_stclsnc
              and obj_refer  = 'I'
              and sezione    = 'V'
            group by id_pot, id_comb
       </querytext>
    </fullquery>

    <fullquery name="sel_relt_id_clsnc_per">
       <querytext>
           select coalesce(sum(n),0) as n
                , id_per
             from coimrelt 
            where cod_relg   =  :cod_relg
              and id_clsnc   =  :id_clsnc
              and id_stclsnc =  :id_stclsnc
	      and id_pot     =  :id_pot
              and obj_refer  = 'I'
              and sezione    = 'V'
            group by id_per
       </querytext>
    </fullquery>

    <fullquery name="sel_relt_id_clsnc_v_5_1">
       <querytext>
           select coalesce(sum(n),0) as tot_verif
             from coimrelt 
            where cod_relg   =  :cod_relg
              and id_clsnc   =  5
              and id_stclsnc =  1
	      and id_pot     =  :id_pot
              and obj_refer  = 'I'
              and sezione    = 'V'
       </querytext>
    </fullquery>

    <fullquery name="sel_relt_id_clsnc_pot_d">
       <querytext>
           select coalesce(sum(n),0) as n
                , id_pot
             from coimrelt 
            where cod_relg   = :cod_relg
              and id_clsnc   = :id_clsnc
              and obj_refer  = 'I'
              and sezione    = 'V'
            group by id_pot
       </querytext>
    </fullquery>

    <fullquery name="sel_relt_id_clsnc_pot_per_d">
       <querytext>
           select coalesce(sum(n),0) as n
                , id_pot
                , id_per
             from coimrelt 
            where cod_relg   = :cod_relg
              and id_clsnc   = :id_clsnc 
              and obj_refer  = 'I'
              and sezione    = 'V'
            group by id_pot, id_per
       </querytext>
    </fullquery>

    <fullquery name="sel_relt_id_clsnc_pot_comb_d">
       <querytext>
           select coalesce(sum(n),0) as n
                , id_pot
                , id_comb
             from coimrelt 
            where cod_relg   =  :cod_relg
              and id_clsnc   =  :id_clsnc
              and obj_refer  = 'I'
              and sezione    = 'V'
            group by id_pot, id_comb
       </querytext>
    </fullquery>

    <fullquery name="sel_relt_nc_tot">
       <querytext>
           select coalesce(sum(n),0) as n
                , id_pot
             from coimrelt 
            where cod_relg   =  :cod_relg
              and id_clsnc   =  5
              and id_stclsnc =  3
              and obj_refer  = 'I'
              and sezione    = 'V'
            group by id_pot
       </querytext>
    </fullquery>

    <fullquery name="sel_relt_id_clsnc_pot_gend">
       <querytext>
           select coalesce(sum(n),0) as n
                , id_pot
             from coimrelt 
            where cod_relg   = :cod_relg
              and id_clsnc   = :id_clsnc
              and id_stclsnc = :id_stclsnc
              and obj_refer  = 'G'
              and sezione    = 'V'
            group by id_pot
       </querytext>
    </fullquery>



</queryset>
