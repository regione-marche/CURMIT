<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_dual_data_calc">
       <querytext>
                   select to_char(add_months(sysdate, -to_number(:mesi_sub,'99999990')), 'yyyy-mm-dd') as data_calc
                     from dual
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
                   select descrizione as desc_camp
                     from coimcinc
                    where cod_cinc = :cod_cinc
       </querytext>
    </fullquery>

    <partialquery name="col_random">
       <querytext>
                   dbms_random.random
       </querytext>
    </partialquery>

    <partialquery name="sel_aimp_si_vie">
       <querytext>
       select *
         from (
                select /* FIRST_ROWS */
                       a.cod_impianto
                     , a.cod_impianto_est
                     , nvl(b.cognome,'')||' '||
                       nvl(b.nome, '') as nome_resp
		     , nvl(d.descr_topo,'')||' '||
                       nvl(d.descrizione, '')||' '||
                       nvl(a.numero,'') as via
		     , c.denominazione as comune
                      $sel_num_cimp
                  from coimaimp a
		     , coimcitt b
                     , coimcomu c
		     , coimviae d
                     $from_dimp
                     $from_dipe
                     $from_anom
                 where a.flag_dpr412       = 'S'
                   and c.cod_comune    (+) = a.cod_comune
		   and d.cod_comune    (+) = a.cod_comune
		   and d.cod_via       (+) = a.cod_via
                   and b.cod_cittadino (+) = a.cod_responsabile
                $where_dimp
                $where_dipe
                $where_anom
		$where_dich
		$where_pote
                $where_comb
		$where_comune
		$where_via
		$where_anno
		$where_word
                $where_area
                $where_stato
                   and not exists (select '1'
                                     from coiminco d
                                    where d.cod_impianto = a.cod_impianto
                                      and d.cod_cinc     =  :cod_cinc)
                   and not exists (select '1'
                                     from coimcimp e
                                    where e.cod_impianto    = a.cod_impianto
                                      and e.data_controllo >=  :data_controllo
                                      and flag_tracciato <> 'MA'
                                  )
                $order_by
         )
         where rownum <= $num_max

       </querytext>
    </partialquery>

    <partialquery name="sel_aimp_no_vie">
       <querytext>
       select *
         from (
                select /* FIRST_ROWS */
		       a.cod_impianto
                     , a.cod_impianto_est
                     , nvl(b.cognome,'')||' '||
                       nvl(b.nome, '') as nome_resp
		     , nvl(a.toponimo,'')||' '||
                       nvl(a.indirizzo, '')||' '||
                       nvl(a.numero,'') as via
		     , c.denominazione as comune
                      $sel_num_cimp
                  from coimaimp a
		     , coimcitt b
                     , coimcomu c
                     $from_dimp
                     $from_dipe
                     $from_anom
                 where a.flag_dpr412       = 'S'
                   and c.cod_comune    (+) = a.cod_comune
                   and b.cod_cittadino (+) = a.cod_responsabile
                $where_dimp
                $where_dipe
                $where_anom
		$where_dich
		$where_pote
                $where_comb
		$where_comune
                $where_via
		$where_anno
		$where_word
                $where_area
                $where_stato
                   and not exists (select '1'
                                     from coiminco d
                                    where d.cod_impianto = a.cod_impianto
                                      and d.cod_cinc     =  :cod_cinc)
                   and not exists (select '1'
                                     from coimcimp e
                                    where e.cod_impianto    = a.cod_impianto
                                      and e.data_controllo >=  :data_controllo
                                      and flag_tracciato <> 'MA'
                                  )
                $order_by
         )
         where rownum <= $num_max
       </querytext>
    </partialquery>

    <partialquery name="count_aimp">
       <querytext>
                select count(*) as num_imp
                  from coimaimp a
                  $from_dimp
                  $from_dipe
                  $from_anom
                 where a.flag_dpr412 = 'S'
                $where_dimp
                $where_dipe
                $where_anom
		$where_dich
		$where_pote
                $where_comb
		$where_comune
                $where_via
		$where_anno
		$where_word
		$where_area
                $where_stato
		$where_ragr
		$where_peso
		$where_anomalie
                   and not exists (select '1'
                                     from coiminco d
                                    where d.cod_impianto = a.cod_impianto
                                      and d.cod_cinc     =  :cod_cinc)
                   and not exists (select '1'
                                     from coimcimp e
                                    where e.cod_impianto    = a.cod_impianto
                                      and e.data_controllo >=  :data_controllo
                                      and flag_tracciato <> 'MA'
                                  )
                $order_by
       </querytext>
    </partialquery>

    <fullquery name="sel_cmar">
       <querytext>
           select cod_comune
             from coimcmar
            where cod_area = :cod_area
       </querytext>
    </fullquery>

    <fullquery name="sel_area_tipo_01">
       <querytext>
               select tipo_01
                 from coimarea 
                where cod_area = :cod_area
       </querytext>
    </fullquery>

    <fullquery name="sel_tpes">
       <querytext>
                   select descr_tpes
                     from coimtpes
                    where cod_tpes = :tipo_estrazione
		    order by cod_tpes
       </querytext>
    </fullquery>

</queryset>
