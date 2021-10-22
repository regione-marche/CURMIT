<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
       <querytext>
                   select a.cod_comune
		        , a.cod_provincia
                        , b.sigla
			, a.denominazione
			, case
                               when a.flag_val = 'T' then 'S&igrave;'
                               when a.flag_val = 'F' then 'No'
                               else ''
                               end as flag_val
			, a.cap
			, a.id_belfiore
			, a.cod_istat
			, case
                               when a.flag_viario_manutentore = 'T' then 'S&igrave;'
                               when a.flag_viario_manutentore = 'F' then 'No'
                               else ''
                               end as flag_viario_manutentore
                     from coimcomu a
                        , coimprov b
		    where 1 = 1
                      and b.cod_provincia = a.cod_provincia
		   $where_last
		   $where_word
		    order by denominazione
                   
       </querytext>
    </partialquery>

</queryset>
