<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="ad_monitor_top.top_misc_info_insert">      
    <querytext>

    insert into ad_monitoring_top (
        top_id, 
        timestamp, 
        timehour, 
        load_avg_1, 
        load_avg_5, 
        load_avg_15,
        memory_real, 
        memory_free, 
        memory_swap_in_use, 
        memory_swap_free
    ) values (
        :top_id, 
        current_timestamp, 
        to_char(current_timestamp, 'HH24')::integer, 
        :load_1, 
        :load_5, 
        :load_15,
        :memory_real, 
        :memory_free, 
        :memory_swap_in_use, 
        :memory_swap_free
    )

    </querytext>
</fullquery>

 
</queryset>
