<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_prvv">
       <querytext>
select cod_prvv
      ,decode (causale
       , 'MC' , 'Mancato pagamento'
       , 'SN' , 'Sanzione per inadempienze sull''impianto'
       , 'GE' , 'Generico'
       , '') as desc_causale
     , iter_edit.data(data_provv) as data_provv_edit
  from coimprvv
 where 1 = 1
   and cod_impianto = :cod_impianto
$where_last
$where_word
order by cod_prvv
       </querytext>
    </partialquery>

</queryset>
