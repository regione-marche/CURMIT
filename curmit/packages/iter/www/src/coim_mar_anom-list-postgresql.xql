<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_d_anom">
       <querytext>
(select a.cod_d_tano
     , a.cod_impianto
     , a.data_controllo
     , iter_edit_data(a.data_controllo) as data_controllo_edit
     , iter_edit_data(a.data_invio_lettera) as data_invio_lettera
     , a.descr_breve
  from coim_d_anom a
 where 1 = 1
$where_aimp
$where_last
order by data_controllo
       , to_number(cod_d_tano, '99999999'))

union

(select a.cod_d_tano
     , a.cod_impianto
     , a.data_controllo
     , iter_edit_data(a.data_controllo) as data_controllo_edit
     , iter_edit_data(a.data_invio_lettera) as data_invio_lettera
     , a.descr_breve
  from coim_dm_anom a
 where 1 = 1
$where_aimp
$where_last
order by data_controllo
       , to_number(cod_d_tano, '99999999'))

       </querytext>
    </partialquery>

</queryset>
