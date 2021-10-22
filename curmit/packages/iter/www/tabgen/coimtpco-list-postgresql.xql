<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
       <querytext>
                   select cod_tpco
                        , descr_tpco
		     from coimtpco
                    where 1 = 1
                   $where_last
                   $where_word
                    order by descr_tpco
       </querytext>
    </partialquery>

</queryset>
