<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_noin">
       <querytext>
                   select cod_noin
                        , descr_noin
                     from coimnoin
                    where 1 = 1
                    $where_last
                    $where_word
                    order by cod_noin
       </querytext>
    </partialquery>

</queryset>
