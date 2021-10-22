<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
       <querytext>
                  select a.cod_provincia
		       , a.denominazione
		       , a.cod_regione
		       , case 
		              when a.flag_val = 'T' then 'S&igrave;'
			      when a.flag_val = 'F' then 'No'
			      else ''
			      end as desc_flag
		       , a.cod_istat
		       , a.sigla
		       , b.denominazione as nome_regi
		    from coimprov a
		       , coimregi b
		   where 1 = 1
		     and b.cod_regione = a.cod_regione
		  $where_last
		  $where_word
		order by denominazione
       </querytext>
    </partialquery>

</queryset>
