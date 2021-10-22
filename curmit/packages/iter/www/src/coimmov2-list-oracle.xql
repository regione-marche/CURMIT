<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_movi">
       <querytext>
select a.cod_movi
     , b.cod_impianto_est
     , decode (a.tipo_movi
       , 'MH' , 'Pagamento per autocertificazione'
       , 'VC' , 'Pagamento onere visita di controllo'
       , 'ST' , 'Provvedimento'
       , 'GE' , 'Generico'
       , '') as desc_movi
     , decode (a.tipo_pag
       , 'BO', 'Bollino Prepagato'
       , 'BP', 'Bollettino postale'
       , 'CN', 'Contante a sportello dell''''ente gestore'
       , 'BB', 'Bonifico Bancario'
       , 'CC', 'Carta di Credito'
       , 'PS', 'POS'
       , '') as desc_pag
     , iter_edit.data(a.data_scad) as data_scad_edit
     , iter_edit.data(a.data_compet) as data_compet_edit
     , iter_edit.num(a.importo, 2) as importo_edit
     , iter_edit.data(a.data_pag) as data_pag_edit
     , nvl(c.cognome,'')||' '||nvl(c.nome,'') as nominativo_resp
     , c.cognome
     , c.nome
  from coimmovi a
     , coimaimp b
     , coimcitt c
 where 1 = 1
   and b.cod_impianto  = a.cod_impianto
   and c.cod_cittadino = b.cod_responsabile
$where_last
$where_word
$where_id_caus
$where_tipo_pag
$where_data_pag
$where_data_scad
$where_importo
$where_data_compet
order by c.cognome, c.nome
       </querytext>
    </partialquery>


    <fullquery name="sel_calcola_movi">
       <querytext>
select count(*) as conta_movi
     , iter_edit.num(sum(a.importo), 2) as tot_imp_movi
  from coimmovi a
       left outer join coimcaus d on a.id_caus = d.id_caus
     , coimaimp b
     , coimcitt c
 where 1 = 1
   and b.cod_impianto = a.cod_impianto
   and c.cod_cittadino = b.cod_responsabile
$where_word
$where_id_caus
$where_tipo_pag
$where_data_pag
$where_data_scad
$where_importo
$where_data_compet
       </querytext>
    </fullquery>


</queryset>
