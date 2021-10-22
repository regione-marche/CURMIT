<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

     <partialquery name="sql_query">
       <querytext>
                   select a.cod_comune
		        , a.cod_provincia
                        , b.sigla
			, a.denominazione
			, decode (a.flag_val
                                 , 'T' , 'S&igrave;'
                                 , 'F' , 'No'
                                 ) as flag_val
			, a.cap
			, a.id_belfiore
			, a.cod_istat
                     from coimcomu a
                        , coimprov b
		    where b.cod_provincia = a.cod_provincia
		   $where_last
		   $where_word
		    order by denominazione
                   
       </querytext>
    </partialquery>
</queryset>
