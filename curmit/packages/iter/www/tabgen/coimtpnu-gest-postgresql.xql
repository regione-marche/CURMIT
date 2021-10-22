<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_tpnu">
       <querytext>
                insert
                  into coimtpnu 
                     ( cod_tpnu
                     , descr
                     , descr_est
                     , progressivo)
                values 
                     (upper(:cod_tpnu)
                     ,upper(:descr)
                     ,upper(:descr_est)
                     ,:progressivo)
       </querytext>
    </partialquery>

    <partialquery name="upd_tpnu">
       <querytext>
                update coimtpnu
                   set descr       = upper(:descr)
                      ,descr_est   = upper(:descr_est)
                      ,progressivo = :progressivo
                 where cod_tpnu    = upper(:cod_tpnu)
       </querytext>
    </partialquery>

    <partialquery name="del_tpnu">
       <querytext>
                delete
                  from coimtpnu
                 where cod_tpnu = upper(:cod_tpnu)
       </querytext>
    </partialquery>

    <fullquery name="sel_tpnu">
       <querytext>
             select descr
                  , descr_est
                  , progressivo
               from coimtpnu
              where cod_tpnu = upper(:cod_tpnu)
       </querytext>
    </fullquery>

    <fullquery name="sel_tpnu_2">
       <querytext>
             select count(*) as conta
               from coimtpnu
              where cod_tpnu = upper(:cod_tpnu)
             $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_tpnu_check">
       <querytext>
        select '1'
          from coimtpnu
         where cod_tpnu = upper(:cod_tpnu)
       </querytext>
    </fullquery>

</queryset>

