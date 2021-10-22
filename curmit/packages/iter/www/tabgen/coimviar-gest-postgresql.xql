<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_viar">
       <querytext>
                insert
                  into coimviar 
                     ( cod_area
                     , cod_comune
                     , cod_via
                     , civico_iniz
                     , civico_fine
                     , data_ins
                     , utente)
                values 
                     (:cod_area
                     ,:cod_comune
                     ,:cod_via
                     ,:civico_iniz
                     ,:civico_fine
                     , current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_viar">
       <querytext>
                update coimviar
                   set civico_iniz = :civico_iniz
                     , civico_fine = :civico_fine
                     , data_mod    =  current_date
                     , utente      = :id_utente
                 where cod_area    = :cod_area
                   and cod_comune  = :cod_comune
                   and cod_via     = :cod_via
       </querytext>
    </partialquery>

    <partialquery name="del_viar">
       <querytext>
                delete
                  from coimviar
                 where cod_area   = :cod_area
                   and cod_comune = :cod_comune
                   and cod_via    = :cod_via
       </querytext>
    </partialquery>

    <fullquery name="sel_viar">
       <querytext>
             select a.cod_area
                  , a.cod_comune
                  , a.cod_via
                  , a.civico_iniz
                  , a.civico_fine
                  , b.denominazione   as descr_comu
                  , c.descrizione     as descr_via
                  , c.descr_topo      as descr_topo
		  , a.cod_via as f_cod_via
               from coimviar a
               left outer join coimcomu b on b.cod_comune = a.cod_comune
               left outer join coimviae c on c.cod_via    = a.cod_via
                                         and c.cod_comune = a.cod_comune
              where a.cod_area   = :cod_area
                and a.cod_comune = :cod_comune
                and a.cod_via    = :cod_via
       </querytext>
    </fullquery>

    <fullquery name="sel_viar_check">
       <querytext>
        select '1'
          from coimviar
         where cod_area   = :cod_area
           and cod_comune = :cod_comune
           and cod_via    = :cod_via
       </querytext>
    </fullquery>

    <fullquery name="sel_descr_comu">
       <querytext>
        select denominazione as descr_comu 
          from coimcomu
         where cod_comune = :cod_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_via">
       <querytext>
             select cod_via 
               from coimviae
              where cod_comune  = :cod_comune
                and descrizione = upper(:descr_via)
                and descr_topo  = upper(:descr_topo)
       </querytext>
    </fullquery>

</queryset>
