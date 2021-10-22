<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
        <querytext>
                   select cod_cost
                        , descr_cost
                     from coimcost
                    where 1 = 1
                   $where_word
                 order by descr_cost
                        , cod_cost
       </querytext>
   </partialquery>

</queryset>
