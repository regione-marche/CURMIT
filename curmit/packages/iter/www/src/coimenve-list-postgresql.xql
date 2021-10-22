<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_enve">
       <querytext>
                   select cod_enve
                        , ragione_01||' '||coalesce(ragione_02,'') as ragione_01
                        , indirizzo  as indirizzo
			, cap
			, provincia
			, telefono
                     from coimenve
		    where 1 = 1
		   $where_last
		   $where_word
                   $where_ragione_01
		    order by cod_enve
       </querytext>
    </partialquery>

 </queryset>
