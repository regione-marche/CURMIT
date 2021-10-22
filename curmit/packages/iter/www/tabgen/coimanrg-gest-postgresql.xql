<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_anrg">
       <querytext>
                insert
                  into coimanrg
                     ( cod_rgen
                     , cod_tano)
                values 
                     (:cod_rgen
                     ,:cod_tano)
       </querytext>
    </partialquery>

    <fullquery name="sel_anrg">
       <querytext>
             select cod_tano
                  , descr_breve
               from coimtano
              where 1 = 1
                and cod_tano  not in (select cod_tano 
                                        from coimanrg 
                                       where cod_rgen = :cod_rgen) 
              order by cod_tano
       </querytext>
    </fullquery>

</queryset>
