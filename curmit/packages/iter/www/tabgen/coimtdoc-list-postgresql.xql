<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_tdoc">
       <querytext>
      select tipo_documento
           , descrizione
        from coimtdoc
       where 1 = 1
      $where_last
      $where_word
       order by tipo_documento
       </querytext>
    </partialquery>

</queryset>
