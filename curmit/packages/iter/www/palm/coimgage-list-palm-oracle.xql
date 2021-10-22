<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_dual_calc_date">
        <querytext>
            select to_char(  to_date(:data_prevista,'yyyymmdd')
                            $operatore 1
                          , 'yyyymmdd')
              from dual
       </querytext>
    </fullquery>

    <partialquery name="sel_gage_si_vie">
       <querytext>
select *
  from (
select a.cod_opma
     , a.cod_impianto
     , a.data_ins
     , case
         when a.stato = '1' then 'Da eseguire'
         when a.stato = '2' then 'Eseguito'
       end                          as stato_ed
     , a.stato
     , c.denominazione              as comune
     , nvl(d.descr_topo,'')||' '||
       nvl(d.descrizione,'')||' '||
       nvl(b.numero,'')             as indir
     , nvl(e.cognome,' ')||' '||
       nvl(e.nome,' ')              as resp
     , d.descrizione                as via
     , b.numero
     , b.cod_impianto_est
  from coimgage a
     , coimaimp b
     , coimcomu c
     , coimviae d
     , coimcitt e
 where a.data_prevista     =  :data_prevista
   and a.cod_opma          =  :cod_manutentore
   and b.cod_impianto      = a.cod_impianto
   and c.cod_comune    (+) = b.cod_comune
   and d.cod_comune    (+) = b.cod_comune
   and d.cod_via       (+) = b.cod_via
   and e.cod_cittadino (+) = b.cod_responsabile
$where_last
$where_word
$ordinamento
)
where rownum <= $rows_per_page
       </querytext>
    </partialquery>

    <partialquery name="sel_gage_no_vie">
       <querytext>
select *
  from (
select a.cod_opma
     , a.cod_impianto
     , a.data_ins
     , case
         when a.stato = '1' then 'Da eseguire'
         when a.stato = '2' then 'Eseguito'
       end                        as stato_ed
     , a.stato
     , c.denominazione            as comune
     , nvl(b.toponimo,'')||' '||
       nvl(b.indirizzo,'')||' '||
       nvl(b.numero,'')           as indir
     , nvl(e.cognome,' ')||' '||
       nvl(e.nome,' ')            as resp
     , b.indirizzo                as via
     , b.numero
     , b.cod_impianto_est
  from coimgage a
     , coimaimp b
     , coimcomu c 
     , coimcitt e
 where a.data_prevista     =  :data_prevista
   and a.cod_opma          =  :cod_manutentore
   and b.cod_impianto      = a.cod_impianto
   and c.cod_comune    (+) = b.cod_comune
   and e.cod_cittadino (+) = b.cod_responsabile
$where_last
$where_word
$ordinamento
)
where rownum <= $rows_per_page
       </querytext>
    </partialquery>

</queryset>
