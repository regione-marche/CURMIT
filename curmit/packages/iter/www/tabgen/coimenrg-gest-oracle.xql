<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="ins_enrg">
       <querytext>
                insert
                  into coimenrg 
                     ( cod_rgen
                     , cod_enre)
                values 
                     (:cod_rgen
                     ,:cod_enre)
       </querytext>
    </partialquery>

    <fullquery name="sel_enrg">
       <querytext>
             select cod_enre
                  , denominazione
               from coimenre
              where 1 = 1
                and cod_enre  not in (select cod_enre 
                                        from coimenrg 
                                       where cod_rgen = :cod_rgen) 
              order by upper(denominazione), cod_enre
       </querytext>
    </fullquery>

</queryset>
