<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
       <querytext>
              select cod_regione
                   , denominazione
                   , case 
                     when flag_val = 'T' then 'S&igrave;'
                     when flag_val = 'F' then 'No'
                     else ''
                     end as desc_flag
                   , cod_istat
                from coimregi
               where 1 = 1
              $where_last
              $where_word
               order by denominazione

       </querytext>
    </partialquery>

</queryset>
