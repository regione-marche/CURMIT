<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_boll">
       <querytext>
              select nvl(b.cognome, '')||' '||nvl(b.nome, '') as manutentore
                   , iter_edit.data(a.data_consegna) as data_consegna
                   , iter_edit.data(a.data_scadenza) as data_scadenza
                   , a.nr_bollini
                   , a.costo_unitario
                   , iter_edit.num(a.costo_unitario, 2) as costo_unitario_ed
                   , a.matricola_da
                   , a.matricola_a
                from coimboll a
                   , coimmanu b
               where a.cod_manutentore = b.cod_manutentore
                     and a.pagati = 'N'
                     $where_cond
            order by b.cognome, a.matricola_da
       </querytext>
    </fullquery>

</queryset>
