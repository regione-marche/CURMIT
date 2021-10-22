?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_boll">
       <querytext>
              select coalesce(b.cognome, '&nbsp;')||' '||coalesce(b.nome, '') as manutentore
                   , iter_edit_data(a.data_consegna) as data_consegna
                   , coalesce(iter_edit_data(a.data_scadenza), '&nbsp;') as data_scadenza
                   , a.nr_bollini
                   , a.costo_unitario
                   , iter_edit_num(a.costo_unitario, 2) as costo_unitario_ed
                   , a.matricola_da
                   , a.matricola_a
                   , a.pagati
                   , c.num_fatt --gab01
                   , c.mod_pag  --gab01
                from coimboll a
                   , coimmanu b
                   , coimfatt c --gab01
               where a.cod_manutentore = b.cod_manutentore
                 and a.cod_fatt        = c.cod_fatt --gab01
                --     and a.pagati = 'N'
                     $where_cond
            order by c.num_fatt --gab01
                   , b.cognome
                   , a.matricola_da
       </querytext>
    </fullquery>

</queryset>
