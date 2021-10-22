<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
        <querytext>
                   select cod_combustibile as cod_comb
                        , descr_comb
                     from coimcomb
                    where 1 = 1
                   $where_word
                 order by descr_comb
                        , cod_combustibile
       </querytext>
   </partialquery>

</queryset>
