<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_tpin">
       <querytext>
select a.descrizione as tipologia_impianto
     , b.cod_coimtpin
  from coimtpin a
     , coimtpin_manu b
 where a.cod_coimtpin = b.cod_coimtpin
   and b.cod_manutentore = :cod_manutentore
       </querytext>
    </partialquery>

</queryset>
