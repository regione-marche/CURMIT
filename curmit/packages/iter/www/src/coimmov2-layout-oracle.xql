<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


    <fullquery name="sel_movi">
       <querytext>
select a.cod_movi
     , b.cod_impianto_est
     , decode (a.tipo_movi
       , 'MH' , 'Pagamento per dichiarazione'
       , 'VC' , 'Pagamento onere visita di controllo'
       , 'PR' , 'Provvedimento'
       , 'GE' , 'Generico'
       , '') as desc_movi
     , decode (a.tipo_pag
       , 'BO', 'Bollino'
       , 'BP', 'Bollettino'
       , 'CN', 'Contante'
       , 'BB', 'Bonifico'
       , 'CC', 'Carta di cred.'
       , 'PS', 'POS'
       , '') as desc_pag
     , iter_edit.data(a.data_scad) as data_scad
     , iter_edit.num(a.importo, 2) as importo_edit
     , iter_edit.num(a.importo_pag, 2) as importo_pagato_edit
     , a.importo
     , a.importo_pag
     , iter_edit.data(a.data_pag) as data_pag
     , iter_edit.data(a.data_compet) as data_compet
     , nota
  from coimmovi a
     , coimaimp b
 where 1 = 1
   and b.cod_impianto = a.cod_impianto
$where_id_caus
$where_tipo_pag
$where_data_pag
$where_data_scad
$where_importo
order by cod_movi
       </querytext>
    </fullquery>
  
    <fullquery name="get_desc_prov">
       <querytext>
                   select initcap(denominazione) as desc_prov
                     from coimprov
                    where cod_provincia = :cod_prov
       </querytext>
    </fullquery>

</queryset>
