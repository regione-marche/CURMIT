<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_movi">
       <querytext>
  select cod_movi
       , c.descrizione             as desc_movi
       , b.descrizione             as desc_pag
       , iter_edit_data(data_scad) as data_scad_edit
       , iter_edit_num(importo, 2) as importo_edit
       , iter_edit_data(data_pag)  as data_pag_edit
    from coimmovi a
         left outer join coimtp_pag b on b.cod_tipo_pag = a.tipo_pag
         left outer join coimcaus c on a.id_caus = c.id_caus
   where 1 = 1
     and cod_impianto = :cod_impianto
  $where_last
  $where_word
  order by cod_movi
       </querytext>
    </partialquery>

</queryset>
