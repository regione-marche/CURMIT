<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_rfis">
       <querytext>
select a.num_rfis
     , a.tipo_sogg
     , a.data_rfis
     , iter_edit_data(a.data_rfis) as data_rfis_edit
     , case tipo_sogg
         when 'M' then coalesce (b.cognome, ' ') ||' '|| coalesce (b.nome, ' ')
         when 'C' then coalesce (c.cognome, ' ') ||' '|| coalesce (c.nome, ' ')
         else ' '
       end as nominativo
     , iter_edit_num(a.imponibile, 2) as imponibile_edit
     , cod_rfis
  from coimrfis a
       left outer join coimmanu b on b.cod_manutentore = a.cod_sogg
       left outer join coimcitt c on c.cod_cittadino = a.cod_sogg
 where 1 = 1
$where_last
$where_word
$where_nome
$where_da_data
$where_a_data
$where_num_rfis
order by data_rfis
       , num_rfis
    </querytext>
    </partialquery>

</queryset>
