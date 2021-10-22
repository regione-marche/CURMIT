<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_opdi">
       <querytext>
                insert
                  into coimopdi 
                     ( cod_opve
                     , prog_disp
                     , ora_da
                     , ora_a)
                values 
                     (:cod_opve
                     ,:prog_disp
                     ,:ora_da
                     ,:ora_a)
       </querytext>
    </partialquery>

    <partialquery name="upd_opdi">
       <querytext>
                update coimopdi
                   set ora_da    = :ora_da
                     , ora_a     = :ora_a
                 where cod_opve  = :cod_opve
                   and prog_disp = :prog_disp
       </querytext>
    </partialquery>

    <partialquery name="del_opdi">
       <querytext>
                delete
                  from coimopdi
                 where cod_opve  = :cod_opve
                   and prog_disp = :prog_disp
       </querytext>
    </partialquery>

    <fullquery name="sel_opdi">
       <querytext>
             select cod_opve
                  , prog_disp
                  , ora_da
                  , ora_a
               from coimopdi
              where cod_opve  = :cod_opve
                and prog_disp = :prog_disp
       </querytext>
    </fullquery>

    <fullquery name="sel_opdi_check">
       <querytext>
        select '1'
          from coimopdi
         where cod_opve =  :cod_opve
           and prog_disp = :prog_disp
       </querytext>
    </fullquery>

    <fullquery name="sel_opve_nome">
       <querytext>
                 select b.ragione_01||' '||coalesce(b.ragione_02,'') as nome_enve
                      , coalesce(a.cognome,'')||' '||coalesce(a.nome,'') as nome_opve
                   from coimopve a
                      , coimenve b
                  where a.cod_opve = :cod_opve
                    and b.cod_enve = a.cod_enve
       </querytext>
    </fullquery>

    <fullquery name="sel_opdi_prog_disp">
       <querytext>
       select coalesce(max(prog_disp),0) + 1 as prog_disp
         from coimopdi
	where cod_opve = :cod_opve
       </querytext>
    </fullquery>

    <fullquery name="sel_opdi_ore">
       <querytext>
       select ora_da as ora_da_db
            , ora_a  as ora_a_db
         from coimopdi 
	where cod_opve = :cod_opve
         $where_condition
       </querytext>
    </fullquery>

</queryset>
