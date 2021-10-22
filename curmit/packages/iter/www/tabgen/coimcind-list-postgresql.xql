<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_cind">
       <querytext>
              select cod_cind
                   , case stato
                     when '1' then 'Aperta'
                     when '2' then 'Chiusa'
                     when '3' then 'Preventivata'
                     else ''
                     end as desc_stato
                   , descrizione
                   , iter_edit_data(data_inizio) as data_inizio_edit
                   , iter_edit_data(data_fine) as data_fine_edit
                   , data_inizio
                from coimcind
               where 1 = 1
               $where_last
               $where_word
               order by data_inizio desc, cod_cind
       </querytext>
    </partialquery>

</queryset>
