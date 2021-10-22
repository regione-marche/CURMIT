<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_docu_tipo_contenuto">
       <querytext>
          select tipo_contenuto
            from coimdocu
           where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_alle">
       <querytext>
          select lo_export(coimdocu.contenuto, :file_name)
            from coimdocu
           where cod_documento = :cod_documento
       </querytext>
    </fullquery>

</queryset>
