<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_stpm">
       <querytext>
             select testo
               from coimstpm
              where id_stampa = :id_stampa
       </querytext>
    </fullquery>

</queryset>
