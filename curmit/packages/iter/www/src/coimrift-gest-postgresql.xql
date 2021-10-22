<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_gest">
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
       end  as ruolo_desc
      ,coalesce(c.cognome, '') as cognome
      ,coalesce(c.nome, '')    as nome
  from coimrife a
  left outer join coimmanu c on c.cod_manutentore = a.cod_soggetto
 where  a.cod_impianto = :cod_impianto
   and  a.ruolo = :ruolo
   and  a.data_fin_valid = :data_fin_valid
       </querytext>
    </fullquery>

    <partialquery name="del_sogg">
       <querytext>
                delete
                  from coimrife
                 where cod_impianto   = :cod_impianto
                   and ruolo          = :ruolo
                   and data_fin_valid = :data_fin_valid
       </querytext>
    </partialquery>


</queryset>
