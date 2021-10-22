<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_ragr_s">
       <querytext>
                   select nextval ('coimragr_s') as cod_raggruppamento
       </querytext>
    </fullquery>

    <partialquery name="ins_ragr">
       <querytext>
                insert
                  into coimragr
                     ( cod_raggruppamento
                     , descrizione
                     , peso_da
                     , peso_a)
                values 
                     ( :cod_raggruppamento
                     , :descrizione
                     , :peso_da
                     , :peso_a)
       </querytext>
    </partialquery>

    <partialquery name="upd_ragr">
       <querytext>
                update coimragr
                   set cod_raggruppamento = :cod_raggruppamento
                     , descrizione = :descrizione
		     , peso_da     = :peso_da
		     , peso_a      = :peso_a
                 where cod_raggruppamento = :cod_raggruppamento
       </querytext>
    </partialquery>

    <partialquery name="del_ragr">
       <querytext>
                delete
                  from coimragr
                 where cod_raggruppamento = :cod_raggruppamento
       </querytext>
    </partialquery>

    <fullquery name="sel_ragr">
       <querytext>
         select cod_raggruppamento
              , descrizione
              , iter_edit_num(peso_da, 0) as peso_da
              , iter_edit_num(peso_a, 0) as peso_a
           from coimragr
          where cod_raggruppamento = :cod_raggruppamento
       </querytext>
    </fullquery>

    <fullquery name="sel_ragr_check">
       <querytext>
        select '1'
          from coimragr
         where cod_raggruppamento = :cod_raggruppamento
       </querytext>
    </fullquery>

</queryset>
