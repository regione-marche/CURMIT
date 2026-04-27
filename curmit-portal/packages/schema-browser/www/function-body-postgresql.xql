<?xml version="1.0"?>
<queryset>
<rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="function_body">      
      <querytext>

         select
           proname as function_name, prosrc as function_src
         from
           pg_proc
         where
           oid = :oid

      </querytext>
</fullquery>
 
</queryset>
