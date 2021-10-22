<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
       <querytext>
                   select a.cod_area
                        , a.descrizione
                     from coimarea a
                    where 1 = 1
		   $where_opve
                   $where_manutentore
                   $where_last
                    order by a.descrizione
       </querytext>
    </partialquery>

</queryset>
