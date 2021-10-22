<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_fatt">
       <querytext>
select a.num_fatt
     , a.tipo_sogg
     , a.data_fatt
     , iter_edit.data(a.data_fatt) as data_fatt_edit
     , decode (a.tipo_sogg
              ,'M', nvl (b.cognome, ' ') ||' '|| nvl (b.nome, ' ')
              ,'C', nvl (c.cognome, ' ') ||' '|| nvl (c.nome, ' ')
              ,' '
              ) as nominativo
     , iter_edit.num(a.imponibile, 2) as imponibile_edit
     , cod_fatt
  from coimfatt a
     , coimmanu b
     , coimcitt c
 where b.cod_manutentore (+) = a.cod_sogg
   and c.cod_cittadino   (+) = a.cod_sogg
$where_last
$where_word
$where_nome
$where_da_data
$where_a_data
$where_num_fatt
order by data_fatt
       , num_fatt
       </querytext>
    </partialquery>

</queryset>
