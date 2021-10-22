<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_sogg_t">
       <querytext>
select iter_edit_data(a.data_fin_valid) as data_fin_valid_edit
      ,a.data_fin_valid
      ,a.ruolo
      ,case a.ruolo
            when 'M' then 'Manutentore'
            when 'I' then 'Installatore'
            when 'D' then 'Distributore'
            when 'G' then 'Progettista'
            else ''
       end  as des_ruolo
      ,coalesce(c.cognome, '') as cognome
      ,coalesce(c.nome, '')    as nome
  from coimrife a
       left outer join coimmanu c
                  on c.cod_manutentore = a.cod_soggetto
 where  a.cod_impianto = :cod_impianto
   and (a.ruolo = 'M' or
        a.ruolo = 'I')
$where_last
union
select iter_edit_data(a.data_fin_valid) as data_fin_valid_edit
      ,a.data_fin_valid
      ,a.ruolo
      ,case a.ruolo
            when 'M' then 'Manutentore'
            when 'I' then 'Installatore'
            when 'D' then 'Distributore'
            when 'G' then 'Progettista'
            else ''
       end  as des_ruolo
      ,coalesce(d.cognome, '') as cognome
      ,coalesce(d.nome, '')    as nome
  from coimrife a
       left outer join coimprog d
                  on d.cod_progettista = a.cod_soggetto
 where a.cod_impianto = :cod_impianto
   and a.ruolo = 'G'
$where_last
union
select iter_edit_data(a.data_fin_valid) as data_fin_valid_edit
      ,a.data_fin_valid
      ,a.ruolo
      ,case a.ruolo
            when 'M' then 'Manutentore'
            when 'I' then 'Installatore'
            when 'D' then 'Distributore'
            when 'G' then 'Progettista'
            else ''
       end  as des_ruolo
      ,coalesce(e.ragione_01, '') as cognome
      ,coalesce(e.ragione_02, '') as nome
  from coimrife a
       left outer join coimdist e
                  on e.cod_distr = a.cod_soggetto
 where a.cod_impianto = :cod_impianto
   and a.ruolo = 'D'
$where_last
order by data_fin_valid desc, ruolo
       </querytext>
    </partialquery>

</queryset>
