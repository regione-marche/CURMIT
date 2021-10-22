<?xml version="1.0"?>


<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
       <querytext>
              select cod_regione
                   , denominazione
                   , decode (flag_val
                            , 'T' , 'S&igrave;'
                            , 'F' , 'No'
                            ) as desc_flag
                   , cod_istat
                from coimregi
               where 1 = 1
              $where_last
              $where_word
               order by denominazione

       </querytext>
    </partialquery>

</queryset>
