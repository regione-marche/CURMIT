<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_flre">
       <querytext>
                insert
                  into coimflre 
                     ( cod_flre
                     , sigla
                     , fluido
                     , formula
                     , data_ins
                     , utente)
                values 
                     (upper(:cod_flre)
                     ,upper(:sigla)
                     ,upper(:fluido)
                     ,upper(:formula)
                     , current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_flre">
       <querytext>
                update coimflre
                   set sigla = upper(:sigla)
                      , fluido = upper(:fluido)
                      , formula = upper(:formula)
                      , data_mod =  current_date
                      , utente     = :id_utente
                 where cod_flre = upper(:cod_flre)
       </querytext>
    </partialquery>

    <partialquery name="del_flre">
       <querytext>
                delete
                  from coimflre
                 where cod_flre = upper(:cod_flre)
       </querytext>
    </partialquery>

    <fullquery name="sel_flre">
       <querytext>
             select sigla,
                    fluido,
                    formula                    
               from coimflre
              where cod_flre = upper(:cod_flre)
       </querytext>
    </fullquery>

    <fullquery name="sel_flre_2">
       <querytext>
             select count(*) as conta
               from coimflre
              where cod_flre = upper(:cod_flre)
             $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_flre_check">
       <querytext>
        select '1'
          from coimflre
         where cod_flre = upper(:cod_flre)
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_check">
       <querytext>
        select '1'
          from coimgend
         where cod_flre = upper(:cod_flre)
        limit 1
       </querytext>
    </fullquery>

</queryset>

