<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

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
     , iter_edit.data(a.data_controllo) as data_controllo_edit
     , a.verb_n
     , iter_edit.data(a.data_verb) as data_verb_edit
     , iter_edit.num(a.costo, 2) as costo_verifica_edit
     , a.esito_verifica
     , a.flag_pericolosita
      $sel_imp
      $sel_resp
      $sel_ind
  from coimcimp a
      $coimaimp_ora
      $coimcitt_ora
      $coimviae_ora
      $coiminco_ora
 where 1 = 1
$where_impianto
$where_last
$where_word
$where_data_cont_da
$where_data_cont_a
$where_opve
$where_aimp_ora
$where_citt_ora
$where_inco_ora
$where_viae_ora
$where_verb
order by a.cod_cimp
       </querytext>
    </partialquery>

    <partialquery name="sel_ind">
       <querytext>
                 , nvl(e.descr_topo,'')||' '||nvl(e.descrizione,'')||' '||nvl(b.numero,'') as indir
       </querytext>
    </partialquery>

    <partialquery name="sel_ind2">
       <querytext>
                 , nvl(b.toponimo,'')||' '||nvl(b.indirizzo,'')||' '||nvl(b.numero,'') as indir
       </querytext>
    </partialquery>

    <partialquery name="sel_resp">
       <querytext>
               , d.cognome||' '||nvl(d.nome,'') as resp
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
