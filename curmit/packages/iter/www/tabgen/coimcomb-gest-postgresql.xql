<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_comb">
       <querytext>
                insert
                  into coimcomb 
                     ( cod_combustibile
                     , descr_comb
                     , data_ins
                     , utente
		     , tipo
                     , um)
                values 
                     (upper(:cod_combustibile)
                     ,upper(:descr_comb)
                     , current_date
                     ,:id_utente
		     ,:tipo
                     ,:um)
       </querytext>
    </partialquery>

    <partialquery name="upd_comb">
       <querytext>
                update coimcomb
                   set descr_comb = upper(:descr_comb)
                      ,data_mod   =  current_date
                      ,utente     = :id_utente
		      ,tipo       = :tipo
                      ,um         = :um
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
                  , tipo
		  , um
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

    <fullquery name="sel_aimp_check">
       <querytext>
        select '1'
          from coimaimp
         where cod_combustibile = upper(:cod_combustibile)
        limit 1
       </querytext>
    </fullquery>

</queryset>

