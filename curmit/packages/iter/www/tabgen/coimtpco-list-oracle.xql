<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
       <querytext>
                   select cod_cost
                        , descr_cost
		     from coimcost
                    where 1 = 1
                   $where_last
                   $where_word
                    order by cod_cost
       </querytext>
    </partialquery>
   

</queryset>
