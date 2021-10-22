<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_sogg_s">
       <querytext>
select iter_edit_data(a.data_fin_valid) as data_fin_valid_edit
      ,a.data_fin_valid
      ,a.ruolo
      ,case a.ruolo
            when 'P' then 'Proprietario'
            when 'O' then 'Occupante'
            when 'A' then 'Amministratore'
            when 'R' then 'Responsabile'
            when 'T' then 'Terzo responsabile'
            else ''
       end  as des_ruolo
      ,b.cognome
      ,b.nome
      ,b.cod_fiscale
  from coimrife a
       left outer join coimcitt b
                  on b.cod_cittadino = a.cod_soggetto
 where  a.cod_impianto = :cod_impianto
   and (a.ruolo = 'P' or
        a.ruolo = 'O' or
        a.ruolo = 'A' or
        a.ruolo = 'R' or
        a.ruolo = 'T')
$where_last
order by data_fin_valid desc, upper(ruolo)
       </querytext>
    </partialquery>

</queryset>
