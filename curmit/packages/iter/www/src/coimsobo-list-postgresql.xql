<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_boll">
       <querytext>
           select a.cod_bollini
                , b.cognome||' '||coalesce(b.nome, '') as nome_manu
                , a.nr_bollini 
                , iter_edit_data(a.data_scadenza) as data_scadenza
                , iter_edit_data(max(c.data_documento)) as data_stampa
             from coimboll a 
                , coimmanu b
  left outer join coimdocu c on c.cod_soggetto = b.cod_manutentore
                            and c.tipo_documento = 'SO'
        where (   a.pagati is null
               or a.pagati = 'N')
              and a.data_scadenza < current_date
              and b.cod_manutentore = a.cod_manutentore
     group by cod_bollini, cognome, nome, data_scadenza, data_stampa, nr_bollini
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_contenuto">
       <querytext>
          select contenuto as docu_contenuto_check
            from coimdocu
           where cod_documento = :cod_documento
       </querytext>
    </fullquery>


</queryset>
