<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
       <querytext>
              select a.cod_urb
                        , a.cod_comune
                        , a.descrizione 
                        , b.denominazione
                     from coimcurb a
                        , coimcomu b
                    where 1 = 1
                      and b.cod_comune = a.cod_comune 
                    $where_last
                    $where_word
                     order by cod_urb,
                              cod_comune
       </querytext>
    </partialquery>

</queryset>
