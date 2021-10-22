<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_prvv">
       <querytext>
          select cod_documento
            from coimprvv
           where cod_prvv = :cod_prvv
       </querytext>
    </fullquery>

    <fullquery name="sel_docu">
       <querytext>
         select tipo_contenuto as tipo_allegato 
           from coimdocu
          where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_2">
       <querytext>
    select contenuto
      from coimdocu
     where cod_documento = [ns_dbquotevalue $cod_documento]
       </querytext>
    </fullquery>

</queryset>
