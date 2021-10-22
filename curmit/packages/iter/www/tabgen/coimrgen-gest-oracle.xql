<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="ins_rgen">
       <querytext>
                insert
                  into coimrgen 
                     ( cod_rgen
                     , descrizione)
                values 
                     (:cod_rgen
                     ,:descrizione)
       </querytext>
    </partialquery>

    <partialquery name="upd_rgen">
       <querytext>
                update coimrgen
                   set descrizione = :descrizione
                 where cod_rgen = :cod_rgen
       </querytext>
    </partialquery>

    <partialquery name="del_rgen">
       <querytext>
                delete
                  from coimrgen
                 where cod_rgen = :cod_rgen
       </querytext>
    </partialquery>

    <fullquery name="sel_rgen">
       <querytext>
             select cod_rgen
                  , descrizione
               from coimrgen
              where cod_rgen = :cod_rgen
       </querytext>
    </fullquery>

    <fullquery name="sel_rgen_check">
       <querytext>
        select '1'
          from coimrgen
         where cod_rgen = :cod_rgen
       </querytext>
    </fullquery>

</queryset>
