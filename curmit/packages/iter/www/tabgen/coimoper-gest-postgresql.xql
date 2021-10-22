<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    
    <fullquery name="sel_cod">
        <querytext>
           select nextval('coimoper_s') as cod_operazione
       </querytext>
    </fullquery>


    <partialquery name="ins_oper">
       <querytext>
                insert
                  into coimoper 
                     ( cod_operazione
                     , descr_operazione
                     , data_ins
		     , data_mod
                     , user_inserimento
		     , user_modifica)
                values 
                     (:cod_operazione
                     ,upper(:descr_operazione)
                     ,current_date
                     ,null
		     ,:id_utente
                     ,null)
       </querytext>
    </partialquery>

    <partialquery name="upd_oper">
       <querytext>
                update coimoper
                   set descr_operazione = upper(:descr_operazione)
                      ,data_mod         =  current_date
                      ,user_modifica    = :id_utente
                 where cod_operazione   = :cod_operazione
       </querytext>
    </partialquery>

    <partialquery name="del_oper">
       <querytext>
                delete
                  from coimoper
                 where cod_operazione = :cod_operazione
       </querytext>
    </partialquery>

    <fullquery name="sel_oper">
       <querytext>
             select descr_operazione
               from coimoper
              where cod_operazione = :cod_operazione
       </querytext>
    </fullquery>

    <fullquery name="sel_oper_2">
       <querytext>
             select count(*) as conta
               from coimoper
              where descr_operazione = upper(:descr_operazione)
             $where_descr
       </querytext>
    </fullquery>

    <fullquery name="sel_oper_check">
       <querytext>
        select '1'
          from coimoper
         where cod_operazione = :cod_operazione
       </querytext>
    </fullquery>


</queryset>

