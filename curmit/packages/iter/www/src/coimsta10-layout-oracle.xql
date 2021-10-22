<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="count_lettere_spe">
       <querytext>
              select count(*) as lettere_spe
                from coimdocu
               where data_documento between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_lettere_spe_inf">
       <querytext>
              select count(*) as lettere_spe_inf
                from coimdocu a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
                 and data_documento between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_lettere_spe_sup">
       <querytext>
              select count(*) as lettere_spe_sup
                from coimdocu a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
                 and data_documento between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_riserve">
       <querytext>
              select count(*) as riserve
                from coiminco a
               where data_verifica is not null
                 and ora_verifica is null
                 and data_verifica between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_riserve_inf">
       <querytext>
              select count(*) as riserve_inf
                from coiminco a,
                     coimaimp b
               where a.data_verifica is not null
                 and a.ora_verifica is null
                 and b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
                 and data_verifica between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_riserve_sup">
       <querytext>
              select count(*) as riserve_sup
                from coiminco a,
                     coimaimp b
               where a.data_verifica is not null
                 and a.ora_verifica is null
                 and b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
                 and data_verifica between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff">
       <querytext>
              select count(*) as controlli_eff
                from coimcimp
               where flag_tracciato != 'MA'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_inf">
       <querytext>
              select count(*) as controlli_eff_inf
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_inf_nnoto">
       <querytext>
              select count(*) as controlli_eff_inf_nnoto
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
                 and a.cod_combustibile = '0'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_inf_gas">
       <querytext>
              select count(*) as controlli_eff_inf_gas
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
                 and a.cod_combustibile = 'G'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_inf_kero">
       <querytext>
              select count(*) as controlli_eff_inf_kero
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
                 and a.cod_combustibile = 'K'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_inf_naft">
       <querytext>
              select count(*) as controlli_eff_inf_naft
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
                 and a.cod_combustibile = 'N'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_inf_gaso">
       <querytext>
              select count(*) as controlli_eff_inf_gaso
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
                 and a.cod_combustibile = 'O'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_inf_gpl">
       <querytext>
              select count(*) as controlli_eff_inf_gpl
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
                 and a.cod_combustibile = 'P'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_inf_altro">
       <querytext>
              select count(*) as controlli_eff_inf_altro
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
                 and a.cod_combustibile = 'X'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_sup">
       <querytext>
              select count(*) as controlli_eff_sup
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_sup_nnoto">
       <querytext>
              select count(*) as controlli_eff_sup_nnoto
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
                 and a.cod_combustibile = '0'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_sup_gas">
       <querytext>
              select count(*) as controlli_eff_sup_gas
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
                 and a.cod_combustibile = 'G'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_sup_kero">
       <querytext>
              select count(*) as controlli_eff_sup_kero
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
                 and a.cod_combustibile = 'K'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_sup_naft">
       <querytext>
              select count(*) as controlli_eff_sup_naft
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
                 and a.cod_combustibile = 'N'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_sup_gaso">
       <querytext>
              select count(*) as controlli_eff_sup_gaso
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
                 and a.cod_combustibile = 'O'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_sup_gpl">
       <querytext>
              select count(*) as controlli_eff_sup_gpl
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
                 and a.cod_combustibile = 'P'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_sup_altro">
       <querytext>
              select count(*) as controlli_eff_sup_altro
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
                 and a.cod_combustibile = 'X'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_pos">
       <querytext>
              select count(*) as controlli_eff_pos
                from coimcimp
               where esito_verifica = 'P'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_mancate_ver">
       <querytext>
              select count(*) as mancate_ver
                from coimcimp
               where flag_tracciato = 'MA'
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_con_note">
       <querytext>
              select count(distinct(cod_cimp_dimp)) as controlli_con_note
                from coimanom a,
                     coimcimp b
               where a.cod_cimp_dimp = b.cod_cimp
                 and b.data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_negativo_uni_inf">
       <querytext>
              select count(*) as negativo_uni_inf
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
                 and data_controllo between :f_data1 and :f_data2
                 and (a.new1_co_rilevato > 1000
                 or ((a.indic_fumosita_md > '2' and a.cod_combustibile = '4')
                   or (a.indic_fumosita_md > '6' and a.cod_combustibile = '6'))) 
       </querytext>
    </fullquery>

    <fullquery name="count_negativo_uni_sup">
       <querytext>
              select count(*) as negativo_uni_sup
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
                 and data_controllo between :f_data1 and :f_data2
                 and (a.new1_co_rilevato > 1000
                 or ((a.indic_fumosita_md > '2' and a.cod_combustibile = '4')
                   or (a.indic_fumosita_md > '6' and a.cod_combustibile = '6'))) 
       </querytext>
    </fullquery>

    <fullquery name="count_negativo_dpr_inf">
       <querytext>
              select count(*) as negativo_dpr_inf
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
                 and a.rend_comb_conv < a.rend_comb_min
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_negativo_dpr_sup">
       <querytext>
              select count(*) as negativo_dpr_sup
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
                 and a.rend_comb_conv < a.rend_comb_min
                 and data_controllo between :f_data1 and :f_data2
       </querytext>
    </fullquery>

    <fullquery name="count_ver_1998">
       <querytext>
              select count(*) as ver_98
                from coimcimp
               where data_controllo between '1998-01-01' and '1998-12-31'
       </querytext>
    </fullquery>

    <fullquery name="count_ver_1999">
       <querytext>
              select count(*) as ver_99
                from coimcimp
               where data_controllo between '1999-01-01' and '1999-12-31'
       </querytext>
    </fullquery>

    <fullquery name="count_ver_2000">
       <querytext>
              select count(*) as ver_00
                from coimcimp
               where data_controllo between '2000-01-01' and '2000-12-31'
       </querytext>
    </fullquery>

    <fullquery name="count_ver_2001">
       <querytext>
              select count(*) as ver_01
                from coimcimp
               where data_controllo between '2001-01-01' and '2001-12-31'
       </querytext>
    </fullquery>

    <fullquery name="count_ver_2002">
       <querytext>
              select count(*) as ver_02
                from coimcimp
               where data_controllo between '2002-01-01' and '2002-12-31'
       </querytext>
    </fullquery>

    <fullquery name="count_ver_2003">
       <querytext>
              select count(*) as ver_03
                from coimcimp
               where data_controllo between '2003-01-01' and '2003-12-31'
       </querytext>
    </fullquery>

    <fullquery name="count_ver_2004">
       <querytext>
              select count(*) as ver_04
                from coimcimp
               where data_controllo between '2004-01-01' and '2004-12-31'
       </querytext>
    </fullquery>

    <fullquery name="count_ver_2005">
       <querytext>
              select count(*) as ver_05
                from coimcimp
               where data_controllo between '2005-01-01' and '2005-12-31'
       </querytext>
    </fullquery>

</queryset>
