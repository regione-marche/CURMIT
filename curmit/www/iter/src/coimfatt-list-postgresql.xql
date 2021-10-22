<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_fatt">
       <querytext>
select a.num_fatt
     , a.tipo_sogg
     , a.data_fatt
     , iter_edit_data(a.data_fatt) as data_fatt_edit
     , case tipo_sogg
         when 'M' then coalesce (b.cognome, ' ') ||' '|| coalesce (b.nome, ' ')
         when 'C' then coalesce (c.cognome, ' ') ||' '|| coalesce (c.nome, ' ')
         else ' '
       end as nominativo
     , iter_edit_num((coalesce(a.spe_postali, 0) + a.imponibile), 2) as imponibile_edit
     , cod_fatt
  from coimfatt a
       left outer join coimmanu b on b.cod_manutentore = a.cod_sogg
       left outer join coimcitt c on c.cod_cittadino = a.cod_sogg
 where 1 = 1
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
