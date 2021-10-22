<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_gage_num">
       <querytext>
           select count(*)
             from coimgage 
            where cod_opma = :cod_manutentore
              and stato    =  '1'
       </querytext>
    </partialquery>

    <partialquery name="sel_gage_test_aimp">
       <querytext>
           select count(*)
             from coimgage 
            where cod_opma     = :cod_manutentore
              and cod_impianto = :cod_impianto
	      and stato        = '1'
       </querytext>
    </partialquery>

    <partialquery name="sel_gage_test_unique">
       <querytext>
           select count(*)
             from coimgage 
            where cod_opma     = :cod_manutentore
              and cod_impianto = :cod_impianto
              and data_ins     = :current_date
       </querytext>
    </partialquery>

    <partialquery name="ins_gage">
       <querytext>
           insert
             into coimgage 
                ( cod_opma
                , cod_impianto
                , stato
                , data_prevista
                , data_esecuzione
                , note
                , data_ins
                , utente)
           values 
                (:cod_manutentore
                ,:cod_impianto
                ,:stato
                ,:data_prevista
                ,:data_esecuzione
                ,:note
                ,:current_date
                ,:id_utente)
       </querytext>
    </partialquery>

</queryset>
