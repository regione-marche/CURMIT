<?xml version="1.0"?>
<queryset>
<rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="unused">      
      <querytext>
      
    select
        table_name,
        trigger_type,
        triggering_event,
        status,
        trigger_body
    from
        user_triggers
    where
        trigger_name = upper(:trigger_name)
      </querytext>
</fullquery>

 
</queryset>
