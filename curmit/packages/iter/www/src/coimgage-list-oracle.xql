<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_gage_si_vie">
       <querytext>
select *
  from (
select a.cod_opma
     , a.cod_impianto
     , case
         when a.stato = '1' then 'Da eseguire'
         when a.stato = '2' then 'Eseguito'
       end                               as stato_ed
     , a.stato
     , iter_edit.data(a.data_prevista)   as data_prevista_edit
     , iter_edit.data(a.data_esecuzione) as data_esecuzione_edit
     , a.data_prevista
     , a.data_esecuzione
     , a.data_ins
     , c.denominazione       as comune
     , nvl(d.descr_topo,'')||' '||
       nvl(d.descrizione,'')||' '||
       nvl(b.numero,'')      as indir
     , d.descrizione         as via
     , b.numero
     , b.cod_impianto_est
     , nvl(e.cognome,' ')||' '||nvl(e.nome,' ')   as resp
  from coimgage a
     , coimaimp b
     , coimcomu c
     , coimviae d
     , coimcitt e
 where 1 = 1
   and e.cod_cittadino (+) = b.cod_responsabile
   and a.cod_opma          =  :cod_manutentore
   and b.cod_impianto      = a.cod_impianto
   and b.stato             = 'A'
   and c.cod_comune    (+) = b.cod_comune
   and d.cod_comune    (+) = b.cod_comune	
   and d.cod_via       (+) = b.cod_via
$where_last
$where_word
$where_stato
$where_data_iniz
$where_data_fine
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
     , case
         when a.stato = '1' then 'Da eseguire'
         when a.stato = '2' then 'Eseguito'
       end                               as stato_ed
     , a.stato
     , iter_edit.data(a.data_prevista)   as data_prevista_edit
     , iter_edit.data(a.data_esecuzione) as data_esecuzione_edit
     , a.data_prevista
     , a.data_esecuzione
     , a.data_ins
     , c.denominazione       as comune
     , nvl(b.toponimo,'')||' '||
       nvl(b.indirizzo,'')||' '||
       nvl(b.numero,'')      as indir
     , b.indirizzo           as via
     , b.numero
     , b.cod_impianto_est
     , nvl(e.cognome,' ')||' '||nvl(e.nome,' ')   as resp
  from coimgage a
     , coimaimp b
     , coimcomu c 
     , coimcitt e
 where 1 = 1
   and e.cod_cittadino (+) = b.cod_responsabile
   and a.cod_opma          =  :cod_manutentore
   and b.cod_impianto      = a.cod_impianto
   and b.stato             = 'A'
   and c.cod_comune    (+) = b.cod_comune
$where_last
$where_word
$where_stato
$where_data_iniz
$where_data_fine
$ordinamento
)
where rownum <= $rows_per_page
       </querytext>
    </partialquery>

</queryset>
