<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_comb">
        <querytext>
                   select cod_combustibile as cod_comb
                        , descr_comb
                     from coimcomb
                    where cod_combustibile = :cod_comb
       </querytext>
   </fullquery>

    <partialquery name="upd_gend">
       <querytext>
          update coimgend
	     set cod_combustibile = :destinazione
           where cod_combustibile = :cod_comb
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp">
       <querytext>
          update coimaimp
	     set cod_combustibile = :destinazione
           where cod_combustibile = :cod_comb
       </querytext>
    </partialquery>

    <partialquery name="upd_cimp">
       <querytext>
          update coimcimp
	     set cod_combustibile = :destinazione
           where cod_combustibile = :cod_comb
       </querytext>
    </partialquery>

    <partialquery name="del_comb">
       <querytext>
           delete 
             from coimcomb
            where cod_combustibile = :cod_comb
       </querytext>
    </partialquery>


</queryset>
