<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_sogg_t">
       <querytext>
select iter_edit.data(a.data_fin_valid) as data_fin_valid_edit
      ,a.data_fin_valid
      ,a.ruolo
      ,decode (a.ruolo
              , 'M', 'Manutentore'
              , 'I', 'Installatore'
              , 'D', 'Distributore'
              , 'G', 'Progettista'
              , '')   as des_ruolo
      ,Nvl(c.cognome, '') as cognome
      ,Nvl(c.nome, '')    as nome
  from coimrife a
      ,coimmanu c
 where  a.cod_impianto = :cod_impianto
   and (a.ruolo = 'M' or
        a.ruolo = 'I')
   and  c.cod_manutentore (+) = a.cod_soggetto
$where_last
union
select iter_edit.data(a.data_fin_valid) as data_fin_valid_edit
      ,a.data_fin_valid
      ,a.ruolo
      ,decode (a.ruolo
              , 'M', 'Manutentore'
              , 'I', 'Installatore'
              , 'D', 'Distributore'
              , 'G', 'Progettista'
              , '')   as des_ruolo
      ,Nvl(d.cognome, '') as cognome
      ,Nvl(d.nome, '')    as nome
  from coimrife a
      ,coimprog d
 where a.cod_impianto = :cod_impianto
   and a.ruolo = 'G'
   and d.cod_progettista (+) = a.cod_soggetto
$where_last
union
select iter_edit.data(a.data_fin_valid) as data_fin_valid_edit
      ,a.data_fin_valid
      ,a.ruolo
      ,decode (a.ruolo
              , 'M', 'Manutentore'
              , 'I', 'Installatore'
              , 'D', 'Distributore'
              , 'G', 'Progettista'
              , '')   as des_ruolo
      ,Nvl(e.ragione_01, '') as cognome
      ,Nvl(e.ragione_02, '') as nome
  from coimrife a
      ,coimdist e
 where a.cod_impianto = :cod_impianto
   and a.ruolo = 'D'
   and e.cod_distr (+) = a.cod_soggetto
$where_last
order by data_fin_valid desc, ruolo
       </querytext>
    </partialquery>

 
</queryset>
