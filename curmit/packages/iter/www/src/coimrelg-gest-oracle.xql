<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_relg_s">
        <querytext>
            select coimrelg_s.nextval
              from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_relg">
       <querytext>
           insert
             into coimrelg 
                ( cod_relg
                , data_rel
                , ente_istat
                , resp_proc
                , nimp_tot_stim_ente
                , nimp_tot_aut_ente
                , nimp_tot_centr_ente
                , nimp_tot_telerisc_ente
                , conv_ass_categ
                , conf_dgr7_7568
                , npiva_ader_conv
                , npiva_ass_acc_reg
                , delib_autodic
                , rifer_datai
                , rifer_dataf
                , valid_datai
                , valid_dataf
                , ntot_autodic_perv
                , ntot_prescrizioni
                , n_ver_interni
                , n_ver_esterni
                , n_accert_enea
                , n_accert_altri
                , nome_file_gen
                , nome_file_tec
                , data_ins
                , data_mod
                , utente)
           values 
                (:cod_relg
                ,:data_rel
                ,:ente_istat
                ,:resp_proc
                ,:nimp_tot_stim_ente
                ,:nimp_tot_aut_ente
                ,:nimp_tot_centr_ente
                ,:nimp_tot_telerisc_ente
                ,:conv_ass_categ
                ,:conf_dgr7_7568
                ,:npiva_ader_conv
                ,:npiva_ass_acc_reg
                ,:delib_autodic
                ,:rifer_datai
                ,:rifer_dataf
                ,:valid_datai
                ,:valid_dataf
                ,:ntot_autodic_perv
                ,:ntot_prescrizioni
                ,:n_ver_interni
                ,:n_ver_esterni
                ,:n_accert_enea
                ,:n_accert_altri
                ,:nome_file_gen
                ,:nome_file_tec
                , sysdate
                , null
                ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="ins_relt">
       <querytext>
           insert
             into coimrelt 
                ( cod_relg
                , cod_relt
                , sezione
                , id_clsnc
                , id_stclsnc
                , obj_refer
                , id_pot
                , id_per
                , id_comb
                , n
                , data_ins
                , data_mod
                , utente)
           values 
                (:cod_relg
                ,:cod_relt
                ,:sezione
                ,:id_clsnc
                ,:id_stclsnc
                ,:obj_refer
                ,:id_pot
                ,:id_per
                ,:id_comb
                ,:n
                , sysdate
                , null
                ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_relg">
       <querytext>
           update coimrelg
              set ente_istat             = :ente_istat
                , resp_proc              = :resp_proc
                , nimp_tot_stim_ente     = :nimp_tot_stim_ente
                , nimp_tot_aut_ente      = :nimp_tot_aut_ente
                , nimp_tot_centr_ente    = :nimp_tot_centr_ente
                , nimp_tot_telerisc_ente = :nimp_tot_telerisc_ente
                , conv_ass_categ         = :conv_ass_categ
                , conf_dgr7_7568         = :conf_dgr7_7568
                , npiva_ader_conv        = :npiva_ader_conv
                , npiva_ass_acc_reg      = :npiva_ass_acc_reg
                , delib_autodic          = :delib_autodic
                , rifer_datai            = :rifer_datai
                , rifer_dataf            = :rifer_dataf
                , valid_datai            = :valid_datai
                , valid_dataf            = :valid_dataf
                , ntot_autodic_perv      = :ntot_autodic_perv
                , ntot_prescrizioni      = :ntot_prescrizioni
                , n_ver_interni          = :n_ver_interni
                , n_ver_esterni          = :n_ver_esterni
                , n_accert_enea          = :n_accert_enea
                , n_accert_altri         = :n_accert_altri
                , nome_file_gen          = :nome_file_gen
                , nome_file_tec          = :nome_file_tec
                , data_mod               =  sysdate
                , utente                 = :id_utente
            where cod_relg               = :cod_relg
       </querytext>
    </partialquery>

    <partialquery name="upd_relt">
       <querytext>
           update coimrelt
              set n          = :n
                , data_mod   =  sysdate
                , utente     = :id_utente
            where cod_relg   = :cod_relg
              and id_clsnc   = :id_clsnc
              and id_stclsnc = :id_stclsnc
              and id_pot     = :id_pot
              and id_per     = :id_per
              and id_comb    = :id_comb
       </querytext>
    </partialquery>

    <partialquery name="del_relg">
       <querytext>
           delete
             from coimrelg
            where cod_relg = :cod_relg
       </querytext>
    </partialquery>

    <partialquery name="del_relt">
       <querytext>
           delete
             from coimrelt
            where cod_relg = :cod_relg
       </querytext>
    </partialquery>

    <fullquery name="sel_relg">
       <querytext>
           select iter_edit.data(data_rel) as data_rel
                , ente_istat
                , resp_proc
                , iter_edit.num(nimp_tot_stim_ente, 0)     as nimp_tot_stim_ente
                , iter_edit.num(nimp_tot_aut_ente, 0)      as nimp_tot_aut_ente
                , iter_edit.num(nimp_tot_centr_ente, 0)    as nimp_tot_centr_ente
                , iter_edit.num(nimp_tot_telerisc_ente, 0) as nimp_tot_telerisc_ente
                , iter_edit.data(conv_ass_categ)           as conv_ass_categ
                , conf_dgr7_7568
                , iter_edit.num(npiva_ader_conv, 0)        as npiva_ader_conv
                , iter_edit.num(npiva_ass_acc_reg, 0)      as npiva_ass_acc_reg
                , delib_autodic
                , iter_edit.data(rifer_datai)              as rifer_datai
                , iter_edit.data(rifer_dataf)              as rifer_dataf
                , iter_edit.data(valid_datai)              as valid_datai
                , iter_edit.data(valid_dataf)              as valid_dataf
                , iter_edit.num(ntot_autodic_perv, 0)      as ntot_autodic_perv
                , iter_edit.num(ntot_prescrizioni, 0)      as ntot_prescrizioni
                , iter_edit.num(n_ver_interni, 0)          as n_ver_interni
                , iter_edit.num(n_ver_esterni, 0)          as n_ver_esterni
                , iter_edit.num(n_accert_enea, 0)          as n_accert_enea
                , iter_edit.num(n_accert_altri, 0)         as n_accert_altri
                , nome_file_gen
                , nome_file_tec
             from coimrelg
            where cod_relg = :cod_relg
       </querytext>
    </fullquery>

    <fullquery name="sel_relt">
       <querytext>
           select iter_edit.num(n,0) as n
             from coimrelt
            where cod_relg   = :cod_relg
              and sezione    = :sezione
              and id_clsnc   = :id_clsnc
              and id_stclsnc = :id_stclsnc
              and obj_refer  = :obj_refer
              and id_pot     = :id_pot
              and id_per     = :id_per
              and id_comb    = :id_comb
       </querytext>
    </fullquery>

    <fullquery name="sel_prov_cod_istat">
        <querytext>
            select cod_istat
              from coimprov
             where cod_provincia = :cod_provincia
       </querytext>
    </fullquery>

    <fullquery name="sel_comu_cod_istat">
        <querytext>
            select cod_istat
              from coimcomu
             where cod_comune = :cod_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_edit_data_rel">
        <querytext>
            select to_char(to_date(:data_rel,'yyyymmdd'),'dd-Mon-yyyy')
              from dual
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_count">
       <querytext>
           select count(*)
             from coimaimp
            where stato    = 'A'
           $where_cod_tpim
           $where_cod_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_data_rel_fine">
        <querytext>
            select to_char(add_months(to_date(:data_rel_iniz,'yyyymmdd')
                                     ,24) -1
                          , 'yyyymmdd')
              from dual
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_count">
       <querytext>
           select count(*)
             from coimdimp
                , coimaimp
            where data_controllo between :data_rel_iniz
                                     and :data_rel_fine
              and coimaimp.cod_impianto = coimdimp.cod_impianto
              and coimaimp.stato       <> 'N'            
           $where_prescrizioni
           $where_cod_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_relg_check">
       <querytext>
           select '1'
             from coimrelg
            where data_rel   = :data_rel
              and ente_istat = :ente_istat
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_non_conformita">
       <querytext>
           select a.cod_impianto
                , a.gen_prog
                , c.cod_potenza
                , c.data_installaz
                , c.cod_combustibile
                , a.manutenzione_8a
                , a.co_fumi_secchi_8b
                , a.indic_fumosita_8c
                , a.rend_comb_8d
                , d.cod_tanom
             from coimcimp a
                , coimaimp c
                , coimanom d
            where a.data_controllo between :data_rel_iniz
                                       and :data_rel_fine
              and a.data_controllo = (
                            select max(b.data_controllo)
                              from coimcimp b
                             where b.cod_impianto         = a.cod_impianto
                               and b.data_controllo between  :data_rel_iniz
                                                        and  :data_rel_fine
                               and b.flag_tracciato <> 'MA')
              and a.flag_tracciato <> 'MA'
              and c.cod_impianto    = a.cod_impianto
              and c.cod_potenza    is not null
              and c.cod_potenza    <> '0'
              and c.stato          <> 'N'
           $where_cod_comune
              and d.cod_cimp_dimp (+) = a.cod_cimp
              and d.flag_origine  (+) =  'RV'
         order by cod_impianto
                , gen_prog
       </querytext>
    </fullquery>
</queryset>
