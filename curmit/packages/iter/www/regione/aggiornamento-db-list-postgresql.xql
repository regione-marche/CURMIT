<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_database_enti">
      <querytext>
	select database_ente as nome_database
	       , denominazione_ente
	from coimereg
      </querytext>
    </fullquery>
</queryset>
