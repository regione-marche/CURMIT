<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_dual_calc_date">
        <querytext>
            select to_char(to_date(:data_prevista,'yyyymmdd')
                          $operatore interval '1 days'
                          , 'yyyymmdd')
              from dual
       </querytext>
    </fullquery>

    <partialquery name="sel_gage_si_vie">
       <querytext>
select a.cod_opma
     , a.cod_impianto
     , a.data_ins
     , case
         when a.stato = '1' then 'Da eseguire'
         when a.stato = '2' then 'Eseguito'
       end                               as stato_ed
     , c.denominazione                   as comune
     , coalesce(d.descr_topo,'')||' '||
       coalesce(d.descrizione,'')||' '||
       coalesce(b.numero,'')             as indir
     , coalesce(e.cognome,' ')||' '||
       coalesce(e.nome,' ')              as resp
     , d.descrizione                     as via
     , b.numero
     , b.cod_impianto_est
  from coimgage a
       inner join coimaimp b on b.cod_impianto  = a.cod_impianto
  left outer join coimcomu c on c.cod_comune    = b.cod_comune
  left outer join coimviae d on d.cod_comune    = b.cod_comune
                            and d.cod_via       = b.cod_via
  left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
 where a.data_prevista = :data_prevista
   and a.cod_opma      = :cod_manutentore
$where_last
$where_word
$ordinamento
limit $rows_per_page
       </querytext>
    </partialquery>

    <partialquery name="sel_gage_no_vie">
       <querytext>
select a.cod_opma
     , a.cod_impianto
     , a.data_ins
     , case
         when a.stato = '1' then 'Da eseguire'
         when a.stato = '2' then 'Eseguito'
       end                             as stato_ed
     , c.denominazione                 as comune
     , coalesce(b.toponimo,'')||' '||
       coalesce(b.indirizzo,'')||' '||
       coalesce(b.numero,'')           as indir
     , coalesce(e.cognome,' ')||' '||
       coalesce(e.nome,' ')            as resp
     , b.indirizzo                     as via
     , b.numero
     , b.cod_impianto_est
  from coimgage a 
       inner join coimaimp b on b.cod_impianto  = a.cod_impianto
  left outer join coimcomu c on c.cod_comune    = b.cod_comune
  left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
 where a.data_prevista = :data_prevista
   and a.cod_opma      = :cod_manutentore
$where_last
$where_word
$ordinamento
limit $rows_per_page
       </querytext>
    </partialquery>

</queryset>
