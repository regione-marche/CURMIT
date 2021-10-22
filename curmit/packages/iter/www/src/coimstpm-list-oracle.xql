<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_stpm">
       <querytext>
     select id_stampa
          , descrizione
       from coimstpm
      where 1 = 1
     $where_last
     $where_word
     order by id_stampa
       </querytext>
    </partialquery>

</queryset>
