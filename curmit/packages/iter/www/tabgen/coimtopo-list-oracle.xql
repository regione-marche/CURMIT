<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_topo">
       <querytext>
                   select cod_topo
                        , descr_topo
                     from coimtopo
                    where 1 = 1
                    $where_last
                    $where_word
                    order by cod_topo
       </querytext>
    </partialquery>

</queryset>
