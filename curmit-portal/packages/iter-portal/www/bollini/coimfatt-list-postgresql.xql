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
         when 'M' then coalesce(b.name, t.name)
         when 'C' then coalesce (c.cognome, ' ')||' '||coalesce (c.nome, ' ')
         else ' '
       end as nominativo
     , iter_edit_num(a.imponibile, 2) as imponibile_edit
     , iter_edit_num(a.importo, 2)    as importo_edit
     , a.cod_fatt
     , case flag_pag when 'N' then 'No' when 'S' then 'Si' else '' end as pagato
     , iter_edit_data(a.data_scadenza) as data_scad_edit
     , iter_edit_data(a.data_pag)      as data_pag_edit
     , iter_edit_num(a.importo_pag, 2) as importo_pag_edit
  from coimfatt a
       left outer join iter_maintainers b on b.iter_code = a.cod_sogg
       left outer join iter_maint_2 t on t.maint_2_id::varchar = a.cod_sogg
       left outer join coimcitt c on c.cod_cittadino = a.cod_sogg
 where 1 = 1
 $where_last
 $where_f_manu
 $where_word
 $where_da_data
 $where_a_data
 $where_num_fatt
 $where_flag
order by data_fatt, num_fatt
    </querytext>
    </partialquery>

</queryset>
