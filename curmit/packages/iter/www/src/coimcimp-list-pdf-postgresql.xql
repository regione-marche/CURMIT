<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_cimp">
       <querytext>
select a.cod_cimp
     , a.flag_tracciato
     , (select coimgend.gen_prog_est
          from coimgend
         where coimgend.cod_impianto = a.cod_impianto
           and coimgend.gen_prog     = a.gen_prog
       ) as gen_prog_est          
     , a.cod_inco
     , iter_edit_data(a.data_controllo) as data_controllo_edit
     , a.verb_n
     , iter_edit_data(a.data_verb) as data_verb_edit
     , iter_edit_num(a.costo, 2) as costo_verifica_edit
     , a.esito_verifica
     ,  case a.esito_verifica
       when 'N' then 'Negativo'
       when 'P' then 'Positivo'
         else '' end as esito_veri       
     , a.flag_pericolosita
      $denom_comune
      $sel_imp
      $sel_resp
      $sel_ind
  from coimcimp a
      $coimaimp_pos $where_aimp_pos
      $coimcomu_pos
      $coimcitt_pos $where_citt_pos
      $coimviae_pos $where_viae_pos
      $coiminco_pos $where_inco_pos
 where 1 = 1
$where_impianto
$where_last
$where_word
$where_data_cont_da
$where_data_cont_a
$where_opve
$where_verb
order by a.cod_cimp
       </querytext>
    </partialquery>

   <partialquery name="sel_cimp_conta">
       <querytext>
select count(*)
     from coimcimp a
      $coimaimp_pos $where_aimp_pos
      $coimcomu_pos
      $coimcitt_pos $where_citt_pos
      $coimviae_pos $where_viae_pos
      $coiminco_pos $where_inco_pos
 where 1 = 1
$where_impianto
$where_last
$where_word
$where_data_cont_da
$where_data_cont_a
$where_opve
$where_verb
       </querytext>
    </partialquery>


    <partialquery name="sel_ind">
       <querytext>
                 , coalesce(e.descr_topo,'')||' '||coalesce(e.descrizione,'')||' '||coalesce(b.numero,'') as indir
       </querytext>
    </partialquery>

    <partialquery name="sel_ind2">
       <querytext>
                 , coalesce(b.toponimo,'')||' '||coalesce(b.indirizzo,'')||' '||coalesce(b.numero,'') as indir
       </querytext>
    </partialquery>

    <partialquery name="sel_resp">
       <querytext>
               , d.cognome||' '||coalesce(d.nome,'') as resp
       </querytext>
    </partialquery>

    <fullquery name="sel_prof_nome_menu">
       <querytext>
       select b.nome_menu 
         from coimuten a
            , coimprof b 
        where a.id_utente = :id_utente
          and b.settore   = a.id_settore 
          and b.ruolo     = a.id_ruolo
       </querytext>
    </fullquery>

</queryset>
