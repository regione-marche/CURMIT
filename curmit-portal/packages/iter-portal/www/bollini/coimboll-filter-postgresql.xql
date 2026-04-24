<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_manu">
       <querytext>
             select iter_code as cod_manu_db
               from iter_maintainers
              where upper(name) $eq_cognome
       </querytext>
    </fullquery>


</queryset>
