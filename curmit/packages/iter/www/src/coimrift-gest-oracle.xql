<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_gest">
       <querytext>
select iter_edit.data(a.data_fin_valid) as data_fin_valid_edit
      ,a.data_fin_valid
      ,a.ruolo
      ,decode (a.ruolo
              , 'M', 'Manutentore'
              , 'I', 'Installatore'
              , 'D', 'Distributore'
              , 'G', 'Progettista'
              , '')   as ruolo_desc
      ,Nvl(c.cognome, '') as cognome
      ,Nvl(c.nome, '')    as nome
  from coimrife a
     , coimmanu c
 where  a.cod_impianto        = :cod_impianto
   and  a.ruolo               = :ruolo
   and  a.data_fin_valid      = :data_fin_valid
   and  c.cod_manutentore (+) = a.cod_soggetto
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
