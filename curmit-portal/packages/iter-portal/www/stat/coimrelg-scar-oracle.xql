<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_relg">
       <querytext>
           select to_char(data_rel,'dd-Mon-yyyy')       as data_rel
                , ente_istat
                , resp_proc
                , nimp_tot_stim_ente
                , nimp_tot_aut_ente
                , nimp_tot_centr_ente
                , nimp_tot_telerisc_ente
                , to_char(conv_ass_categ,'dd-Mon-yyyy') as conv_ass_categ
                , conf_dgr7_7568
                , npiva_ader_conv                       as npiva_ader_conv
                , npiva_ass_acc_reg                     as npiva_ass_acc_reg
                , delib_autodic
                , to_char(rifer_datai,'dd-Mon-yyyy')    as rifer_datai
                , to_char(rifer_dataf,'dd-Mon-yyyy')    as rifer_dataf
                , to_char(valid_datai,'dd-Mon-yyyy')    as valid_datai
                , to_char(valid_dataf,'dd-Mon-yyyy')    as valid_dataf
                , ntot_autodic_perv                     as ntot_autodic_perv
                , ntot_prescrizioni                     as ntot_prescrizioni
                , n_ver_interni                         as n_ver_interni
                , n_ver_esterni                         as n_ver_esterni
                , n_accert_enea                         as n_accert_enea
                , n_accert_altri                        as n_accert_altri
                , nome_file_gen
                , nome_file_tec
             from coimrelg
            where cod_relg = :cod_relg
       </querytext>
    </fullquery>

</queryset>
