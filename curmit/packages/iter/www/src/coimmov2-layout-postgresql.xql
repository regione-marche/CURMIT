<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    gab01 15/09/2017 Vado in join sulla tabella coimtp_pag per estrarre la descrizione del
    gab01            tipo pagamento senza usare la case when che andrebbe sempre aggiornata.
-->

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_movi">
       <querytext>
select a.cod_movi
     , b.cod_impianto_est
     , coalesce(d.descrizione, '&nbsp;') as desc_movi
     --gab01 , case a.tipo_pag
     --gab01  when 'BO' then 'Bollino'
     --gab01  when 'BP' then 'Bollettino'
     --gab01  when 'CN' then 'Contante'
     --gab01  when 'BB' then 'Bonifico'
     --gab01  when 'CC' then 'Carta di cred.'
     --gab01  when 'PS' then 'POS'
     --gab01  else ''
     --gab01  end as desc_pag
     , t.descrizione as desc_pag --gab01
     , coalesce(iter_edit_data(a.data_scad),'&nbsp;') as data_scad
     , iter_edit_num(a.importo, 2) as importo_edit
     , coalesce(iter_edit_num(a.importo_pag, 2), '&nbsp;') as importo_pagato_edit
     , a.importo
     , a.importo_pag
     , coalesce(iter_edit_data(a.data_pag), '&nbsp;') as data_pag
     , iter_edit_data(a.data_compet) as data_compet
     , coalesce(iter_edit_data(a.data_incasso), '&nbsp;') as data_incasso --san01
     , coalesce(nota, '&nbsp;') as nota
  from coimmovi a
       left outer join coimcaus d on d.id_caus = a.id_caus
       left outer join coimtp_pag t on a.tipo_pag = t.cod_tipo_pag --gab01
     , coimaimp b
 where b.cod_impianto = a.cod_impianto
$where_id_caus
$where_tipo_pag
$where_data_pag
$where_data_scad
$where_importo
$where_data_incasso --san01
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
