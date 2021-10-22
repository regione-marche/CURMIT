<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
       <querytext>
                   select cod_distr
                        , ragione_01||' '||nvl(ragione_02,'') as ragione_01
                        , indirizzo  as indirizzo
			, cap
			, provincia
			, telefono
                     from coimdist
		    where 1 = 1
		   $where_last
		   $where_word
                   $where_ragione_01
		    order by cod_distr
       </querytext>
    </partialquery>

</queryset>
