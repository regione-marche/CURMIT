<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="count_gg_lavoro_opve">
       <querytext>
              select count(distinct(data_controllo)) as gg_lavoro_opve
                from coimcimp
       </querytext>
    </fullquery>

    <fullquery name="count_lettere_spe">
       <querytext>
              select count(*) as lettere_spe
                from coimdocu
       </querytext>
    </fullquery>

    <fullquery name="count_lettere_spe_inf">
       <querytext>
              select count(*) as lettere_spe_inf
                from coimdocu a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
       </querytext>
    </fullquery>

    <fullquery name="count_lettere_spe_sup">
       <querytext>
              select count(*) as lettere_spe_sup
                from coimdocu a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
       </querytext>
    </fullquery>

    <fullquery name="count_riserve">
       <querytext>
              select count(*) as riserve
                from coiminco a
               where data_verifica is not null
                 and ora_verifica is null
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
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff">
       <querytext>
              select count(*) as controlli_eff
                from coimcimp
               where flag_tracciato != 'MA'
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_inf">
       <querytext>
              select count(*) as controlli_eff_inf
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_inf_comb">
       <querytext>
              select b.cod_combustibile
                   , count(*) as controlli_eff_inf_comb
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
            group by b.cod_combustibile
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_sup">
       <querytext>
              select count(*) as controlli_eff_sup
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_sup_comb">
       <querytext>
              select b.cod_combustibile
                   , count(*) as controlli_eff_sup_comb
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
            group by b.cod_combustibile
       </querytext>
    </fullquery>

    <fullquery name="count_controlli_eff_sup">
       <querytext>
              select count(*) as controlli_eff_sup
                from coimcimp
               where esito = 'P'
       </querytext>
    </fullquery>

    <fullquery name="count_mancate_ver">
       <querytext>
              select count(*) as mancate_ver
                from coimcimp
               where flag_tracciato = 'MA'
       </querytext>
    </fullquery>

    <fullquery name="count_negativo_UNI_inf">
       <querytext>
              select count(*) as negativo_UNI_inf
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
                 and (a.new1_co_rilevato > 1000
                 or ((a.indic_fumosita_md > '2' and a.cod_combustibile = '4')
                   or (a.indic_fumosita_md > '6' and a.cod_combustibile = '6'))) 
       </querytext>
    </fullquery>

    <fullquery name="count_negativo_UNI_sup">
       <querytext>
              select count(*) as negativo_UNI_sup
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
                 and (a.new1_co_rilevato > 1000
                 or ((a.indic_fumosita_md > '2' and a.cod_combustibile = '4')
                   or (a.indic_fumosita_md > '6' and a.cod_combustibile = '6'))) 
       </querytext>
    </fullquery>

    <fullquery name="count_negativo_DPR_inf">
       <querytext>
              select count(*) as negativo_DPR_inf
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza < '35'
                 and a.rend_comb_conv < a.rend_comb_min
       </querytext>
    </fullquery>

    <fullquery name="count_negativo_DPR_sup">
       <querytext>
              select count(*) as negativo_DPR_sup
                from coimcimp a,
                     coimaimp b
               where b.cod_impianto = a.cod_impianto
                 and b.potenza >= '35'
                 and a.rend_comb_conv < a.rend_comb_min
       </querytext>
    </fullquery>

</queryset>
