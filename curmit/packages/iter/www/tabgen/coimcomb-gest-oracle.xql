<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="ins_comb">
       <querytext>
                insert
                  into coimcomb 
                     ( cod_combustibile
                     , descr_comb
                     , data_ins
                     , utente)
                values 
                     (upper(:cod_combustibile)
                     ,upper(:descr_comb)
                     , sysdate
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_comb">
       <querytext>
                update coimcomb
                   set descr_comb = upper(:descr_comb)
                      ,data_mod   =  sysdate
                      ,utente     = :id_utente
                 where cod_combustibile = upper(:cod_combustibile)
       </querytext>
    </partialquery>

    <partialquery name="del_comb">
       <querytext>
                delete
                  from coimcomb
                 where cod_combustibile = upper(:cod_combustibile)
       </querytext>
    </partialquery>

    <fullquery name="sel_comb">
       <querytext>
             select descr_comb
               from coimcomb
              where cod_combustibile = upper(:cod_combustibile)
       </querytext>
    </fullquery>

    <fullquery name="sel_comb_2">
       <querytext>
             select count(*) as conta
               from coimcomb
              where cod_combustibile = upper(:cod_combustibile)
             $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_comb_check">
       <querytext>
        select '1'
          from coimcomb
         where cod_combustibile = upper(:cod_combustibile)
       </querytext>
    </fullquery>

</queryset>
