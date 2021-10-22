<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_docu">
       <querytext>
select a.cod_documento
     , iter_edit_data(a.data_stampa) as data_stampa_edit
     , iter_edit_data(a.data_documento) as data_documento_edit
     , iter_edit_data(a.data_notifica) as data_notifica_edit
     , a.descrizione
     , b.descrizione as descr_tipo
      from coimdocu a
left outer join coimtdoc b on b.tipo_documento = a.tipo_documento
 where 1 = 1
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
order by to_number(a.cod_documento, '99999999') desc
       </querytext>
    </partialquery>

    <partialquery name="sel_docu_gen">
       <querytext>
select a.cod_documento
     , iter_edit_data(a.data_stampa) as data_stampa_edit
     , iter_edit_data(a.data_documento) as data_documento_edit
     , iter_edit_data(a.data_notifica) as data_notifica_edit
     , a.descrizione
     , b.descrizione as descr_tipo
     , c.cod_impianto_est
     , coalesce(d.cognome,'')||' '||coalesce(d.nome,'') as nominativo_resp
     , e.denominazione as denom_comune
     , coalesce(k.cognome, '') || '-' ||coalesce(a.descrizione,'') as descrizione
  from coimdocu a
  left outer join coimtdoc b on b.tipo_documento = a.tipo_documento
  left outer join coimaimp c on c.cod_impianto   = a.cod_impianto
  left outer join coimcitt d on d.cod_cittadino  = a.cod_soggetto
  left outer join coimcomu e on e.cod_comune     = c.cod_comune
  left outer join coimmanu k on k.cod_manutentore = a.cod_soggetto
 where 1 = 1  
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
order by to_number(a.cod_documento, '99999999') desc
       </querytext>
    </partialquery>

</queryset>
