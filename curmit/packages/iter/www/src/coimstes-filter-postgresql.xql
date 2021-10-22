<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_cinc_att">
       <querytext>
            select cod_cinc as cod_cinc_att
              from coimcinc
             where stato = '1'
       </querytext>
    </fullquery>

</queryset>
