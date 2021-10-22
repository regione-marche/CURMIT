<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_tari">
       <querytext>
select iter_edit.num(a.tipo_costo, 0) as tipo_costo_edit
     , a.tipo_costo
     , decode (tipo_costo
        ,'1' , 'Autocertificazione'
        ,'2' , 'Verifica'
        ,'3' , 'Verifica generatore aggiuntivo'
        ,'4' , 'Sanzioni per inadempienze tecniche'
        ,'5' , 'Mancata verifica'
        ,'6' , 'Tariffa verificatore'
       ) as tipo_costo_edit
     , b.descr_potenza
     , a.cod_potenza
     , a.data_inizio
     , iter_edit.num(a.importo, 2) as importo_edit
     , iter_edit.data(a.data_inizio) as data_inizio_edit
  from coimtari a  
     , coimpote b
 where 1 = 1
   and a.cod_listino = :cod_listino
   and b.cod_potenza = a.cod_potenza
 $where_last
order by tipo_costo, cod_potenza, data_inizio
       </querytext>
    </partialquery>

</queryset>
