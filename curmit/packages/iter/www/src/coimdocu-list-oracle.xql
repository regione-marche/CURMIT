<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_docu">
       <querytext>
select a.cod_documento
     , iter_edit.data(a.data_stampa) as data_stampa_edit
     , iter_edit.data(a.data_documento) as data_documento_edit
     , iter_edit.data(a.data_notifica) as data_notifica_edit
     , a.descrizione
     , b.descrizione as descr_tipo
  from coimdocu a
     , coimtdoc b
 where 1 = 1
$where_cod_impianto
$where_cod_impianto_est  
   and b.tipo_documento = a.tipo_documento
$where_num_prot
$where_num_prot2
$where_dat_prot
$where_dat_prot2
$where_data_stp
$where_cod_sogg
$where_tipo_doc
$where_last
$where_word
order by a.cod_documento
       </querytext>
    </partialquery>

    <partialquery name="sel_docu_gen">
       <querytext>
select a.cod_documento
     , iter_edit.data(a.data_stampa) as data_stampa_edit
     , iter_edit.data(a.data_documento) as data_documento_edit
     , iter_edit.data(a.data_notifica) as data_notifica_edit
     , a.descrizione
     , b.descrizione as descr_tipo
     , c.cod_impianto_est
     , nvl(d.cognome,'')||' '||nvl(d.nome,'') as nominativo_resp
     , e.denominazione as denom_comune
  from coimdocu a
     , coimtdoc b
     , coimaimp c
     , coimcitt d
     , coimcomu e
 where 1 = 1
   and b.tipo_documento    = a.tipo_documento
   and c.cod_impianto  (+) = a.cod_impianto
   and d.cod_cittadino (+) = a.cod_soggetto
   and e.cod_comune    (+) = c.cod_comune
$where_cod_impianto 
$where_cod_impianto_est 
$where_num_prot
$where_num_prot2
$where_dat_prot
$where_dat_prot2
$where_data_stp
$where_cod_sogg
$where_tipo_doc
$where_last
$where_word
order by a.cod_documento
       </querytext>
    </partialquery>

</queryset>
