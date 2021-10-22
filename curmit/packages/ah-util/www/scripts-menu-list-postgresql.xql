<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>8.2</version></rdbms>

<fullquery name="paginator">      
      <querytext>
	select m.script_id
        from   mis_script_menu m
        where 1 = 1
        [template::list::filter_where_clauses -name scriptsmenu -and]
        [template::list::orderby_clause -name scriptsmenu -orderby]
      </querytext>
</fullquery>

<fullquery name="dummy_paginator">      
      <querytext>
        select script_id
        from  mis_script_menu		
        where 1 = 2
      </querytext>
</fullquery>

</queryset>


