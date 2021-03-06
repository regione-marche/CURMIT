<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================

-->
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_targa">
       <querytext>
       select distinct targa
            , upper(targa)
         from coimaimp 
        where 1 = 1
       $where_last
       $where_word
       order by upper(targa)
       </querytext>
    </partialquery>

   <fullquery name="sel_conta_targa">
       <querytext>
           select iter_edit_num(count(distinct(targa)),0) as conta_num
             from coimaimp
           where 1=1
           $where_word
       </querytext>
   </fullquery>
    
</queryset>
