<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
       <querytext>
                   select cod_potenza
                        , descr_potenza
                        , flag_tipo_impianto
                     from coimpote
                    where 1 = 1
                   $where_last
                    order by flag_tipo_impianto ,cod_potenza
       </querytext>
    </partialquery>

</queryset>
