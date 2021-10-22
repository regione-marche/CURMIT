<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_tppt">
       <querytext>
                insert
                  into coimtppt 
                     ( cod_tppt
                     , descr
                     , descr_est
                     , progressivo)
                values 
                     (upper(:cod_tppt)
                     ,:descr
                     ,upper(:descr_est)
                     ,:progressivo)
       </querytext>
    </partialquery>

    <partialquery name="upd_tppt">
       <querytext>
                update coimtppt
                   set descr       = upper(:descr)
                      ,descr_est   = upper(:descr_est)
                      ,progressivo = :progressivo
                 where cod_tppt   = upper(:cod_tppt)
       </querytext>
    </partialquery>

    <partialquery name="del_tppt">
       <querytext>
                delete
                  from coimtppt
                 where cod_tppt= upper(:cod_tppt)
       </querytext>
    </partialquery>

    <fullquery name="sel_tppt">
       <querytext>
             select descr
                  , descr_est
                  , progressivo
               from coimtppt
              where cod_tppt= upper(:cod_tppt)
       </querytext>
    </fullquery>

    <fullquery name="sel_tppt_2">
       <querytext>
             select count(*) as conta
               from coimtppt
              where cod_tppt= upper(:cod_tppt)
             $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_tppt_check">
       <querytext>
        select '1'
          from coimtppt
         where cod_tppt= upper(:cod_tppt)
       </querytext>
    </fullquery>

</queryset>

