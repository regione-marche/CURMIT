<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_tdoc">
       <querytext>
                insert
                  into coimtdoc 
                     ( tipo_documento
                     , descrizione)
                values 
                     (:tipo_documento
                     ,:descrizione)
       </querytext>
    </partialquery>

    <partialquery name="upd_tdoc">
       <querytext>
                update coimtdoc
                   set descrizione = :descrizione
                 where tipo_documento = :tipo_documento
       </querytext>
    </partialquery>

    <partialquery name="del_tdoc">
       <querytext>
                delete
                  from coimtdoc
                 where tipo_documento = :tipo_documento
       </querytext>
    </partialquery>

    <fullquery name="sel_tdoc">
       <querytext>
             select tipo_documento
                  , descrizione
                  , flag_modifica
               from coimtdoc
              where tipo_documento = :tipo_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_tdoc_check">
       <querytext>
        select '1'
          from coimtdoc
         where tipo_documento = :tipo_documento
       </querytext>
    </fullquery>

    <fullquery name="check_desc">
       <querytext>
        select '1'
          from coimtdoc
         where upper(descrizione) = upper(:descrizione)
	 $where_cod
       </querytext>
    </fullquery>

</queryset>
