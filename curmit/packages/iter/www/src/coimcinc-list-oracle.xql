<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_cinc">
       <querytext>
              select cod_cinc
                   , decode(stato
                           , '1', 'Aperta'
                           , '2', 'Chiusa'
                           , '3', 'Preventivata'
                           , '') as desc_stato
                   , descrizione
                   , iter_edit.data(data_inizio) as data_inizio_edit
                   , iter_edit.data(data_fine) as data_fine_edit
                   , data_inizio
                from coimcinc
               where 1 = 1
               $where_last
               $where_word
               order by data_inizio desc, cod_cinc
       </querytext>
    </partialquery>

</queryset>
