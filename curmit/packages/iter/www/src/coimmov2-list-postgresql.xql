<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    rom01 12/04/2018 toloto il collegamento alla coimdocu in quanto duplicava i movimenti.

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
     --gab01  when 'BO' then 'Bollino'
     --gab01  when 'BP' then 'Bollettino postale'
     --gab01  when 'CN' then 'Contante a sportello dell''''ente gestore'
     --gab01  when 'BB' then 'Bonifico Bancario'
     --gab01  when 'CC' then 'Carta di Credito'
     --gab01  when 'PS' then 'POS'
     --gab01  else ''
     --gab01  end as desc_pag
     , t.descrizione as desc_pag --gab01
     , iter_edit_data(a.data_scad) as data_scad_edit
     , iter_edit_data(a.data_compet) as data_compet_edit
     , iter_edit_num(a.importo, 2) as importo_edit
     , iter_edit_data(a.data_pag) as data_pag_edit
     , coalesce(c.cognome,'')||' '||coalesce(c.nome,'') as nominativo_resp
     --rom01 , coalesce(k.protocollo_01,'') as protocollo_01
     , c.cognome
     , c.nome
  from coimmovi a
       left outer join coimcaus d on a.id_caus = d.id_caus
       --rom01 left outer join coimdocu k on a.cod_impianto = k.cod_impianto
       left outer join coimtp_pag t on a.tipo_pag = t.cod_tipo_pag --gab01
     , coimaimp b
     , coimcitt c
 where 1 = 1
   and b.cod_impianto = a.cod_impianto
   and c.cod_cittadino = b.cod_responsabile
$where_last
$where_word
$where_id_caus
$where_tipo_pag
$where_data_pag
$where_data_scad
$where_data_compet
$where_data_incasso  --san01
$where_importo
--rom01  where_prot
order by c.cognome, c.nome
       </querytext>
    </partialquery>

    <fullquery name="sel_calcola_movi">
       <querytext>
select count(*) as conta_movi
     , iter_edit_num(sum(a.importo), 2) as tot_imp_movi
  from coimmovi a
       left outer join coimcaus d on a.id_caus = d.id_caus
       --rom01 left outer join coimdocu k on a.cod_impianto = k.cod_impianto
     , coimaimp b
     , coimcitt c
 where 1 = 1
   and b.cod_impianto  = a.cod_impianto
   and c.cod_cittadino = b.cod_responsabile
$where_word
$where_id_caus
$where_tipo_pag
$where_data_pag
$where_data_scad
$where_data_compet
$where_data_incasso --san01
$where_importo
--rom01 where_prot
       </querytext>
    </fullquery>


</queryset>
