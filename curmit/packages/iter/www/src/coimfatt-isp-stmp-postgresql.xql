<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =========================================================================

-->

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_movi">
       <querytext>
select a.cod_movi 
     , b.cod_impianto_est
     , coalesce(d.descrizione, '&nbsp;') as desc_movi
     , t.descrizione as desc_pag 
     , coalesce(iter_edit_data(a.data_scad),'&nbsp;') as data_scad
     , iter_edit_num(a.importo, 2) as importo_edit
     , coalesce(iter_edit_num(a.importo_pag, 2), '&nbsp;') as importo_pagato_edit
     , a.importo
     , a.importo_pag
     , coalesce(iter_edit_data(a.data_pag), '&nbsp;') as data_pag
     , iter_edit_data(a.data_compet) as data_compet
     , coalesce(iter_edit_data(a.data_incasso), '&nbsp;') as data_incasso 
     , coalesce(nota, '&nbsp;') as nota
  from coimmovi a
       left outer join coimcaus d on d.id_caus = a.id_caus
       left outer join coimtp_pag t on a.tipo_pag = t.cod_tipo_pag 
     , coimaimp b
 where b.cod_impianto = a.cod_impianto
$where_cod_movi

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
