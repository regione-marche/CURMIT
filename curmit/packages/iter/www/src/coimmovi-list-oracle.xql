<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_movi">
       <querytext>
select cod_movi
      ,decode (tipo_movi
       , 'MH' , 'Pagamento per dichiarazione'
       , 'VC' , 'Pagamento onere visita di controllo'
       , 'PR' , 'Provvedimento'
       , 'GE' , 'Generico'
       , '') as desc_movi
      ,decode (tipo_pag
       , 'BO', 'Bollino Prepagato'
       , 'BP', 'Bollettino postale'
       , 'CN', 'Contante a sportello dell''''ente gestore'
       , 'BB', 'Bonifico Bancario'
       , 'CC', 'Carta di Credito'
       , 'PS', 'POS'
       , '') as desc_pag
     , iter_edit.data(data_scad) as data_scad_edit
     , iter_edit.num(importo, 2) as importo_edit
     , iter_edit.data(data_pag) as data_pag_edit
  from coimmovi
 where 1 = 1
   and cod_impianto = :cod_impianto
$where_last
$where_word
order by cod_movi
       </querytext>
    </partialquery>

</queryset>
