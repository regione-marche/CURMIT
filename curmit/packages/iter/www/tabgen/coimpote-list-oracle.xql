<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
       <querytext>
                   select cod_potenza
                        , descr_potenza
                     from coimpote
                    where 1 = 1
                   $where_last
                    order by cod_potenza
       </querytext>
    </partialquery>

</queryset>
