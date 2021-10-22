<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_funz">
       <querytext>
                insert
                  into coimfunz 
                     ( nome_funz 
                     , desc_funz
                     , tipo_funz
                     , dett_funz
                     , azione
                     , parametri)
                values 
                     (:nome_funz_prog
                     ,:desc_funz
                     ,:tipo_funz
                     ,:dett_funz
                     ,:azione
                     ,:parametri)
       </querytext>
    </partialquery>

    <partialquery name="upd_funz">
       <querytext>
                update coimfunz
                   set desc_funz = :desc_funz
                     , azione = :azione
                     , parametri = :parametri
                 where nome_funz = :nome_funz_prog
                   and tipo_funz = :tipo_funz
                   and dett_funz = :dett_funz
       </querytext>
    </partialquery>

    <partialquery name="del_funz">
       <querytext>
                delete
                  from coimfunz
                 where nome_funz = :nome_funz_prog
                   and tipo_funz = :tipo_funz
                   and dett_funz = :dett_funz
       </querytext>
    </partialquery>

    <fullquery name="sel_funz">
       <querytext>
             select nome_funz as nome_funz_prog
                  , desc_funz
                  , tipo_funz
                  , dett_funz
                  , azione
                  , parametri
               from coimfunz
              where nome_funz = :nome_funz_prog
                and tipo_funz = :tipo_funz
                and dett_funz = :dett_funz
       </querytext>
    </fullquery>

    <fullquery name="sel_funz_check">
       <querytext>
        select '1'
          from coimfunz
         where upper(nome_funz) = upper(:nome_funz_prog)
           and tipo_funz = :tipo_funz
           and upper(dett_funz) = upper(:dett_funz)
       </querytext>
    </fullquery>

</queryset>
