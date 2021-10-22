<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_opve">
       <querytext>
            select cognome || ' ' || nome as descrizione
                 , cod_opve
              from coimopve
          order by cognome, nome
       </querytext>
    </fullquery>

    <fullquery name="cognome_opve">
       <querytext>
            select cognome 
              from coimopve
             where cod_opve = :cod_opve
       </querytext>
    </fullquery>

    <fullquery name="inco">
       <querytext>
	select nome_colonna
	       , denominazione
	       , tipo_dato
	       , dimensione
	       , obbligatorio
	       , default_value
	       , range_value
	 from coimtabs 
	 where nome_tabella = :nome_estrazione 
	 order by ordinamento;
       </querytext>
    </fullquery>

</queryset>
