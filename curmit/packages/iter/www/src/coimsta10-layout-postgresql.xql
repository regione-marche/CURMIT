?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_tot_imp">
       <querytext>
              select count(*) as tot_imp
                from coimaimp
               where (data_ins between :f_data1 and :f_data2)
       </querytext>
    </fullquery>

    <partialquery name="sel_aimp">
       <querytext>
           select b.cod_impianto
                , b.data_ins
                , d.denominazione as comune 
                , iter_edit_data(b.data_ins)             as data_ins_edit
                 , coalesce($nome_col_toponimo,'')||' '||
                  coalesce($nome_col_via,'')||
                  case
                    when b.numero is null then ''
                    else ', '||b.numero
                  end ||
                  case
                    when b.esponente is null then ''
                    else '/'||b.esponente
                  end ||
                  case
                    when b.scala is null then ''
                    else ' S.'||b.scala
                  end ||
                  case
                    when b.piano is null then ''
                    else ' P.'||b.piano
                  end ||
                  case
                    when b.interno is null then ''
                    else ' In.'||b.interno
                  end                                    as indir
                  ,b.utente_ins   as utente
                  ,b.cod_impianto_est
                  ,coalesce(f.cognome,'') || ' ' || coalesce(f.nome,'') as resp
               from coimaimp b
  left outer join coimcitt c on c.cod_cittadino = b.cod_responsabile
  left outer join coimcomu d on d.cod_comune    = b.cod_comune
  left outer join coimcitt f on f.cod_cittadino = b.cod_responsabile
  left outer join coimviae e on e.cod_comune    = b.cod_comune and e.cod_via = b.cod_via
  where (b.data_ins between :f_data1 and :f_data2)
  order by b.data_ins
         , b.cod_impianto_est
       </querytext>
    </partialquery>

    <fullquery name="sel_inco_stato">
       <querytext>
              select b.descr_inst as stato
                   , count(*) as inco_count_stato
                from coiminco a
                   , coiminst b
               where data_verifica between :f_data1 and :f_data2
                 and b.cod_inst = a.stato
            group by b.descr_inst
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_eff_pote">
       <querytext>
              select c.cod_potenza
                   , c.descr_potenza as potenza
                   , count(*) as inco_count_pote
                from coiminco a
                   , coimaimp b
                   , coimpote c
               where a.data_verifica between :f_data1 and :f_data2
                 and a.stato = '8'
                 and a.cod_impianto = b.cod_impianto
                 and c.cod_potenza = b.cod_potenza
               group by c.descr_potenza, c.cod_potenza
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_eff_tpes_pote">
       <querytext>
              select descr_tpes as tp_estr
                   , count(*) as count_tpes
                from coiminco a
                   , coimtpes b
                   , coimaimp c
               where data_verifica between :f_data1 and :f_data2
                 and a.stato = '8'
                 and cod_tpes = tipo_estrazione
                 and c.cod_impianto = a.cod_impianto
                 and c.cod_potenza = :cod_potenza
               group by descr_tpes
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_eff_tpes">
       <querytext>
              select descr_tpes as tipo_estrazione
                   , count(*) as inco_count_tpes
                from coiminco a
                   , coimtpes b
               where data_verifica between :f_data1 and :f_data2
                 and a.stato = '8'
                 and cod_tpes = tipo_estrazione
               group by descr_tpes
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_motivi_ann">
       <querytext>
              select descr_noin as motivo_ann
                   , count(*) as inco_count_ann
                from coiminco a
                   , coimnoin b
               where data_verifica between :f_data1 and :f_data2
                 and a.stato = '5'
                 and a.cod_noin = b.cod_noin
            group by descr_noin
       </querytext>
    </fullquery>

</queryset>
