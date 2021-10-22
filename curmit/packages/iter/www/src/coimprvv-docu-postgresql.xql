<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_prvv">
       <querytext>
          select cod_documento
            from coimprvv
           where cod_prvv = :cod_prvv
       </querytext>
    </fullquery>

    <fullquery name="sel_docu">
       <querytext>
          select tipo_contenuto                            as tipo_allegato 
               , lo_export(coimdocu.contenuto, :file_name) as flag_export
            from coimdocu
           where cod_documento = :cod_documento
       </querytext>
    </fullquery>

</queryset>
