<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="sel_liste_csv">
        <querytext>
	select nome_colonna
	       , denominazione
	       , tipo_dato
	       , dimensione
	       , obbligatorio
	       , default_value
	       , range_value
	 from coimtabs 
	 where nome_tabella = :csv_name 
	 order by ordinamento
	</querytext>
    </fullquery>
    <fullquery name="sel_cod_tanom">
        <querytext>
	select cod_tano as codice_anomalia
	  from coimtano
	</querytext>    
    </fullquery>

</queryset>
