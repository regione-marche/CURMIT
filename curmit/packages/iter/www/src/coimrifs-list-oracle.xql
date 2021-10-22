<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_sogg_s">
       <querytext>
select iter_edit.data(a.data_fin_valid) as data_fin_valid_edit
      ,a.data_fin_valid
      ,a.ruolo
      ,decode (a.ruolo
              , 'P', 'Proprietario'
              , 'O', 'Occupante'
              , 'A', 'Amministratore'
              , 'R', 'Responsabile'
              , 'T', 'Intestatario'
              , '')   as des_ruolo
      ,b.cognome
      ,b.nome
      ,b.cod_fiscale
  from coimrife a
     , coimcitt b
 where  a.cod_impianto = :cod_impianto
   and (a.ruolo = 'P' or
        a.ruolo = 'O' or
        a.ruolo = 'A' or
        a.ruolo = 'R' or
        a.ruolo = 'T')
   and  b.cod_cittadino (+) = a.cod_soggetto
$where_last
order by data_fin_valid desc, upper(ruolo)
       </querytext>
    </partialquery>


    <partialquery name="del_sogg">
       <querytext>
                delete
                  from coimrife
                 where cod_impianto   = :cod_impianto
                   and ruolo          = :ruolo_canc
                   and data_fin_valid = :data_canc
       </querytext>
    </partialquery>

</queryset>
