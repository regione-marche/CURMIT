<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    gab01 15/09/2017 Vado in join sulla tabella coimtp_pag per estrarre la descrizione del
    gab01            tipo pagamento senza usare la case when che andrebbe sempre aggiornata.
-->


<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>


    <partialquery name="sel_movi">
       <querytext>
select a.cod_movi
     , b.cod_impianto_est
     , d.descrizione as desc_movi
     --gab01 , case a.tipo_pag
     --gab01  when 'BO' then 'Bollettino prepagato'
     --gab01  when 'BP' then 'Bollettino postale'
     --gab01  when 'CN' then 'Contante a sportello dell''''ente gestore'
     --gab01  when 'BB' then 'Bonifico Bancario'
     --gab01  when 'CC' then 'Carta di Credito'
     --gab01  when 'PS' then 'POS'
     --gab01  else ''
     --gab01  end as desc_pag
     , t.descrizione as desc_pag --gab01
     , iter_edit_data(a.data_scad) as data_scad
     , iter_edit_num(a.importo, 2) as importo_edit
     , iter_edit_num(a.importo_pag, 2) as importo_pag_edit
     , iter_edit_data(a.data_pag) as data_pag
     , iter_edit_data(a.data_compet) as data_compet
     , iter_edit_data(a.data_incasso) as data_incasso
     , nota
     , flag_pagato
     , coalesce(c.cognome, '') as cognome
     , coalesce(c.nome, '') as nome
     , coalesce(c.indirizzo, '') as indirizzo
     , coalesce(c.cap, '') as cap
     , coalesce(c.comune, '') as comune
     , coalesce(c.cod_fiscale, '') as codice_fiscale
  from coimmovi a
       left outer join coimcaus d on a.id_caus = d.id_caus
       left outer join coimtp_pag t on a.tipo_pag = t.cod_tipo_pag --gab01
     , coimaimp b
     , coimcitt c
 where 1 = 1
   and b.cod_impianto = a.cod_impianto
   and b.cod_responsabile = c.cod_cittadino
$where_id_caus
$where_tipo_pag
$where_data_pag
$where_data_scad
$where_importo
$where_data_incasso --san01
$where_data_compet  --sim01
order by cod_movi
       </querytext>
    </partialquery>

</queryset>
