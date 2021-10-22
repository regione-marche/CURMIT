<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="ins_tpdu">
       <querytext>
                insert
                  into coimtpdu 
                     ( cod_tpdu
                     , descr_tpdu
                     , data_ins
                     , utente)
                values 
                     (:cod_tpdu
                     ,:descr_tpdu
                     , sysdate
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_tpdu">
       <querytext>
                update coimtpdu
                   set descr_tpdu = :descr_tpdu
                      ,  data_mod =  sysdate
                      ,    utente = :id_utente    
                 where cod_tpdu = :cod_tpdu
       </querytext>
    </partialquery>

    <partialquery name="del_tpdu">
       <querytext>
                delete
                  from coimtpdu
                 where cod_tpdu = :cod_tpdu
       </querytext>
    </partialquery>

    <fullquery name="sel_tpdu">
       <querytext>
             select cod_tpdu
                  , descr_tpdu
               from coimtpdu
              where cod_tpdu = :cod_tpdu
       </querytext>
    </fullquery>

    <fullquery name="sel_tpdu_check">
       <querytext>
        select '1'
          from coimtpdu
         where cod_tpdu = :cod_tpdu
       </querytext>
    </fullquery>

    <fullquery name="check_desc">
       <querytext>
            select '1' 
              from coimtpdu
             where descr_tpdu = :descr_tpdu
	     $where_cod             
       </querytext>
    </fullquery>

</queryset>
