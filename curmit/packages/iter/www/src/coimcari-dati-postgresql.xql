<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="comuni_italia">
       <querytext>
       select denominazione as nome_comune_italia
            , cod_comune as cod_comune_italia
         from coimcomu
       </querytext>
    </fullquery>

    <fullquery name="provincie_italia">
       <querytext>
       select cod_provincia as cod_provincia_italia
            , sigla as sigla_provincia_italia
         from coimprov
       </querytext>
    </fullquery>

    <fullquery name="sel_ente_ver">
	<querytext>
	select cod_enve 
	  from coimenve limit 1
	</querytext>   
    </fullquery>

    <fullquery name="sel_cod_tanom">
        <querytext>
	select cod_tano as codice_anomalia
	  from coimtano
	</querytext>    
    </fullquery>

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
	 order by ordinamento;
	</querytext>
    </fullquery>

    <fullquery name="add_date_month">
	 <querytext>
	 select date(to_char(add_months(:data_dich,:months),'yyyy-mm-dd'));
	 </querytext>
    </fullquery>

    <fullquery name="sel_addmonth_dich">
        <querytext>
	select valid_mod_h
	       , valid_mod_h_b 
	from coimtgen 
	where cod_tgen = 1;
	</querytext>
    </fullquery>

</queryset>
